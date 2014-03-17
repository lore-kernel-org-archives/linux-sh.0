From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 17 Mar 2014 20:23:12 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <2780951.47jzSPgHnH@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395056275-5005-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1395056275-5005-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sh@vger.kernel.org, netdev@vger.kernel.org

Hi Ben,

Thank you for the patch.

On Monday 17 March 2014 11:37:55 Ben Dooks wrote:
> The pm_rumtime work queue is causing the device to be suspended during
> initialisation, thus the initialisation may not be able to access registers
> properly. As the code is called from a work queue, it is possible that this
> is not seen from certain configurations/builds due to the asynchronos
> nature of the code.
> 
> Use pm_runtime_get_sync() and pm_runtime_put_sync() to ensure that the
> pm system does not suspend it during the probe() call and remove the
> now unnecessary pm_runtime_resume() call.
> 
> This fixes the external abort that can cause /sbin/init or other such
> init processed to die.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/net/ethernet/renesas/sh_eth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c
> b/drivers/net/ethernet/renesas/sh_eth.c index 4f76b5e..f1cfd64 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -2869,7 +2869,7 @@ static int sh_eth_drv_probe(struct platform_device
> *pdev) spin_lock_init(&mdp->lock);
>  	mdp->pdev = pdev;
>  	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_resume(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);

Now that we've found out that the problem is caused by registering the network 
device before registering the mdio bus, shouldn't the proper solution be to 
register the network device last in the probe function ?

> 
>  	if (pdev->dev.of_node)
>  		pd = sh_eth_parse_dt(&pdev->dev);
> @@ -2961,6 +2961,7 @@ static int sh_eth_drv_probe(struct platform_device
> *pdev) pr_info("Base address at 0x%x, %pM, IRQ %d.\n",
>  		(u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
> 
> +	pm_runtime_put_sync(&pdev->dev);
>  	platform_set_drvdata(pdev, ndev);
> 
>  	return ret;

-- 
Regards,

Laurent Pinchart

