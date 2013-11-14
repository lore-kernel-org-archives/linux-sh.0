From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Nov 2013 06:26:53 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: mark GPIO keys as wake-up sources
Message-Id: <20131114062639.GA2292@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131113224026.20904.35898.sendpatchset@w520>
In-Reply-To: <20131113224026.20904.35898.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 14, 2013 at 07:40:26AM +0900, Magnus Damm wrote:
> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> 
> Enable wakeup for the GPIO keys on the Lager board.
> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Hi Magnus,

is this relevant to other boards too?

> ---
> 
>  arch/arm/mach-shmobile/board-lager.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0002/arch/arm/mach-shmobile/board-lager.c
> +++ work/arch/arm/mach-shmobile/board-lager.c	2013-11-13 17:22:08.000000000 +0900
> @@ -121,7 +121,7 @@ static const struct gpio_led_platform_da
>  /* GPIO KEY */
>  #define GPIO_KEY(c, g, d, ...) \
>  	{ .code = c, .gpio = g, .desc = d, .active_low = 1, \
> -	  .debounce_interval = 20 }
> +	  .wakeup = 1, .debounce_interval = 20 }
>  
>  static struct gpio_keys_button gpio_buttons[] = {
>  	GPIO_KEY(KEY_4,		RCAR_GP_PIN(1, 28),	"SW2-pin4"),
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
