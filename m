From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 22 Dec 2009 16:51:50 +0000
Subject: Re: Probably cache synchronization issue on SH7723
Message-Id: <20091222165150.GA7254@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 22, 2009 at 05:18:16PM +0100, Pietrek, Markus wrote:
> Hi, 
>
> Lacking some understanding of the caching system I'm not sure why in
> update_cache() some dirty pages are skipped. The following patch fixes
> my problem, but I'm not sure about any negative side effects.

Interesting! Good investigative work.

It's an optimisation so that we don't flush the dcache more than we need
to. There shouldn't be any negative side effects of your patch, it's
just a bit inefficient.

Having looked at the MIPS __update_cache() function I'm wondering if the
bug is that we should be flushing the cache if the page is executable.

Could you try this patch?

diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index e9415d3..8460bbf 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -126,8 +126,9 @@ void __update_cache(struct vm_area_struct *vma,
 {
 	struct page *page;
 	unsigned long pfn = pte_pfn(pte);
+	int exec = (vma->vm_flags & VM_EXEC);
 
-	if (!boot_cpu_data.dcache.n_aliases)
+	if (!boot_cpu_data.dcache.n_aliases && !exec)
 		return;
 
 	page = pfn_to_page(pfn);
@@ -136,7 +137,7 @@ void __update_cache(struct vm_area_struct *vma,
 		if (dirty) {
 			unsigned long addr = (unsigned long)page_address(page);
 
-			if (pages_do_alias(addr, address & PAGE_MASK))
+			if (exec || pages_do_alias(addr, address & PAGE_MASK))
 				__flush_purge_region((void *)addr, PAGE_SIZE);
 		}
 	}

