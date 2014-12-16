From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 16 Dec 2014 16:26:03 +0000
Subject: [PATCH v2 7/7] ARM: shmobile: r8a73a4: ape6evm: remove legacy platform
Message-Id: <1418747163-21729-8-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This removes the remains of the legacy ape6evm platform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/Makefile             |   1 -
 arch/arm/mach-shmobile/Kconfig         |  13 --
 arch/arm/mach-shmobile/Makefile        |   1 -
 arch/arm/mach-shmobile/Makefile.boot   |   1 -
 arch/arm/mach-shmobile/board-ape6evm.c | 286 ---------------------------------
 5 files changed, 302 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 68bb222..e545624 100644
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
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f8977e7..5fc4756 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -108,13 +108,6 @@ config ARCH_SH73A0
 	select SH_INTC
 	select RENESAS_INTC_IRQPIN
 
-config ARCH_R8A73A4
-	bool "R-Mobile APE6 (R8A73A40)"
-	select ARCH_RMOBILE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_GIC
-	select RENESAS_IRQC
-
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
 	select ARCH_RMOBILE
@@ -136,12 +129,6 @@ config ARCH_R8A7779
 
 comment "Renesas ARM SoCs Board Type"
 
-config MACH_APE6EVM
-	bool "APE6EVM board"
-	depends on ARCH_R8A73A4
-	select SMSC_PHY if SMSC911X
-	select USE_OF
-
 config MACH_MACKEREL
 	bool "mackerel board"
 	depends on ARCH_SH7372
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 40f82ee..963d985 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o sleep-sh7372.o
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
-obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index e67a6c9..d893aa4 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -1,6 +1,5 @@
 # per-board load address for uImage
 loadaddr-y	:-loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
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

