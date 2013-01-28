From: Simon Horman <horms@verge.net.au>
Date: Mon, 28 Jan 2013 01:26:40 +0000
Subject: Re: [PATCH 2/2] net: sh-eth: Use pr_err instead of printk
Message-Id: <20130128012640.GB27896@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1350350279-8693-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <1350350279-8693-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1350350279-8693-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, linux-sh@vger.kernel.org

[Cc David Miller, linux-sh]

On Tue, Oct 16, 2012 at 10:17:59AM +0900, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Dave, I know this is an oldie, but it appears to still be a goodie.
Could you consider it for 3.8?

> ---
>  drivers/net/ethernet/renesas/sh_eth.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index 756d87e..ba97a45 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -598,7 +598,7 @@ static int sh_eth_check_reset(struct net_device *ndev)
>  		cnt--;
>  	}
>  	if (cnt < 0) {
> -		printk(KERN_ERR "Device reset fail\n");
> +		pr_err("Device reset fail\n");
>  		ret = -ETIMEDOUT;
>  	}
>  	return ret;
> @@ -2329,7 +2329,7 @@ static const u16 *sh_eth_get_register_offset(int register_type)
>  		reg_offset = sh_eth_offset_fast_sh3_sh2;
>  		break;
>  	default:
> -		printk(KERN_ERR "Unknown register type (%d)\n", register_type);
> +		pr_err("Unknown register type (%d)\n", register_type);
>  		break;
>  	}
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
