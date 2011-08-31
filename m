From: Yutaro Ebihara <ebiharaml@si-linux.co.jp>
Date: Wed, 31 Aug 2011 15:07:18 +0000
Subject: Re: Ecovec (SH7724) board doesn't work on latest linus tree
Message-Id: <2ECC67EFACD13Cebiharaml@si-linux.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

hello.

i think you can run linux-3.0.4 kernel on your Ecovec (SH7724) board 
in this debug-code.


 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
                     enum dma_data_direction direction)
 {
         void *addr;
 
         addr = __in_29bit_mode() ?
-               (void *)CAC_ADDR((unsigned long)vaddr) : vaddr;
+               (void *)P1SEGADDR((unsigned long)vaddr) : vaddr;



CAC_ADDR((unsigned long)vaddr) : vaddr; 
must be fail.



>@@ -84,6 +84,10 @@ void dma_cache_sync(struct device *dev, void *vaddr, 
>size_t size,
> 	addr = __in_29bit_mode() ?
> 	       (void *)CAC_ADDR((unsigned long)vaddr) : vaddr;



>
>Dear Paul
>
>Ecovec board still doesn't work on latest linus tree.
>Because of below commit.
>
>----------------
>commit 3f9b8520b06013939ad247ba08b69529b5f14be1
>Author: Paul Mundt <lethal@linux-sh.org>
>Date:   Tue May 31 14:38:29 2011 +0900
>
>    sh64: Move from P1SEG to CAC_ADDR for consistent sync.
>    
>    sh64 doesn't define a P1SEGADDR, resulting in a build failure. The proper
>    mapping can be attained for both sh32 and 64 via the CAC_ADDR macro, so
>    switch to that instead.
>    
>    Signed-off-by: Paul Mundt <lethal@linux-sh.org>
>----------------
>
>The output of below patch was 
>
>dma_cache_sync: vaddr 8e000000, CAC 6e000000, P1SEG 8e000000       
>
>------
>diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
>index f251b5f..01bb4ee 100644
>--- a/arch/sh/mm/consistent.c
>+++ b/arch/sh/mm/consistent.c
>@@ -84,6 +84,10 @@ void dma_cache_sync(struct device *dev, void *vaddr, 
>size_t size,
> 	addr = __in_29bit_mode() ?
> 	       (void *)CAC_ADDR((unsigned long)vaddr) : vaddr;
> 
>+	printk_once("%s: vaddr %p, CAC %08lx, P1SEG %08lx\n", __func__, vaddr,
>+		CAC_ADDR((unsigned long)vaddr),
>+		P1SEGADDR((unsigned long)vaddr));
>+
> 	switch (direction) {
> 	case DMA_FROM_DEVICE:		/* invalidate only */
> 		__flush_invalidate_region(addr, size);
>
>
>Best regards
>---
>Kuninori Morimoto
>--
>To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
