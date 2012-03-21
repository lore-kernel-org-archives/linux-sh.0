From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 21 Mar 2012 06:47:00 +0000
Subject: [PATCH v2] usb: ehci-sh: Add PHY init function with platform data
Message-Id: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In devices using ehci-sh, initialization of the PHY may be necessary.
This adds platform data to ehci-sh and provide function to initialize PHY.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
CC: Shimoda Yoshihiro <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/ehci-sh.c  |    8 ++++++++
 include/linux/usb/ehci-sh.h |   28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/usb/ehci-sh.h

diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index 9d9cf47..98def36 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -11,6 +11,7 @@
  */
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/usb/ehci-sh.h>
 
 struct ehci_sh_priv {
 	struct clk *iclk, *fclk;
@@ -100,6 +101,7 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 	const struct hc_driver *driver = &ehci_sh_hc_driver;
 	struct resource *res;
 	struct ehci_sh_priv *priv;
+	struct ehci_sh_platdata *pdata;
 	struct usb_hcd *hcd;
 	int irq, ret;
 
@@ -124,6 +126,9 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 		goto fail_create_hcd;
 	}
 
+	if (pdev->dev.platform_data != NULL)
+		pdata = pdev->dev.platform_data;
+
 	/* initialize hcd */
 	hcd = usb_create_hcd(&ehci_sh_hc_driver, &pdev->dev,
 			     dev_name(&pdev->dev));
@@ -168,6 +173,9 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 	clk_enable(priv->fclk);
 	clk_enable(priv->iclk);
 
+	if (pdata && pdata->phy_init)
+		pdata->phy_init();
+
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to add hcd");
diff --git a/include/linux/usb/ehci-sh.h b/include/linux/usb/ehci-sh.h
new file mode 100644
index 0000000..817b206
--- /dev/null
+++ b/include/linux/usb/ehci-sh.h
@@ -0,0 +1,28 @@
+/*
+ * EHCI SuperH driver platform data
+ *
+ * Copyright (C) 2012  Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
+ * Copyright (C) 2012  Renesas Solutions Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __LINUX_USB_EHCI_SH_H
+#define __LINUX_USB_EHCI_SH_H
+
+struct ehci_sh_platdata {
+	void (*phy_init)(void); /* Phy init function */
+};
+
+#endif /* __LINUX_USB_EHCI_SH_H */
-- 
1.7.9.1

