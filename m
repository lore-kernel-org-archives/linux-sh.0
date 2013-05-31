From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 May 2013 05:48:23 +0000
Subject: Re: [PATCH] thermal: rcar: set up I/O base before requesting IRQ
Message-Id: <20130531054823.GD5009@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369817336-1953-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1369817336-1953-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 29, 2013 at 10:48:56AM +0200, Ulrich Hecht wrote:
> It is used by the interrupt handler. Fixes crash when booting via kexec
> on APE6 board.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Ulrich,

could you clarify the target of this fix?
Is it for next and thus v3.11 or is it applicable to v3.10.
In the case of the latter is it also applicable to earlier
kernel versions and thus relevant to -stable.

Thanks

> ---
>  drivers/thermal/rcar_thermal.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 8d7edd4..7641dcc 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -395,13 +395,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  			return -ENODEV;
>  		}
>  
> -		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
> -				       dev_name(dev), common);
> -		if (ret) {
> -			dev_err(dev, "irq request failed\n ");
> -			return ret;
> -		}
> -
>  		/*
>  		 * rcar_has_irq_support() will be enabled
>  		 */
> @@ -409,6 +402,13 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		if (IS_ERR(common->base))
>  			return PTR_ERR(common->base);
>  
> +		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
> +				       dev_name(dev), common);
> +		if (ret) {
> +			dev_err(dev, "irq request failed\n ");
> +			return ret;
> +		}
> +
>  		/* enable temperature comparation */
>  		rcar_thermal_common_write(common, ENR, 0x00030303);
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
