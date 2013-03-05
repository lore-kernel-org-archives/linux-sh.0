From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Mar 2013 03:04:11 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7779: fixup DT machine name
Message-Id: <20130305030409.GM16128@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871ubvr65n.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ubvr65n.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 03, 2013 at 11:11:20PM -0800, Kuninori Morimoto wrote:
> r8a7779 is not sh73a0
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index 7f8daf1..9322858 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -414,7 +414,7 @@ static const char *r8a7779_compat_dt[] __initdata = {
>  	NULL,
>  };
>  
> -DT_MACHINE_START(SH73A0_DT, "Generic R8A7779 (Flattened Device Tree)")
> +DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
>  	.map_io		= r8a7779_map_io,
>  	.init_early	= r8a7779_init_delay,
>  	.nr_irqs	= NR_IRQS_LEGACY,

Thanks, applied to the soc5 branch of the renesas tree
and thus included in its next branch and queued up for v3.10.

