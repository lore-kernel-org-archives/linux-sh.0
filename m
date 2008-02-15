From: Hideo Saito <saito@densan.co.jp>
Date: Fri, 15 Feb 2008 07:40:03 +0000
Subject: Re: needs writeback on ptrace
Message-Id: <20080215.164003.46639159.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20080215.095254.68562685.saito@densan.co.jp>
In-Reply-To: <20080215.095254.68562685.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 15 Feb 2008 14:29:13 +0900, Paul Mundt wrote:

> Two problems here, one is that you're trying to use vto outside of the
> path where it's mapped (so the logic at least needs to be moved after the
> memcpy() and before the kunmap_coherent(), and the other issue is that
> this is precisely what flush_cache_page() is doing already. If
> flush_cache_page() isn't working in this case, it's important to figure
> out why that's so, rather than trying to side-step it with these
> __flush_xxx() routines.
> 
> How does something like:
> 
> 	vto = ...
> 	memcpy
> 
> 	if (vma->vm_flags & VM_EXEC)
> 		flush_cache_page(vma, (unsigned long)vto, page_to_pfn(page));
> 	
> 	kunmap_coherent(vto);
> 
> work?

The chang was not effective. If the following code at flush_cache_page() in cache-sh4.c is removed, gdb works.

        if ((address^phys) & alias_mask) {
                /* Loop 4K of the D-cache */
                flush_cache_4096(
                        CACHE_OC_ADDRESS_ARRAY | (address & alias_mask),
                        phys);
                /* Loop another 4K of the D-cache */
                flush_cache_4096(
                        CACHE_OC_ADDRESS_ARRAY | (phys & alias_mask),
                        phys);
        }

modified as follows:
        if (1) {
            ...
        }

I think that the breakpoint should always be written to the physical memory.
