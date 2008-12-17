From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2008 08:18:45 +0000
Subject: [PATCH] sh: split coherent pages
Message-Id: <20081217081845.28528.20104.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Split pages returned by dma_alloc_coherent() and make sure
we free them one by one.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/mm/consistent.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- 0001/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2008-12-17 17:12:04.000000000 +0900
@@ -42,6 +42,8 @@ void *dma_alloc_coherent(struct device *
 		return NULL;
 	}
 
+	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
+
 	*dma_handle = virt_to_phys(ret);
 	return ret_nocache;
 }
@@ -51,10 +53,13 @@ void dma_free_coherent(struct device *de
 			 void *vaddr, dma_addr_t dma_handle)
 {
 	int order = get_order(size);
+	unsigned long pfn = dma_handle >> PAGE_SHIFT;
+	int k;
 
 	if (!dma_release_from_coherent(dev, order, vaddr)) {
 		WARN_ON(irqs_disabled());	/* for portability */
-		free_pages((unsigned long)phys_to_virt(dma_handle), order);
+		for (k = 0; k < (1 << order); k++)
+			__free_pages(pfn_to_page(pfn + k), 0);
 		iounmap(vaddr);
 	}
 }
