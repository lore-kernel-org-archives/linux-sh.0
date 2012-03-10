From: Bastian Hecht <hechtb@googlemail.com>
Date: Sat, 10 Mar 2012 15:31:18 +0000
Subject: [PATCH] mtd: sh_flctl: Add power management support
Message-Id: <1331393478-30850-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

All transactions with the NAND chip require a chip enable signal. So we
wrap the runtime_pm_get()/put()s around it. As registers are cached, we
need no suspend()/resume() callbacks.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c  |   31 +++++++++++++++++++++++++------
 include/linux/mtd/sh_flctl.h |    1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index d0f1f3c..c72de39 100644
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
@@ -689,12 +692,22 @@ static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
 	case -1:
 		flctl->flcmncr_base &= ~CE0_ENABLE;
 		writel(flctl->flcmncr_base, FLCMNCR(flctl));
+
+		if (flctl->power) {
+			pm_runtime_put_sync(&flctl->pdev->dev);
+			flctl->power = 0;
+		}
 		break;
 	case 0:
 		flctl->flcmncr_base |= CE0_ENABLE;
 		writel(flctl->flcmncr_base, FLCMNCR(flctl));
 		if (flctl->holden)
 			writel(HOLDEN, FLHOLDCR(flctl));
+
+		if (!flctl->power) {
+			pm_runtime_get_sync(&flctl->pdev->dev);
+			flctl->power = 1;
+		}
 		break;
 	default:
 		BUG();
@@ -835,13 +848,13 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		goto err;
+		goto err_iomap;
 	}
 
 	flctl->reg = ioremap(res->start, resource_size(res));
 	if (flctl->reg = NULL) {
 		dev_err(&pdev->dev, "failed to remap I/O memory\n");
-		goto err;
+		goto err_iomap;
 	}
 
 	platform_set_drvdata(pdev, flctl);
@@ -871,23 +884,28 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 		nand->read_word = flctl_read_word;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_resume(&pdev->dev);
+
 	ret = nand_scan_ident(flctl_mtd, 1, NULL);
 	if (ret)
-		goto err;
+		goto err_chip;
 
 	ret = flctl_chip_init_tail(flctl_mtd);
 	if (ret)
-		goto err;
+		goto err_chip;
 
 	ret = nand_scan_tail(flctl_mtd);
 	if (ret)
-		goto err;
+		goto err_chip;
 
 	mtd_device_register(flctl_mtd, pdata->parts, pdata->nr_parts);
 
 	return 0;
 
-err:
+err_chip:
+	pm_runtime_disable(&pdev->dev);
+err_iomap:
 	kfree(flctl);
 	return ret;
 }
@@ -897,6 +915,7 @@ static int __devexit flctl_remove(struct platform_device *pdev)
 	struct sh_flctl *flctl = platform_get_drvdata(pdev);
 
 	nand_release(&flctl->mtd);
+	pm_runtime_disable(&pdev->dev);
 	kfree(flctl);
 
 	return 0;
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 8bcf299..f34a0a1 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -149,6 +149,7 @@ struct sh_flctl {
 	unsigned page_size:1;	/* NAND page size (0 = 512, 1 = 2048) */
 	unsigned hwecc:1;	/* Hardware ECC (0 = disabled, 1 = enabled) */
 	unsigned holden:1;	/* Hardware has FLHOLDCR and HOLDEN is set */
+	unsigned power:1;	/* RTPM flag */
 };
 
 struct sh_flctl_platform_data {
-- 
1.7.5.4

