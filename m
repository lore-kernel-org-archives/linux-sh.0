From: David Miller <davem@davemloft.net>
Date: Tue, 07 Jan 2014 19:07:55 +0000
Subject: Re: [PATCH v3 net-next 1/3] sh_eth: Add support for r7s72100
Message-Id: <20140107.140755.1722284527902829385.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1389061635-4083-1-git-send-email-horms+renesas@verge.net.au>
 <1389061635-4083-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1389061635-4083-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue,  7 Jan 2014 11:27:13 +0900

> @@ -318,6 +371,14 @@ static int sh_eth_is_gether(struct sh_eth_private *mdp)
>  		return 0;
>  }
>  
> +static int sh_eth_is_rz_fast_ether(struct sh_eth_private *mdp)
> +{
> +	if (mdp->reg_offset = sh_eth_offset_fast_rz)
> +		return 1;
> +	else
> +		return 0;
> +}

Please make this return a boolean and use true/false.

> @@ -2061,6 +2155,10 @@ static struct net_device_stats *sh_eth_get_stats(struct net_device *ndev)
>  {
>  	struct sh_eth_private *mdp = netdev_priv(ndev);
>  
> +	if (sh_eth_is_rz_fast_ether(mdp)) {
> +		return &ndev->stats;
> +	}

Single statement basic blocks do not need curly braces, therefore
please remove them here.

THanks.
