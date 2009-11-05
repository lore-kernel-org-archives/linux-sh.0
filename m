From: Matt Fleming <matt@console-pimps.org>
Date: Thu, 05 Nov 2009 23:22:49 +0000
Subject: Re: [PATCH] sh: sh4a: Cache optimization if no cache alias
Message-Id: <20091105232249.GB7361@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4AD5C968.1030005@siemens.com>
In-Reply-To: <4AD5C968.1030005@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 14, 2009 at 04:51:52PM +0400, Valentin R Sitsikov wrote:
> Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>
> ---
> arch/sh/include/asm/system_32.h |    2 +-
> arch/sh/mm/Makefile             |    1 +
> arch/sh/mm/cache-sh4a.c         |  169  
> +++++++++++++++++++++++++++++++++++++++

Your email client appears to have word wrapped this patch which means
that it does not apply cleanly.

> arch/sh/mm/cache.c              |    6 ++
> 4 files changed, 177 insertions(+), 1 deletions(-)
> create mode 100644 arch/sh/mm/cache-sh4a.c
>
> diff --git a/arch/sh/include/asm/system_32.h  
> b/arch/sh/include/asm/system_32.h
> index 607d413..7fe8011 100644
> --- a/arch/sh/include/asm/system_32.h
> +++ b/arch/sh/include/asm/system_32.h
> @@ -72,7 +72,7 @@ do {                                    \
> #define __ocbp(addr)    __asm__ __volatile__ ( "ocbp @%0\n\t" : : "r"  
> (addr))
> #define __ocbi(addr)    __asm__ __volatile__ ( "ocbi @%0\n\t" : : "r"  
> (addr))
> #define __ocbwb(addr)    __asm__ __volatile__ ( "ocbwb @%0\n\t" : : "r"  
> (addr))
> -
> +#define __icbi(addr)    __asm__ __volatile__ ( "icbi @%0\n\t" : : "r"  
> (addr))

I don't think this change is correct. the icbi instruction is only
available on SH4-A and there is already an __icbi() placeholder for
non-SH4A CPUs. This will break all non-SH4A builds,

arch/sh/include/asm/system_32.h:75: error: "__icbi" redefined
arch/sh/include/asm/system_32.h:69: note: this is the location of the previous definition

[...]

> +/*
> + * Write back & invalidate the D-cache of the page.
> + * (To avoid "alias" issues)
> + */
> +static void sh4a_flush_dcache_page(void *arg)
> +{
> +    struct page *page = arg;
> +    struct address_space *mapping = page_mapping(page);
> +
> +#ifndef CONFIG_SMP
> +    if (mapping && !mapping_mapped(mapping))
> +        set_bit(PG_dcache_dirty, &page->flags);
> +    else
> +#endif
> +    {
> +        sh4a_purge_dcache(page_address(page), PAGE_SIZE);
> +        sh4a_invalidate_icache(page_address(page), PAGE_SIZE);
> +    }

Is there a reason why you are also invalidating the icache here? I think
that only the dcache needs to be written-back and invalidated.

> +/*
> + * SH-4 has virtually indexed and physically tagged cache.
> + */
> +void __init sh4a_cache_init(void)
> +{
> +    printk("SH4A cache optimization\n");
> +
> +    local_flush_icache_range    = sh4a_flush_icache_range;
> +    /* Not sure about alias cases - not checked yet */
> +    if (boot_cpu_data.dcache.n_aliases = 0) {
> +        local_flush_dcache_page        = sh4a_flush_dcache_page;
> +    }
> +
> +}

It is possible for the icache to have aliases too, so you should
probably only use the sh4a optimized versions if there are no icache
aliases. Also, it would be a good idea to move the printk() so that the
"SH4A cache optimization" string is only printed if there are no aliases
in the cache and we're actually using the optimized versions.
