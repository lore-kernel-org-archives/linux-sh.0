From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 13:36:14 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen: keep local function as static
Message-Id: <20130418133612.GG20929@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87haj4s5yw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87haj4s5yw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 17, 2013 at 11:33:47PM -0700, Kuninori Morimoto wrote:
> marzen_init_late() should be static
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued-up for v3.11 int the boards-marzen branch.

> ---
>  arch/arm/mach-shmobile/board-marzen.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index fac9e0f..ff8111b 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -350,7 +350,7 @@ static struct platform_device *marzen_late_devices[] __initdata = {
>  	&ohci1_device,
>  };
>  
> -void __init marzen_init_late(void)
> +static void __init marzen_init_late(void)
>  {
>  	/* get usb phy */
>  	phy = usb_get_phy(USB_PHY_TYPE_USB2);
> -- 
> 1.7.9.5
> 
