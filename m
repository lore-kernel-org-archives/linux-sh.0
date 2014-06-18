From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 09:11:01 +0000
Subject: [PROTOTYPE 5/8] ARM: shmobile: add Audio DMAC clocks on DTSI
Message-Id: <87fvj2y449.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add MSTP5 clock definitions for Audio DMAC

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi            |    7 ++++---
 include/dt-bindings/clock/r8a7790-clock.h |    2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7a165be..d681c84 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -862,10 +862,11 @@
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
index f929a79e..098573b 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -67,6 +67,8 @@
 #define R8A7790_CLK_USBDMAC1		31
 
 /* MSTP5 */
+#define R8A7790_CLK_AUDIO_DMAC1		1
+#define R8A7790_CLK_AUDIO_DMAC0		2
 #define R8A7790_CLK_THERMAL		22
 #define R8A7790_CLK_PWM			23
 
-- 
1.7.9.5

