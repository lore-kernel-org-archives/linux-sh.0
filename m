From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 01 Aug 2013 07:41:21 +0000
Subject: [PATCH 3/3] ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT nodes
Message-Id: <1375342881-2155-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds MMCIF0, SDHI0 and SDHI1 DT nodes and a fixed voltage
reglator for them to the ape6evm-reference platform.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v4: make SDHI0 Vcc 3.3V instead of 3.0V

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   72 +++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index bbd09d8..6797fac 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 /include/ "r8a73a4.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "APE6EVM";
@@ -24,6 +25,34 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
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
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	lbsc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -62,4 +91,47 @@
 		renesas,groups = "scifa0_data";
 		renesas,function = "scifa0";
 	};
+
+	mmc0_pins: mmcif {
+		renesas,groups = "mmc0_data8", "mmc0_ctrl";
+		renesas,function = "mmc0";
+	};
+
+	sdhi0_pins: sdhi0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi1_pins: sdhi1 {
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
 };
-- 
1.7.2.5

