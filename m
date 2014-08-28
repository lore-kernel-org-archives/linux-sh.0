From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 28 Aug 2014 08:21:55 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7779 dtsi: Use tabs for indentation
Message-Id: <1409214116-6016-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1400761997-13512-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1400761997-13512-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Checkpatch says:

ERROR: code indent should use tabs where possible

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index ddc89000854c..d25ed7b4aece 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -440,10 +440,10 @@
 		/* Gate clocks */
 		mstp0_clks: clocks@ffc80030 {
 			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
+				     "renesas,cpg-mstp-clocks";
 			reg = <0xffc80030 4>;
 			clocks = <&cpg_clocks R8A7779_CLK_S>,
-			         <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>,
@@ -477,7 +477,7 @@
 		};
 		mstp1_clks: clocks@ffc80034 {
 			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
+				     "renesas,cpg-mstp-clocks";
 			reg = <0xffc80034 4>, <0xffc80044 4>;
 			clocks = <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
@@ -506,7 +506,7 @@
 		};
 		mstp3_clks: clocks@ffc8003c {
 			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
+				     "renesas,cpg-mstp-clocks";
 			reg = <0xffc8003c 4>;
 			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
 				 <&s4_clk>, <&s4_clk>;
-- 
1.9.1

