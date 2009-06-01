From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 01 Jun 2009 09:41:08 +0000
Subject: Re: [PATCH] sh4a: add L2 cache support
Message-Id: <20090601094108.GC31292@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 29, 2009 at 04:41:18PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/include/cpu-sh4/cpu/cache.h |    5 +++++
>  arch/sh/kernel/cpu/init.c           |    8 ++++++++
>  arch/sh/mm/Kconfig                  |    5 +++++
>  3 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/include/cpu-sh4/cpu/cache.h b/arch/sh/include/cpu-sh4/cpu/cache.h
> index 1c61ebf..0a438f5 100644
> --- a/arch/sh/include/cpu-sh4/cpu/cache.h
> +++ b/arch/sh/include/cpu-sh4/cpu/cache.h
> @@ -31,6 +31,11 @@
>  #define CCR_CACHE_EMODE	0x80000000	/* EMODE Enable */
>  #endif
>  
> +#define RAMCR			0xFF000074
> +#define RAMCR_CACHE_L2FC	0x0002
> +#define RAMCR_CACHE_L2E		0x0001
> +#define L2_CACHE_ENABLE		(RAMCR_CACHE_L2E|RAMCR_CACHE_L2FC)
> +
>  /* Default CCR setup: 8k+16k-byte cache,P1-wb,enable */
>  #define CCR_CACHE_ENABLE	(CCR_CACHE_OCE|CCR_CACHE_ICE)
>  #define CCR_CACHE_INVALIDATE	(CCR_CACHE_OCI|CCR_CACHE_ICI)
> diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
> index d29e69c..79646e8 100644
> --- a/arch/sh/kernel/cpu/init.c
> +++ b/arch/sh/kernel/cpu/init.c
> @@ -146,6 +146,14 @@ static void __uses_jump_to_uncached cache_init(void)
>  	flags &= ~CCR_CACHE_ENABLE;
>  #endif
>  
> +#ifdef CONFIG_L2_CACHE_ENABLE
> +	/* Enabel L2 cache */
> +	if (current_cpu_data.flags & CPU_HAS_L2_CACHE) {
> +		ctrl_outl(flags & ~CCR_CACHE_ENABLE, CCR);

What is the purpose of this? This suggests that we don't have to care
about things like the OCE and ICE bits if the L2 cache is enabled, but I
don't see this mentioned anywhere in the specification.

> +		ctrl_outl(L2_CACHE_ENABLE, RAMCR);
> +	}
> +#endif
> +
>  	ctrl_outl(flags, CCR);

And it will be clobbered here anyways, so I expect this part was at least
not verified.

>  	back_to_cached();
>  }
> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
> index 2795618..8be9d95 100644
> --- a/arch/sh/mm/Kconfig
> +++ b/arch/sh/mm/Kconfig
> @@ -291,4 +291,9 @@ config CACHE_OFF
>  
>  endchoice
>  
> +config L2_CACHE_ENABLE
> +	bool "L2 Cache Enable"
> +	depends on CACHE_WRITEBACK || CACHE_WRITETHROUGH
> +	depends on CPU_SH4
> +

There is no point in having this as a config option, we always want it
enabled, and only want it disabled if we build an uncached kernel.

Unfortunately each CPU that implements the L2 seems to do so in totally
different ways, so this is something that will have to be done by the CPU
code. Shoving these bits in RAMCR seems pretty dubious to start with, and
no other sane CPU (ie, SH7786) does this, although obviously in the case
of SH7724 this is just reusing the low reserved RAMCR bits rather than
adding a proper L2CR.

The behaviour also seems to differ. While SH7786 specifically has
I/D-cache fetch bits for the L2, SH7724 seems to skip this and write in
to the addres array directly. The ICE/OCE implications are less obvious
in the case of SH7786, though.
