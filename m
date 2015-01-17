From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 17 Jan 2015 00:58:37 +0000
Subject: [PATCH 04/11] ARM: shmobile: r8a7791: fix MSTP8 input clocks
Message-Id: <2fd4e094bbe6de0dc98355c4c387c433f6de525c.1421380713.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I made  a mistake when rebasing Andrey Gusakov's patch adding MLB+ clock to the
R8A7791 device  tree, inserting <&hp_clk> into the "clocks"  property of the
MSTP8 node at a wrong position, so that the input clocks for MLB+ and IPMMU-SGX
got swapped...

Fixes: 7408d3061d2f ("ARM: shmobile: r8a7791: add MLB+ clock")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 2810226..946cd3a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1154,7 +1154,7 @@
 		mstp8_clks: mstp8_clks@e6150990 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&hp_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
+			clocks = <&zg_clk>, <&hp_clk>, <&zg_clk>, <&zg_clk>,
 			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
-- 
2.1.4

