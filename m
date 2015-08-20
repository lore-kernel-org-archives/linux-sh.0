From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 09:26:47 +0000
Subject: [PATCH 08/17 v6][RFC] arm64: renesas: r8a7795: Add SCIF2 support
Message-Id: <87bne2b9fv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

This patch enables SCIF2
Gaku Inami <gaku.inami.xw@bp.renesas.com> created original patch,
and Kuninori updated DTSI

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v6

 - cpg has #clock-cells

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 21 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f013814..7bf9f56 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -49,10 +49,23 @@
 		};
 
 		cpg_clocks: cpg_clocks@e6150000 {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			ranges;
+
 			compatible = "renesas,r8a7795-cpg-clocks",
 				     "renesas,rcar-gen3-cpg-clocks";
 			reg = <0 0xe6150000 0 0x1000>;
 			clocks = <&extal_clk>;
+
+			mstp3_clks: mstp3_clks@e615013c {
+				compatible = "renesas,r8a7795-mstp-clocks",
+				             "renesas,cpg-mstp-clocks";
+				reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+				clocks =  <&s3d4_clks>;
+				renesas,clock-indices = <R8A7795_CLK_SCIF2>;
+			};
 		};
 	};
 
@@ -85,5 +98,13 @@
 				     <GIC_PPI 10
 					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
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

