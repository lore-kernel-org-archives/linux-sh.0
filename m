From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Aug 2014 04:40:34 +0000
Subject: [PATCH 3/5] ARM: shmobile: r8a7779: add generation level compatible for i2c
Message-Id: <87oavyw7r3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, Simon <horms@verge.net.au>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 463e3fd..ac89e42 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -159,7 +159,7 @@
 	i2c0: i2c@ffc70000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7779";
+		compatible = "renesas,i2c-r8a7779", "renesas,i2c-rcar-gen1";
 		reg = <0xffc70000 0x1000>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
@@ -169,7 +169,7 @@
 	i2c1: i2c@ffc71000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7779";
+		compatible = "renesas,i2c-r8a7779", "renesas,i2c-rcar-gen1";
 		reg = <0xffc71000 0x1000>;
 		interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
@@ -179,7 +179,7 @@
 	i2c2: i2c@ffc72000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7779";
+		compatible = "renesas,i2c-r8a7779", "renesas,i2c-rcar-gen1";
 		reg = <0xffc72000 0x1000>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
@@ -189,7 +189,7 @@
 	i2c3: i2c@ffc73000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7779";
+		compatible = "renesas,i2c-r8a7779", "renesas,i2c-rcar-gen1";
 		reg = <0xffc73000 0x1000>;
 		interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
-- 
1.7.9.5

