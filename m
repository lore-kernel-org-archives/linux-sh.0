From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Apr 2013 14:11:41 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: Armadillo800EVA: Reference DT implementation
Message-Id: <9752999.C2OXdWVk6a@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Thursday 04 April 2013 15:45:44 Bastian Hecht wrote:
> Provide alternate board code for the kzm9g to demonstrate
> how DT may be used given the current state of driver
> device tree support. This is intended to act as a reference
> for mach-shmobile developers.
> 
> This a rather bare bone version with the following devices supported:
> 
>  - GIC
>  - irqpins
>  - i2c0/1
>  - touchscreen
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                         |    1 +
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |   45 +++++
>  arch/arm/boot/dts/r8a7740.dtsi                     |  117 +++++++++++
>  arch/arm/mach-shmobile/Kconfig                     |   14 ++
>  arch/arm/mach-shmobile/Makefile                    |    1 +
>  .../board-armadillo800eva-reference.c              |  211 +++++++++++++++++
>  6 files changed, 389 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
>  create mode 100644 arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 47b6be7..48de263 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -136,6 +136,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
>  	ccu9540.dtb
>  dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
>  	r8a7740-armadillo800eva.dtb \
> +	r8a7740-armadillo800eva-reference.dtb \
>  	r8a7778-bockw.dtb \
>  	r8a7779-marzen-reference.dtb \
>  	r8a7790-lager.dtb \
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts new file mode
> 100644
> index 0000000..09ea22c
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> @@ -0,0 +1,45 @@
> +/*
> + * Reference Device Tree Source for the armadillo 800 eva board
> + *
> + * Copyright (C) 2012 Renesas Solutions Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "r8a7740.dtsi"
> +
> +/ {
> +	model = "armadillo 800 eva reference";
> +	compatible = "renesas,armadillo800eva-reference", "renesas,r8a7740";
> +
> +	chosen {
> +		bootargs = "console=tty0 console=ttySC1,115200
> earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp
> nfsroot=,rsize@96,wsize@96 rw"; +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x40000000 0x20000000>;
> +	};
> +
> +	reg_3p3v: regulator@0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +};
> +
> +&i2c0 {
> +	touchscreen: st1232@55 {
> +		compatible = "sitronix,st1232";
> +		reg = <0x55>;
> +		interrupt-parent = <&irqpin1>;
> +		interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
> +	};
> +};
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 798fa35..25dc930 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -18,4 +18,121 @@
>  			compatible = "arm,cortex-a9";
>  		};
>  	};
> +
> +	gic: interrupt-controller@c2800000 {
> +		compatible = "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		#address-cells = <1>;
> +		interrupt-controller;
> +		reg = <0xc2800000 0x1000>,
> +		      <0xc2000000 0x1000>;
> +	};
> +
> +	/* irqpin0: IRQ0 - IRQ7 */
> +	irqpin0: irqpin@e6900000 {
> +		compatible = "renesas,intc-irqpin";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		reg = <0xe6900000 4>,
> +			<0xe6900010 4>,
> +			<0xe6900020 1>,
> +			<0xe6900040 1>,
> +			<0xe6900060 1>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4>;
> +	};
> +
> +	/* irqpin1: IRQ8 - IRQ15 */
> +	irqpin1: irqpin@e6900004 {
> +		compatible = "renesas,intc-irqpin";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		reg = <0xe6900004 4>,
> +			<0xe6900014 4>,
> +			<0xe6900024 1>,
> +			<0xe6900044 1>,
> +			<0xe6900064 1>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4>;
> +	};
> +
> +	/* irqpin2: IRQ16 - IRQ23 */
> +	irqpin2: irqpin@e6900008 {
> +		compatible = "renesas,intc-irqpin";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		reg = <0xe6900008 4>,
> +			<0xe6900018 4>,
> +			<0xe6900028 1>,
> +			<0xe6900048 1>,
> +			<0xe6900068 1>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4>;
> +	};
> +
> +	/* irqpin3: IRQ24 - IRQ31 */
> +	irqpin3: irqpin@e690000c {
> +		compatible = "renesas,intc-irqpin";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		reg = <0xe690000c 4>,
> +			<0xe690001c 4>,
> +			<0xe690002c 1>,
> +			<0xe690004c 1>,
> +			<0xe690006c 1>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4
> +			      0 149 0x4>;
> +	};
> +
> +	i2c0: i2c@fff20000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,rmobile-iic";
> +		reg = <0xfff20000 0x425>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 201 0x4
> +			      0 202 0x4
> +			      0 203 0x4
> +			      0 204 0x4>;
> +	};
> +
> +	i2c1: i2c@e6c20000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,rmobile-iic";
> +		reg = <0xe6c20000 0x425>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 70 0x4
> +			      0 71 0x4
> +			      0 72 0x4
> +			      0 73 0x4>;
> +	};
>  };
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 1a517e2..c6fb9ec 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -129,6 +129,20 @@ config MACH_ARMADILLO800EVA
>  	select SND_SOC_WM8978 if SND_SIMPLE_CARD
>  	select USE_OF
> 
> +config MACH_ARMADILLO800EVA_REFERENCE
> +	bool "Armadillo-800 EVA board - Reference Device Tree Implementation"
> +	depends on ARCH_R8A7740
> +	select ARCH_REQUIRE_GPIOLIB
> +	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> +	select SND_SOC_WM8978 if SND_SIMPLE_CARD
> +	select USE_OF
> +	---help---
> +	   Use reference implementation of Aramdillo800 EVA board support
> +	   which makes a greater use of device tree at the expense
> +	   of not supporting a number of devices.
> +
> +	   This is intended to aid developers
> +
>  config MACH_BOCKW
>  	bool "BOCK-W platform"
>  	depends on ARCH_R8A7778
> diff --git a/arch/arm/mach-shmobile/Makefile
> b/arch/arm/mach-shmobile/Makefile index 068f1da..812de04 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
>  obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
>  obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
>  obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
> +obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+> board-armadillo800eva-reference.o obj-$(CONFIG_MACH_KZM9D)	+= board-
kzm9d.o
>  obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
>  obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c new file mode
> 100644
> index 0000000..3b86cdc
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> @@ -0,0 +1,211 @@
> +/*
> + * armadillo 800 eva board support
> + *
> + * Copyright (C) 2012 Renesas Solutions Corp.
> + * Copyright (C) 2012 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
> USA + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/pinctrl/machine.h>
> +#include <mach/common.h>
> +#include <mach/r8a7740.h>
> +#include <asm/mach/arch.h>
> +#include <asm/hardware/cache-l2x0.h>
> +
> +/*
> + * CON1		Camera Module
> + * CON2		Extension Bus
> + * CON3		HDMI Output
> + * CON4		Composite Video Output
> + * CON5		H-UDI JTAG
> + * CON6		ARM JTAG
> + * CON7		SD1
> + * CON8		SD2
> + * CON9		RTC BackUp
> + * CON10	Monaural Mic Input
> + * CON11	Stereo Headphone Output
> + * CON12	Audio Line Output(L)
> + * CON13	Audio Line Output(R)
> + * CON14	AWL13 Module
> + * CON15	Extension
> + * CON16	LCD1
> + * CON17	LCD2
> + * CON19	Power Input
> + * CON20	USB1
> + * CON21	USB2
> + * CON22	Serial
> + * CON23	LAN
> + * CON24	USB3
> + * LED1		Camera LED(Yellow)
> + * LED2		Power LED (Green)
> + * ED3-LED6	User LED(Yellow)
> + * LED7		LAN link LED(Green)
> + * LED8		LAN activity LED(Yellow)
> + */
> +
> +/*
> + * DipSwitch
> + *
> + *                    SW1
> + *
> + * -12345678-+---------------+----------------------------
> + *  1        | boot          | hermit
> + *  0        | boot          | OS auto boot
> + * -12345678-+---------------+----------------------------
> + *   00      | boot device   | eMMC
> + *   10      | boot device   | SDHI0 (CON7)
> + *   01      | boot device   | -
> + *   11      | boot device   | Extension Buss (CS0)
> + * -12345678-+---------------+----------------------------
> + *     0     | Extension Bus | D8-D15 disable, eMMC enable
> + *     1     | Extension Bus | D8-D15 enable,  eMMC disable
> + * -12345678-+---------------+----------------------------
> + *      0    | SDHI1         | COM8 disable, COM14 enable
> + *      1    | SDHI1         | COM8 enable,  COM14 disable
> + * -12345678-+---------------+----------------------------
> + *       0   | USB0          | COM20 enable,  COM24 disable
> + *       1   | USB0          | COM20 disable, COM24 enable
> + * -12345678-+---------------+----------------------------
> + *        00 | JTAG          | SH-X2
> + *        10 | JTAG          | ARM
> + *        01 | JTAG          | -
> + *        11 | JTAG          | Boundary Scan
> + *-----------+---------------+----------------------------
> + */
> +
> +/*
> + * FSI-WM8978
> + *
> + * this command is required when playback.
> + *
> + * # amixer set "Headphone" 50
> + *
> + * this command is required when capture.
> + *
> + * # amixer set "Input PGA" 15
> + * # amixer set "Left Input Mixer MicP" on
> + * # amixer set "Left Input Mixer MicN" on
> + * # amixer set "Right Input Mixer MicN" on
> + * # amixer set "Right Input Mixer MicP" on
> + */
> +
> +/*
> + * USB function
> + *
> + * When you use USB Function,
> + * set SW1.6 ON, and connect cable to CN24.
> + *
> + * USBF needs workaround on R8A7740 chip.
> + * These are a little bit complex.
> + * see
> + *	usbhsf_power_ctrl()
> + */
> +
> +static const struct pinctrl_map eva_pinctrl_map[] = {
> +	/* SCIFA1 */
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.1", "pfc-r8a7740",
> +				  "scifa1_data", "scifa1"),
> +};
> +
> +static void __init eva_clock_init(void)
> +{
> +	struct clk *system	= clk_get(NULL, "system_clk");
> +	struct clk *xtal1	= clk_get(NULL, "extal1");
> +	struct clk *usb24s	= clk_get(NULL, "usb24s");
> +	struct clk *fsibck	= clk_get(NULL, "fsibck");
> +
> +	if (IS_ERR(system)	||
> +	    IS_ERR(xtal1)	||
> +	    IS_ERR(usb24s)	||
> +	    IS_ERR(fsibck)) {
> +		pr_err("armadillo800eva board clock init failed\n");
> +		goto clock_error;
> +	}
> +
> +	/* armadillo 800 eva extal1 is 24MHz */
> +	clk_set_rate(xtal1, 24000000);
> +
> +	/* usb24s use extal1 (= system) clock (= 24MHz) */
> +	clk_set_parent(usb24s, system);
> +
> +	/* FSIBCK is 12.288MHz, and it is parent of FSI-B */
> +	clk_set_rate(fsibck, 12288000);
> +
> +clock_error:
> +	if (!IS_ERR(system))
> +		clk_put(system);
> +	if (!IS_ERR(xtal1))
> +		clk_put(xtal1);
> +	if (!IS_ERR(usb24s))
> +		clk_put(usb24s);
> +	if (!IS_ERR(fsibck))
> +		clk_put(fsibck);
> +}
> +
> +/*
> + * board init
> + */
> +static void __init eva_init(void)
> +{
> +
> +	r8a7740_clock_init(MD_CK0 | MD_CK2);
> +	eva_clock_init();
> +
> +	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
> +	r8a7740_pinmux_init();
> +
> +	r8a7740_meram_workaround();
> +
> +	/* Touchscreen */
> +	gpio_request(GPIO_FN_IRQ10,     NULL); /* TP_INT */

Please, no function GPIO in reference DT implementations.

> +	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */

The GPIO should be passed to the touchscreen driver through DT. As we have no 
GPIO DT bindings for the r8a7740 yet, an option would be to pass it through 
platform data (using OF_DEV_AUXDATA).

> +#ifdef CONFIG_CACHE_L2X0
> +	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
> +	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
> +#endif
> +
> +	r8a7740_add_standard_devices_dt();
> +	r8a7740_pm_init();
> +}
> +
> +#define RESCNT2 IOMEM(0xe6188020)
> +static void eva_restart(char mode, const char *cmd)
> +{
> +	/* Do soft power on reset */
> +	writel((1 << 31), RESCNT2);
> +}
> +
> +static const char *eva_boards_compat_dt[] __initdata = {
> +	"renesas,armadillo800eva-reference",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
> +	.map_io		= r8a7740_map_io,
> +	.init_early	= r8a7740_init_delay,
> +	.init_irq	= r8a7740_init_irq_of,
> +	.init_machine	= eva_init,
> +	.init_time	= shmobile_timer_init,
> +	.init_late	= shmobile_init_late,
> +	.dt_compat	= eva_boards_compat_dt,
> +	.restart	= eva_restart,
> +MACHINE_END
-- 
Regards,

Laurent Pinchart

