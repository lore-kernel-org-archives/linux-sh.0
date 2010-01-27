From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Jan 2010 09:11:20 +0000
Subject: [PATCH] mtd: trivial sh_flctl changes
Message-Id: <20100127091120.21312.77488.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, shimoda.yoshihiro@renesas.com, dwmw2@infradead.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch contains a few changes for the sh_flctl driver:
 - not sh7723-only driver - get rid of kconfig dependency
 - use dev_err() instead of printk()
 - use __devinit and __devexit for probe()/remove()
 - fix probe() return values

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mtd/nand/Kconfig     |    4 ++--
 drivers/mtd/nand/sh_flctl.c  |   40 ++++++++++++++++++++++------------------
 include/linux/mtd/sh_flctl.h |    1 +
 3 files changed, 25 insertions(+), 20 deletions(-)

--- 0001/drivers/mtd/nand/Kconfig
+++ work/drivers/mtd/nand/Kconfig	2010-01-26 22:11:20.000000000 +0900
@@ -451,10 +451,10 @@ config MTD_NAND_NOMADIK
 
 config MTD_NAND_SH_FLCTL
 	tristate "Support for NAND on Renesas SuperH FLCTL"
-	depends on MTD_NAND && SUPERH && CPU_SUBTYPE_SH7723
+	depends on MTD_NAND && SUPERH
 	help
 	  Several Renesas SuperH CPU has FLCTL. This option enables support
-	  for NAND Flash using FLCTL. This driver support SH7723.
+	  for NAND Flash using FLCTL.
 
 config MTD_NAND_DAVINCI
         tristate "Support NAND on DaVinci SoC"
--- 0001/drivers/mtd/nand/sh_flctl.c
+++ work/drivers/mtd/nand/sh_flctl.c	2010-01-27 17:43:42.000000000 +0900
@@ -1,10 +1,10 @@
 /*
  * SuperH FLCTL nand controller
  *
- * Copyright © 2008 Renesas Solutions Corp.
- * Copyright © 2008 Atom Create Engineering Co., Ltd.
+ * Copyright (c) 2008 Renesas Solutions Corp.
+ * Copyright (c) 2008 Atom Create Engineering Co., Ltd.
  *
- * Based on fsl_elbc_nand.c, Copyright © 2006-2007 Freescale Semiconductor
+ * Based on fsl_elbc_nand.c, Copyright (c) 2006-2007 Freescale Semiconductor
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -75,6 +75,11 @@ static void start_translation(struct sh_
 	writeb(TRSTRT, FLTRCR(flctl));
 }
 
+static void timeout_error(struct sh_flctl *flctl, const char *str)
+{
+	dev_err(&flctl->pdev->dev, "Timeout occured in %s\n", str);
+}
+
 static void wait_completion(struct sh_flctl *flctl)
 {
 	uint32_t timeout = LOOP_TIMEOUT_MAX;
@@ -87,7 +92,7 @@ static void wait_completion(struct sh_fl
 		udelay(1);
 	}
 
-	printk(KERN_ERR "wait_completion(): Timeout occured \n");
+	timeout_error(flctl, __func__);
 	writeb(0x0, FLTRCR(flctl));
 }
 
@@ -132,7 +137,7 @@ static void wait_rfifo_ready(struct sh_f
 			return;
 		udelay(1);
 	}
-	printk(KERN_ERR "wait_rfifo_ready(): Timeout occured \n");
+	timeout_error(flctl, __func__);
 }
 
 static void wait_wfifo_ready(struct sh_flctl *flctl)
@@ -146,7 +151,7 @@ static void wait_wfifo_ready(struct sh_f
 			return;
 		udelay(1);
 	}
-	printk(KERN_ERR "wait_wfifo_ready(): Timeout occured \n");
+	timeout_error(flctl, __func__);
 }
 
 static int wait_recfifo_ready(struct sh_flctl *flctl, int sector_number)
@@ -198,7 +203,7 @@ static int wait_recfifo_ready(struct sh_
 		writel(0, FL4ECCCR(flctl));
 	}
 
-	printk(KERN_ERR "wait_recfifo_ready(): Timeout occured \n");
+	timeout_error(flctl, __func__);
 	return 1;	/* timeout */
 }
 
@@ -214,7 +219,7 @@ static void wait_wecfifo_ready(struct sh
 			return;
 		udelay(1);
 	}
-	printk(KERN_ERR "wait_wecfifo_ready(): Timeout occured \n");
+	timeout_error(flctl, __func__);
 }
 
 static void read_datareg(struct sh_flctl *flctl, int offset)
@@ -769,38 +774,36 @@ static int flctl_chip_init_tail(struct m
 	return 0;
 }
 
-static int __init flctl_probe(struct platform_device *pdev)
+static int __devinit flctl_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct sh_flctl *flctl;
 	struct mtd_info *flctl_mtd;
 	struct nand_chip *nand;
 	struct sh_flctl_platform_data *pdata;
-	int ret;
+	int ret = -ENXIO;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata = NULL) {
-		printk(KERN_ERR "sh_flctl platform_data not found.\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
 	}
 
 	flctl = kzalloc(sizeof(struct sh_flctl), GFP_KERNEL);
 	if (!flctl) {
-		printk(KERN_ERR "Unable to allocate NAND MTD dev structure.\n");
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		printk(KERN_ERR "%s: resource not found.\n", __func__);
-		ret = -ENODEV;
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
 		goto err;
 	}
 
 	flctl->reg = ioremap(res->start, resource_size(res));
 	if (flctl->reg = NULL) {
-		printk(KERN_ERR "%s: ioremap error.\n", __func__);
-		ret = -ENOMEM;
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
 		goto err;
 	}
 
@@ -808,6 +811,7 @@ static int __init flctl_probe(struct pla
 	flctl_mtd = &flctl->mtd;
 	nand = &flctl->chip;
 	flctl_mtd->priv = nand;
+	flctl->pdev = pdev;
 	flctl->hwecc = pdata->has_hwecc;
 
 	flctl_register_init(flctl, pdata->flcmncr_val);
@@ -846,7 +850,7 @@ err:
 	return ret;
 }
 
-static int __exit flctl_remove(struct platform_device *pdev)
+static int __devexit flctl_remove(struct platform_device *pdev)
 {
 	struct sh_flctl *flctl = platform_get_drvdata(pdev);
 
--- 0001/include/linux/mtd/sh_flctl.h
+++ work/include/linux/mtd/sh_flctl.h	2010-01-26 22:11:20.000000000 +0900
@@ -96,6 +96,7 @@
 struct sh_flctl {
 	struct mtd_info		mtd;
 	struct nand_chip	chip;
+	struct platform_device	*pdev;
 	void __iomem		*reg;
 
 	uint8_t	done_buff[2048 + 64];	/* max size 2048 + 64 */
