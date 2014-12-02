From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:37:19 +0000
Subject: [PATCH 5/5] ARM: shmobile: r8a73a4: ape6evm: replace legacy with multiplatform
Message-Id: <1417509439-31739-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This removes the remains of the legacy ape6evm platform and replaces it
with multiplatform, at the same time renaming the latter to ape6evm.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/Makefile                      |   3 +-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 240 --------------------
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           | 169 +++++++++++++-
 arch/arm/mach-shmobile/board-ape6evm.c          | 286 ------------------------
 4 files changed, 165 insertions(+), 533 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d8ab74e..841796e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -377,7 +377,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
-	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
@@ -388,7 +387,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	sh73a0-kzm9g-reference.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
-	r8a73a4-ape6evm-reference.dtb \
+	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
deleted file mode 100644
index cd5b2f1..0000000
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ /dev/null
@@ -1,240 +0,0 @@
-/*
- * Device Tree Source for the APE6EVM board
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/dts-v1/;
-#include "r8a73a4.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "APE6EVM";
-	compatible = "renesas,ape6evm-reference", "renesas,r8a73a4";
-
-	aliases {
-		serial0 = &scifa0;
-	};
-
-	chosen {
-		bootargs = "ignore_loglevel rw";
-		stdout-path = &scifa0;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0 0x40000000 0 0x40000000>;
-	};
-
-	memory@200000000 {
-		device_type = "memory";
-		reg = <2 0x00000000 0 0x40000000>;
-	};
-
-	vcc_mmc0: regulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "MMC0 Vcc";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		regulator-always-on;
-	};
-
-	vcc_sdhi0: regulator@1 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "SDHI0 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&pfc 76 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	/* Common 3.3V rail, used by several devices on APE6EVM */
-	ape6evm_fixed_3v3: regulator@2 {
-		compatible = "regulator-fixed";
-		regulator-name = "3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	lbsc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0x80000000>;
-
-		ethernet@8000000 {
-			compatible = "smsc,lan9220", "smsc,lan9115";
-			reg = <0x08000000 0x1000>;
-			interrupt-parent = <&irqc1>;
-			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
-			phy-mode = "mii";
-			reg-io-width = <4>;
-			smsc,irq-active-high;
-			smsc,irq-push-pull;
-			vddvario-supply = <&ape6evm_fixed_3v3>;
-			vdd33a-supply = <&ape6evm_fixed_3v3>;
-			status = "okay";
-			clocks = <&zb_clk>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		led1 {
-			gpios = <&pfc 28 GPIO_ACTIVE_LOW>;
-			label = "gnss-en";
-		};
-		led2 {
-			gpios = <&pfc 126 GPIO_ACTIVE_LOW>;
-			label = "nfc-nrst";
-		};
-		led3 {
-			gpios = <&pfc 132 GPIO_ACTIVE_LOW>;
-			label = "gnss-nrst";
-		};
-		led4 {
-			gpios = <&pfc 232 GPIO_ACTIVE_LOW>;
-			label = "bt-wakeup";
-		};
-		led5 {
-			gpios = <&pfc 250 GPIO_ACTIVE_LOW>;
-			label = "strobe";
-		};
-		led6 {
-			gpios = <&pfc 288 GPIO_ACTIVE_LOW>;
-			label = "bbresetout";
-		};
-	};
-
-	keyboard {
-		compatible = "gpio-keys";
-
-		zero-key {
-			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_0>;
-			label = "S16";
-		};
-
-		menu-key {
-			gpios = <&pfc 325 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_MENU>;
-			label = "S17";
-		};
-
-		home-key {
-			gpios = <&pfc 326 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_HOME>;
-			label = "S18";
-		};
-
-		back-key {
-			gpios = <&pfc 327 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_BACK>;
-			label = "S19";
-		};
-
-		volup-key {
-			gpios = <&pfc 328 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEUP>;
-			label = "S20";
-		};
-
-		voldown-key {
-			gpios = <&pfc 329 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			label = "S21";
-		};
-	};
-};
-
-&i2c5 {
-	status = "okay";
-	vdd_dvfs: max8973@1b {
-		compatible = "maxim,max8973";
-		reg = <0x1b>;
-
-		regulator-min-microvolt = <935000>;
-		regulator-max-microvolt = <1200000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_dvfs>;
-	operating-points = <
-		/* kHz  uV */
-		1950000 1115000
-		1462500  995000
-	>;
-	voltage-tolerance = <1>; /* 1% */
-};
-
-&cmt1 {
-	status = "okay";
-};
-
-&pfc {
-	scifa0_pins: serial0 {
-		renesas,groups = "scifa0_data";
-		renesas,function = "scifa0";
-	};
-
-	mmc0_pins: mmc {
-		renesas,groups = "mmc0_data8", "mmc0_ctrl";
-		renesas,function = "mmc0";
-	};
-
-	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
-		renesas,function = "sdhi0";
-	};
-
-	sdhi1_pins: sd1 {
-		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
-		renesas,function = "sdhi1";
-	};
-};
-
-&mmcif0 {
-	vmmc-supply = <&vcc_mmc0>;
-	bus-width = <8>;
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	status = "okay";
-};
-
-&scifa0 {
-	pinctrl-0 = <&scifa0_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&sdhi0 {
-	vmmc-supply = <&vcc_sdhi0>;
-	bus-width = <4>;
-	toshiba,mmc-wrprotect-disable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhi0_pins>;
-	status = "okay";
-};
-
-&sdhi1 {
-	vmmc-supply = <&ape6evm_fixed_3v3>;
-	bus-width = <4>;
-	broken-cd;
-	toshiba,mmc-wrprotect-disable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhi1_pins>;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index ce085fa..3c7b7c3 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -10,14 +10,20 @@
 
 /dts-v1/;
 #include "r8a73a4.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "APE6EVM";
 	compatible = "renesas,ape6evm", "renesas,r8a73a4";
 
+	aliases {
+		serial0 = &scifa0;
+	};
+
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		bootargs = "ignore_loglevel rw";
+		stdout-path = &scifa0;
 	};
 
 	memory@40000000 {
@@ -30,7 +36,27 @@
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
@@ -39,11 +65,13 @@
 	};
 
 	lbsc {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		ranges = <0 0 0 0x80000000>;
 
 		ethernet@8000000 {
-			compatible = "smsc,lan9118", "smsc,lan9115";
+			compatible = "smsc,lan9220", "smsc,lan9115";
 			reg = <0x08000000 0x1000>;
 			interrupt-parent = <&irqc1>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -51,8 +79,78 @@
 			reg-io-width = <4>;
 			smsc,irq-active-high;
 			smsc,irq-push-pull;
-			vdd33a-supply = <&ape6evm_fixed_3v3>;
 			vddvario-supply = <&ape6evm_fixed_3v3>;
+			vdd33a-supply = <&ape6evm_fixed_3v3>;
+			status = "okay";
+			clocks = <&zb_clk>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 28 GPIO_ACTIVE_LOW>;
+			label = "gnss-en";
+		};
+		led2 {
+			gpios = <&pfc 126 GPIO_ACTIVE_LOW>;
+			label = "nfc-nrst";
+		};
+		led3 {
+			gpios = <&pfc 132 GPIO_ACTIVE_LOW>;
+			label = "gnss-nrst";
+		};
+		led4 {
+			gpios = <&pfc 232 GPIO_ACTIVE_LOW>;
+			label = "bt-wakeup";
+		};
+		led5 {
+			gpios = <&pfc 250 GPIO_ACTIVE_LOW>;
+			label = "strobe";
+		};
+		led6 {
+			gpios = <&pfc 288 GPIO_ACTIVE_LOW>;
+			label = "bbresetout";
+		};
+	};
+
+	keyboard {
+		compatible = "gpio-keys";
+
+		zero-key {
+			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_0>;
+			label = "S16";
+		};
+
+		menu-key {
+			gpios = <&pfc 325 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+			label = "S17";
+		};
+
+		home-key {
+			gpios = <&pfc 326 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			label = "S18";
+		};
+
+		back-key {
+			gpios = <&pfc 327 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			label = "S19";
+		};
+
+		volup-key {
+			gpios = <&pfc 328 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			label = "S20";
+		};
+
+		voldown-key {
+			gpios = <&pfc 329 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			label = "S21";
 		};
 	};
 };
