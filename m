From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 10 Jul 2013 09:20:05 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: fix SDHI0 VccQ regulator on sh73a0 with DT
Message-Id: <3882330.n7B3srRuA4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307091625490.28812@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307091625490.28812@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thank you for the patch.

On Tuesday 09 July 2013 16:27:24 Guennadi Liakhovetski wrote:
> The PFC pinctrl driver on sh73a0 is also regiatering a VccQ regulator for
> SDHI0. However, its consumers list only included the platform-data based
> SDHI device name. When booted with DT SDHI0 couldn't enable VccQ and
> therefore was unusable. Fix this by adding a consumer with DT-based name.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Is this the correct fix or is there a better option? Observed and tested
> on kzm9g-reference.

The fix looks good to me.

>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c index 7956df5..31f7d0e 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> @@ -3785,6 +3785,7 @@ static const struct regulator_desc
> sh73a0_vccq_mc0_desc = {
> 
>  static struct regulator_consumer_supply sh73a0_vccq_mc0_consumers[] = {
>  	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
> +	REGULATOR_SUPPLY("vqmmc", "ee100000.sdhi"),
>  };
> 
>  static const struct regulator_init_data sh73a0_vccq_mc0_init_data = {

-- 
Regards,

Laurent Pinchart

