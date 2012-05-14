From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 14 May 2012 12:14:41 +0000
Subject: [PATCH v4 2/8] mtd: sh_flctl: Add support for error IRQ
Message-Id: <1336997687-6868-3-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, linux-sh@vger.kernel.org

When the data transfer between the controller and the NAND chip fails,
we now get notified.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c  |   34 +++++++++++++++++++++++++++++++---
 include/linux/mtd/sh_flctl.h |    9 +++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index a5a60ca..fb22cc7 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -68,8 +69,8 @@ static struct nand_bbt_descr flctl_4secc_largepage = {
 
 static void empty_fifo(struct sh_flctl *flctl)
 {
-	writel(0x000c0000, FLINTDMACR(flctl));	/* FIFO Clear */
-	writel(0x00000000, FLINTDMACR(flctl));	/* Clear Error flags */
+	writel(flctl->flintdmacr_base | AC1CLR | AC0CLR, FLINTDMACR(flctl));
+	writel(flctl->flintdmacr_base, FLINTDMACR(flctl));
 }
 
 static void start_translation(struct sh_flctl *flctl)
@@ -839,6 +840,16 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 	return 0;
 }
 
+static irqreturn_t flctl_handle_flste(int irq, void *dev_id)
+{
+	struct sh_flctl *flctl = dev_id;
+
+	dev_err(&flctl->pdev->dev, "flste irq: %x\n", readl(FLINTDMACR(flctl)));
+	writel(flctl->flintdmacr_base, FLINTDMACR(flctl));
+
+	return IRQ_HANDLED;
+}
+
 static int __devinit flctl_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -847,6 +858,7 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	struct nand_chip *nand;
 	struct sh_flctl_platform_data *pdata;
 	int ret = -ENXIO;
+	int irq;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata = NULL) {
@@ -872,14 +884,27 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 		goto err_iomap;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get flste irq data\n");
+		goto err_flste;
+	}
+
+	ret = request_irq(irq, flctl_handle_flste, IRQF_SHARED, "flste", flctl);
+	if (ret) {
+		dev_err(&pdev->dev, "request interrupt failed.\n");
+		goto err_flste;
+	}
+
 	platform_set_drvdata(pdev, flctl);
 	flctl_mtd = &flctl->mtd;
 	nand = &flctl->chip;
 	flctl_mtd->priv = nand;
 	flctl->pdev = pdev;
-	flctl->flcmncr_base = pdata->flcmncr_val;
 	flctl->hwecc = pdata->has_hwecc;
 	flctl->holden = pdata->use_holden;
+	flctl->flcmncr_base = pdata->flcmncr_val;
+	flctl->flintdmacr_base = flctl->hwecc ? (STERINTE | ECERB) : STERINTE;
 
 	/* Set address of hardware control function */
 	/* 20 us command delay time */
@@ -918,6 +943,8 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 
 err_chip:
 	pm_runtime_disable(&pdev->dev);
+	free_irq(irq, flctl);
+err_flste:
 	iounmap(flctl->reg);
 err_iomap:
 	kfree(flctl);
@@ -930,6 +957,7 @@ static int __devexit flctl_remove(struct platform_device *pdev)
 
 	nand_release(&flctl->mtd);
 	pm_runtime_disable(&pdev->dev);
+	free_irq(platform_get_irq(pdev, 0), flctl);
 	iounmap(flctl->reg);
 	kfree(flctl);
 
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index a38e1fa..2daa43e 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -107,6 +107,14 @@
 #define DOCMD2_E	(0x1 << 17)	/* 2nd cmd stage execute */
 #define DOCMD1_E	(0x1 << 16)	/* 1st cmd stage execute */
 
+/* FLINTDMACR control bits */
+#define ESTERINTE	(0x1 << 24)	/* ECC error interrupt enable */
+#define AC1CLR		(0x1 << 19)	/* ECC FIFO clear */
+#define AC0CLR		(0x1 << 18)	/* Data FIFO clear */
+#define ECERB		(0x1 << 9)	/* ECC error */
+#define STERB		(0x1 << 8)	/* Status error */
+#define STERINTE	(0x1 << 4)	/* Status error enable */
+
 /* FLTRCR control bits */
 #define TRSTRT		(0x1 << 0)	/* translation start */
 #define TREND		(0x1 << 1)	/* translation end */
@@ -145,6 +153,7 @@ struct sh_flctl {
 	uint32_t erase_ADRCNT;		/* bits of FLCMDCR in ERASE1 cmd */
 	uint32_t rw_ADRCNT;	/* bits of FLCMDCR in READ WRITE cmd */
 	uint32_t flcmncr_base;	/* base value of FLCMNCR */
+	uint32_t flintdmacr_base;	/* irq enable bits */
 
 	int	hwecc_cant_correct[4];
 
-- 
1.7.5.4