@@ -79,3 +177,64 @@
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
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
deleted file mode 100644
index 66f6781..0000000
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ /dev/null
@@ -1,286 +0,0 @@
-/*
- * APE6EVM board support
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/mfd/tmio.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
-#include <linux/pinctrl/machine.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-#include <linux/sh_clk.h>
-#include <linux/smsc911x.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "irqs.h"
-#include "r8a73a4.h"
-
-/* LEDS */
-static struct gpio_led ape6evm_leds[] = {
-	{
-		.name		= "gnss-en",
-		.gpio		= 28,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "nfc-nrst",
-		.gpio		= 126,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "gnss-nrst",
-		.gpio		= 132,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "bt-wakeup",
-		.gpio		= 232,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "strobe",
-		.gpio		= 250,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	}, {
-		.name		= "bbresetout",
-		.gpio		= 288,
-		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
-	},
-};
-
-static __initdata struct gpio_led_platform_data ape6evm_leds_pdata = {
-	.leds		= ape6evm_leds,
-	.num_leds	= ARRAY_SIZE(ape6evm_leds),
-};
-
-/* GPIO KEY */
-#define GPIO_KEY(c, g, d, ...) \
-	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
-
-static struct gpio_keys_button gpio_buttons[] = {
-	GPIO_KEY(KEY_0,			324,	"S16"),
-	GPIO_KEY(KEY_MENU,		325,	"S17"),
-	GPIO_KEY(KEY_HOME,		326,	"S18"),
-	GPIO_KEY(KEY_BACK,		327,	"S19"),
-	GPIO_KEY(KEY_VOLUMEUP,		328,	"S20"),
-	GPIO_KEY(KEY_VOLUMEDOWN,	329,	"S21"),
-};
-
-static struct gpio_keys_platform_data ape6evm_keys_pdata __initdata = {
-	.buttons	= gpio_buttons,
-	.nbuttons	= ARRAY_SIZE(gpio_buttons),
-};
-
-/* Dummy supplies, where voltage doesn't matter */
-static struct regulator_consumer_supply dummy_supplies[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
-};
-
-/* SMSC LAN9220 */
-static const struct resource lan9220_res[] __initconst = {
-	DEFINE_RES_MEM(0x08000000, 0x1000),
-	{
-		.start	= irq_pin(40), /* IRQ40 */
-		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_HIGH,
-	},
-};
-
-static const struct smsc911x_platform_config lan9220_data __initconst = {
-	.flags		= SMSC911X_USE_32BIT,
-	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
-};
-
-/*
- * MMC0 power supplies:
- * Both Vcc and VccQ to eMMC on APE6EVM are supplied by a tps80032 voltage
- * regulator. Until support for it is added to this file we simulate the
- * Vcc supply by a fixed always-on regulator
- */
-static struct regulator_consumer_supply vcc_mmc0_consumers[] -{
-	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
-};
-
-/*
- * SDHI0 power supplies:
- * Vcc to SDHI0 on APE6EVM is supplied by a GPIO-switchable regulator. VccQ is
- * provided by the same tps80032 regulator as both MMC0 voltages - see comment
- * above
- */
-static struct regulator_consumer_supply vcc_sdhi0_consumers[] -{
-	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
-};
-
-static struct regulator_init_data vcc_sdhi0_init_data = {
-	.constraints = {
-		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = ARRAY_SIZE(vcc_sdhi0_consumers),
-	.consumer_supplies      = vcc_sdhi0_consumers,
-};
-
-static const struct fixed_voltage_config vcc_sdhi0_info __initconst = {
-	.supply_name = "SDHI0 Vcc",
-	.microvolts = 3300000,
-	.gpio = 76,
-	.enable_high = 1,
-	.init_data = &vcc_sdhi0_init_data,
-};
-
-/*
- * SDHI1 power supplies:
- * Vcc and VccQ to SDHI1 on APE6EVM are both fixed at 3.3V
- */
-static struct regulator_consumer_supply vcc_sdhi1_consumers[] -{
-	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
-};
-
-/* MMCIF */
-static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
-	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
-	.slave_id_tx	= SHDMA_SLAVE_MMCIF0_TX,
-	.slave_id_rx	= SHDMA_SLAVE_MMCIF0_RX,
-	.ccs_unsupported = true,
-};
-
-static const struct resource mmcif0_resources[] __initconst = {
-	DEFINE_RES_MEM(0xee200000, 0x100),
-	DEFINE_RES_IRQ(gic_spi(169)),
-};
-
-/* SDHI0 */
-static const struct sh_mobile_sdhi_info sdhi0_pdata __initconst = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-};
-
-static const struct resource sdhi0_resources[] __initconst = {
-	DEFINE_RES_MEM(0xee100000, 0x100),
-	DEFINE_RES_IRQ(gic_spi(165)),
-};
-
-/* SDHI1 */
-static const struct sh_mobile_sdhi_info sdhi1_pdata __initconst = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
-			  MMC_CAP_NEEDS_POLL,
-};
-
-static const struct resource sdhi1_resources[] __initconst = {
-	DEFINE_RES_MEM(0xee120000, 0x100),
-	DEFINE_RES_IRQ(gic_spi(166)),
-};
-
-static const struct pinctrl_map ape6evm_pinctrl_map[] __initconst = {
-	/* SCIFA0 console */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
-				  "scifa0_data", "scifa0"),
-	/* SMSC */
-	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a73a4",
-				  "irqc_irq40", "irqc"),
-	/* MMCIF0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
-				  "mmc0_data8", "mmc0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
-				  "mmc0_ctrl", "mmc0"),
-	/* SDHI0: uSD: no WP */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
-				  "sdhi0_data4", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
-				  "sdhi0_ctrl", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
-				  "sdhi0_cd", "sdhi0"),
-	/* SDHI1 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a73a4",
-				  "sdhi1_data4", "sdhi1"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a73a4",
-				  "sdhi1_ctrl", "sdhi1"),
-};
-
-static void __init ape6evm_add_standard_devices(void)
-{
-
-	struct clk *parent;
-	struct clk *mp;
-
-	r8a73a4_clock_init();
-
-	/* MP clock parent = extal2 */
-	parent      = clk_get(NULL, "extal2");
-	mp          = clk_get(NULL, "mp");
-	BUG_ON(IS_ERR(parent) || IS_ERR(mp));
-
-	clk_set_parent(mp, parent);
-	clk_put(parent);
-	clk_put(mp);
-
-	pinctrl_register_mappings(ape6evm_pinctrl_map,
-				  ARRAY_SIZE(ape6evm_pinctrl_map));
-	r8a73a4_pinmux_init();
-	r8a73a4_add_standard_devices();
-
-	/* LAN9220 ethernet */
-	gpio_request_one(270, GPIOF_OUT_INIT_HIGH, NULL); /* smsc9220 RESET */
-
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-
-	platform_device_register_resndata(NULL, "smsc911x", -1,
-					  lan9220_res, ARRAY_SIZE(lan9220_res),
-					  &lan9220_data, sizeof(lan9220_data));
-
-	regulator_register_always_on(1, "MMC0 Vcc", vcc_mmc0_consumers,
-				     ARRAY_SIZE(vcc_mmc0_consumers), 2800000);
-	platform_device_register_resndata(NULL, "sh_mmcif", 0,
-					  mmcif0_resources, ARRAY_SIZE(mmcif0_resources),
-					  &mmcif0_pdata, sizeof(mmcif0_pdata));
-	platform_device_register_data(NULL, "reg-fixed-voltage", 2,
-				      &vcc_sdhi0_info, sizeof(vcc_sdhi0_info));
-	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 0,
-					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
-					  &sdhi0_pdata, sizeof(sdhi0_pdata));
-	regulator_register_always_on(3, "SDHI1 Vcc", vcc_sdhi1_consumers,
-				     ARRAY_SIZE(vcc_sdhi1_consumers), 3300000);
-	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 1,
-					  sdhi1_resources, ARRAY_SIZE(sdhi1_resources),
-					  &sdhi1_pdata, sizeof(sdhi1_pdata));
-	platform_device_register_data(NULL, "gpio-keys", -1,
-				      &ape6evm_keys_pdata,
-				      sizeof(ape6evm_keys_pdata));
-	platform_device_register_data(NULL, "leds-gpio", -1,
-				      &ape6evm_leds_pdata,
-				      sizeof(ape6evm_leds_pdata));
-}
-
-static const char *ape6evm_boards_compat_dt[] __initdata = {
-	"renesas,ape6evm",
-	NULL,
-};
-
-DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= shmobile_init_delay,
-	.init_machine	= ape6evm_add_standard_devices,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= ape6evm_boards_compat_dt,
-MACHINE_END
-- 
1.8.4.5

