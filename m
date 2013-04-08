From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 08 Apr 2013 09:41:05 +0000
Subject: Re: [RFC][PATCH] sh-pfc: r8a7779: tidyup intc_irq3_b typo
Message-Id: <1526271.cx8ciUsg4Q@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87obdpohxx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87obdpohxx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Sunday 07 April 2013 19:49:17 Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> 
> >> Laurent
> 
> Now, I'm studying about sh pinctrol code.
> So, I can't have firm belief about this patch.
> But maybe it was typo

It's definitely a typo, thank you for pointing it out.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Simon, this is a bug fix, could you please push it to v3.10 ?

>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index 62dcdcd..791a671 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> @@ -2552,7 +2552,7 @@ static const char * const intc_groups[] = {
>  	"intc_irq2",
>  	"intc_irq2_b",
>  	"intc_irq3",
> -	"intc_irq4_b",
> +	"intc_irq3_b",
>  };
> 
>  static const char * const lbsc_groups[] = {

-- 
Regards,

Laurent Pinchart

