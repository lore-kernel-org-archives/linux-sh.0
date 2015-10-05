From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 05 Oct 2015 12:06:29 +0000
Subject: [PATCH 3/4] usb: host: xhci-rcar: Change code for new SoCs
Message-Id: <1444046790-5804-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch changes code to ease the addition of next generation SoCs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci-rcar.c | 51 +++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index b4b110e..acfa03a 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -17,8 +17,8 @@
 #include "xhci.h"
 #include "xhci-rcar.h"
 
-#define FIRMWARE_NAME		"r8a779x_usb3_v1.dlmem"
-MODULE_FIRMWARE(FIRMWARE_NAME);
+#define FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
+MODULE_FIRMWARE(FIRMWARE_NAME_V1);
 
 /*** Register Offset ***/
 #define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
@@ -57,7 +57,7 @@ MODULE_FIRMWARE(FIRMWARE_NAME);
 #define RCAR_USB3_RX_POL_VAL	BIT(21)
 #define RCAR_USB3_TX_POL_VAL	BIT(4)
 
-bool xhci_rcar_is_compatible(struct usb_hcd *hcd)
+static bool xhci_rcar_is_compatible_with_gen2(struct usb_hcd *hcd)
 {
 	struct device_node *of_node = hcd->self.controller->of_node;
 
@@ -69,6 +69,27 @@ bool xhci_rcar_is_compatible(struct usb_hcd *hcd)
 	return false;
 }
 
+bool xhci_rcar_is_compatible(struct usb_hcd *hcd)
+{
+	if (xhci_rcar_is_compatible_with_gen2(hcd))
+		return true;
+
+	return false;
+}
+
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
@@ -78,19 +99,13 @@ void xhci_rcar_start(struct usb_hcd *hcd)
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
+		if (xhci_rcar_is_compatible_with_gen2(hcd))
+			xhci_rcar_start_gen2(hcd);
 	}
 }
 
-static int xhci_rcar_download_firmware(struct device *dev, void __iomem *regs)
+static int xhci_rcar_download_firmware(struct device *dev, void __iomem *regs,
+				       const char *firmware_name)
 {
 	const struct firmware *fw;
 	int retval, index, j, time;
@@ -98,7 +113,7 @@ static int xhci_rcar_download_firmware(struct device *dev, void __iomem *regs)
 	u32 data, val, temp;
 
 	/* request R-Car USB3.0 firmware */
-	retval = request_firmware(&fw, FIRMWARE_NAME, dev);
+	retval = request_firmware(&fw, firmware_name, dev);
 	if (retval)
 		return retval;
 
@@ -153,9 +168,15 @@ static int xhci_rcar_download_firmware(struct device *dev, void __iomem *regs)
 /* This function needs to initialize a "phy" of usb before */
 int xhci_rcar_init_quirk(struct usb_hcd *hcd)
 {
+	const char *firmware_name = NULL;
+
 	/* If hcd->regs is NULL, we don't just call the following function */
 	if (!hcd->regs)
 		return 0;
 
-	return xhci_rcar_download_firmware(hcd->self.controller, hcd->regs);
+	if (xhci_rcar_is_compatible_with_gen2(hcd))
+		firmware_name = FIRMWARE_NAME_V1;
+
+	return xhci_rcar_download_firmware(hcd->self.controller, hcd->regs,
+					   firmware_name);
 }
-- 
1.9.1

