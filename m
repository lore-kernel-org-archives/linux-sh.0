From: Bastian Hecht <hechtb@googlemail.com>
Date: Fri, 20 Apr 2012 09:13:48 +0000
Subject: [PATCH 7/9] mtd: sh_flctl: Restructure the hardware ECC handling
Message-Id: <1334913230-23615-8-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

There are multiple reasons for a rewrite:
 - a race exists: when _4ECCEND is set, _4ECCFA may become true too
   meanwhile, which is lost and a non-correctable error is treated as
   correctable.
 - the ECC statistics don't get properly propagated to the base code.
 - empty pages would get marked as corrupted

The rewrite resolves the issues and I hope it gives a more explicit
code flow structure.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c  |  120 ++++++++++++++++++++++++++++--------------
 include/linux/mtd/sh_flctl.h |   10 +++-
 2 files changed, 88 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 1e5d684..408e013 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -165,27 +165,56 @@ static void wait_wfifo_ready(struct sh_flctl *flctl)
 	timeout_error(flctl, __func__);
 }
 
-static int wait_recfifo_ready(struct sh_flctl *flctl, int sector_number)
+static enum flctl_ecc_res_t wait_recfifo_ready
+		(struct sh_flctl *flctl, int sector_number)
 {
 	uint32_t timeout = LOOP_TIMEOUT_MAX;
-	int checked[4];
 	void __iomem *ecc_reg[4];
 	int i;
+	int state = FL_SUCCESS;
 	uint32_t data, size;
 
-	memset(checked, 0, sizeof(checked));
-
+	/*
+	 * First this loops checks in FLDTCNTR if we are ready to read out the
+	 * oob data. This is the case if either all went fine without errors or
+	 * if the bottom part of the loop corrected the errors or marked them as
+	 * uncorrectable and the controller is given time to push the data into
+	 * the FIFO.
+	 */
 	while (timeout--) {
+		/* check if all is ok and we can read out the OOB */
 		size = readl(FLDTCNTR(flctl)) >> 24;
-		if (size & 0xFF)
-			return 0;	/* success */
+		if ((size & 0xFF) = 4)
+			return state;
+
+		/* check if a correction code has been calculated */
+		if (!(readl(FL4ECCCR(flctl)) & _4ECCEND)) {
+			/*
+			 * either we wait for the fifo to be filled or a
+			 * correction pattern is being generated
+			 */
+			udelay(1);
+			continue;
+		}
 
-		if (readl(FL4ECCCR(flctl)) & _4ECCFA)
-			return 1;	/* can't correct */
+		/* check for an uncorrectable error */
+		if (readl(FL4ECCCR(flctl)) & _4ECCFA) {
+			/* check if we face a non-empty page */
+			for (i = 0; i < 512; i++) {
+				if (flctl->done_buff[i] != 0xff) {
+					state = FL_ERROR; /* can't correct */
+					break;
+				}
+			}
 
-		udelay(1);
-		if (!(readl(FL4ECCCR(flctl)) & _4ECCEND))
+			if (state = FL_SUCCESS)
+				dev_dbg(&flctl->pdev->dev,
+				"reading empty sector %d, ecc error ignored\n",
+				sector_number);
+
+			writel(0, FL4ECCCR(flctl));
 			continue;
+		}
 
 		/* start error correction */
 		ecc_reg[0] = FL4ECCRESULT0(flctl);
@@ -194,28 +223,26 @@ static int wait_recfifo_ready(struct sh_flctl *flctl, int sector_number)
 		ecc_reg[3] = FL4ECCRESULT3(flctl);
 
 		for (i = 0; i < 3; i++) {
+			uint8_t org;
+			int index;
+
 			data = readl(ecc_reg[i]);
-			if (data != INIT_FL4ECCRESULT_VAL && !checked[i]) {
-				uint8_t org;
-				int index;
-
-				if (flctl->page_size)
-					index = (512 * sector_number) +
-						(data >> 16);
-				else
-					index = data >> 16;
-
-				org = flctl->done_buff[index];
-				flctl->done_buff[index] = org ^ (data & 0xFF);
-				checked[i] = 1;
-			}
-		}
 
+			if (flctl->page_size)
+				index = (512 * sector_number) +
+					(data >> 16);
+			else
+				index = data >> 16;
+
+			org = flctl->done_buff[index];
+			flctl->done_buff[index] = org ^ (data & 0xFF);
+		}
+		state = FL_REPAIRABLE;
 		writel(0, FL4ECCCR(flctl));
 	}
 
 	timeout_error(flctl, __func__);
