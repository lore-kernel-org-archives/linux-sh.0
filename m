From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 16 Dec 2014 16:25:57 +0000
Subject: [PATCH v2 1/7] ARM: shmobile: ape6evm: synchronize dts with reference platform
Message-Id: <1418747163-21729-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This moves everything to the legacy dts that is missing there in
preparation for the switch to multiplatform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 94 +++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index ce085fa..c98cd14 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -10,14 +10,19 @@
 
 /dts-v1/;
 #include "r8a73a4.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "APE6EVM";
 	compatible = "renesas,ape6evm", "renesas,r8a73a4";
 
+	aliases {
+		serial0 = &scifa0;
+	};
+
 	chosen {
 		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		stdout-path = &scifa0;
 	};
 
 	memory@40000000 {
@@ -30,7 +35,27 @@
 		reg = <2 0x00000000 0 0x40000000>;
 	};
 
-	ape6evm_fixed_3v3: fixedregulator@0 {
+	vcc_mmc0: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "MMC0 Vcc";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	vcc_sdhi0: regulator@1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pfc 76 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/* Common 3.3V rail, used by several devices on APE6EVM */
+	ape6evm_fixed_3v3: regulator@2 {
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
 		regulator-min-microvolt = <3300000>;
@@ -39,11 +64,13 @@
 	};
 
 	lbsc {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		ranges = <0 0 0 0x20000000>;
 
 		ethernet@8000000 {
-			compatible = "smsc,lan9118", "smsc,lan9115";
+			compatible = "smsc,lan9220", "smsc,lan9115";
 			reg = <0x08000000 0x1000>;
 			interrupt-parent = <&irqc1>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -79,3 +106,64 @@
 	>;
 	voltage-tolerance = <1>; /* 1% */
 };
+
+&cmt1 {
+	status = "okay";
+};
+
+&pfc {
+	scifa0_pins: serial0 {
+		renesas,groups = "scifa0_data";
+		renesas,function = "scifa0";
+	};
+
+	mmc0_pins: mmc {
+		renesas,groups = "mmc0_data8", "mmc0_ctrl";
+		renesas,function = "mmc0";
+	};
+
+	sdhi0_pins: sd0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi1_pins: sd1 {
+		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
+		renesas,function = "sdhi1";
+	};
+};
+
+&mmcif0 {
+	vmmc-supply = <&vcc_mmc0>;
+	bus-width = <8>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	status = "okay";
+};
+
+&scifa0 {
+	pinctrl-0 = <&scifa0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&sdhi0 {
+	vmmc-supply = <&vcc_sdhi0>;
+	bus-width = <4>;
+	toshiba,mmc-wrprotect-disable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhi0_pins>;
+	status = "okay";
+};
+
+&sdhi1 {
+	vmmc-supply = <&ape6evm_fixed_3v3>;
+	bus-width = <4>;
+	broken-cd;
+	toshiba,mmc-wrprotect-disable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhi1_pins>;
+	status = "okay";
+};
-- 
1.8.4.5

