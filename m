From: Simon Horman <horms@verge.net.au>
Date: Mon, 26 Jan 2015 02:26:40 +0000
Subject: Re: [PATCH] ARM: shmobile: salvage lost CONFIG_REGULATOR
Message-Id: <20150126022636.GB8229@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 26, 2015 at 10:24:04AM +0900, Simon Horman wrote:
> Hi Geert, Hi Morimoto-san,
> 
> I believe this problem is present in renesas-next-20150122-v3.19-rc1,
> but not in renesas-devel-20150123-v3.19-rc5 due to the presence there of
> the following in the latter:
> 
> >From Magnus Damm <damm+renesas@opensource.se>
> 
> ARM: shmobile: sh73a0: Add Multiplatform support
> 
> Enable sh73a0 Multiplatform support for the generic sh73a0
> machine vector. No board support is enabled, and the board
> code for KZM9G DT Reference is left by itself.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 2f36c85..8ee2f28 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -78,6 +78,11 @@ config ARCH_R8A7794
>  	bool "R-Car E2 (R8A77940)"
>  	select ARCH_RCAR_GEN2
>  
> +config ARCH_SH73A0
> +	bool "SH-Mobile AG5 (R8A73A00)"
> +	select ARCH_RMOBILE
> +	select RENESAS_INTC_IRQPIN
> +
>  comment "Renesas ARM SoCs Board Type"
>  
>  config MACH_MARZEN
> [patch truncated]
> 
> 
> It may have been better if the defconfig problem that Morimoto-san
> mentions below had not gone into next for v3.20 while the change above
> ended up being deferred for v3.21. But that is how things have
> played out. And the result seems to be that Morimoto-san's patch
> will resolve a regression that has been queued up for v3.20.
> 
> With the above in mind I plan to queue up the change below
> as a fix for v3.20.

As I would like to treat this as a fix I have made a more minimal
version of Morimoto-san's patch. I have also  updated the changelog to
supply a bit more information.

I will post the result as "[PATCH] ARM: shmobile: Select CONFIG_REGULATOR
in defconfig once again".
