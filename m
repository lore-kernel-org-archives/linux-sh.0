From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Dec 2015 02:12:26 +0000
Subject: [PATCH v3 2/3] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <1449799947-19866-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449799947-19866-1-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Add fallback compatibility strings for R-Car Gen2 and Gen3.
This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3
* Moved documentation of SoC names to a separate patch
* Use correct fallback compatibility string in example

v2
* Add R-Car Gen2 and Gen3 fallback compatibility strings rather than
  a single compatibility string for all of R-Car.
---
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 10 +++++++++-
 drivers/usb/renesas_usbhs/common.c                      |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index a14c0bb561d5..c55cf77006d0 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -2,10 +2,18 @@ Renesas Electronics USBHS driver
 
 Required properties:
   - compatible: Must contain one of the following:
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

