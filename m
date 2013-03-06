From: Simon Horman <horms@verge.net.au>
Date: Wed, 06 Mar 2013 07:55:40 +0000
Subject: Re: [PATCH] ARM: shmobile: Make r8a7779 INTC irqpin platform data static
Message-Id: <20130306075539.GC29060@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130306061006.4880.33317.sendpatchset@w520>
In-Reply-To: <20130306061006.4880.33317.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 06, 2013 at 03:10:06PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The platform data for the INTC irq pin driver
> seems to be global symbols, make it static to
> allow multi-soc build.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

I have added this to topic/intc-external-irq with the related patches.
The holding-pen for INTC.

> ---
> 
>  arch/arm/mach-shmobile/intc-r8a7779.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0001/arch/arm/mach-shmobile/intc-r8a7779.c
> +++ work/arch/arm/mach-shmobile/intc-r8a7779.c	2013-03-06 15:04:35.000000000 +0900
> @@ -42,7 +42,7 @@
>  #define INT2NTSR0 IOMEM(0xfe700060)
>  #define INT2NTSR1 IOMEM(0xfe700064)
>  
> -struct renesas_intc_irqpin_config irqpin0_platform_data = {
> +static struct renesas_intc_irqpin_config irqpin0_platform_data = {
>  	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
>  	.sense_bitfield_width = 2,
>  };
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
