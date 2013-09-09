From: Simon Horman <horms@verge.net.au>
Date: Mon, 09 Sep 2013 00:42:36 +0000
Subject: Re: [PATCH v2 1/2] sh_eth: check platform data pointer
Message-Id: <20130909004236.GJ21921@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201309070340.07158.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201309070340.07158.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Sep 07, 2013 at 03:40:06AM +0400, Sergei Shtylyov wrote:
> Check the platform data pointer before dereferencing it and error out of the
> probe() method if it's NULL.
> 
> This has additional effect of preventing kernel oops with outdated platform data
> containing zero PHY address instead (such as on SolutionEngine7710).
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


> 
> ---
> This patch is against Dave's 'net-next.git' repo.
> Not posting it to netdev@vger.kernel.org this time, or Dave will scold me. :-)
> 
> Changes in version 2:
> - refreshed the patch.
> 
>  drivers/net/ethernet/renesas/sh_eth.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
> =================================> --- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
> +++ net-next/drivers/net/ethernet/renesas/sh_eth.c
> @@ -2659,6 +2659,12 @@ static int sh_eth_drv_probe(struct platf
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_resume(&pdev->dev);
>  
> +	if (!pd) {
> +		dev_err(&pdev->dev, "no platform data\n");
> +		ret = -EINVAL;
> +		goto out_release;
> +	}
> +
>  	/* get PHY ID */
>  	mdp->phy_id = pd->phy;
>  	mdp->phy_interface = pd->phy_interface;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
