From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 13:16:18 +0000
Subject: [PATCH 3/6] ARM: shmobile: armadillo800eva-reference: add MMCIF and SDHI DT nodes
Message-Id: <1374498981-5263-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1363915432-21720-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363915432-21720-4-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add MMCIF, SDHI0 and SDHI1 DT nodes to armadillo800eva-reference together
with required regulators and pinctrl bindings.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   83 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7740.dtsi                     |   33 ++++++++
 2 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 366f729..1acf1bd 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -49,6 +49,44 @@
 			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	vcc_sdhi0: regulator@1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vcc-sdhi0";
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
+		regulator-name = "vcc-sdhi1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pfc 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: gpio-regulator@0 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "vccq-sdhi0";
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
 };
 
 &i2c0 {
@@ -63,6 +101,36 @@
 	};
 };
 
+&mmcif0 {
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <8>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	status = "okay";
+};
+
+&sdhi0 {
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	cap-power-off-card;
+	bus-width = <4>;
+	cd-gpios = <&pfc 167 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhi0_pins>;
+	status = "okay";
+};
+
+&sdhi1 {
+	vmmc-supply = <&vcc_sdhi1>;
+	cap-power-off-card;
+	bus-width = <4>;
+	cd-gpios = <&pfc 72 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhi1_pins>;
+	status = "okay";
+};
+
 &pfc {
 	pinctrl-0 = <&scifa1_pins>;
 	pinctrl-names = "default";
@@ -76,4 +144,19 @@
 		renesas,groups = "intc_irq10";
 		renesas,function = "intc";
 	};
+
+	mmc0_pins: mmcif {
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
 };
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 638ada2..1d112f9 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -235,6 +235,39 @@
 			      0 73 0x4>;
 	};
 
+	mmcif0: mmcif@e6bd0000 {
+		compatible = "renesas,sh-mmcif", "renesas,sh7372-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 56 4
+				0 57 4>;
+		status = "disabled";
+	};
+
+	sdhi0: sdhi@e6850000 {
+		compatible = "renesas,r8a7740-sdhi";
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
+		compatible = "renesas,r8a7740-sdhi";
+		reg = <0xe6860000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 121 4
+				0 122 4
+				0 123 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
 	pfc: pfc@e6050000 {
 		compatible = "renesas,pfc-r8a7740";
 		reg = <0xe6050000 0x8000>,
-- 
1.7.2.5

