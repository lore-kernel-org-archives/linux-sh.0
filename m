From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 02 Dec 2015 05:53:54 +0000
Subject: [PATCH v2] dmaengine: usb-dmac: Document SoC specific compatibility strings
Message-Id: <1449035634-18761-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, devicetree@vger.kernel.org

In general Renesas hardware is not documented to the extent where the
relationship between IP blocks on different SoCs can be assumed although
they may appear to operate the same way. Furthermore the documentation
typically does not specify a version for individual IP blocks. For these
reasons a convention of using the SoC name in place of a version and
providing SoC-specific compatibility strings has been adopted.

Although not universally liked this convention is used in the bindings for
most drivers for Renesas hardware. The purpose of this patch is to
update the Renesas USB DMA Controller driver to follow this convention.

Cc: devicetree@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Notes:
* r8a7792 (R-Car V2H) is omitted as my reading of the documentation
  is that Renesas USB-DMAC does not exist on that SoC.

v2:
* Use <vendor>,<chip>-<block> rather than <vendor>,<block>-<chip>
  pattern for new compatibility strings
* Added compatibility string for r8a7795 on advice from Shimoda-san
* Added Acks
---
 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
index 040f365954cc..e7780a186a36 100644
--- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
@@ -1,7 +1,13 @@
 * Renesas USB DMA Controller Device Tree bindings
 
 Required Properties:
-- compatible: must contain "renesas,usb-dmac"
+-compatible: "renesas,<soctype>-usb-dmac", "renesas,usb-dmac" as fallback.
+	Examples with soctypes are:
+	  - "renesas,r8a7790-usb-dmac" (R-Car H2)
+	  - "renesas,r8a7791-usb-dmac" (R-Car M2-W)
+	  - "renesas,r8a7793-usb-dmac" (R-Car M2-N)
+	  - "renesas,r8a7794-usb-dmac" (R-Car E2)
+	  - "renesas,r8a7795-usb-dmac" (R-Car H3)
 - reg: base address and length of the registers block for the DMAC
 - interrupts: interrupt specifiers for the DMAC, one for each entry in
   interrupt-names.
@@ -15,7 +21,7 @@ Required Properties:
 Example: R8A7790 (R-Car H2) USB-DMACs
 
 	usb_dmac0: dma-controller@e65a0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65a0000 0 0x100>;
 		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
 			      0 109 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4

