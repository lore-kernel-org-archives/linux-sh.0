From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 03:48:13 +0000
Subject: Re: [PATCH v2 3/4] ARM: shmobile: ape6evm-reference: add CPUFreq support
Message-Id: <CANqRtoRjKaZS9RJ3aAbqL1PLtMn+fSpoSKN98RBDpN_OfUYN5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373038006-19973-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373038006-19973-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Sat, Jul 6, 2013 at 12:26 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Add CPUFreq support to ape6evm-reference, using a max8973 regulator, that
> is supplying V_DVFS for the 4 CA15 cores on r8a73a4.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v2: extracted from patch 2 from v1
>
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   22 ++++++++++++++++++++++
>  arch/arm/mach-shmobile/board-ape6evm-reference.c |    1 +
>  2 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> index 4990076..aa84b09 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> @@ -31,3 +31,25 @@
>                 ranges = <0 0 0 0x80000000>;
>         };
>  };
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
> diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
> index 7e3e0d7..ee9f75d 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
> @@ -56,6 +56,7 @@ static void __init ape6evm_add_standard_devices(void)
>         r8a73a4_pinmux_init();
>         r8a73a4_add_aux_devices_dt();
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +       r8a73a4_add_cpufreq_device_dt();

Instead of adding a special function with ifdefs and whatnot in the
r8a73a4 code and calling r8a73a4_add_cpufreq_device_dt() from this
file, please update the code to simply use the following directly from
this file:

platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);

Thanks,

/ magnus
