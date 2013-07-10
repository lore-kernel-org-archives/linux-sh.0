From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 01:15:39 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: fix SDHI0 VccQ regulator on sh73a0 with DT
Message-Id: <20130710011538.GP32603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307091625490.28812@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307091625490.28812@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 09, 2013 at 04:27:24PM +0200, Guennadi Liakhovetski wrote:
> The PFC pinctrl driver on sh73a0 is also regiatering a VccQ regulator for
> SDHI0. However, its consumers list only included the platform-data based
> SDHI device name. When booted with DT SDHI0 couldn't enable VccQ and
> therefore was unusable. Fix this by adding a consumer with DT-based name.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Is this the correct fix or is there a better option? Observed and tested 
> on kzm9g-reference.
> 
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> index 7956df5..31f7d0e 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> @@ -3785,6 +3785,7 @@ static const struct regulator_desc sh73a0_vccq_mc0_desc = {
>  
>  static struct regulator_consumer_supply sh73a0_vccq_mc0_consumers[] = {
>  	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
> +	REGULATOR_SUPPLY("vqmmc", "ee100000.sdhi"),
>  };
>  
>  static const struct regulator_init_data sh73a0_vccq_mc0_init_data = {
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
