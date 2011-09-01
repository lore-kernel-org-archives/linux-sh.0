From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 01 Sep 2011 01:28:19 +0000
Subject: Re: Ecovec (SH7724) board doesn't work on latest linus tree
Message-Id: <8762ldcaqa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ebihara-san, and Paul

Thank you for your report.

> i think you can run linux-3.0.4 kernel on your Ecovec (SH7724) board 
> in this debug-code.
> 
> 
>  void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>                      enum dma_data_direction direction)
>  {
>          void *addr;
>  
>          addr = __in_29bit_mode() ?
> -               (void *)CAC_ADDR((unsigned long)vaddr) : vaddr;
> +               (void *)P1SEGADDR((unsigned long)vaddr) : vaddr;

Paul

I guess your patch tried to share code for sh32/sh64.
and CAC_ADDR() should be equal P1SEGADDR(), correct ?

I'm not filmier with memory control, but
on Ecovec case, 1st (and crash case) dma_cache_sync() caller is
${LINUX}/arch/sh/mm/consistent.c :: dma_generic_alloc_coherent()

it tried

	ret = (void *)__get_free_pages(gfp, order);
        (snip)
        dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);

This "ret" is "8e000000" for now.

but CAC_ADDR(xx)/P1SEGADDR(xx) is defined as below

CAC_ADDR(addr)  ((addr) - uncached_start + PAGE_OFFSET)
P1SEGADDR(a)    ((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | P1SEG))

I guess this "ret" should be uncached area if dma_cache_sync(xx) use CAC_ADDR(xx).

If I apply below patch, Ecovec start works without crash, but I'm not sure.
Is this correct patch ?

--------------------
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index f251b5f..198234a 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -48,7 +48,7 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t si
         * Pages from the page allocator may have data present in
         * cache. So flush the cache before using uncached memory.
         */
-       dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);
+       dma_cache_sync(dev, UNCAC_ADDR(ret), size, DMA_BIDIRECTIONAL);
 
        ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
        if (!ret_nocache) {
-------------------------

But I'm afraid below comment of dma_generic_alloc_coherent()

	/*
	 * Pages from the page allocator may have data present in
	 * cache. So flush the cache before using uncached memory.
	 */
	dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);


Best regards
---
Kuninori Morimoto
