From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 31 Jan 2010 11:55:27 +0000
Subject: Re: Bug: access to already released memory
Message-Id: <m3vdeiqyj4.fsf@phlog.console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <a328840c1001301356r14505614pbb4563754c6890ac@mail.gmail.com>
In-Reply-To: <a328840c1001301356r14505614pbb4563754c6890ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, 30 Jan 2010 22:56:30 +0100, Marek Skuczynski <mareksk7@gmail.com> wrote:
> Hello,
>    I have found two places where access to already released memory happens,
>    attaching patches.
> 
> Regards,
>   Marek
> From 1d0be80204871527e1e7757f4a009ce6f9ba0d73 Mon Sep 17 00:00:00 2001
> From: Marek Skuczynski <mareksk7@gmail.com>
> Date: Sat, 30 Jan 2010 22:27:41 +0100
> Subject: [PATCH 1/2] sh: Fix access to released memory in dwarf_unwinder_cleanup()
> 
> Signed-off-by: Marek Skuczynski <mareksk7@gmail.com>
> ---
>  arch/sh/kernel/dwarf.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
> index 3576b70..88d28ec 100644
> --- a/arch/sh/kernel/dwarf.c
> +++ b/arch/sh/kernel/dwarf.c
> @@ -892,18 +892,18 @@ static struct unwinder dwarf_unwinder = {
>  
>  static void dwarf_unwinder_cleanup(void)
>  {
> -	struct dwarf_cie *cie;
> -	struct dwarf_fde *fde;
> +	struct dwarf_cie *cie, *cie_tmp;
> +	struct dwarf_fde *fde, *fde_tmp;
>  
>  	/*
>  	 * Deallocate all the memory allocated for the DWARF unwinder.
>  	 * Traverse all the FDE/CIE lists and remove and free all the
>  	 * memory associated with those data structures.
>  	 */
> -	list_for_each_entry(cie, &dwarf_cie_list, link)
> +	list_for_each_entry_safe(cie, cie_tmp, &dwarf_cie_list, link)
>  		kfree(cie);
>  
> -	list_for_each_entry(fde, &dwarf_fde_list, link)
> +	list_for_each_entry_safe(fde, fde_tmp, &dwarf_fde_list, link)
>  		kfree(fde);
>  
>  	kmem_cache_destroy(dwarf_reg_cachep);
> -- 
> 1.6.4.2
> 

Good catch.

Acked-by: Matt Fleming <matt@console-pimps.org>
