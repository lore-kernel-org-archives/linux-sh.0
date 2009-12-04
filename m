From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Dec 2009 18:44:48 +0000
Subject: [PATCH 2/5] dmaengine: fix dmatest to verify minimum transfer length
Message-Id: <Pine.LNX.4.64.0912041940580.3981@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-sh@vger.kernel.org

Transfers and the test buffer have to be at least align bytes long.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/dmatest.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a32a4cf..8b90516 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -298,10 +298,6 @@ static int dmatest_func(void *data)
 
 		total_tests++;
 
-		len = dmatest_random() % test_buf_size + 1;
-		src_off = dmatest_random() % (test_buf_size - len + 1);
-		dst_off = dmatest_random() % (test_buf_size - len + 1);
-
 		/* honor alignment restrictions */
 		if (thread->type = DMA_MEMCPY)
 			align = dev->copy_align;
@@ -310,7 +306,19 @@ static int dmatest_func(void *data)
 		else if (thread->type = DMA_PQ)
 			align = dev->pq_align;
 
+		if (1 << align > test_buf_size) {
+			pr_err("%u-byte buffer too small for %d-byte alignment\n",
+			       test_buf_size, 1 << align);
+			break;
+		}
+
+		len = dmatest_random() % test_buf_size + 1;
 		len = (len >> align) << align;
+		if (!len)
+			len = 1 << align;
+		src_off = dmatest_random() % (test_buf_size - len + 1);
+		dst_off = dmatest_random() % (test_buf_size - len + 1);
+
 		src_off = (src_off >> align) << align;
 		dst_off = (dst_off >> align) << align;
 
-- 
1.6.2.4

