From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Oct 2014 08:26:32 +0000
Subject: [PATCH 01/11] ARM: shmobile: r8a7790: Add Audio DMAC devices to DT
Message-Id: <87ioj2x8sp.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Instantiate the two Audio DMA controllers in the r8a7790 device tree.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi            |   64 +++++++++++++++++++++++++++--
 include/dt-bindings/clock/r8a7790-clock.h |    2 +
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0f18db0..a7c1338 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -312,6 +312,63 @@
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
+
+	audma0: dma-contorller@ec700000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xec700000 0 0x10000>;
+		interrupts =	<0 346 IRQ_TYPE_LEVEL_HIGH
+				 0 320 IRQ_TYPE_LEVEL_HIGH
+				 0 321 IRQ_TYPE_LEVEL_HIGH
+				 0 322 IRQ_TYPE_LEVEL_HIGH
+				 0 323 IRQ_TYPE_LEVEL_HIGH
+				 0 324 IRQ_TYPE_LEVEL_HIGH
+				 0 325 IRQ_TYPE_LEVEL_HIGH
+				 0 326 IRQ_TYPE_LEVEL_HIGH
+				 0 327 IRQ_TYPE_LEVEL_HIGH
+				 0 328 IRQ_TYPE_LEVEL_HIGH
+				 0 329 IRQ_TYPE_LEVEL_HIGH
+				 0 330 IRQ_TYPE_LEVEL_HIGH
+				 0 331 IRQ_TYPE_LEVEL_HIGH
+				 0 332 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12";
+		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC0>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <13>;
+	};
+
+	audma1: dma-controller@ec720000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xec720000 0 0x10000>;
+		interrupts =	<0 347 IRQ_TYPE_LEVEL_HIGH
+				 0 333 IRQ_TYPE_LEVEL_HIGH
+				 0 334 IRQ_TYPE_LEVEL_HIGH
+				 0 335 IRQ_TYPE_LEVEL_HIGH
+				 0 336 IRQ_TYPE_LEVEL_HIGH
+				 0 337 IRQ_TYPE_LEVEL_HIGH
+				 0 338 IRQ_TYPE_LEVEL_HIGH
+				 0 339 IRQ_TYPE_LEVEL_HIGH
+				 0 340 IRQ_TYPE_LEVEL_HIGH
+				 0 341 IRQ_TYPE_LEVEL_HIGH
+				 0 342 IRQ_TYPE_LEVEL_HIGH
+				 0 343 IRQ_TYPE_LEVEL_HIGH
+				 0 344 IRQ_TYPE_LEVEL_HIGH
+				 0 345 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12";
+		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC1>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <13>;
+	};
+
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1058,10 +1115,11 @@
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&extal_clk>, <&p_clk>;
+			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
-			clock-output-names = "thermal", "pwm";
+			renesas,clock-indices = <R8A7790_CLK_AUDIO_DMAC0 R8A7790_CLK_AUDIO_DMAC1
+						 R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
+			clock-output-names = "audmac0", "audamc1", "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index e3a3fb8..c27b3b5 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -78,6 +78,8 @@
 #define R8A7790_CLK_USBDMAC1		31
 
 /* MSTP5 */
+#define R8A7790_CLK_AUDIO_DMAC1		1
+#define R8A7790_CLK_AUDIO_DMAC0		2
 #define R8A7790_CLK_THERMAL		22
 #define R8A7790_CLK_PWM			23
 
-- 
1.7.9.5

