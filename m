From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 08 Feb 2012 12:16:50 +0000
Subject: [PATCH 6/7] mtd: sh_flctl: Add power management support
Message-Id: <1328703411-3452-6-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328703411-3452-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328703411-3452-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com

Add pm support for global suspend/resume as well as for
runtime-suspend/-resume. All transactions with the NAND chip require a
chip enable signal. So we wrap the runtime_get()/put()s around it.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c  |   46 +++++++++++++++++++++++++++++++++++++----
 include/linux/mtd/sh_flctl.h |    2 +
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 70ca40d..a0231dd 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <linux/mtd/mtd.h>
@@ -515,6 +516,8 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
 	uint32_t read_cmd = 0;
 
+	BUG_ON(!flctl->power);
+
 	flctl->read_bytes = 0;
 	if (command != NAND_CMD_PAGEPROG)
 		flctl->index = 0;
@@ -681,14 +684,26 @@ read_normal_exit:
 static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	uint32_t flcmncr_val = readl(FLCMNCR(flctl));
+	uint32_t flcmncr_val;
 
 	switch (chipnr) {
 	case -1:
+		flcmncr_val = readl(FLCMNCR(flctl));
 		flcmncr_val &= ~CE0_ENABLE;
 		writel(flcmncr_val, FLCMNCR(flctl));
+
+		if (flctl->power) {
+			pm_runtime_put_sync(&flctl->pdev->dev);
+			flctl->power = 0;
+		}
 		break;
 	case 0:
+		if (!flctl->power) {
+			pm_runtime_get_sync(&flctl->pdev->dev);
+			flctl->power = 1;
+			udelay(1);	/* registers read 0 without delay */
+		}
+		flcmncr_val = readl(FLCMNCR(flctl));
 		flcmncr_val |= CE0_ENABLE;
 		writel(flcmncr_val, FLCMNCR(flctl));
 		break;
@@ -815,6 +830,20 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 	return 0;
 }
 
+static int flctl_reinitialize(struct device *dev)
+{
+	struct sh_flctl *flctl = dev_get_drvdata(dev);
+	udelay(1);
+	flctl_register_init(flctl, flctl->flcmncr_val);
+
+	return 0;
+}
+
+static const struct dev_pm_ops flctl_dev_pm_ops = {
+	.resume = flctl_reinitialize,
+	.runtime_resume = flctl_reinitialize,
+};
+
 static int __devinit flctl_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -853,9 +882,13 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	nand = &flctl->chip;
 	flctl_mtd->priv = nand;
 	flctl->pdev = pdev;
+	flctl->flcmncr_val = pdata->flcmncr_val;
 	flctl->hwecc = pdata->has_hwecc;
 	flctl->holden = pdata->use_holden;
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_resume(&pdev->dev);
+
 	flctl_register_init(flctl, pdata->flcmncr_val);
 
 	nand->options = NAND_NO_AUTOINCR;
@@ -878,20 +911,21 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 
 	ret = nand_scan_ident(flctl_mtd, 1, NULL);
 	if (ret)
-		goto err;
+		goto chip_err;
 
 	ret = flctl_chip_init_tail(flctl_mtd);
 	if (ret)
-		goto err;
+		goto chip_err;
 
 	ret = nand_scan_tail(flctl_mtd);
 	if (ret)
-		goto err;
+		goto chip_err;
 
 	mtd_device_register(flctl_mtd, pdata->parts, pdata->nr_parts);
 
 	return 0;
-
+chip_err:
+	pm_runtime_disable(&pdev->dev);
 err:
 	kfree(flctl);
 	return ret;
@@ -902,6 +936,7 @@ static int __devexit flctl_remove(struct platform_device *pdev)
 	struct sh_flctl *flctl = platform_get_drvdata(pdev);
 
 	nand_release(&flctl->mtd);
+	pm_runtime_disable(&pdev->dev);
 	kfree(flctl);
 
 	return 0;
@@ -912,6 +947,7 @@ static struct platform_driver flctl_driver = {
 	.driver = {
 		.name	= "sh_flctl",
 		.owner	= THIS_MODULE,
+		.pm	= &flctl_dev_pm_ops,
 	},
 };
 
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index fc77017..bdef1b9 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -145,9 +145,11 @@ struct sh_flctl {
 
 	int	hwecc_cant_correct[4];
 
+	unsigned long flcmncr_val;
 	unsigned page_size:1;	/* NAND page size (0 = 512, 1 = 2048) */
 	unsigned hwecc:1;	/* Hardware ECC (0 = disabled, 1 = enabled) */
 	unsigned holden:1;	/* Hardware has FLHOLDCR and HOLDEN is set */
+	unsigned power:1;	/* RTPM flag */
 };
 
 struct sh_flctl_platform_data {
-- 
1.7.5.4

