From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Sep 2013 07:12:03 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: r8a7778: r8a7778_register_hspi() become static
Message-Id: <20130925071201.GL6663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjr2rc0e.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjr2rc0e.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 23, 2013 at 11:04:37PM -0700, Kuninori Morimoto wrote:
> r8a7778_register_hspi() used only from setup-r8a7778.c
> it can be static
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/setup-r8a7778.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 31e77a8..bfeedd1 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -275,7 +275,7 @@ static struct resource hspi_resources[] __initdata = {
>  	DEFINE_RES_IRQ(gic_iid(0x75)),
>  };
>  
> -void __init r8a7778_register_hspi(int id)
> +static void __init r8a7778_register_hspi(int id)
>  {
>  	BUG_ON(id < 0 || id > 2);

Thanks, queued up for v3.13.
