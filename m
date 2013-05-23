From: Simon Horman <horms@verge.net.au>
Date: Thu, 23 May 2013 01:39:30 +0000
Subject: Re: [RFC/PATCH v2 1/2] gpio-rcar: Make the platform data gpio_base field signed
Message-Id: <20130523013930.GH22608@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369136406-23800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1369136406-23800-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1369136406-23800-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 21, 2013 at 01:40:05PM +0200, Laurent Pinchart wrote:
> The gpio_base field is used to specify the desired GPIO base for the
> GPIO controller. The GPIO core can automatically allocate a GPIO number
> range when the base is set to -1. To make this possible, make the field
> signed.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, this is queued-up for v3.11 in the gpio-rcar branch.

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
