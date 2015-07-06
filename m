From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 06 Jul 2015 07:53:02 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779 Marzen legacy fix
Message-Id: <2562172.dFuHRJdhXh@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150706070216.25453.35953.sendpatchset@little-apple>
In-Reply-To: <20150706070216.25453.35953.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Monday 06 July 2015 16:02:16 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Unbreak the r8a7779 Marzen legacy code provided by marzen_defconfig.
> 
> As it is today Marzen multiplatform is working, but the legacy code
> is broken. This patch intends to leave multiplatform as-is but do
> a simple one-shot fix to unbreak the legacy code base.
> 
> Without this patch there is no preset delay and the TWD is defined
> both in C code and in DT. Solve the delay by invoking shmobile_init_delay()
> and simply exclude the TWD DT instance in case of building for legacy.
> 
> Marzen legacy code will be removed in the near future, but until then
> we may as well avoid breaking it.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Built on top of renesas-devel-20150629-v4.1
> 
>  arch/arm/boot/dts/r8a7779.dtsi         |    4 ++--
>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> --- 0001/arch/arm/boot/dts/r8a7779.dtsi
> +++ work/arch/arm/boot/dts/r8a7779.dtsi	2015-07-06 15:42:28.182366518 +0900
> @@ -62,7 +62,7 @@
>  		reg = <0xf0001000 0x1000>,
>  		      <0xf0000100 0x100>;
>  	};
> -
> +#ifndef CONFIG_ARCH_SHMOBILE_LEGACY /* TWD defined in C code for legacy
> case */ timer@f0000600 {
>  		compatible = "arm,cortex-a9-twd-timer";
>  		reg = <0xf0000600 0x20>;
> @@ -70,7 +70,7 @@
>  			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		clocks = <&cpg_clocks R8A7779_CLK_ZS>;
>  	};
> -
> +#endif

DT should really not depend on kernel configuration. Can't you disable the 
device from legacy board/SoC code instead ?

>  	gpio0: gpio@ffc40000 {
>  		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
>  		reg = <0xffc40000 0x2c>;
> --- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-07-06
> 15:43:58.472366518 +0900 @@ -677,6 +677,8 @@ void __init
> r8a7779_add_standard_devices
> 
>  void __init r8a7779_add_early_devices(void)
>  {
> +	shmobile_init_delay();
> +
>  	early_platform_add_devices(r8a7779_early_devices,
>  				   ARRAY_SIZE(r8a7779_early_devices));

-- 
Regards,

Laurent Pinchart

