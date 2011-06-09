From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 09 Jun 2011 06:31:33 +0000
Subject: Re: Ecovec (SH7724) board doesn't work on latest linus tree
Message-Id: <20110609063132.GC26006@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 09, 2011 at 03:21:17PM +0900, Kuninori Morimoto wrote:
> Unable to handle kernel paging request at virtual address 6e000000              
> pc = 8800ef82                                                                   
> *pde = 00000000                                                                 
> Oops: 0000 [#1]                                                                 
> Modules linked in:                                                              
>                                                                                 
> Pid : 1, Comm:          swapper                                                 
> CPU : 0                 Not tainted  (3.0.0-rc2+ #910)                          
>                                                                                 
> PC is at sh4__flush_purge_region+0x30/0x8a                                      
> PR is at dma_cache_sync+0x32/0x54                                               

Grr. Can you try with the following debug patch?

---

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index f251b5f..01bb4ee 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -84,6 +84,10 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	addr = __in_29bit_mode() ?
 	       (void *)CAC_ADDR((unsigned long)vaddr) : vaddr;
 
+	printk_once("%s: vaddr %p, CAC %08lx, P1SEG %08lx\n", __func__, vaddr,
+		CAC_ADDR((unsigned long)vaddr),
+		P1SEGADDR((unsigned long)vaddr));
+
 	switch (direction) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
 		__flush_invalidate_region(addr, size);
