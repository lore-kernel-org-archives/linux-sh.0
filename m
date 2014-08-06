From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Aug 2014 04:40:52 +0000
Subject: [PATCH 5/5] ARM: shmobile: r8a7791: add generation level compatible for i2c
Message-Id: <87lhr2w7ql.wl%kuninori.morimoto.gx@renesas.com>
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
 arch/arm/boot/dts/r8a7791.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1e97113..854eca2 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -245,7 +245,7 @@
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
@@ -255,7 +255,7 @@
 	i2c1: i2c@e6518000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
@@ -265,7 +265,7 @@
 	i2c2: i2c@e6530000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
@@ -275,7 +275,7 @@
 	i2c3: i2c@e6540000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
@@ -285,7 +285,7 @@
 	i2c4: i2c@e6520000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
@@ -296,7 +296,7 @@
 		/* doesn't need pinmux */
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
-- 
1.7.9.5

