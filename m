From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 27 Aug 2015 19:02:29 +0000
Subject: [PATCH 3/5] arm64: renesas: r8a7795 dtsi: Add pll1_div2 clock
Message-Id: <1440702151-1406-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the pll1_div2 clock, which runs at half the frequency of pll1.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 54f2a2b0e1158335..7a9dee91fee6ba7b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -71,6 +71,15 @@
 			#clock-cells = <1>;
 			ranges;
 
+			pll1_div2_clk: pll1_div2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+				clock-output-names = "pll1_div2";
+			};
+
 			zt_clk: zt {
 				compatible = "fixed-factor-clock";
 				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
-- 
1.9.1

