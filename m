From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 17 Dec 2019 06:53:47 +0000
Subject: Re: [PATCH] SH: Convert iounmap() macros to inline functions
Message-Id: <20191217065347.GA28172@ravnborg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87eex3h2g6.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eex3h2g6.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Kuninori

On Tue, Dec 17, 2019 at 03:48:57PM +0900, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Macro iounmap() do nothing, but that results in
> unused variable warnings all over the place.
> This patch convert it to inline to avoid warning

To help other people with the same warning it is always a good idea to
include the warning you fix in the changelog.

With this fixed:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> 
> Fixes: 98c90e5ea34e9 ("sh: remove __iounmap")
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/sh/include/asm/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index 1495489..351a0a9 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -328,7 +328,7 @@ __ioremap_mode(phys_addr_t offset, unsigned long size, pgprot_t prot)
>  #else
>  #define __ioremap(offset, size, prot)		((void __iomem *)(offset))
>  #define __ioremap_mode(offset, size, prot)	((void __iomem *)(offset))
> -#define iounmap(addr)				do { } while (0)
> +static inline void iounmap(void __iomem *addr) {}
>  #endif /* CONFIG_MMU */
>  
>  static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
> -- 
> 2.7.4
