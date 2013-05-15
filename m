From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 May 2013 02:00:38 +0000
Subject: Re: [RFC/PATCH 1/2] gpio-rcar: Make the platform data gpio_base field signed
Message-Id: <20130515020038.GA14751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368197317-13169-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1368197317-13169-2-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1368197317-13169-2-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm@opensource.se>

On Fri, May 10, 2013 at 04:48:36PM +0200, Laurent Pinchart wrote:
> The gpio_base field is used to specify the desired GPIO base for the
> GPIO controller. The GPIO core can automatically allocate a GPIO number
> range when the base is set to -1. To make this possible, make the field
> signed.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, queued-up for v3.11 in the gpio-car branch.

> ---
>  include/linux/platform_data/gpio-rcar.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
> index cc472f6..fb2c718 100644
> --- a/include/linux/platform_data/gpio-rcar.h
> +++ b/include/linux/platform_data/gpio-rcar.h
> @@ -17,7 +17,7 @@
>  #define __GPIO_RCAR_H__
>  
>  struct gpio_rcar_config {
> -	unsigned int gpio_base;
> +	int gpio_base;
>  	unsigned int irq_base;
>  	unsigned int number_of_pins;
>  	const char *pctl_name;
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
