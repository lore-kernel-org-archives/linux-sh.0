From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 26 Oct 2015 08:12:35 +0000
Subject: [PATCH v3 7/7] usb: host: xhci-plat: add support for the R-Car H3 xHCI controllers
Message-Id: <1445847155-5468-8-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The R-Car H3 has two xHCI controllers. This SoC is compatible with
R-Car Gen2 SoCs, however this SoC doesn't need some specific registers
setting, and need a new firmware.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt |  4 ++--
 drivers/usb/host/xhci-plat.c                       | 14 ++++++++++++--
 drivers/usb/host/xhci-plat.h                       |  1 +
 drivers/usb/host/xhci-rcar.c                       |  7 +++++++
 drivers/usb/host/xhci-rcar.h                       |  1 +
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 106299a..0825732 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -3,8 +3,8 @@ USB xHCI controllers
 Required properties:
   - compatible: should be one of "generic-xhci",
     "marvell,armada-375-xhci", "marvell,armada-380-xhci",
-    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7793"
-    (deprecated: "xhci-platform").
+    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7793",
+    "renesas,xhci-r8a7795" (deprecated: "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
   - interrupts: one XHCI interrupt should be described here.
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 0113e79..770b6b0 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -52,7 +52,8 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
 {
 	int ret;
 
-	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2)) {
+	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2) ||
+	    xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3)) {
 		ret = xhci_rcar_init_quirk(hcd);
 		if (ret)
 			return ret;
@@ -63,7 +64,8 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
 
 static int xhci_plat_start(struct usb_hcd *hcd)
 {
-	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2))
+	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2) ||
+	    xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3))
 		xhci_rcar_start(hcd);
 
 	return xhci_run(hcd);
@@ -79,6 +81,11 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
 	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V1,
 };
 
+static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
+	.type = XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
+	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2,
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "generic-xhci",
@@ -100,6 +107,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
 		.compatible = "renesas,xhci-r8a7793",
 		.data = &xhci_plat_renesas_rcar_gen2,
 	}, {
+		.compatible = "renesas,xhci-r8a7795",
+		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
 	},
 };
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 20b32a7..5a2e2e3 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -16,6 +16,7 @@
 enum xhci_plat_type {
 	XHCI_PLAT_TYPE_MARVELL_ARMADA,
 	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
+	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
 };
 
 struct xhci_plat_priv {
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 010a24f..623100e 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -17,7 +17,14 @@
 #include "xhci-plat.h"
 #include "xhci-rcar.h"
 
+/*
+* - The V2 firmware is possible to use on R-Car Gen2. However, the V2 causes
+*   performance degradation. So, this driver continues to use the V1 if R-Car
+*   Gen2.
+* - The V1 firmware is impossible to use on R-Car Gen3.
+*/
 MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V1);
+MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V2);
 
 /*** Register Offset ***/
 #define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
diff --git a/drivers/usb/host/xhci-rcar.h b/drivers/usb/host/xhci-rcar.h
index ba3ad31..2941a25 100644
--- a/drivers/usb/host/xhci-rcar.h
+++ b/drivers/usb/host/xhci-rcar.h
@@ -12,6 +12,7 @@
 #define _XHCI_RCAR_H
 
 #define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
+#define XHCI_RCAR_FIRMWARE_NAME_V2	"r8a779x_usb3_v2.dlmem"
 
 #if IS_ENABLED(CONFIG_USB_XHCI_RCAR)
 void xhci_rcar_start(struct usb_hcd *hcd);
-- 
1.9.1

