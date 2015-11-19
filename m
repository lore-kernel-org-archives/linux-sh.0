From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 19 Nov 2015 18:29:11 +0000
Subject: [PATCH v3] arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes
Message-Id: <1447957751-32554-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add the device nodes for all HSCIF serial ports, incl. clocks, clock
domain, and dma properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Switch to final CPG/MSSR bindings,

v2:
  - Drop obsolete vendor prefix from "renesas,clock-indices" property,
  - Move HSCIF nodes before SCIF nodes to preserve alphabetical sort
    order,
  - Switch from cpg-mstp to cpg-mssr.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 2ae303843ec8..979a087d2b59 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -358,6 +358,66 @@
 			#size-cells = <0>;
 		};
 
+		hscif0: serial@e6540000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6540000 0 96>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 520>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hscif1: serial@e6550000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6550000 0 96>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 519>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hscif2: serial@e6560000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6560000 0 96>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 518>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hscif3: serial@e66a0000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe66a0000 0 96>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 517>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hscif4: serial@e66b0000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe66b0000 0 96>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 516>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		scif0: serial@e6e60000 {
 			compatible = "renesas,scif-r8a7795", "renesas,scif";
 			reg = <0 0xe6e60000 0 64>;
-- 
1.9.1

