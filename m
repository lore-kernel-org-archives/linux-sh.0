From: Julia Lawall <julia@diku.dk>
Date: Tue, 26 Feb 2008 20:42:11 +0000
Subject: [PATCH 1/9] arch/sh/drivers/dma/dma-sh.c: Correct use of.and &
Message-Id: <Pine.LNX.4.64.0802262141450.18200@ask.diku.dk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

In commit e6bafba5b4765a5a252f1b8d31cbf6d2459da337, a bug was fixed that
involved converting !x & y to !(x & y).  The code below shows the same
pattern, and thus should perhaps be fixed in the same way.

This is not tested and clearly changes the semantics, so it is only
something to consider.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@ expression E1,E2; @@
(
  !E1 & !E2
|
- !E1 & E2
+ !(E1 & E2)
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

diff -u -p a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
--- a/arch/sh/drivers/dma/dma-sh.c 2008-02-02 16:08:46.000000000 +0100
+++ b/arch/sh/drivers/dma/dma-sh.c 2008-02-26 08:00:00.000000000 +0100
@@ -90,7 +90,7 @@ static irqreturn_t dma_tei(int irq, void
 
 static int sh_dmac_request_dma(struct dma_channel *chan)
 {
-	if (unlikely(!chan->flags & DMA_TEI_CAPABLE))
+	if (unlikely(!(chan->flags & DMA_TEI_CAPABLE)))
 		return 0;
 
 	return request_irq(get_dmte_irq(chan->chan), dma_tei,
