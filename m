From: Rich Felker <dalias@libc.org>
Date: Thu, 29 Mar 2018 16:26:56 +0000
Subject: Re: [PATCH v5 15/16] sh: Switch to generic free_initrd_mem.
Message-Id: <20180329162656.GP1436@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20180328203659.18692-1-shea@shealevy.com>
 <20180329113207.30674-1-shea@shealevy.com>
 <20180329113207.30674-15-shea@shealevy.com>
In-Reply-To: <20180329113207.30674-15-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-riscv@lists.infradead.org

On Thu, Mar 29, 2018 at 07:32:06AM -0400, Shea Levy wrote:
> The generic implementation is functionally identical.
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  arch/sh/mm/init.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index ce0bbaa7e404..7451459d0725 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -477,13 +477,6 @@ void free_initmem(void)
>  	free_initmem_default(-1);
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> -
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>  		bool want_memblock)
> -- 
> 2.16.2

LGTM.

Acked-by: Rich Felker <dalias@libc.org>
