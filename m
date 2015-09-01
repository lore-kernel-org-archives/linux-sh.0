From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 01 Sep 2015 15:12:40 +0000
Subject: [PATCH 5/6] arm64: renesas: r8a7795 dtsi: Link CPG to RST using "renesas,modemr"
Message-Id: <1441120361-1232-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a link from the Clock Pulse Generator node to the Reset Controller
node, so the CPG can read the Mode Monitoring Register (MODEMR) to
obtain the mode pin values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 05de9810aef0d569..a2235400146289e2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -358,6 +358,7 @@
 					R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
 				>;
 				#power-domain-cells = <0>;
+				renesas,modemr = <&rst 0x60>;
 
 				mstp2_clks: mstp2_clks@e6150138 {
 					compatible -- 
1.9.1

