From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Oct 2015 00:41:35 +0000
Subject: Re: [PATCH v2] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <87eggdgpkl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446158791-29682-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446158791-29682-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


Hi Wolfram Sang wrote:
> 
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Please add explain why this patch is needed, and what happen
without this patch.
And my previous patch didn't explain this, but please add
93c659d820ef291f6ca5e628f44b26cfb2226aba
was cause of this issue.

>  drivers/i2c/busses/i2c-rcar.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 616433d387cdb2..58dbd30c24d1cc 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -612,7 +612,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->io))
>  		return PTR_ERR(priv->io);
>  
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
>  	rcar_i2c_init(priv);
> +	pm_runtime_put(dev);
>  
>  	irq = platform_get_irq(pdev, 0);
>  	init_waitqueue_head(&priv->wait);
> @@ -631,22 +634,24 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>  			       dev_name(dev), priv);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot get irq %d\n", irq);
> -		return ret;
> +		goto out_pm_disable;
>  	}
>  
> -	pm_runtime_enable(dev);
>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = i2c_add_numbered_adapter(adap);
>  	if (ret < 0) {
>  		dev_err(dev, "reg adap failed: %d\n", ret);
> -		pm_runtime_disable(dev);
> -		return ret;
> +		goto out_pm_disable;
>  	}
>  
>  	dev_info(dev, "probed\n");
>  
>  	return 0;
> +
> + out_pm_disable:
> +	pm_runtime_disable(dev);
> +	return ret;
>  }
>  
>  static int rcar_i2c_remove(struct platform_device *pdev)
> -- 
> 2.1.4
> 
