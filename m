From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 13 Jan 2016 02:00:36 +0000
Subject: [PATCH v3 1/2] usb: host: xhci-plat: add R-Car Gen2 and Gen3 fallback compatibility strings
Message-Id: <1452650437-26312-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <53868E18.7090805@renesas.com>
In-Reply-To: <53868E18.7090805@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add fallback compatibility strings for R-Car Gen2 and Gen3.

This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v3
* Refer to Armada 38x rather than Armada 380 SoCs
  as the binding is also used by Armada 385 SoCs
* Added Ack from Geert Uytterhoeven

v2
* Use consistent line ending in documentation
* Group compat strings at the bottom of usb_xhci_of_match[]
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 21 +++++++++++++++++----
 drivers/usb/host/xhci-plat.c                       |  5 +++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 082573289f1e..6a17aa85c4d5 100644
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
+    - "marvell,armada-380-xhci" for Armada 38x SoCs
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
2.1.4

