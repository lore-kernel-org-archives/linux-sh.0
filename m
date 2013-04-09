From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 09 Apr 2013 22:39:47 +0000
Subject: [PATCH v3 9/9] rcar-phy: handle platform data
Message-Id: <201304100239.47852.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Set the USBPCTRL0 register from the passed platform data in rcar_usb_phy_init();
don't reset it to 0 in  rcar_usb_phy_shutdown()  anymore as that does not make
sense.  Also, don't allow the driver's probe to succeed when the platform data
are not supplied with a device.

The patch has been tested on the Marzen and BOCK-W boards.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since version 2:
- added a note about testing to the changelog;
- added ACKs from Simon Horman and Kuninori Morimoto.

 drivers/usb/phy/rcar-phy.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: renesas/drivers/usb/phy/rcar-phy.c
=================================--- renesas.orig/drivers/usb/phy/rcar-phy.c
+++ renesas/drivers/usb/phy/rcar-phy.c
@@ -1,8 +1,9 @@
 /*
  * Renesas R-Car USB phy driver
  *
- * Copyright (C) 2012 Renesas Solutions Corp.
+ * Copyright (C) 2012-2013 Renesas Solutions Corp.
  * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ * Copyright (C) 2013 Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -11,10 +12,11 @@
 
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/usb/otg.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/rcar-phy.h>
 
 /* REGS block */
 #define USBPCTRL0	0x00
@@ -55,6 +57,7 @@ static int rcar_usb_phy_init(struct usb_
 {
 	struct rcar_usb_phy_priv *priv = usb_phy_to_priv(phy);
 	struct device *dev = phy->dev;
+	struct rcar_phy_platform_data *pdata = dev->platform_data;
 	void __iomem *reg0 = priv->reg0;
 	int i;
 	u32 val;
@@ -90,7 +93,7 @@ static int rcar_usb_phy_init(struct usb_
 		iowrite32(PHY_ENB | PLL_ENB | PHY_RST, (reg0 + USBPCTRL1));
 
 		/* set platform specific port settings */
-		iowrite32(0x00000000, (reg0 + USBPCTRL0));
+		iowrite32(pdata->usbpctrl0, (reg0 + USBPCTRL0));
 
 		/*
 		 * Bus alignment settings
@@ -117,10 +120,8 @@ static void rcar_usb_phy_shutdown(struct
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	if (priv->counter-- = 1) { /* last user */
-		iowrite32(0x00000000, (reg0 + USBPCTRL0));
+	if (priv->counter-- = 1)	/* last user */
 		iowrite32(0x00000000, (reg0 + USBPCTRL1));
-	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
@@ -133,6 +134,11 @@ static int rcar_usb_phy_probe(struct pla
 	void __iomem *reg0;
 	int ret;
 
+	if (!pdev->dev.platform_data) {
+		dev_err(dev, "No platform data\n");
+		return -EINVAL;
+	}
+
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res0) {
 		dev_err(dev, "Not enough platform resources\n");
