From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Aug 2014 04:40:42 +0000
Subject: [PATCH 4/5] ARM: shmobile: r8a7790: add generation level compatible for i2c
Message-Id: <87mwbiw7qv.wl%kuninori.morimoto.gx@renesas.com>
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
 arch/arm/boot/dts/r8a7790.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7218bff..02d07b7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -252,7 +252,7 @@
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7790";
+		compatible = "renesas,i2c-r8a7790", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
@@ -262,7 +262,7 @@
 	i2c1: i2c@e6518000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7790";
+		compatible = "renesas,i2c-r8a7790", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
@@ -272,7 +272,7 @@
 	i2c2: i2c@e6530000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7790";
+		compatible = "renesas,i2c-r8a7790", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
@@ -282,7 +282,7 @@
 	i2c3: i2c@e6540000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7790";
+		compatible = "renesas,i2c-r8a7790", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
-- 
1.7.9.5

