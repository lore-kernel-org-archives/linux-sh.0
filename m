From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 17:40:08 +0000
Subject: [PATCH v3 1/9] dmaengine: Add 16 bytes, 32 bytes and 64 bytes bus widths
Message-Id: <1414345216-14486-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The widths are missing, add them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/linux/dmaengine.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 653a1fd07ae8..aa13a6d9f4e6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -298,6 +298,9 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
 	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
 	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
+	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
+	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
+	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
 };
 
 /**
-- 
2.0.4

