From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 01 Apr 2014 11:02:17 +0000
Subject: [PATCH 3/4] ARM: shmobile: r8a7790: Fix the I2C clocks parents in DT
Message-Id: <1396350138-26850-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All I2C clocks derive from the HP clock, not from the P clock. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index da69afc..c4b9ff7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -758,7 +758,7 @@
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
 			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>,
-				 <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
+				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD
-- 
1.8.3.2

