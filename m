From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 08:11:45 +0000
Subject: Re: [PATCH] gpio: em: Use irq_domain_add_simple() to fix runtime error
Message-Id: <20130213081144.GR30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130212155613.13396.44355.sendpatchset@w520>
In-Reply-To: <20130212155613.13396.44355.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 12:56:13AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Adjust the gpio-em.c driver to reconsider the pdata->irq_base
> variable. Non-DT board code like for instance board-kzm9d.c
> needs to operate of a static IRQ range for platform devices.
> 
> So this patch is updating the code to make use of the function
> irq_domain_add_simple() instead of irq_domain_add_linear().
> 
> Fixes a EMEV2 / KZM9D runtime error caused by the following commit:
> 7385500 gpio/em: convert to linear IRQ domain
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>


Tested-by: Simon Horman <horms+renesas@verge.net.au>
Reported-by: Simon Horman <horms+renesas@verge.net.au>

This appears to be a regression between v3.7 and v3.8-rc1 which
(possibly amongst other things) prevents the NIC on the KZM9D
from functioning.

> ---
> 
>  drivers/gpio/gpio-em.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- 0001/drivers/gpio/gpio-em.c
> +++ work/drivers/gpio/gpio-em.c	2013-02-12 22:40:16.000000000 +0900
> @@ -299,8 +299,9 @@ static int em_gio_probe(struct platform_
>  	irq_chip->irq_set_type = em_gio_irq_set_type;
>  	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE;
>  
> -	p->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
> +	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
>  					      pdata->number_of_pins,
> +					      pdata->irq_base,
>  					      &em_gio_irq_domain_ops, p);
>  	if (!p->irq_domain) {
>  		ret = -ENXIO;
> 
