From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 28 Mar 2014 16:57:17 +0000
Subject: Re: [PATCH 1/7] gpio: rcar: Add helper variable dev = &pdev->dev
Message-Id: <1679540.TxvK82nUub@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395953262-4290-1-git-send-email-geert@linux-m68k.org> <1395953262-4290-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395953262-4290-2-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 27 March 2014 21:47:36 Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: linux-gpio@vger.kernel.org

I'm not sure if I would have bothered, but I have nothing against this :-)

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpio/gpio-rcar.c |   32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index ca76ce751540..03c91482432c 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -356,12 +356,13 @@ static int gpio_rcar_probe(struct platform_device
> *pdev) struct resource *io, *irq;
>  	struct gpio_chip *gpio_chip;
>  	struct irq_chip *irq_chip;
> -	const char *name = dev_name(&pdev->dev);
> +	struct device *dev = &pdev->dev;
> +	const char *name = dev_name(dev);
>  	int ret;
> 
> -	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> +	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
>  	if (!p) {
> -		dev_err(&pdev->dev, "failed to allocate driver data\n");
> +		dev_err(dev, "failed to allocate driver data\n");
>  		ret = -ENOMEM;
>  		goto err0;
>  	}
> @@ -380,15 +381,14 @@ static int gpio_rcar_probe(struct platform_device
> *pdev) irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> 
>  	if (!io || !irq) {
> -		dev_err(&pdev->dev, "missing IRQ or IOMEM\n");
> +		dev_err(dev, "missing IRQ or IOMEM\n");
>  		ret = -EINVAL;
>  		goto err0;
>  	}
> 
> -	p->base = devm_ioremap_nocache(&pdev->dev, io->start,
> -				       resource_size(io));
> +	p->base = devm_ioremap_nocache(dev, io->start, resource_size(io));
>  	if (!p->base) {
> -		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> +		dev_err(dev, "failed to remap I/O memory\n");
>  		ret = -ENXIO;
>  		goto err0;
>  	}
> @@ -402,7 +402,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
> gpio_chip->set = gpio_rcar_set;
>  	gpio_chip->to_irq = gpio_rcar_to_irq;
>  	gpio_chip->label = name;
> -	gpio_chip->dev = &pdev->dev;
> +	gpio_chip->dev = dev;
>  	gpio_chip->owner = THIS_MODULE;
>  	gpio_chip->base = p->config.gpio_base;
>  	gpio_chip->ngpio = p->config.number_of_pins;
> @@ -421,30 +421,30 @@ static int gpio_rcar_probe(struct platform_device
> *pdev) &gpio_rcar_irq_domain_ops, p);
>  	if (!p->irq_domain) {
>  		ret = -ENXIO;
> -		dev_err(&pdev->dev, "cannot initialize irq domain\n");
> +		dev_err(dev, "cannot initialize irq domain\n");
>  		goto err0;
>  	}
> 
> -	if (devm_request_irq(&pdev->dev, irq->start,
> -			     gpio_rcar_irq_handler, IRQF_SHARED, name, p)) {
> -		dev_err(&pdev->dev, "failed to request IRQ\n");
> +	if (devm_request_irq(dev, irq->start, gpio_rcar_irq_handler,
> +			     IRQF_SHARED, name, p)) {
> +		dev_err(dev, "failed to request IRQ\n");
>  		ret = -ENOENT;
>  		goto err1;
>  	}
> 
>  	ret = gpiochip_add(gpio_chip);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to add GPIO controller\n");
> +		dev_err(dev, "failed to add GPIO controller\n");
>  		goto err1;
>  	}
> 
> -	dev_info(&pdev->dev, "driving %d GPIOs\n", p->config.number_of_pins);
> +	dev_info(dev, "driving %d GPIOs\n", p->config.number_of_pins);
> 
>  	/* warn in case of mismatch if irq base is specified */
>  	if (p->config.irq_base) {
>  		ret = irq_find_mapping(p->irq_domain, 0);
>  		if (p->config.irq_base != ret)
> -			dev_warn(&pdev->dev, "irq base mismatch (%u/%u)\n",
> +			dev_warn(dev, "irq base mismatch (%u/%u)\n",
>  				 p->config.irq_base, ret);
>  	}
> 
> @@ -452,7 +452,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
> ret = gpiochip_add_pin_range(gpio_chip, p->config.pctl_name, 0,
> gpio_chip->base, gpio_chip->ngpio);
>  		if (ret < 0)
> -			dev_warn(&pdev->dev, "failed to add pin range\n");
> +			dev_warn(dev, "failed to add pin range\n");
>  	}
> 
>  	return 0;

-- 
Regards,

Laurent Pinchart

