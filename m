From: Adrian McMenamin <lkmladrian@gmail.com>
Date: Tue, 20 Jan 2009 21:48:00 +0000
Subject: [PATCH] dma: fix up broken comparison in dma_alloc_from_coherent
Message-Id: <8b67d60901201348r6a59928dw3fcf8c9c823d5c68@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh <linux-sh@vger.kernel.org>, penberg@cs.helsinki.fi, dbaryshkov@gmail.com, penguin-kernel@i-love.sakura.ne.jp, Adrian McMenamin <adrian@newgolddream.dyndns.info>

Currently this code compares a size in bytes with a size in pages.
This patch makes both sides of the comparison bytes.


Previous code (introduced in commit
58c6d3dfe436eb8cfb451981d8fdc9044eaf42da) brakes Dreamcast, this code
has been tested and works on the Dreamcast.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff --git a/kernel/dma-coherent.c b/kernel/dma-coherent.c
index 0387074..8114dd7 100644
--- a/kernel/dma-coherent.c
+++ b/kernel/dma-coherent.c
@@ -112,13 +112,13 @@ int dma_alloc_from_coherent(struct device *dev,
ssize_t size,
 	struct dma_coherent_mem *mem;
 	int order = get_order(size);
 	int pageno;

 	if (!dev)
 		return 0;
 	mem = dev->dma_mem;
 	if (!mem)
 		return 0;
-	if (unlikely(size > mem->size))
+	if (unlikely(size > mem->size << PAGE_SHIFT))
  		return 0;

 	pageno = bitmap_find_free_region(mem->bitmap, mem->size, order);
