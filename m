From: Rich Felker <dalias@libc.org>
Date: Mon, 04 Jul 2016 01:48:52 +0000
Subject: Re: [PATCH v5 04/22] sh: Use P1SEGADDR
Message-Id: <20160704014852.GO15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <1467564402-2649-5-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-5-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 04, 2016 at 01:46:24AM +0900, Yoshinori Sato wrote:
> FDT address is P1SEG. So not virtual address.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 86f2792..8e3b099 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -254,7 +254,7 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
>  #ifdef CONFIG_USE_BUILTIN_DTB
>  	dt_virt = __dtb_start;
>  #else
> -	dt_virt = phys_to_virt(dt_phys);
> +	dt_virt = (void *)P1SEGADDR(dt_phys);
>  #endif
>  
>  	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
> -- 

I don't think this change is correct, and I'm not sure what the
motivation is. It certainly can't work with !CONFIG_29BIT, and likely
can't work on nommu either (it won't work on J2). Maybe we have
different ideas about the sort of physical address the boot loader is
expected to pass; I would expect it to be something that, when passed
to phys_to_virt, yields an address the kernel can use to access the
memory. This does not necessarily mean it's MMU-mapped memory; it
could be (and in practice will be, I think) an address in the P1
segment obtained by adding PAGE_OFFSET (see asm/page.h).

Rich
