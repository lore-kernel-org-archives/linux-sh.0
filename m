From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 17:43:16 +0000
Subject: [PATCH v5] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <Pine.LNX.4.64.1309261931340.11968@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org

Add SDHI0 and MMCIF interfaces to armadillo800eva-reference with
regulators and pin configurations. SDHI1 is not added yet, because the
switch, that connects the interface either to an SD slot or to a WiFi
SDIO card cannot be described in DT yet.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v5: remove SDHI1 until we can properly handle the WiFi / card slot switch.

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   58 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7740.dtsi                     |   33 +++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 8b2aab5..ea2992a 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -35,6 +35,33 @@
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
+	vccq_sdhi0: regulator@2 {
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
@@ -92,8 +119,39 @@
 		renesas,groups = "tpu0_to2_1";
 		renesas,function = "tpu0";
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
 };
 
 &tpu {
 	status = "okay";
 };
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
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 868bdde..ae1e230 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -161,4 +161,37 @@
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

