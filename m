From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 27 Aug 2015 19:02:30 +0000
Subject: [PATCH 4/5] arm64: renesas: r8a7795 dtsi: Add mso MSIOF parent clock
Message-Id: <1440702151-1406-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the mso clock, which is the programmable DIV6 parent clock of the
MSIOF module clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 7a9dee91fee6ba7b..75908b8ccd6dc33a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -254,6 +254,16 @@
 						     "pll3", "pll4";
 				#power-domain-cells = <0>;
 
+				mso_clk: mso_clk@e6150014 {
+					compatible +						"renesas,r8a7795-div6-clock",
+						"renesas,cpg-div6-clock";
+					reg = <0 0xe6150014 0 4>;
+					clocks = <&pll1_div2_clk>;
+					#clock-cells = <0>;
+					clock-output-names = "mso";
+				};
+
 				mstp2_clks: mstp2_clks@e6150138 {
 					compatible  						"renesas,r8a7795-mstp-clocks",
-- 
1.9.1

