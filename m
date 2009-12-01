From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 01 Dec 2009 22:00:14 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: update ecovec24 defconfig
Message-Id: <20091201220014.GA17935@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 01, 2009 at 09:18:55AM +0900, Kuninori Morimoto wrote:
> 
> Dear Matt
> 
> Thank you for your patch !
> 
> > Could you apply this patch and post the backtrace?
> 
> Hmm..
> I applied your patch, but there are no WARN_ON output...
> It still doesn't work.
> I tested it on ms7724se / ecovec24
> My current git commit is fd2cb0ce74e07babaf8c7bf96ef03c25d194e463
> My .config have CONFIG_CACHE_WRITEBACK=y
> 

What size caches do the ms7724se and ecovec24 have?

Here's another patch. Currently, we always do associative writes to the
memory-mapped IC/OC arrays when flushing the cache. Associative writes
require us to use a virtual address (not a physical address) in the
"Tag" section of the data field (8.6.3 OC Address Array in the SH4-A
manual).

The problem with associate writes, however, is that when the translation
is performed on the value of the "Tag" field, if a TLB miss occurs we
don't get an exception. Nothing happens. It's possible to be in a
situation where userland data is in the cache, but because we're using
associative writes and if there's no TLB entry for the userland mapping,
we can't flush the data out of the cache.

Would you mind giving this patch a whirl? I don't really expect your
problems to go away, but it's worth trying. Also, be aware that commit
39ac11c1607f1d566e7cf885acd403fa4f07f8a2 is causing me some issues so
you might want to revert that while testing this patch.


diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 6bfd08d..0811358 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -117,14 +117,14 @@ static void sh4_flush_dcache_page(void *arg)
 	else
 #endif
 	{
-		unsigned long phys = page_to_phys(page);
+		unsigned long virt = (unsigned long)page_address(page);
 		unsigned long addr = CACHE_OC_ADDRESS_ARRAY;
 		int i, n;
 
 		/* Loop all the D-cache */
 		n = boot_cpu_data.dcache.n_aliases;
 		for (i = 0; i <= n; i++, addr += PAGE_SIZE)
-			flush_cache_one(addr, phys);
+			flush_cache_one(addr, virt);
 	}
 
 	wmb();
@@ -258,7 +258,7 @@ static void sh4_flush_cache_page(void *args)
 
 	if (pages_do_alias(address, phys))
 		flush_cache_one(CACHE_OC_ADDRESS_ARRAY |
-			(address & shm_align_mask), phys);
+			(address & shm_align_mask), address);
 
 	if (vma->vm_flags & VM_EXEC)
 		flush_icache_all();
