From: Jason Cooper <jason@lakedaemon.net>
Date: Tue, 24 Nov 2015 15:19:37 +0000
Subject: Re: [PATCH] irqchip/renesas-intc-irqpin: Improve clock error handling and reporting
Message-Id: <20151124151937.GS6520@io.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1448377693-19597-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448377693-19597-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hey Geert,

On Tue, Nov 24, 2015 at 04:08:13PM +0100, Geert Uytterhoeven wrote:
> If the Renesas External IRQ Pin driver cannot find a functional clock,
> it prints a warning, .e.g.
> 
>     renesas_intc_irqpin fe78001c.interrupt-controller: unable to get clock
> 
> and continues, as the clock is optional, depending on the SoC type.
> This warning may confuse users.
> 
> To fix this, add a flag to indicate that the clock is mandatory or
> optional, and add a few more compatible entries:
>   - If the clock is mandatory (on R-Mobile A1 or SH-Mobile AG5), a
>     missing clock is now treated as a fatal error,
>   - If the clock is optional (on R-Car Gen1, or using the generic
>     "renesas,intc-irqpin" compatible value), the warning is no longer
>     printed.
> 
> This requires making struct intc_irqpin_irlm_config more generic by
> renaming it to intc_irqpin_config, and adding a flag to indicate if IRLM
> is needed.
> The new clock flag is merged with the existing shared_irqs boolean into
> a bitfield to save space.
> 
> Suggested-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on
>   - r8a7779/marzen (no functional clock),
>   - r8a7740/armadillo (with and without mandatory functional clock),
>   - sh73a0/kzm9g (with and without mandatory functional clock).
> 
>  drivers/irqchip/irq-renesas-intc-irqpin.c | 45 ++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 12 deletions(-)

I'll pick up this a the previous series you just sent (fyi: tglx).

> diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
> index 7f6cf19aa6ac00d7..713177d97c7aa0b6 100644
> --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
> @@ -79,12 +79,15 @@ struct intc_irqpin_priv {
>  	struct irq_chip irq_chip;
>  	struct irq_domain *irq_domain;
>  	struct clk *clk;
> -	bool shared_irqs;
> +	unsigned shared_irqs:1;
> +	unsigned needs_clk:1;
>  	u8 shared_irq_mask;
>  };
>  
> -struct intc_irqpin_irlm_config {
> +struct intc_irqpin_config {
>  	unsigned int irlm_bit;
> +	unsigned needs_irlm:1;
> +	unsigned needs_clk:1;
>  };

Why not just stick with bool?  Changing shared_irqs -> has_shared_irqs?

>  static unsigned long intc_irqpin_read32(void __iomem *iomem)
> @@ -359,8 +362,15 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
>  	.xlate  = irq_domain_xlate_twocell,
>  };
>  
> -static const struct intc_irqpin_irlm_config intc_irqpin_irlm_r8a777x = {
> +static const struct intc_irqpin_config intc_irqpin_irlm_r8a777x = {
>  	.irlm_bit = 23, /* ICR0.IRLM0 */
> +	.needs_irlm = 1,
> +	.needs_clk = 0,
> +};
> +
> +static const struct intc_irqpin_config intc_irqpin_rmobile = {
> +	.needs_irlm = 0,
> +	.needs_clk = 1,
>  };
>  
>  static const struct of_device_id intc_irqpin_dt_ids[] = {
> @@ -369,12 +379,17 @@ static const struct of_device_id intc_irqpin_dt_ids[] = {
>  	  .data = &intc_irqpin_irlm_r8a777x },
>  	{ .compatible = "renesas,intc-irqpin-r8a7779",
>  	  .data = &intc_irqpin_irlm_r8a777x },
> +	{ .compatible = "renesas,intc-irqpin-r8a7740",
> +	  .data = &intc_irqpin_rmobile },
> +	{ .compatible = "renesas,intc-irqpin-sh73a0",
> +	  .data = &intc_irqpin_rmobile },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, intc_irqpin_dt_ids);

Add these compatibles and the clock requirement info to the devicetree
binding?

> @@ -500,10 +521,10 @@ static int intc_irqpin_probe(struct platform_device *pdev)
>  
>  	/* scan for shared interrupt lines */
>  	ref_irq = p->irq[0].requested_irq;
> -	p->shared_irqs = true;
> +	p->shared_irqs = 1;
>  	for (k = 1; k < nirqs; k++) {
>  		if (ref_irq != p->irq[k].requested_irq) {
> -			p->shared_irqs = false;
> +			p->shared_irqs = 0;
>  			break;
>  		}
>  	}

The bool suggestion, above, would make this easier to read imo.

thx,

Jason.
