From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 23 Apr 2014 08:25:27 +0000
Subject: [PATCH v3 1/2] ARM: shmobile: r8a7790 dtsi: Add GPIO clocks
Message-Id: <1398241528-7733-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - Add Acked-by
  - Bindings have been accepted in
    git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git#for-next

v2:
  - No changes
---
 arch/arm/boot/dts/r8a7790.dtsi |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index d38d70339149..7ff29601f962 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -117,6 +117,7 @@
 		gpio-ranges = <&pfc 0 0 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO0>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -128,6 +129,7 @@
 		gpio-ranges = <&pfc 0 32 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -139,6 +141,7 @@
 		gpio-ranges = <&pfc 0 64 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO2>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -150,6 +153,7 @@
 		gpio-ranges = <&pfc 0 96 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO3>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -161,6 +165,7 @@
 		gpio-ranges = <&pfc 0 128 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO4>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -172,6 +177,7 @@
 		gpio-ranges = <&pfc 0 160 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO5>;
 	};
 
 	thermal@e61f0000 {
@@ -802,14 +808,19 @@
 		mstp9_clks: mstp9_clks@e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>, <&cp_clk>,
+			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>, <&cp_clk>,
 				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
+				R8A7790_CLK_GPIO5 R8A7790_CLK_GPIO4 R8A7790_CLK_GPIO3
+				R8A7790_CLK_GPIO2 R8A7790_CLK_GPIO1 R8A7790_CLK_GPIO0
 				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD R8A7790_CLK_IICDVFS
 				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1 R8A7790_CLK_I2C0
 			>;
 			clock-output-names +				"gpio5", "gpio4", "gpio3", "gpio2", "gpio1", "gpio0",
 				"rcan1", "rcan0", "qspi_mod", "iic3",
 				"i2c3", "i2c2", "i2c1", "i2c0";
 		};
-- 
1.7.9.5

