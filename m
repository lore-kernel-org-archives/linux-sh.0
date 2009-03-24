From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 24 Mar 2009 09:27:24 +0000
Subject: [PATCH] sh_flctl: fix hardware ecc handling for 2048 byte page
Message-Id: <49C8A77C.9070902@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dwmw2@infradead.org
Cc: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org


Signed-off-by: Jeremy Baker <Jeremy.Baker@renesas.com>
Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/mtd/nand/sh_flctl.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 821acb0..2bc8966 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -58,7 +58,7 @@ static struct nand_bbt_descr flctl_4secc_smallpage = {
 };

 static struct nand_bbt_descr flctl_4secc_largepage = {
-	.options = 0,
+	.options = NAND_BBT_SCAN2NDPAGE,
 	.offs = 58,
 	.len = 2,
 	.pattern = scan_ff_pattern,
@@ -149,7 +149,7 @@ static void wait_wfifo_ready(struct sh_flctl *flctl)
 	printk(KERN_ERR "wait_wfifo_ready(): Timeout occured \n");
 }

-static int wait_recfifo_ready(struct sh_flctl *flctl)
+static int wait_recfifo_ready(struct sh_flctl *flctl, int sector_number)
 {
 	uint32_t timeout = LOOP_TIMEOUT_MAX;
 	int checked[4];
@@ -183,7 +183,12 @@ static int wait_recfifo_ready(struct sh_flctl *flctl)
 				uint8_t org;
 				int index;

-				index = data >> 16;
+				if (flctl->page_size)
+					index = (512 * sector_number) +
+						(data >> 16);
+				else
+					index = data >> 16;
+
 				org = flctl->done_buff[index];
 				flctl->done_buff[index] = org ^ (data & 0xFF);
 				checked[i] = 1;
@@ -238,14 +243,14 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 	}
 }

-static int read_ecfiforeg(struct sh_flctl *flctl, uint8_t *buff)
+static int read_ecfiforeg(struct sh_flctl *flctl, uint8_t *buff, int sector)
 {
 	int i;
 	unsigned long *ecc_buf = (unsigned long *)buff;
 	void *fifo_addr = (void *)FLECFIFO(flctl);

 	for (i = 0; i < 4; i++) {
-		if (wait_recfifo_ready(flctl))
+		if (wait_recfifo_ready(flctl , sector))
 			return 1;
 		ecc_buf[i] = readl(fifo_addr);
 		ecc_buf[i] = be32_to_cpu(ecc_buf[i]);
@@ -384,7 +389,8 @@ static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
 		read_fiforeg(flctl, 512, 512 * sector);

 		ret = read_ecfiforeg(flctl,
-			&flctl->done_buff[mtd->writesize + 16 * sector]);
+			&flctl->done_buff[mtd->writesize + 16 * sector],
+			sector);

 		if (ret)
 			flctl->hwecc_cant_correct[sector] = 1;
-- 
1.5.5

