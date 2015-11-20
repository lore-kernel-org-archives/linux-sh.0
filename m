From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 01:05:09 +0000
Subject: [PATCH 02/29] ARM: shmobile: r8a7794 dtsi: Remove bogus imp_clk node
Message-Id: <b6be6b2f3be270cbd53fb13706c32500f6cd1432.1447981420.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Car E2 does not have an IMP core or an IMP clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index a9977d6ee81a..6fc1acff507f 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -879,14 +879,6 @@
 			clock-mult = <1>;
 			clock-output-names = "m2";
 		};
-		imp_clk: imp_clk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <4>;
-			clock-mult = <1>;
-			clock-output-names = "imp";
-		};
 		rclk_clk: rclk_clk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-- 
2.1.4

