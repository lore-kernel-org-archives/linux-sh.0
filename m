From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 23 Apr 2014 01:25:54 +0000
Subject: [PATCH 26/33] ARM: shmobile: r8a7790: Fix the I2C clocks parents in DT
Message-Id: <3672b059e3a8582171863e1c588059a37aa56b75.1398216022.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All I2C clocks derive from the HP clock, not from the P clock. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
1.8.5.2

