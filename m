From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:45:09 +0000
Subject: [PATCH 07/17] ARM: shmobile: sh73a0: fixup DT node naming for SDHI
Message-Id: <878uxvdlku.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SDHI DT node from "sdhi" to "sd".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   20 ++++++++++----------
 arch/arm/boot/dts/sh73a0.dtsi                |    6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 8ee06dd..eaeebd2 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -59,7 +59,7 @@
 		regulator-boot-on;
 	};
 
-	vmmc_sdhi0: regulator@2 {
+	vmmc_sd0: regulator@2 {
 	        compatible = "regulator-fixed";
 		regulator-name = "SDHI0 Vcc";
 		regulator-min-microvolt = <3300000>;
@@ -68,7 +68,7 @@
 		enable-active-high;
 	};
 
-	vmmc_sdhi2: regulator@3 {
+	vmmc_sd2: regulator@3 {
 	        compatible = "regulator-fixed";
 		regulator-name = "SDHI2 Vcc";
 		regulator-min-microvolt = <3300000>;
@@ -222,31 +222,31 @@
 		renesas,function = "scifa4";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sd0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
 
-	sdhi2_pins: sdhi2 {
+	sd2_pins: sd2 {
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
 };
 
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
+&sd0 {
+	pinctrl-0 = <&sd0_pins>;
 	pinctrl-names = "default";
 
-	vmmc-supply = <&vmmc_sdhi0>;
+	vmmc-supply = <&vmmc_sd0>;
 	bus-width = <4>;
 	status = "okay";
 };
 
-&sdhi2 {
-	pinctrl-0 = <&sdhi2_pins>;
+&sd2 {
+	pinctrl-0 = <&sd2_pins>;
 	pinctrl-names = "default";
 
-	vmmc-supply = <&vmmc_sdhi2>;
+	vmmc-supply = <&vmmc_sd2>;
 	bus-width = <4>;
 	broken-cd;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index fcf2688..ead8e58 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -200,7 +200,7 @@
 		status = "disabled";
 	};
 
-	sdhi0: sdhi@ee100000 {
+	sd0: sd@ee100000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee100000 0x100>;
 		interrupt-parent = <&gic>;
@@ -212,7 +212,7 @@
 	};
 
 	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
-	sdhi1: sdhi@ee120000 {
+	sd1: sd@ee120000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee120000 0x100>;
 		interrupt-parent = <&gic>;
@@ -223,7 +223,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi@ee140000 {
+	sd2: sd@ee140000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee140000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

