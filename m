From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 18 Jul 2014 05:28:39 +0000
Subject: [PATCH] ARM: shmobile: r8a7791: fixup SD2CKCR register address
Message-Id: <87a987grqy.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Hi Geert, Simon

Can you please test this patch ?
I don't have M2 board

 arch/arm/boot/dts/r8a7791.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6e9a556..0d82a4b 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -583,9 +583,9 @@
 			#clock-cells = <0>;
 			clock-output-names = "sd1";
 		};
-		sd2_clk: sd3_clk@e615007c {
+		sd2_clk: sd3_clk@e615026c {
 			compatible = "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe615007c 0 4>;
+			reg = <0 0xe615026c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "sd2";
-- 
1.7.9.5