-	return 1;	/* timeout */
+	return FL_TIMEOUT;	/* timeout */
 }
 
 static void wait_wecfifo_ready(struct sh_flctl *flctl)
@@ -259,20 +286,24 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 	}
 }
 
-static int read_ecfiforeg(struct sh_flctl *flctl, uint8_t *buff, int sector)
+static enum flctl_ecc_res_t read_ecfiforeg
+		(struct sh_flctl *flctl, uint8_t *buff, int sector)
 {
 	int i;
+	enum flctl_ecc_res_t res;
 	unsigned long *ecc_buf = (unsigned long *)buff;
 	void *fifo_addr = (void *)FLECFIFO(flctl);
 
-	for (i = 0; i < 4; i++) {
-		if (wait_recfifo_ready(flctl , sector))
-			return 1;
-		ecc_buf[i] = readl(fifo_addr);
-		ecc_buf[i] = be32_to_cpu(ecc_buf[i]);
+	res = wait_recfifo_ready(flctl , sector);
+
+	if (res != FL_ERROR) {
+		for (i = 0; i < 4; i++) {
+			ecc_buf[i] = readl(fifo_addr);
+			ecc_buf[i] = be32_to_cpu(ecc_buf[i]);
+		}
 	}
 
-	return 0;
+	return res;
 }
 
 static void write_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
@@ -367,6 +398,7 @@ static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
 	int sector, page_sectors;
+	enum flctl_ecc_res_t ecc_result;
 
 	page_sectors = flctl->page_size ? 4 : 1;
 
@@ -382,17 +414,27 @@ static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
 	start_translation(flctl);
 
 	for (sector = 0; sector < page_sectors; sector++) {
-		int ret;
 		read_fiforeg(flctl, 512, 512 * sector);
 
-		ret = read_ecfiforeg(flctl,
+		ecc_result = read_ecfiforeg(flctl,
 			&flctl->done_buff[mtd->writesize + 16 * sector],
 			sector);
 
-		if (ret)
-			flctl->hwecc_cant_correct[sector] = 1;
-
-		writel(0x0, FL4ECCCR(flctl));
+		switch (ecc_result) {
+		case FL_REPAIRABLE:
+			dev_info(&flctl->pdev->dev,
+				"applied ecc on page 0x%x", page_addr);
+			flctl->mtd.ecc_stats.corrected++;
+			break;
+		case FL_ERROR:
+			dev_warn(&flctl->pdev->dev,
+				"page 0x%x contains corrupted data\n",
+				page_addr);
+			flctl->mtd.ecc_stats.failed++;
+			break;
+		default:
+			;
+		}
 	}
 
 	wait_completion(flctl);
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 91c5b01..a9e24d7 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -127,9 +127,15 @@
 #define	_4ECCEND	(0x1 << 1)	/* 4 symbols end */
 #define	_4ECCEXST	(0x1 << 0)	/* 4 symbols exist */
 
-#define INIT_FL4ECCRESULT_VAL	0x03FF03FF
 #define LOOP_TIMEOUT_MAX	0x00010000
 
+enum flctl_ecc_res_t {
+	FL_SUCCESS,
+	FL_REPAIRABLE,
+	FL_ERROR,
+	FL_TIMEOUT
+};
+
 struct sh_flctl {
 	struct mtd_info		mtd;
 	struct nand_chip	chip;
@@ -149,8 +155,6 @@ struct sh_flctl {
 	uint32_t flcmncr_base;	/* base value of FLCMNCR */
 	uint32_t flintdmacr_base;	/* irq enable bits */
 
-	int	hwecc_cant_correct[4];
-
 	unsigned page_size:1;	/* NAND page size (0 = 512, 1 = 2048) */
 	unsigned hwecc:1;	/* Hardware ECC (0 = disabled, 1 = enabled) */
 	unsigned holden:1;	/* Hardware has FLHOLDCR and HOLDEN is set */
-- 
1.7.5.4

