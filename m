From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Feb 2008 05:29:13 +0000
Subject: Re: needs writeback on ptrace
Message-Id: <20080215052913.GA22905@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080215.095254.68562685.saito@densan.co.jp>
In-Reply-To: <20080215.095254.68562685.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 15, 2008 at 09:52:54AM +0900, Hideo Saito wrote:
> Hi Paul,
> 
> When I test gdb on linux-2.6.24 for SH7780, the gdb can't step the program.
> I think inserted breakpoints can't write back to the physical memory.
> 
> Following changes is available for this problem.
> 
> --- ./arch/sh/mm/pg-sh4.c.org	2008-01-25 07:58:37.000000000 +0900
> +++ ./arch/sh/mm/pg-sh4.c	2008-02-06 17:19:58.000000000 +0900
> @@ -87,18 +109,21 @@ void copy_to_user_page(struct vm_area_st
>  	void *vto;
>  
>  	__set_bit(PG_mapped, &page->flags);
>  
>  	vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
>  	memcpy(vto, src, len);
>  	kunmap_coherent(vto);
>  
> -	if (vma->vm_flags & VM_EXEC)
> -		flush_cache_page(vma, vaddr, page_to_pfn(page));
> +	if (vma->vm_flags & VM_EXEC) {
> +		extern void __flush_invalidate_region_icache(void *start, int size);
> +		__flush_wback_region(vto, len);
> +		__flush_invalidate_region_icache(vto, len);
> +	}
>  }
>  
Two problems here, one is that you're trying to use vto outside of the
path where it's mapped (so the logic at least needs to be moved after the
memcpy() and before the kunmap_coherent(), and the other issue is that
this is precisely what flush_cache_page() is doing already. If
flush_cache_page() isn't working in this case, it's important to figure
out why that's so, rather than trying to side-step it with these
__flush_xxx() routines.

How does something like:

	vto = ...
	memcpy

	if (vma->vm_flags & VM_EXEC)
		flush_cache_page(vma, (unsigned long)vto, page_to_pfn(page));
	
	kunmap_coherent(vto);

work?
