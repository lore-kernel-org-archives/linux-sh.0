From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 06 Dec 2019 13:28:49 +0000
Subject: [PATCH] usb: host: ehci-sh: Remove unused platform data support
Message-Id: <20191206132849.29406-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

ehci_sh_platdata was never used, remove it. It can be resurrected from
git history when needed.

This basically reverts commit 3e0c70d050c7ed6d ("usb: ehci-sh: Add PHY
init function with platform data").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/usb/host/ehci-sh.c            |  7 -------
 include/linux/platform_data/ehci-sh.h | 16 ----------------
 2 files changed, 23 deletions(-)
 delete mode 100644 include/linux/platform_data/ehci-sh.h

diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index 2afde14dc425c261..c25c51d26f26035b 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -8,7 +8,6 @@
  */
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/platform_data/ehci-sh.h>
 
 struct ehci_sh_priv {
 	struct clk *iclk, *fclk;
@@ -76,7 +75,6 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct ehci_sh_priv *priv;
-	struct ehci_sh_platdata *pdata;
 	struct usb_hcd *hcd;
 	int irq, ret;
 
@@ -89,8 +87,6 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 		goto fail_create_hcd;
 	}
 
-	pdata = dev_get_platdata(&pdev->dev);
-
 	/* initialize hcd */
 	hcd = usb_create_hcd(&ehci_sh_hc_driver, &pdev->dev,
 			     dev_name(&pdev->dev));
@@ -127,9 +123,6 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 	clk_enable(priv->fclk);
 	clk_enable(priv->iclk);
 
-	if (pdata && pdata->phy_init)
-		pdata->phy_init();
-
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to add hcd");
diff --git a/include/linux/platform_data/ehci-sh.h b/include/linux/platform_data/ehci-sh.h
deleted file mode 100644
index 219bd79dabfc0a0e..0000000000000000
--- a/include/linux/platform_data/ehci-sh.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * EHCI SuperH driver platform data
- *
- * Copyright (C) 2012  Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
- * Copyright (C) 2012  Renesas Solutions Corp.
- */
-
-#ifndef __USB_EHCI_SH_H
-#define __USB_EHCI_SH_H
-
-struct ehci_sh_platdata {
-	void (*phy_init)(void); /* Phy init function */
-};
-
-#endif /* __USB_EHCI_SH_H */
-- 
2.17.1
