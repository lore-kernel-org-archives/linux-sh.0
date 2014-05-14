From: Simon Horman <horms@verge.net.au>
Date: Wed, 14 May 2014 23:17:26 +0000
Subject: Re: [PATCH v3 1/2] ARM: shmobile: koelsch-reference: Remove workarounds for core clock issues
Message-Id: <20140514231726.GE29233@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1400078866-5694-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1400078866-5694-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 14, 2014 at 04:47:45PM +0200, Geert Uytterhoeven wrote:
> Now the core clock issues have been fixed by commit
> 3c90c55dcde745bed81f6447f24ba96bda43d984 ("drivers: sh: compile
> drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI"), revert the following
> 3 commits:
>   - 4dcb4c80380dfa482874b931e308fd382597feab ("ARM: shmobile: Add Koelsch
>     clock workarounds for SDHI"),
>   - 8e4f394b20a0fe474dd88204d76978191566decf ("ARM: shmobile:
>     koelsch-reference: Annotate clk_enables as __initconst"),
>   - 3d75d9ea74fee6f5a4bdcbbdf2d577661d047eef ("ARM: shmobile:
>     koelsch-reference: Work around core clock issues").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> This depends on 3c90c55dcde745bed81f6447f24ba96bda43d984 having landed
> in Linus' tree

Very nice. And likewise for lager.
And I suspect we can clean up other platforms too
(perhaps patches which haven't been queued up yet).

Please repost this once the dependency hits Linus's tree.
I will then queue it up for 3.17.

> 
> v3:
>   - Add Reviewed-by
> v2:
>   - New
> ---
>  arch/arm/mach-shmobile/board-koelsch-reference.c |   15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
> index d322a162b4b0..a13b51ff8817 100644
> --- a/arch/arm/mach-shmobile/board-koelsch-reference.c
> +++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
> @@ -92,24 +92,9 @@ static const struct clk_name clk_names[] __initconst = {
>  	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
>  };
>  
> -/*
> - * This is a really crude hack to work around core platform clock issues
> - */
> -static const struct clk_name clk_enables[] __initconst = {
> -	{ "ether", NULL, "ee700000.ethernet" },
> -	{ "i2c2", NULL, "e6530000.i2c" },
> -	{ "msiof0", NULL, "e6e20000.spi" },
> -	{ "qspi_mod", NULL, "e6b10000.spi" },
> -	{ "sdhi0", NULL, "ee100000.sd" },
> -	{ "sdhi1", NULL, "ee140000.sd" },
> -	{ "sdhi2", NULL, "ee160000.sd" },
> -	{ "thermal", NULL, "e61f0000.thermal" },
> -};
> -
>  static void __init koelsch_add_standard_devices(void)
>  {
>  	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
> -	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
>  	r8a7791_add_dt_devices();
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
