From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 11 Jan 2016 04:07:24 +0000
Subject: [PATCH v2 1/2] usb: host: xhci-plat: add R-Car Gen2 and Gen3 fallback compatibility strings
Message-Id: <1452485245-9001-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add fallback compatibility strings for R-Car Gen2 and Gen3.

This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Use consistent line ending in documentation
* Group compat strings at the bottom of usb_xhci_of_match[]
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 21 +++++++++++++++++----
 drivers/usb/host/xhci-plat.c                       |  5 +++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 082573289f1e..34e1d7b6a829 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -1,10 +1,23 @@
 USB xHCI controllers
 
 Required properties:
-  - compatible: should be one of "generic-xhci",
-    "marvell,armada-375-xhci", "marvell,armada-380-xhci",
-    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7793",
-    "renesas,xhci-r8a7795" (deprecated: "xhci-platform").
+  - compatible: should be one or more of
+
+    - "generic-xhci" for generic XHCI device
+    - "marvell,armada-375-xhci" for Armada 375 SoCs
+    - "marvell,armada-380-xhci" for Armada 380 SoCs
+    - "renesas,xhci-r8a7790" for r8a7790 SoC
+    - "renesas,xhci-r8a7791" for r8a7791 SoC
+    - "renesas,xhci-r8a7793" for r8a7793 SoC
+    - "renesas,xhci-r8a7795" for r8a7795 SoC
+    - "renesas,rcar-gen2-xhci" for a generic R-Car Gen2 compatible device
+    - "renesas,rcar-gen3-xhci" for a generic R-Car Gen3 compatible device
+    - "xhci-platform" (deprecated)
+
+    When compatible with the generic version, nodes must list the
+    SoC-specific version corresponding to the platform first
+    followed by the generic version.
+
   - reg: should contain address and length of the standard XHCI
     register set for the device.
   - interrupts: one XHCI interrupt should be described here.
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 770b6b088797..05d09d7547ea 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -110,6 +110,11 @@ static const struct of_device_id usb_xhci_of_match[] = {
 		.compatible = "renesas,xhci-r8a7795",
 		.data = &xhci_plat_renesas_rcar_gen3,
 	}, {
+		.compatible = "renesas,rcar-gen2-xhci",
+		.data = &xhci_plat_renesas_rcar_gen2,
+	}, {
+		.compatible = "renesas,rcar-gen3-xhci",
+		.data = &xhci_plat_renesas_rcar_gen3,
 	},
 };
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
-- 
2.7.0.rc3.207.g0ac5344

