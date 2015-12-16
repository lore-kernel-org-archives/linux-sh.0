From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Dec 2015 04:51:51 +0000
Subject: [PATCH v4 2/3] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <1450241512-24699-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450241512-24699-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450241512-24699-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Add fallback compatibility strings for R-Car Gen2 and Gen3.
This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v4
* State that one or more compat string should be used

v3
* Moved documentation of SoC names to a separate patch
* Use correct fallback compatibility string in example

v2
* Add R-Car Gen2 and Gen3 fallback compatibility strings rather than
  a single compatibility string for all of R-Car.
---
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 12 ++++++++++--
 drivers/usb/renesas_usbhs/common.c                      |  9 +++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index a14c0bb561d5..45d9ae13ffa3 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -1,11 +1,19 @@
 Renesas Electronics USBHS driver
 
 Required properties:
-  - compatible: Must contain one of the following:
+  - compatible: Must contain one or more of the following:
+
 	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
 	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
 	- "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
 	- "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
+	- "renesas,rcar-gen2-usbhs" for R-Car Gen2 compatible device
+	- "renesas,rcar-gen3-usbhs" for R-Car Gen3 compatible device
+
+	When compatible with the generic version, nodes must list the
+	SoC-specific version corresponding to the platform first followed
+	by the generic version.
+
   - reg: Base address and length of the register for the USBHS
   - interrupts: Interrupt specifier for the USBHS
   - clocks: A list of phandle + clock specifier pairs
@@ -22,7 +30,7 @@ Optional properties:
 
 Example:
 	usbhs: usb@e6590000 {
-		compatible = "renesas,usbhs-r8a7790";
+		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-gen2-usbhs";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index d82fa36c3465..db9a17bd8997 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -481,6 +481,15 @@ static const struct of_device_id usbhs_of_match[] = {
 		.compatible = "renesas,usbhs-r8a7795",
 		.data = (void *)USBHS_TYPE_RCAR_GEN2,
 	},
+	{
+		.compatible = "renesas,rcar-gen2-usbhs",
+		.data = (void *)USBHS_TYPE_RCAR_GEN2,
+	},
+	{
+		/* Gen3 is compatible with Gen2 */
+		.compatible = "renesas,rcar-gen3-usbhs",
+		.data = (void *)USBHS_TYPE_RCAR_GEN2,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, usbhs_of_match);
-- 
2.1.4

