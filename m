From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 07 Aug 2015 03:17:34 +0000
Subject: [PATCH 08/16 v5][RFC] arm64: renesas: Add SCIF2 support on r8a7795
Message-Id: <87wpx7dc3e.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables SCIF2
Gaku Inami <gaku.inami.xw@bp.renesas.com> created original patch,
and Kuninori updated DTSI

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v4 -> v5

 - no change

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 22 ++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index efcd3c2..0de2771 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -80,6 +80,10 @@
 			};
 
 			cpg_clocks: cpg_clocks@e6150000 {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
 				compatible = "renesas,r8a7795-cpg-clocks",
 					     "renesas,rcar-gen3-cpg-clocks";
 				reg = <0 0xe6150000 0 0x1000>;
@@ -87,7 +91,25 @@
 				#clock-cells = <1>;
 				clock-output-names = "main", "pll0", "pll1","pll2",
 						     "pll3", "pll4";
+
+				mstp3_clks: mstp3_clks@e615013c {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+					clocks =  <&p_clk>;
+					#clock-cells = <1>;
+					renesas,clock-indices = <R8A7795_CLK_SCIF2>;
+					clock-output-names = "scif2";
+				};
 			};
 		};
+
+		scif2: serial@e6e88000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7795_CLK_SCIF2>;
+			clock-names = "sci_ick";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 334fa13..27b3a29 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -24,6 +24,7 @@
 /* MSTP2 */
 
 /* MSTP3 */
+#define R8A7795_CLK_SCIF2		10
 
 /* MSTP5 */
 
-- 
1.9.1

