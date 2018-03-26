From: Palmer Dabbelt <palmer@sifive.com>
Date: Mon, 26 Mar 2018 00:41:14 +0000
Subject: Re: [PATCH v2 02/16] riscv: Use INITRAMFS_GENERIC_UNLOAD.
Message-Id: <mhng-5691a509-dedf-4092-bd6d-020a81512c15@palmer-si-x1c4>
List-Id: <linux-sh.vger.kernel.org>
References: <20180325221853.10839-3-shea@shealevy.com>
In-Reply-To: <20180325221853.10839-3-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shea@shealevy.com
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, 25 Mar 2018 15:18:39 PDT (-0700), shea@shealevy.com wrote:
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  arch/riscv/Kconfig   | 1 +
>  arch/riscv/mm/init.c | 6 ------
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c22ebe08e902..ab1b4cee84fc 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -37,6 +37,7 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select RISCV_TIMER
>  	select GENERIC_IRQ_MULTI_HANDLER
> +	select INITRAMFS_GENERIC_UNLOAD
>
>  config MMU
>  	def_bool y
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c77df8142be2..36f83fe8a726 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -62,9 +62,3 @@ void free_initmem(void)
>  {
>  	free_initmem_default(0);
>  }
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -}
> -#endif /* CONFIG_BLK_DEV_INITRD */

I haven't looked through the rest of the patch set, but this is a pretty 
trivial change so feel free to add a 

Reviewed-By: Palmer Dabbelt <palmer@sifive.com>

if you'd like.  If you'd like it merged through my tree then just say 
something!
