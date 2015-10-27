From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 27 Oct 2015 01:18:28 +0000
Subject: [PATCH v4 5/7] usb: host: xhci-rcar: Change code for new SoCs
Message-Id: <1445908710-5812-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch changes code to ease the addition of next generation SoCs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci-plat.c |  1 +
 drivers/usb/host/xhci-rcar.c | 37 +++++++++++++++++++++++--------------
 drivers/usb/host/xhci-rcar.h |  2 ++
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 083e77b..a471f12 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -76,6 +76,7 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada = {
 
 static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
 	.type = XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
+	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V1,
 };
 
 static const struct of_device_id usb_xhci_of_match[] = {
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index ff0d1b4..010a24f 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -14,10 +14,10 @@
 #include <linux/usb/phy.h>
 
 #include "xhci.h"
+#include "xhci-plat.h"
 #include "xhci-rcar.h"
 
-#define FIRMWARE_NAME		"r8a779x_usb3_v1.dlmem"
-MODULE_FIRMWARE(FIRMWARE_NAME);
+MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V1);
 
 /*** Register Offset ***/
 #define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
@@ -56,6 +56,19 @@ MODULE_FIRMWARE(FIRMWARE_NAME);
 #define RCAR_USB3_RX_POL_VAL	BIT(21)
 #define RCAR_USB3_TX_POL_VAL	BIT(4)
 
+static void xhci_rcar_start_gen2(struct usb_hcd *hcd)
+{
+	/* LCLK Select */
+	writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_LCLK);
+	/* USB3.0 Configuration */
+	writel(RCAR_USB3_CONF1_VAL, hcd->regs + RCAR_USB3_CONF1);
+	writel(RCAR_USB3_CONF2_VAL, hcd->regs + RCAR_USB3_CONF2);
+	writel(RCAR_USB3_CONF3_VAL, hcd->regs + RCAR_USB3_CONF3);
+	/* USB3.0 Polarity */
+	writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX_POL);
+	writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX_POL);
+}
+
 void xhci_rcar_start(struct usb_hcd *hcd)
 {
 	u32 temp;
@@ -65,27 +78,23 @@ void xhci_rcar_start(struct usb_hcd *hcd)
 		temp = readl(hcd->regs + RCAR_USB3_INT_ENA);
 		temp |= RCAR_USB3_INT_ENA_VAL;
 		writel(temp, hcd->regs + RCAR_USB3_INT_ENA);
-		/* LCLK Select */
-		writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_LCLK);
-		/* USB3.0 Configuration */
-		writel(RCAR_USB3_CONF1_VAL, hcd->regs + RCAR_USB3_CONF1);
-		writel(RCAR_USB3_CONF2_VAL, hcd->regs + RCAR_USB3_CONF2);
-		writel(RCAR_USB3_CONF3_VAL, hcd->regs + RCAR_USB3_CONF3);
-		/* USB3.0 Polarity */
-		writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX_POL);
-		writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX_POL);
+		if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2))
+			xhci_rcar_start_gen2(hcd);
 	}
 }
 
-static int xhci_rcar_download_firmware(struct device *dev, void __iomem *regs)
+static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 {
+	struct device *dev = hcd->self.controller;
+	void __iomem *regs = hcd->regs;
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
 	const struct firmware *fw;
 	int retval, index, j, time;
 	int timeout = 10000;
 	u32 data, val, temp;
 
 	/* request R-Car USB3.0 firmware */
-	retval = request_firmware(&fw, FIRMWARE_NAME, dev);
+	retval = request_firmware(&fw, priv->firmware_name, dev);
 	if (retval)
 		return retval;
 
@@ -144,5 +153,5 @@ int xhci_rcar_init_quirk(struct usb_hcd *hcd)
 	if (!hcd->regs)
 		return 0;
 
-	return xhci_rcar_download_firmware(hcd->self.controller, hcd->regs);
+	return xhci_rcar_download_firmware(hcd);
 }
diff --git a/drivers/usb/host/xhci-rcar.h b/drivers/usb/host/xhci-rcar.h
index 5850125..ba3ad31 100644
--- a/drivers/usb/host/xhci-rcar.h
+++ b/drivers/usb/host/xhci-rcar.h
@@ -11,6 +11,8 @@
 #ifndef _XHCI_RCAR_H
 #define _XHCI_RCAR_H
 
+#define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
+
 #if IS_ENABLED(CONFIG_USB_XHCI_RCAR)
 void xhci_rcar_start(struct usb_hcd *hcd);
 int xhci_rcar_init_quirk(struct usb_hcd *hcd);
-- 
1.9.1

