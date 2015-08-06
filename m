From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Aug 2015 13:33:09 +0000
Subject: [PATCH/RFC 2/2] arm64: renesas: r8a7795 dtsi: Add CPG/MSTP Clock Domain
Message-Id: <1438867989-4942-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add an appropriate "#power-domain-cells" property to the cpg_clocks
device node, to create the CPG/MSTP Clock Domain.

Add "power-domains" properties to all device nodes for devices that are
part of the CPG/MSTP Clock Domain and can be power-managed through an
MSTP clock.  This applies to most on-SoC devices, which have a
one-to-one mapping from SoC device to DT device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index db0828ad475986c0..25f03049b7d94bbe 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -91,6 +91,7 @@
 				#clock-cells = <1>;
 				clock-output-names = "main", "pll0", "pll1","pll2",
 						     "pll3", "pll4";
+				#power-domain-cells = <0>;
 
 				mstp3_clks: mstp3_clks@e615013c {
 					compatible = "renesas,r8a7795-mstp-clocks",
@@ -109,6 +110,7 @@
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp3_clks RCAR_R8A7795_CLK_SCIF2>;
 			clock-names = "sci_ick";
+			power-domains = <&cpg_clocks>;
 		};
 	};
 };
-- 
1.9.1

