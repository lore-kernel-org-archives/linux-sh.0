From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:44:09 +0000
Subject: [PATCH 01/17] ARM: shmobile: r8a73a4: fixup DT node naming for SDHI
Message-Id: <87hacjdlmi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SDHI DT node from "sdhi" to "sd".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   16 ++++++++--------
 arch/arm/boot/dts/r8a73a4.dtsi                  |    6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 9443e93..27ce4ac 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -33,7 +33,7 @@
 		regulator-always-on;
 	};
 
-	vcc_sdhi0: regulator@1 {
+	vcc_sd0: regulator@1 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI0 Vcc";
@@ -98,12 +98,12 @@
 		renesas,function = "mmc0";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sd0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
 		renesas,function = "sdhi0";
 	};
 
-	sdhi1_pins: sdhi1 {
+	sd1_pins: sd1 {
 		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
 		renesas,function = "sdhi1";
 	};
@@ -118,21 +118,21 @@
 	status = "okay";
 };
 
-&sdhi0 {
-	vmmc-supply = <&vcc_sdhi0>;
+&sd0 {
+	vmmc-supply = <&vcc_sd0>;
 	bus-width = <4>;
 	toshiba,mmc-wrprotect-disable;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-0 = <&sd0_pins>;
 	status = "okay";
 };
 
-&sdhi1 {
+&sd1 {
 	vmmc-supply = <&ape6evm_fixed_3v3>;
 	bus-width = <4>;
 	broken-cd;
 	toshiba,mmc-wrprotect-disable;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-0 = <&sd1_pins>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 287e047..447c128 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -244,7 +244,7 @@
 		#gpio-cells = <2>;
 	};
 
-	sdhi0: sdhi@ee100000 {
+	sd0: sd@ee100000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -253,7 +253,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi@ee120000 {
+	sd1: sd@ee120000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -262,7 +262,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi@ee140000 {
+	sd2: sd@ee140000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

