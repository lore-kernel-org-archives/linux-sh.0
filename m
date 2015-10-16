From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 Oct 2015 14:05:15 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7794 dtsi: Remove bogus imp_clk node
Message-Id: <1445004316-17235-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R-Car E2 does not have an IMP core or an IMP clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index a9977d6ee81af21f..6fc1acff507faa2e 100644
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
1.9.1

