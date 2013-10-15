From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:44:43 +0000
Subject: [PATCH 04/17] ARM: shmobile: r8a7740: fixup DT node naming for SDHI
Message-Id: <87d2n7dllk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SDHI DT node from "sdhi" to "sd".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   16 ++++++++--------
 arch/arm/boot/dts/r8a7740.dtsi                     |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 1c56c5e..5b6578d 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -35,7 +35,7 @@
 		regulator-boot-on;
 	};
 
-	vcc_sdhi0: regulator@1 {
+	vcc_sd0: regulator@1 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI0 Vcc";
@@ -46,13 +46,13 @@
 		enable-active-high;
 	};
 
-	vccq_sdhi0: regulator@2 {
+	vccq_sd0: regulator@2 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI0 VccQ";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_sdhi0>;
+		vin-supply = <&vcc_sd0>;
 
 		enable-gpio = <&pfc 74 GPIO_ACTIVE_HIGH>;
 		gpios = <&pfc 17 GPIO_ACTIVE_HIGH>;
@@ -125,7 +125,7 @@
 		renesas,function = "mmc0";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sd0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
@@ -145,12 +145,12 @@
 	status = "okay";
 };
 
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
+&sd0 {
+	pinctrl-0 = <&sd0_pins>;
 	pinctrl-names = "default";
 
-	vmmc-supply = <&vcc_sdhi0>;
-	vqmmc-supply = <&vccq_sdhi0>;
+	vmmc-supply = <&vcc_sd0>;
+	vqmmc-supply = <&vccq_sd0>;
 	bus-width = <4>;
 	cd-gpios = <&pfc 167 GPIO_ACTIVE_LOW>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index ae1e230..d384fd8 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -171,7 +171,7 @@
 		status = "disabled";
 	};
 
-	sdhi0: sdhi@e6850000 {
+	sd0: sd@e6850000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6850000 0x100>;
 		interrupt-parent = <&gic>;
@@ -183,7 +183,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi@e6860000 {
+	sd1: sd@e6860000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6860000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

