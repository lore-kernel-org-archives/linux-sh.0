From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 15:50:04 +0000
Subject: [PATCH/RFC 3/3] ARM: shmobile: switch SDHI and MMCIF interfaces on kzm9g-reference to pinctrl
Message-Id: <1360684204-12888-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The recently added on sh73a0 DT pinctrl support enables us to switch SDHI
and MMCIF interface pins to pinctrl and to add GPIO bindings for their
card-detection pins and regulators.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   61 +++++++++++++++++++-----
 arch/arm/boot/dts/sh73a0-reference.dtsi        |    9 ----
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   36 ++------------
 3 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index fe0ee98..b93b16a 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -36,13 +36,37 @@
 		regulator-boot-on;
 	};
 
-	reg_2p8v: regulator@1 {
+	vcc_sdhi0: regulator@1 {
 		compatible = "regulator-fixed";
-		regulator-name = "fixed-2.8V";
+		regulator-name = "vcc-sdhi0";
 		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
-		regulator-always-on;
-		regulator-boot-on;
+
+		gpio = <&gpio 15 0>;
+		enable-active-high;
+	};
+
+	vcc_sdhi2: regulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-sdhi2";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+
+		gpio = <&gpio 14 0>;
+		enable-active-high;
+	};
+
+	mmcif0: mmcif@0xe6bd0000 {
+		compatible = "renesas,sh-mmcif", "renesas,sh73a0-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 140 4
+				0 141 4>;
+		vmmc-supply = <&reg_1p8v>;
+		bus-width = <8>;
+		non-removable;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mmc0_pins>;
 	};
 
 	sdhi0: sdhi@0xee100000 {
@@ -52,8 +76,12 @@
 		interrupts = <0 83 4
 				0 84 4
 				0 85 4>;
-		vmmc-supply = <&reg_2p8v>;
+		vmmc-supply = <&vcc_sdhi0>;
 		bus-width = <4>;
+		cd-gpios = <&gpio 162 1>;
+		broken-cd;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdhi0_pins>;
 		toshiba,mmc-has-idle-wait;
 	};
 
@@ -63,9 +91,11 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 4
 				0 105 4>;
-		vmmc-supply = <&reg_2p8v>;
+		vmmc-supply = <&vcc_sdhi2>;
 		bus-width = <4>;
-		broken-cd;
+		cd-gpios = <&gpio 13 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdhi2_pins>;
 		toshiba,mmc-wrprotect-disable;
 		toshiba,mmc-has-idle-wait;
 	};
@@ -77,13 +107,20 @@
 };
 
 &gpio {
+	sdhi0_pins: pfc_sdhi0_pins {
+		renesas,pins = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp", "sdhi0_cd";
+		renesas,function = "sdhi0";
+	};
+	sdhi2_pins: pfc_sdhi2_pins {
+		renesas,pins = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2";
+	};
+	mmc0_pins: pfc_mmc0_pins {
+		renesas,pins = "mmc0_data8_0", "mmc0_ctrl_0";
+		renesas,function = "mmc0";
+	};
 	i2c3_pins: pfc_i2c3_pins {
 		renesas,pins = "i2c3_1";
 		renesas,function = "i2c3";
 	};
 };
-
-&mmcif {
-	bus-width = <8>;
-	vmmc-supply = <&reg_1p8v>;
-};
diff --git a/arch/arm/boot/dts/sh73a0-reference.dtsi b/arch/arm/boot/dts/sh73a0-reference.dtsi
index 457afc7..3da1983 100644
--- a/arch/arm/boot/dts/sh73a0-reference.dtsi
+++ b/arch/arm/boot/dts/sh73a0-reference.dtsi
@@ -13,15 +13,6 @@
 / {
 	compatible = "renesas,sh73a0";
 
-	mmcif: mmcif@0x10010000 {
-		compatible = "renesas,sh-mmcif";
-		reg = <0xe6bd0000 0x100>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 140 0x4
-			      0 141 0x4>;
-		reg-io-width = <4>;
-	};
-
 	gic: interrupt-controller@f0001000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index d92da6d..1490246 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -90,38 +90,12 @@ static void __init kzm_init(void)
 	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	platform_device_register(&smsc_device);
 
-	/* enable MMCIF */
-	gpio_request(GPIO_FN_MMCCLK0,		NULL);
-	gpio_request(GPIO_FN_MMCCMD0_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_0_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_1_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_2_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_3_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_4_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_5_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);
-
-	/* enable SD */
-	gpio_request(GPIO_FN_SDHIWP0,		NULL);
-	gpio_request(GPIO_FN_SDHICD0,		NULL);
-	gpio_request(GPIO_FN_SDHICMD0,		NULL);
-	gpio_request(GPIO_FN_SDHICLK0,		NULL);
-	gpio_request(GPIO_FN_SDHID0_3,		NULL);
-	gpio_request(GPIO_FN_SDHID0_2,		NULL);
-	gpio_request(GPIO_FN_SDHID0_1,		NULL);
-	gpio_request(GPIO_FN_SDHID0_0,		NULL);
+	/*
+	 * Enable SD: this is a pseudo-GPIO, it actually only sets bit 28 in
+	 * MSEL3CR to turn VCCQ_MC0 on. One could make a primitive fixed
+	 * regulator of this and use it as vqmmc-supply for SDHI0.
+	 */
 	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
-	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
-
-	/* enable Micro SD */
-	gpio_request(GPIO_FN_SDHID2_0,		NULL);
-	gpio_request(GPIO_FN_SDHID2_1,		NULL);
-	gpio_request(GPIO_FN_SDHID2_2,		NULL);
-	gpio_request(GPIO_FN_SDHID2_3,		NULL);
-	gpio_request(GPIO_FN_SDHICMD2,		NULL);
-	gpio_request(GPIO_FN_SDHICLK2,		NULL);
-	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
-- 
1.7.2.5

