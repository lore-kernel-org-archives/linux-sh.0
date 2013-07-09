From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jul 2013 09:03:16 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: bockw: add DT reference
Message-Id: <CANqRtoT+tS5HvZxfaHhAsVLnJ69NSw_ruHRSkyrw33xcGH5dfA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for your patch. I have one comment below:

On Tue, Jul 9, 2013 at 5:32 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> This patch adds a sample DT-based Bock-W "reference" implementation.
> The use of platform-specific C-code should be avoided
> with this configuration as much as possible.
>
> This patch adds new r8a7778_add_dt_devices() which was same stance
> of r8a7790_add_dt_devices()
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/Makefile                     |    1 +
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   52 +++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                 |   14 +++++
>  arch/arm/mach-shmobile/Makefile                |    1 +
>  arch/arm/mach-shmobile/Makefile.boot           |    1 +
>  arch/arm/mach-shmobile/board-bockw-reference.c |   80 ++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/r8a7778.h  |    1 +
>  arch/arm/mach-shmobile/setup-r8a7778.c         |    7 ++-
>  8 files changed, 156 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
>  create mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f2dc697..fd83b1a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -162,6 +162,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
>  dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
>         r8a7740-armadillo800eva.dtb \
>         r8a7778-bockw.dtb \
> +       r8a7778-bockw-reference.dtb \
>         r8a7740-armadillo800eva-reference.dtb \
>         r8a7779-marzen-reference.dtb \
>         r8a7790-lager.dtb \
> diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> new file mode 100644
> index 0000000..a04508c
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> @@ -0,0 +1,52 @@
> +/*
> + * Reference Device Tree Source for the Bock-W board
> + *
> + * Copyright (C) 2013  Renesas Solutions Corp.
> + * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + *
> + * based on r8a7779
> + *
> + * Copyright (C) 2013 Renesas Solutions Corp.
> + * Copyright (C) 2013 Simon Horman
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "r8a7778.dtsi"
> +
> +/ {
> +       model = "bockw";
> +       compatible = "renesas,bockw-reference", "renesas,r8a7778";
> +
> +       chosen {
> +               bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs";
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x60000000 0x10000000>;
> +       };
> +
> +       fixedregulator3v3: fixedregulator@0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "fixed-3.3V";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +
> +       lan0@18000000 {
> +               compatible = "smsc,lan9115";
> +               reg = <0x18300000 0x100>;
> +               phy-mode = "mii";
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 (0x3b - 32) 0x4>; /* gic iid of IRQ0 */
> +               reg-io-width = <4>;
> +               vddvario-supply = <&fixedregulator3v3>;
> +               vdd33a-supply = <&fixedregulator3v3>;
> +       };
> +};

This portion about the SMSC chip, I think the interrupt bit looks strange here.

Since the SMSC chip is an external ethernet controller it will use an
external IRQ pin. It looks like IRQ0 is used according to the comment.
But if IRQ0 is used then you should use IRQ0 from some other interrupt
parent - not GIC. I realize you may have some chained FPGA setup for
interrupts that complicates things, but perhaps the FPGA can be
configured to be transparent somehow in a static way and just let
interrupts go straight through?

Anyway, I recommend you to remove the SMSC bits for now and resend
this patch without ethernet controller as a start. Then we can deal
with the ethernet controller as an incremental patch.

Cheers,

/ magnus
