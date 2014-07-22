From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 22 Jul 2014 05:04:29 +0000
Subject: [PATCH v2] ARM: shmobile: r8a7791: Fix SD2CKCR register address
Message-Id: <87fvhuhtlw.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

59e79895b95892863617ce630fbda467f2470575
(ARM: shmobile: r8a7791: Add clocks)
added r8a7791 SD clocks when v3.14.

2c60a7df72711fb8b4be1e6aa651ab166a8931bc
(ARM: shmobile: Add SDHI devices for Koelsch DTS)
enabled SD on r8a7791 Koelsch when v3.15.

1299df03d7191ab4356c995dde8b912d3c8922e9
(ARM: shmobile: henninger: add SDHI0/2 DT support)
enable SD on r8a7791 Henninger when v3.16.

But r8a7791 SD clock had wrong address.
This patch fixup it.

[Kuninori Morimoto: tidyup for upstreaming]

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- update git log

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

