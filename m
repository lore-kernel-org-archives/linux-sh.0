From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 05 Jul 2013 04:53:03 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: APE6EVM: add DT reference
Message-Id: <CANqRtoRdKx8VuvrjUUpycxW1Unw6yHHhHZj7VKixpERChFZLeg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372970438-21549-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372970438-21549-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Fri, Jul 5, 2013 at 5:40 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch adds a sample DT-based APE6EVM "reference" implementation. The
> use of platform-specific C-code should be avoided with this configuration
> as much as possible.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks for your patch.

>  arch/arm/boot/dts/Makefile                       |    1 +
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   76 +++++++++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                   |   11 +++
>  arch/arm/mach-shmobile/Makefile                  |    1 +
>  arch/arm/mach-shmobile/board-ape6evm-reference.c |   77 ++++++++++++++++++++++
>  5 files changed, 166 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
>  create mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c

It seems that Makefile.boot is missing, did you look at the Lager DT
reference code by Simon like I asked you to?

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f2dc697..ea5f2bd 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -169,6 +169,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
>         sh73a0-kzm9g.dtb \
>         sh73a0-kzm9g-reference.dtb \
>         r8a73a4-ape6evm.dtb \
> +       r8a73a4-ape6evm-reference.dtb \
>         sh7372-mackerel.dtb
>  dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
>         socfpga_vt.dtb
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> new file mode 100644
> index 0000000..ea386fe
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> @@ -0,0 +1,76 @@
> +/*
> + * Device Tree Source for the APE6EVM board
> + *
> + * Copyright (C) 2013 Renesas Solutions Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "r8a73a4.dtsi"
> +
> +/ {
> +       model = "APE6EVM";
> +       compatible = "renesas,ape6evm-reference", "renesas,r8a73a4";
> +
> +       chosen {
> +               bootargs = "console=ttySC0,115200 debug root=/dev/nfs ip=dhcp";
> +       };
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0 0x40000000 0 0x40000000>;
> +       };
> +
> +       ape6evm_fixed_3v3: fixedregulator@0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "3V3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;
> +       };
> +
> +       lbsc {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0 0 0 0x80000000>;
> +
> +               ethernet@8000000 {
> +                       compatible = "smsc,lan9118", "smsc,lan9115";
> +                       reg = <0x08000000 0x1000>;
> +                       interrupt-parent = <&irqc1>;
> +                       interrupts = <8 0x4>;
> +                       phy-mode = "mii";
> +                       reg-io-width = <4>;
> +                       smsc,irq-active-high;
> +                       smsc,irq-push-pull;
> +                       vdd33a-supply = <&ape6evm_fixed_3v3>;
> +                       vddvario-supply = <&ape6evm_fixed_3v3>;
> +               };
> +       };
> +};
> +
> +&i2c5 {
> +       vdd_dvfs: max8973@1b {
> +               compatible = "maxim,max8973";
> +               reg = <0x1b>;
> +
> +               regulator-min-microvolt = <935000>;
> +               regulator-max-microvolt = <1200000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +};
> +
> +&cpu0 {
> +       cpu0-supply = <&vdd_dvfs>;
> +       operating-points = <
> +               /* kHz  uV */
> +               1950000 1115000
> +               1462500  995000
> +       >;
> +       voltage-tolerance = <1>; /* 1% */
> +};


It's nice that you have several device that you can add here, but can
we please do that in an incremental fashion. So please begin by
sending out a potentially correct initial APE6EVM DT reference board
support patch with more or less nothing included in it.

> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 30c571b..606e3a6 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -83,6 +83,17 @@ config MACH_APE6EVM
>         depends on ARCH_R8A73A4
>         select USE_OF
>
> +config MACH_APE6EVM_REFERENCE
> +       bool "APE6EVM board - Reference Device Tree Implementation"
> +       depends on ARCH_R8A73A4
> +       select USE_OF
> +       ---help---
> +          Use reference implementation of APE6EVM board support
> +          which makes a greater use of device tree at the expense
> +          of not supporting a number of devices.
> +
> +          This is intended to aid developers
> +
>  config MACH_MACKEREL
>         bool "mackerel board"
>         depends on ARCH_SH7372
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index d813133..7535ccb 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_ARCH_SH73A0)     += pm-sh73a0.o
>  # Board objects
>  obj-$(CONFIG_MACH_AG5EVM)      += board-ag5evm.o
>  obj-$(CONFIG_MACH_APE6EVM)     += board-ape6evm.o
> +obj-$(CONFIG_MACH_APE6EVM_REFERENCE)   += board-ape6evm-reference.o
>  obj-$(CONFIG_MACH_MACKEREL)    += board-mackerel.o
>  obj-$(CONFIG_MACH_KOTA2)       += board-kota2.o
>  obj-$(CONFIG_MACH_BOCKW)       += board-bockw.o
> diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
> new file mode 100644
> index 0000000..573c2b6
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
> @@ -0,0 +1,77 @@
> +/*
> + * APE6EVM board support
> + *
> + * Copyright (C) 2013  Renesas Solutions Corp.
> + * Copyright (C) 2013  Magnus Damm
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
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +#include <linux/pinctrl/machine.h>
> +#include <linux/sh_clk.h>
> +#include <mach/common.h>
> +#include <mach/r8a73a4.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +static const struct pinctrl_map ape6evm_pinctrl_map[] = {
> +       /* SCIFA0 console */
> +       PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
> +                                 "scifa0_data", "scifa0"),
> +       /* SMSC */
> +       PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a73a4",
> +                                 "irqc_irq40", "irqc"),
> +};
> +
> +static void __init ape6evm_add_standard_devices(void)
> +{
> +
> +       struct clk *parent;
> +       struct clk *mp;
> +
> +       r8a73a4_clock_init();
> +
> +       /* MP clock parent = extal2 */
> +       parent      = clk_get(NULL, "extal2");
> +       mp          = clk_get(NULL, "mp");
> +       BUG_ON(IS_ERR(parent) || IS_ERR(mp));
> +
> +       clk_set_parent(mp, parent);
> +       clk_put(parent);
> +       clk_put(mp);
> +
> +       pinctrl_register_mappings(ape6evm_pinctrl_map,
> +                                 ARRAY_SIZE(ape6evm_pinctrl_map));
> +       r8a73a4_pinmux_init();
> +       r8a73a4_add_standard_devices_dt();
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +
> +       /* LAN9220 ethernet */
> +       gpio_request_one(270, GPIOF_OUT_INIT_HIGH, NULL); /* smsc9220 RESET */

This gpio_request_one() does not look like it belongs to long term DT
support. Can you please rework the ethernet portion into an individual
patch that uses DT only?

Thanks,

/ magnus
