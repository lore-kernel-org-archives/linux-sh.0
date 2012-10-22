From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Oct 2012 06:09:51 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: fixup DT machine desc name typo
Message-Id: <20121022060950.GB30527@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sj97rstd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sj97rstd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Oct 21, 2012 at 10:15:13PM -0700, Kuninori Morimoto wrote:
> r8a7740 machine desc name should be R8A7740,
> not SH7372

Hi Morimoto-san,

this looks like 3.8 material to me. Do you agree?

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/setup-r8a7740.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 11bb1d9..9777e2d 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -747,7 +747,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
>  	NULL,
>  };
>  
> -DT_MACHINE_START(SH7372_DT, "Generic R8A7740 (Flattened Device Tree)")
> +DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
>  	.map_io		= r8a7740_map_io,
>  	.init_early	= r8a7740_add_early_devices_dt,
>  	.init_irq	= r8a7740_init_irq,
> -- 
> 1.7.9.5
> 
