From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 07:16:04 +0000
Subject: [PATCH 05/14][RFC] arm64: renesas: r8a7795: add AUDIO-DMAC support
Message-Id: <87k2ryn3y9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 72 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  2 +
 2 files changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 235f266..4586690 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -425,6 +425,18 @@
 					clock-indices = <R8A7795_CLK_SCIF2>;
 				};
 
+				mstp5_clks: mstp5_clks@e6150144 {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+					clocks = <&s3d4_clk>, <&s3d4_clk>;
+					#clock-cells = <1>;
+					clock-indices = <
+						R8A7795_CLK_AUDIO_DMAC0 R8A7795_CLK_AUDIO_DMAC1
+					>;
+					clock-output-names = "audmac0", "audmac1";
+				};
+
 				mstp9_clks: mstp9_clks@e6150994 {
 					compatible = "renesas,r8a7795-mstp-clocks",
 						     "renesas,cpg-mstp-clocks";
@@ -489,6 +501,66 @@
 			};
 		};
 
+		audma0: dma-controller@ec700000 {
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xec700000 0 0x10000>;
+			interrupts =	<0 350 IRQ_TYPE_LEVEL_HIGH
+					 0 320 IRQ_TYPE_LEVEL_HIGH
+					 0 321 IRQ_TYPE_LEVEL_HIGH
+					 0 322 IRQ_TYPE_LEVEL_HIGH
+					 0 323 IRQ_TYPE_LEVEL_HIGH
+					 0 324 IRQ_TYPE_LEVEL_HIGH
+					 0 325 IRQ_TYPE_LEVEL_HIGH
+					 0 326 IRQ_TYPE_LEVEL_HIGH
+					 0 327 IRQ_TYPE_LEVEL_HIGH
+					 0 328 IRQ_TYPE_LEVEL_HIGH
+					 0 329 IRQ_TYPE_LEVEL_HIGH
+					 0 330 IRQ_TYPE_LEVEL_HIGH
+					 0 331 IRQ_TYPE_LEVEL_HIGH
+					 0 332 IRQ_TYPE_LEVEL_HIGH
+					 0 333 IRQ_TYPE_LEVEL_HIGH
+					 0 334 IRQ_TYPE_LEVEL_HIGH
+					 0 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&mstp5_clks R8A7795_CLK_AUDIO_DMAC0>;
+			clock-names = "fck";
+			#dma-cells = <1>;
+			dma-channels = <15>;
+		};
+
+		audma1: dma-controller@ec720000 {
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xec720000 0 0x10000>;
+			interrupts =	<0 351 IRQ_TYPE_LEVEL_HIGH
+					 0 336 IRQ_TYPE_LEVEL_HIGH
+					 0 337 IRQ_TYPE_LEVEL_HIGH
+					 0 338 IRQ_TYPE_LEVEL_HIGH
+					 0 339 IRQ_TYPE_LEVEL_HIGH
+					 0 340 IRQ_TYPE_LEVEL_HIGH
+					 0 341 IRQ_TYPE_LEVEL_HIGH
+					 0 342 IRQ_TYPE_LEVEL_HIGH
+					 0 343 IRQ_TYPE_LEVEL_HIGH
+					 0 344 IRQ_TYPE_LEVEL_HIGH
+					 0 345 IRQ_TYPE_LEVEL_HIGH
+					 0 346 IRQ_TYPE_LEVEL_HIGH
+					 0 347 IRQ_TYPE_LEVEL_HIGH
+					 0 348 IRQ_TYPE_LEVEL_HIGH
+					 0 349 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13";
+			clocks = <&mstp5_clks R8A7795_CLK_AUDIO_DMAC1>;
+			clock-names = "fck";
+			#dma-cells = <1>;
+			dma-channels = <14>;
+		};
+
 		pfc: pfc@e6060000 {
 			compatible = "renesas,pfc-r8a7795";
 			reg = <0 0xe6060000 0 0x50c>;
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 6c523bb..f926b86 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -32,6 +32,8 @@
 #define R8A7795_CLK_SCIF2		10
 
 /* MSTP5 */
+#define R8A7795_CLK_AUDIO_DMAC0		2
+#define R8A7795_CLK_AUDIO_DMAC1		1
 
 /* MSTP7 */
 
-- 
1.9.1

