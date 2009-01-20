From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Tue, 20 Jan 2009 21:55:07 +0000
Subject: Re: [PATCH] dma: fix up broken comparison in
Message-Id: <1232488507.6794.8.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60901201348r6a59928dw3fcf8c9c823d5c68@mail.gmail.com>
In-Reply-To: <8b67d60901201348r6a59928dw3fcf8c9c823d5c68@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh <linux-sh@vger.kernel.org>, penberg@cs.helsinki.fi, dbaryshkov@gmail.com, penguin-kernel@i-love.sakura.ne.jp

On Tue, 2009-01-20 at 21:48 +0000, Adrian McMenamin wrote:
> Currently this code compares a size in bytes with a size in pages.
> This patch makes both sides of the comparison bytes.

Apologies, here it is without the line wrap.

Currently this comparison is made between bytes and pages. This patch
ensures it is bytes on both side of the comparison.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

--- a/kernel/dma-coherent.c
+++ b/kernel/dma-coherent.c
@@ -118,7 +118,7 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 	mem = dev->dma_mem;
 	if (!mem)
 		return 0;
-	if (unlikely(size > mem->size))
+	if (unlikely(size > mem->size << PAGE_SHIFT))
  		return 0;
 
 	pageno = bitmap_find_free_region(mem->bitmap, mem->size, order);

