From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 05 Nov 2014 10:04:34 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock
Message-Id: <1415181874-21549-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to the datasheet, the operating clock for IIC0 is the HPP
(RT Peri) clock, not the SUB (Peri) clock. Both clocks run at the same
speed (50 Mhz).

This is consistent with IIC0 being located in the A4R PM domain, and
IIC1 in the A3SP PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 20d2b56773fbf069..e2c9496c2c325a1f 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -497,7 +497,7 @@
 			clocks = <&cpg_clocks R8A7740_CLK_S>,
 				 <&cpg_clocks R8A7740_CLK_S>, <&sub_clk>,
 				 <&cpg_clocks R8A7740_CLK_B>,
-				 <&sub_clk>, <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_HPP>, <&sub_clk>,
 				 <&cpg_clocks R8A7740_CLK_B>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-- 
1.9.1

