From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 28 Mar 2014 16:54:37 +0000
Subject: Re: [PATCH 3/7] gpio: rcar: Add minimal runtime PM support
Message-Id: <17238523.dCO4noXFe4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395953262-4290-1-git-send-email-geert@linux-m68k.org> <1395953262-4290-4-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395953262-4290-4-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 27 March 2014 21:47:38 Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> This is just enough to automatically enable the functional clock, if
> present. Clock management during suspend/resume is still to be added.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: linux-gpio@vger.kernel.org
> ---
>  drivers/gpio/gpio-rcar.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 03c91482432c..c6995f6c3c40 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -26,6 +26,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_data/gpio-rcar.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> 
> @@ -377,6 +378,9 @@ static int gpio_rcar_probe(struct platform_device *pdev)
> 
>  	platform_set_drvdata(pdev, p);
> 
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
>  	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> 
> @@ -460,6 +464,8 @@ static int gpio_rcar_probe(struct platform_device *pdev)
> err1:
>  	irq_domain_remove(p->irq_domain);
>  err0:
> +	pm_runtime_put_sync(dev);

Do we really need the sync version, isn't pm_runtime_put() enough ?

> +	pm_runtime_disable(dev);
>  	return ret;
>  }
> 
> @@ -473,6 +479,8 @@ static int gpio_rcar_remove(struct platform_device
> *pdev) return ret;
> 
>  	irq_domain_remove(p->irq_domain);
> +	pm_runtime_put_sync(&pdev->dev);

Same comment here.

> +	pm_runtime_disable(&pdev->dev);
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart

