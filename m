From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 12 Nov 2015 01:53:59 +0000
Subject: [PATCH] dmaengine: rcar-dmac: Document SoC specific bindings
Message-Id: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

In general Renesas hardware is not documented to the extent where the
relationship between IP blocks on different SoCs can be assumed although
they may appear to operate the same way. Furthermore the documentation
typically does not specify a version for individual IP blocks. For these
reasons a convention of using the SoC name in place of a version and
providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings for
most drivers for Renesas hardware. The purpose of this patch is to
update the Renesas R-Car DMA Controller driver to follow this convention.

Cc: devicetree@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Once this has been merged I intend to provide follow-up patches
to use these new compat strings in the relevant dtsi files.

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 09daeef1ff22..5b902ac8d97e 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -14,7 +14,14 @@ not described in these device tree bindings.
 
 Required Properties:
 
-- compatible: must contain "renesas,rcar-dmac"
+- compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.
+	      Examples with soctypes are:
+		- "renesas,dmac-r8a7790" (R-Car H2)
+		- "renesas,dmac-r8a7791" (R-Car M2-W)
+		- "renesas,dmac-r8a7792" (R-Car V2H)
+		- "renesas,dmac-r8a7793" (R-Car M2-N)
+		- "renesas,dmac-r8a7794" (R-Car E2)
+		- "renesas,dmac-r8a7795" (R-Car H3)
 
 - reg: base address and length of the registers block for the DMAC
 
@@ -35,7 +42,7 @@ Required Properties:
 Example: R8A7790 (R-Car H2) SYS-DMACs
 
 	dmac0: dma-controller@e6700000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
 		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
 			      0 200 IRQ_TYPE_LEVEL_HIGH
@@ -65,7 +72,7 @@ Example: R8A7790 (R-Car H2) SYS-DMACs
 	};
 
 	dmac1: dma-controller@e6720000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
 		reg = <0 0xe6720000 0 0x20000>;
 		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
 			      0 216 IRQ_TYPE_LEVEL_HIGH
-- 
2.1.4

