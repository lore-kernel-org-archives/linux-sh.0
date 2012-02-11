From: Bastian Hecht <hechtb@googlemail.com>
Date: Sat, 11 Feb 2012 11:45:03 +0000
Subject: [PATCH v2 5/7] mtd: sh_flctl: Use cached register value for FLCMNCR
Message-Id: <1328960705-18699-6-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

Instead of reading out the register, use a cached value. This will
make way for a proper runtime power management implementation.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
changelog: I delayed the rtpm patch until the clock code is fixed for
board mackerel, so that no "udelay(1);" is needed. Instead I cleaned
up the code to use a cached register value. The rtpm code will benefit
from it.

 drivers/mtd/nand/sh_flctl.c  |   15 +++------------
 include/linux/mtd/sh_flctl.h |    1 +
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 5c3e71f..1af41fd 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -681,16 +681,13 @@ read_normal_exit:
 static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	uint32_t flcmncr_val = readl(FLCMNCR(flctl));
 
 	switch (chipnr) {
 	case -1:
-		flcmncr_val &= ~CE0_ENABLE;
-		writel(flcmncr_val, FLCMNCR(flctl));
+		writel(flctl->flcmncr_val, FLCMNCR(flctl));
 		break;
 	case 0:
-		flcmncr_val |= CE0_ENABLE;
-		writel(flcmncr_val, FLCMNCR(flctl));
+		writel(flctl->flcmncr_val | CE0_ENABLE, FLCMNCR(flctl));
 		break;
 	default:
 		BUG();
@@ -748,11 +745,6 @@ static int flctl_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
 	return 0;
 }
 
-static void flctl_register_init(struct sh_flctl *flctl, unsigned long val)
-{
-	writel(val, FLCMNCR(flctl));
-}
-
 static int flctl_chip_init_tail(struct mtd_info *mtd)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
@@ -851,10 +843,9 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	nand = &flctl->chip;
 	flctl_mtd->priv = nand;
 	flctl->pdev = pdev;
+	flctl->flcmncr_val = pdata->flcmncr_val;
 	flctl->hwecc = pdata->has_hwecc;
 
-	flctl_register_init(flctl, pdata->flcmncr_val);
-
 	nand->options = NAND_NO_AUTOINCR;
 
 	/* Set address of hardware control function */
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index e66c393..107fd8a 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -132,6 +132,7 @@ struct sh_flctl {
 	int	erase1_page_addr;	/* page_addr in ERASE1 cmd */
 	uint32_t erase_ADRCNT;		/* bits of FLCMDCR in ERASE1 cmd */
 	uint32_t rw_ADRCNT;	/* bits of FLCMDCR in READ WRITE cmd */
+	uint32_t flcmncr_val;	/* base value of FLCMNCR */
 
 	int	hwecc_cant_correct[4];
 
-- 
1.7.5.4

