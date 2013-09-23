From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 23 Sep 2013 15:38:47 +0000
Subject: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add SDHI0, SDHI1 and MMCIF interfaces to armadillo800eva-reference with 
regulators and pin configurations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v4:

1. now that PFC pinctrl is usable with DT, we can use proper regulators 
and pin configurations on armadillo800eva

2. corrected SDHI compatibility strings

3. RFC because I don't know how to enable choosing between CON14 and CON8. 
In .c version this is done by reading GPIO 6. To do the same in DT mode 
we'd probably have to use some run-time DT patching, which isn't possible 
yet, AFAICS.

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   83 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7740.dtsi                     |   33 ++++++++
 2 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index c638e4a..af15be0 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -34,6 +34,44 @@
 		regulator-boot-on;
 	};
 
+	vcc_sdhi0: regulator@1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pfc 75 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc_sdhi1: regulator@2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pfc 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: regulator@3 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sdhi0>;
+
+		enable-gpio = <&pfc 74 GPIO_ACTIVE_HIGH>;
+		gpios = <&pfc 17 GPIO_ACTIVE_HIGH>;
+		states = <3300000 0
+			  1800000 1>;
+
+		enable-active-high;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led1 {
@@ -76,4 +114,49 @@
 		renesas,groups = "intc_irq10";
 		renesas,function = "intc";
 	};
+
+	mmc0_pins: mmc0 {
+		renesas,groups = "mmc0_data8_1", "mmc0_ctrl_1";
+		renesas,function = "mmc0";
+	};
+
+	sdhi0_pins: sdhi0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi1_pins: sdhi1 {
+		renesas,groups = "sdhi1_data4", "sdhi1_ctrl", "sdhi1_cd", "sdhi1_wp";
+		renesas,function = "sdhi1";
+	};
+};
+
+&mmcif0 {
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	bus-width = <4>;
+	broken-cd;
+	status = "okay";
+};
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi1>;
+	bus-width = <4>;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 44d3d52..018c02d 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -159,4 +159,37 @@
 		status = "disabled";
 		#pwm-cells = <3>;
 	};
+
+	mmcif0: mmcif@e6bd0000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 56 4
+				0 57 4>;
+		status = "disabled";
+	};
+
+	sdhi0: sdhi@e6850000 {
+		compatible = "renesas,sdhi-r8a7740";
+		reg = <0xe6850000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 117 4
+				0 118 4
+				0 119 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi1: sdhi@e6860000 {
+		compatible = "renesas,sdhi-r8a7740";
+		reg = <0xe6860000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 121 4
+				0 122 4
+				0 123 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
 };
-- 
1.7.2.5

