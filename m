From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 26 Jun 2014 00:47:58 +0000
Subject: [PATCH] ARM: shmobile: r8a7791: fixup GPIO6/7 register address
Message-Id: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch is based on R-Car M2 v0.4 datasheet

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 336a6c0..1613ede 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -150,9 +150,9 @@
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO5>;
 	};
 
-	gpio6: gpio@e6055400 {
+	gpio6: gpio@e6055100 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xe6055400 0 0x50>;
+		reg = <0 0xe6055100 0 0x50>;
 		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
@@ -162,9 +162,9 @@
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO6>;
 	};
 
-	gpio7: gpio@e6055800 {
+	gpio7: gpio@e6055200 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xe6055800 0 0x50>;
+		reg = <0 0xe6055200 0 0x50>;
 		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
-- 
1.7.9.5

