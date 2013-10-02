From: Simon Horman <horms@verge.net.au>
Date: Wed, 02 Oct 2013 08:06:06 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: marzen: enable INTC IRQ and fixup SMSC IRQ number
Message-Id: <20131002080604.GD28462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201308090144.03912.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308090144.03912.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 01, 2013 at 11:20:01PM -0700, Kuninori Morimoto wrote:
> This patch adds missing INTC IRQ settings,
> and fixup miss-setting of SMSC IRQ number.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Please split this into two patches.

1. A DT patch that modifies r8a7779-marzen-reference.dts
2. A board patch that modifies board-marzen-reference.c

> ---
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts  |    8 ++++++--
>  arch/arm/mach-shmobile/board-marzen-reference.c |    1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> index 6d55083..ab4110a 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> @@ -42,8 +42,8 @@
>  		pinctrl-names = "default";
>  
>  		phy-mode = "mii";
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 28 0x4>;
> +		interrupt-parent = <&irqpin0>;
> +		interrupts = <1 0>; /* IRQ1: hwirq 1 on irqpin0 */
>  		reg-io-width = <4>;
>  		vddvario-supply = <&fixedregulator3v3>;
>  		vdd33a-supply = <&fixedregulator3v3>;
> @@ -63,6 +63,10 @@
>  	};
>  };
>  
> +&irqpin0 {
> +	status = "okay";
> +};
> +
>  &pfc {
>  	pinctrl-0 = <&scif2_pins &scif4_pins &sdhi0_pins>;
>  	pinctrl-names = "default";
> diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
> index 3f4250a..2773936 100644
> --- a/arch/arm/mach-shmobile/board-marzen-reference.c
> +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
> @@ -28,6 +28,7 @@
>  static void __init marzen_init(void)
>  {
>  	r8a7779_add_standard_devices_dt();
> +	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
>  }
>  
>  static const char *marzen_boards_compat_dt[] __initdata = {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
