From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 27 Oct 2009 12:11:53 +0000
Subject: Re: Clean config for hp6xx and Hugetlbpage build errors
Message-Id: <20091027131153.7b991d33.kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026201143.a0e55726.kristoffer.ericson@gmail.com>
In-Reply-To: <20091026201143.a0e55726.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 27 Oct 2009 06:59:28 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Mon, Oct 26, 2009 at 08:11:43PM +0100, Kristoffer Ericson wrote:
> > Greetings,
> > 
> > Starting with a fresh ARCH=sh menuconfig and selecting my various bits and pieces
> > for hp6xx, I end up with this:
> > 
> > In file included from include/linux/hugetlb.h:275,
> >                  from arch/sh/mm/hugetlbpage.c:14:
> > /home/kristoffer/work/kernel/linux-hpc.git/arch/sh/include/asm/hugetlb.h: In function `prepare_hugepage_range':
> > /home/kristoffer/work/kernel/linux-hpc.git/arch/sh/include/asm/hugetlb.h:20: error: `HPAGE_SHIFT' undeclared (first use in this function)
> > /home/kristoffer/work/kernel/linux-hpc.git/arch/sh/include/asm/hugetlb.h:20: error: (Each undeclared identifier is reported only once
> > /home/kristoffer/work/kernel/linux-hpc.git/arch/sh/include/asm/hugetlb.h:20: error: for each function it appears in.)
> > make[1]: *** [arch/sh/mm/hugetlbpage.o] Fel 1
> > make: *** [arch/sh/mm] Fel 2
> > 
> Ah, kconfig strikes again. The problem here is that HUGETLB_PAGE depends
> on SUPERH && MMU while the hugetlb page size definitions depend on SH-4
> or SH-5 due to the fact SH-3 doesn't support huge pages.
> 
> Fortunately these days we have a shiny new SYS_SUPPORTS_HUGETLBFS so
> there's no need to further abuse fs/Kconfig.
> 
> This ought to do it for you, and is what I'll fold in to the 2.6.32
> queue.

Sweet, thx.

> 
> ---
> 
>  arch/sh/Kconfig    |    5 +++++
>  arch/sh/mm/Kconfig |    2 +-
>  fs/Kconfig         |    4 ++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 2d3a699..5ac3c0a 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -123,6 +123,9 @@ config SYS_SUPPORTS_APM_EMULATION
>  	bool
>  	select ARCH_SUSPEND_POSSIBLE
>  
> +config SYS_SUPPORTS_HUGETLBFS
> +	bool
> +
>  config SYS_SUPPORTS_SMP
>  	bool
>  
> @@ -197,6 +200,7 @@ config CPU_SH4
>  	select CPU_HAS_SR_RB
>  	select CPU_HAS_FPU if !CPU_SH4AL_DSP
>  	select SYS_SUPPORTS_TMU
> +	select SYS_SUPPORTS_HUGETLBFS if MMU
>  
>  config CPU_SH4A
>  	bool
> @@ -211,6 +215,7 @@ config CPU_SH5
>  	bool
>  	select CPU_HAS_FPU
>  	select SYS_SUPPORTS_TMU
> +	select SYS_SUPPORTS_HUGETLBFS if MMU
>  
>  config CPU_SHX2
>  	bool
> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
> index ca02b72..a5e0867 100644
> --- a/arch/sh/mm/Kconfig
> +++ b/arch/sh/mm/Kconfig
> @@ -225,7 +225,7 @@ endchoice
>  
>  choice
>  	prompt "HugeTLB page size"
> -	depends on HUGETLB_PAGE && (CPU_SH4 || CPU_SH5) && MMU
> +	depends on HUGETLB_PAGE
>  	default HUGETLB_PAGE_SIZE_1MB if PAGE_SIZE_64KB
>  	default HUGETLB_PAGE_SIZE_64K
>  
> diff --git a/fs/Kconfig b/fs/Kconfig
> index d4bf8ca..48b81f9 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -135,8 +135,8 @@ config TMPFS_POSIX_ACL
>  
>  config HUGETLBFS
>  	bool "HugeTLB file system support"
> -	depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || \
> -		   (S390 && 64BIT) || SYS_SUPPORTS_HUGETLBFS || BROKEN
> +	depends on X86 || IA64 || PPC64 || SPARC64 || (S390 && 64BIT) || \
> +		   SYS_SUPPORTS_HUGETLBFS || BROKEN
>  	help
>  	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
>  	  ramfs. For architectures that support it, say Y here and read


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>
