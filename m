From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 23 Feb 2014 12:40:22 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7791: add IIC(B) clocks to dtsi
Message-Id: <1393159224-14377-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1389082976-22254-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389082976-22254-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3b2cdc8..eb2cec8 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -674,14 +674,16 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>,
-				<&cpg_clocks R8A7791_CLK_SD0>, <&mmc0_clk>, <&rclk_clk>;
+				<&cpg_clocks R8A7791_CLK_SD0>, <&mmc0_clk>, <&rclk_clk>,
+				<&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1
 				R8A7791_CLK_SDHI0 R8A7791_CLK_MMCIF0 R8A7791_CLK_CMT1
+				R8A7791_CLK_IIC0 R8A7791_CLK_IIC1
 			>;
 			clock-output-names -				"tpu0", "sdhi2", "sdhi1", "sdhi0", "mmcif0", "cmt1";
+				"tpu0", "sdhi2", "sdhi1", "sdhi0", "mmcif0", "cmt1", "i2c7", "i2c8";
 		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
@@ -727,16 +729,17 @@
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
 			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>,
 				 <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				 <&p_clk>;
+				 <&p_clk>, <&cp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD
 				R8A7791_CLK_I2C5 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
 				R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
+				R8A7791_CLK_IICDVFS
 			>;
 			clock-output-names  				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c4", "i2c3",
-				"i2c2", "i2c1", "i2c0";
+				"i2c2", "i2c1", "i2c0", "i2c6";
 		};
 		mstp11_clks: mstp11_clks@e615099c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.8.5.1

