From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 Oct 2015 14:05:16 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7791 dtsi: Remove bogus imp_clk node
Message-Id: <1445004316-17235-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <56e86dd4bbeb66a7ad67e20fa045c6f51b4da571.1443752733.git.horms+renesas@verge.net.au>
In-Reply-To: <56e86dd4bbeb66a7ad67e20fa045c6f51b4da571.1443752733.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R-Car M2-W does not have an IMP core or an IMP clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 328f48bd15e711ad..76742cc6021ee0a2 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1163,14 +1163,6 @@
 			clock-mult = <1>;
 			clock-output-names = "m2";
 		};
-		imp_clk: imp_clk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7791_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <4>;
-			clock-mult = <1>;
-			clock-output-names = "imp";
-		};
 		rclk_clk: rclk_clk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7791_CLK_PLL1>;
-- 
1.9.1

