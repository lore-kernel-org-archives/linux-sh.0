From: Simon Horman <horms@verge.net.au>
Date: Wed, 06 Mar 2013 07:55:37 +0000
Subject: Re: [PATCH] ARM: shmobile: Make sh73a0 INTC irqpin platform data static
Message-Id: <20130306075536.GB29060@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130306060831.4859.88481.sendpatchset@w520>
In-Reply-To: <20130306060831.4859.88481.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 06, 2013 at 03:08:31PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The platform data for the INTC irq pin driver
> seems to be global symbols, make it static to
> allow multi-soc build.

I have added this to topic/intc-external-irq with the related patches.
The holding-pen for INTC.

I'm also fine with you sending a v2 of revisions to unmerged patches.

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/setup-sh73a0.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-03-06 15:03:05.000000000 +0900
> @@ -782,7 +782,7 @@ static struct platform_device pmu_device
>  	.resource	= pmu_resources,
>  };
>  
> -struct renesas_intc_irqpin_config irqpin0_platform_data = {
> +static struct renesas_intc_irqpin_config irqpin0_platform_data = {
>  	.irq_base = irq_pin(0), /* IRQ0 -> IRQ7 */
>  };
>  
> @@ -812,7 +812,7 @@ static struct platform_device irqpin0_de
>  	},
>  };
>  
> -struct renesas_intc_irqpin_config irqpin1_platform_data = {
> +static struct renesas_intc_irqpin_config irqpin1_platform_data = {
>  	.irq_base = irq_pin(8), /* IRQ8 -> IRQ15 */
>  	.control_parent = true, /* Disable spurious IRQ10 */
>  };
> @@ -843,7 +843,7 @@ static struct platform_device irqpin1_de
>  	},
>  };
>  
> -struct renesas_intc_irqpin_config irqpin2_platform_data = {
> +static struct renesas_intc_irqpin_config irqpin2_platform_data = {
>  	.irq_base = irq_pin(16), /* IRQ16 -> IRQ23 */
>  };
>  
> @@ -873,7 +873,7 @@ static struct platform_device irqpin2_de
>  	},
>  };
>  
> -struct renesas_intc_irqpin_config irqpin3_platform_data = {
> +static struct renesas_intc_irqpin_config irqpin3_platform_data = {
>  	.irq_base = irq_pin(24), /* IRQ24 -> IRQ31 */
>  };
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
