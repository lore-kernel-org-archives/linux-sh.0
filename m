From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Aug 2012 05:18:54 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: marzen: fixup smsc911x id for regulator
Message-Id: <20120830051852.GC30566@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87wr0hxhsp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wr0hxhsp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 29, 2012 at 06:58:01PM -0700, Kuninori Morimoto wrote:
> dummy_supplies for smsc911x are registered as "smsc911x".
> smsc911x driver needs id = -1
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks. This seems to effect 3.6-rc3 so I have added
it to a new fixes branch of my renesas tree and will
endeavour to get it included in 3.6.

> ---
>  arch/arm/mach-shmobile/board-marzen.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index 00b1816..a34d13e 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -78,7 +78,7 @@ static struct smsc911x_platform_config smsc911x_platdata = {
>  
>  static struct platform_device eth_device = {
>  	.name		= "smsc911x",
> -	.id		= 0,
> +	.id		= -1,
>  	.dev  = {
>  		.platform_data = &smsc911x_platdata,
>  	},
> -- 
> 1.7.9.5
> 
