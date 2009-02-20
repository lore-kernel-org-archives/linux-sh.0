From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 20 Feb 2009 12:19:56 +0000
Subject: Re: [PATCH 1/3] sh: Add support 32-bit physical addressing by
Message-Id: <20090220121956.GA3844@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <499E867C.6080202@renesas.com>
In-Reply-To: <499E867C.6080202@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 19:31 Fri 20 Feb     , Yoshihiro Shimoda wrote:
> There doesn't manage PMB in the kernel. The boot loader should set up PMB.
> P1/P2 area is handled like a 29-bit physical addressing, and local bus
> devices are assigned P3 area.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
>  arch/sh/boot/Makefile           |   15 +++++++++++++
>  arch/sh/include/asm/addrspace.h |    4 +-
>  arch/sh/include/asm/io.h        |    4 +-
>  arch/sh/include/asm/page.h      |    7 +++++-
>  arch/sh/kernel/vmlinux_32.lds.S |    7 ++++-
>  arch/sh/mm/Kconfig              |   32 ++++++++++++++++++++++++++-
>  arch/sh/mm/Makefile_32          |    1 +
>  arch/sh/mm/fixed_pmb.c          |   45 +++++++++++++++++++++++++++++++++++++++
>  arch/sh/mm/ioremap_32.c         |    6 +++-
>  9 files changed, 110 insertions(+), 11 deletions(-)
>  create mode 100644 arch/sh/mm/fixed_pmb.c
> 
> diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
> index c16ccd4..d7ff2af 100644
> --- a/arch/sh/boot/Makefile
> +++ b/arch/sh/boot/Makefile
> @@ -34,8 +34,10 @@ $(obj)/compressed/vmlinux: FORCE
>  	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
> 
is it not possible to create a var or a macro to avoid all this if esle
and idef else?
>  ifeq ($(CONFIG_32BIT),y)
> +ifeq ($(CONFIG_FIXED_PMB),y)
>  KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
>  		     $$[$(CONFIG_PAGE_OFFSET)  + \
> +			($(CONFIG_MEMORY_START) & 0x1fffffff) + \
>  			$(CONFIG_ZERO_PAGE_OFFSET)]')
>  else
>  KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
> @@ -43,11 +45,24 @@ KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
>  			$(CONFIG_MEMORY_START) + \
>  			$(CONFIG_ZERO_PAGE_OFFSET)]')
>  endif
> +else
> +KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
> +		     $$[$(CONFIG_PAGE_OFFSET)  + \
> +			$(CONFIG_MEMORY_START) + \
> +			$(CONFIG_ZERO_PAGE_OFFSET)]')
> +endif
> 
> +ifeq ($(CONFIG_FIXED_PMB),y)
> +KERNEL_ENTRY	:= $(shell /bin/bash -c 'printf "0x%08x" \
> +		     $$[$(CONFIG_PAGE_OFFSET)  + \
> +			($(CONFIG_MEMORY_START) & 0x1fffffff) + \
> +			$(CONFIG_ZERO_PAGE_OFFSET) + $(CONFIG_ENTRY_OFFSET)]')
<snip>
> index 7b4b82b..69fe954 100644
> --- a/arch/sh/kernel/vmlinux_32.lds.S
> +++ b/arch/sh/kernel/vmlinux_32.lds.S
> @@ -15,8 +15,11 @@ OUTPUT_ARCH(sh)
>  ENTRY(_start)
>  SECTIONS
>  {
> -#ifdef CONFIG_32BIT
> -	. = CONFIG_PAGE_OFFSET + CONFIG_ZERO_PAGE_OFFSET;
> +#ifdef CONFIG_FIXED_PMB
> +	. = CONFIG_PAGE_OFFSET + (CONFIG_MEMORY_START & 0x1fffffff) +
> +	    CONFIG_ZERO_PAGE_OFFSET;
> +#elif defined(CONFIG_32BIT)
> +	. = CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START + CONFIG_ZERO_PAGE_OFFSET;
sure? 32Bit and 29bit are the same
>  #else
>  	. = CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START + CONFIG_ZERO_PAGE_OFFSET;
>  #endif
> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
> index 555ec97..8e1b6cf 100644

Best Regards,
J.
