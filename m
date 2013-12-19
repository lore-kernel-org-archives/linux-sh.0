From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 19 Dec 2013 15:51:04 +0000
Subject: [PATCH 4/6] ARM: shmobile: r8a7791: Add QSPI module clock in device tree
Message-Id: <1387468266-13625-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 15 ++++++++-------
 include/dt-bindings/clock/r8a7791-clock.h |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6a29341..19c6550 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -482,17 +482,18 @@
 		mstp9_clks: mstp9_clks@e6150994 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				 <&p_clk>, <&p_clk>, <&p_clk>;
+			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>,
+				 <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				 <&p_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_I2C4
-				R8A7791_CLK_I2C4 R8A7791_CLK_I2C3 R8A7791_CLK_I2C2
-				R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
+				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD
+				R8A7791_CLK_I2C4 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
+				R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
 			>;
 			clock-output-names -				"rcan1", "rcan0", "i2c5", "i2c4", "i2c3", "i2c2", "i2c1",
-				"i2c0";
+				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c4", "i2c3",
+				"i2c2", "i2c1", "i2c0";
 		};
 		mstp11_clks: mstp11_clks@e615099c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index a69e090..30f82f2 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -94,6 +94,7 @@
 #define R8A7791_CLK_GPIO0		12
 #define R8A7791_CLK_RCAN1		15
 #define R8A7791_CLK_RCAN0		16
+#define R8A7791_CLK_QSPI_MOD		17
 #define R8A7791_CLK_I2C5		25
 #define R8A7791_CLK_IICDVFS		26
 #define R8A7791_CLK_I2C4		27
-- 
1.8.3.2

