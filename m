From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 10 Dec 2009 17:35:15 +0000
Subject: [PATCH 3/3] dmaengine: clarify the meaning of the DMA_CTRL_ACK flag
Message-Id: <Pine.LNX.4.64.0912101833520.4487@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912101826010.4487@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912101826010.4487@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-sh@vger.kernel.org

DMA_CTRL_ACK's description applies to its clear state, not to its set state.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/dmaengine.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 2b9f2ac..7878498 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -74,7 +74,7 @@ enum dma_transaction_type {
  *  control completion, and communicate status.
  * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon completion of
  *  this transaction
- * @DMA_CTRL_ACK - the descriptor cannot be reused until the client
+ * @DMA_CTRL_ACK - if clear, the descriptor cannot be reused until the client
  *  acknowledges receipt, i.e. has has a chance to establish any dependency
  *  chains
  * @DMA_COMPL_SKIP_SRC_UNMAP - set to disable dma-unmapping the source buffer(s)
-- 
1.6.2.4

