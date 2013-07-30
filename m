From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 00:02:33 +0000
Subject: Re: [PATCH] ARM: shmobile: sh73a0: Remove global GPIO_NR definition
Message-Id: <20130730000232.GF11142@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375126434-25884-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375126434-25884-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 29, 2013 at 09:33:54PM +0200, Laurent Pinchart wrote:
> The total number of SoC GPIOs is only used to compute the base GPIO
> number of th PCF8575 GPIO extender on the KZM9G board. As GPIO
> allocation became fully dynamic with DT, no other SH73A0 board will use
> the GPIO_NR macro. Move it to the KZM9G board file.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I am happy with this.
But I will wait to give others a chance to review it before
queueing it up.

> ---
>  arch/arm/mach-shmobile/board-kzm9g.c         | 16 ++++++++--------
>  arch/arm/mach-shmobile/include/mach/sh73a0.h |  2 --
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index 1068120..f199496 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -54,14 +54,14 @@
>  /*
>   * external GPIO
>   */
> -#define GPIO_PCF8575_BASE	(GPIO_NR)
> -#define GPIO_PCF8575_PORT10	(GPIO_NR + 8)
> -#define GPIO_PCF8575_PORT11	(GPIO_NR + 9)
> -#define GPIO_PCF8575_PORT12	(GPIO_NR + 10)
> -#define GPIO_PCF8575_PORT13	(GPIO_NR + 11)
> -#define GPIO_PCF8575_PORT14	(GPIO_NR + 12)
> -#define GPIO_PCF8575_PORT15	(GPIO_NR + 13)
> -#define GPIO_PCF8575_PORT16	(GPIO_NR + 14)
> +#define GPIO_PCF8575_BASE	(310)
> +#define GPIO_PCF8575_PORT10	(GPIO_PCF8575_BASE + 8)
> +#define GPIO_PCF8575_PORT11	(GPIO_PCF8575_BASE + 9)
> +#define GPIO_PCF8575_PORT12	(GPIO_PCF8575_BASE + 10)
> +#define GPIO_PCF8575_PORT13	(GPIO_PCF8575_BASE + 11)
> +#define GPIO_PCF8575_PORT14	(GPIO_PCF8575_BASE + 12)
> +#define GPIO_PCF8575_PORT15	(GPIO_PCF8575_BASE + 13)
> +#define GPIO_PCF8575_PORT16	(GPIO_PCF8575_BASE + 14)
>  
>  /* Dummy supplies, where voltage doesn't matter */
>  static struct regulator_consumer_supply dummy_supplies[] = {
> diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
> index 680dc5f..359b582 100644
> --- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
> +++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
> @@ -1,8 +1,6 @@
>  #ifndef __ASM_SH73A0_H__
>  #define __ASM_SH73A0_H__
>  
> -#define GPIO_NR			310
> -
>  /* DMA slave IDs */
>  enum {
>  	SHDMA_SLAVE_INVALID,
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
