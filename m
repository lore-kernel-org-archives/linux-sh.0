From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 26 Oct 2015 08:12:34 +0000
Subject: [PATCH v3 6/7] usb: host: xhci-plat: add support for the R-Car M2-N xHCI controller
Message-Id: <1445847155-5468-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds support for R-Car M2-N (r8a7793) xHCI controller.
This SoC is compatible with R-Car H2 (r8a7790) and R-Car M2-W (r8a7791).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 4 ++--
 drivers/usb/host/xhci-plat.c                       | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 86f67f0..106299a 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -3,8 +3,8 @@ USB xHCI controllers
 Required properties:
   - compatible: should be one of "generic-xhci",
     "marvell,armada-375-xhci", "marvell,armada-380-xhci",
-    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791" (deprecated:
-    "xhci-platform").
+    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7793"
+    (deprecated: "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
   - interrupts: one XHCI interrupt should be described here.
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index a471f12..0113e79 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -97,6 +97,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
 		.compatible = "renesas,xhci-r8a7791",
 		.data = &xhci_plat_renesas_rcar_gen2,
 	}, {
+		.compatible = "renesas,xhci-r8a7793",
+		.data = &xhci_plat_renesas_rcar_gen2,
+	}, {
 	},
 };
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
-- 
1.9.1

