From: Simon Horman <horms@verge.net.au>
Date: Fri, 30 Aug 2013 03:49:58 +0000
Subject: Re: [PATCH] sh_eth: no need to call ether_setup()
Message-Id: <20130830034957.GC17800@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201308300024.48415.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308300024.48415.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

On Fri, Aug 30, 2013 at 12:24:47AM +0400, Sergei Shtylyov wrote:
> There's no need to call ether_setup() in the driver since prior alloc_etherdev()
> call already arranges for it.
> 
> Suggested-by: Denis Kirjanov <kda@linux-powerpc.org>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> ---
>  drivers/net/ethernet/renesas/sh_eth.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
> =================================> --- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
> +++ net-next/drivers/net/ethernet/renesas/sh_eth.c
> @@ -2639,9 +2639,6 @@ static int sh_eth_drv_probe(struct platf
>  
>  	SET_NETDEV_DEV(ndev, &pdev->dev);
>  
> -	/* Fill in the fields of the device structure with ethernet values. */
> -	ether_setup(ndev);
> -
>  	mdp = netdev_priv(ndev);
>  	mdp->num_tx_ring = TX_RING_SIZE;
>  	mdp->num_rx_ring = RX_RING_SIZE;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
