From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 01 Apr 2014 11:02:18 +0000
Subject: [PATCH 4/4] ARM: shmobile: r8a7791: Fix the I2C clocks parents in DT
Message-Id: <1396350138-26850-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All I2C clocks derive from the HP clock, not from the P clock. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index f71670a..f1e8900 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -805,9 +805,9 @@
 		mstp9_clks: mstp9_clks@e6150994 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>, <&p_clk>,
-				 <&cp_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				 <&p_clk>, <&p_clk>;
+			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>, <&hp_clk>,
+				 <&cp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
+				 <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD R8A7791_CLK_I2C5
-- 
1.8.3.2

