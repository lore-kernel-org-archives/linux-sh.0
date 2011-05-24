From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 10:31:28 +0000
Subject: [PATCH 03/03] dmaengine: shdma: Update SH_DMAC_MAX_CHANNELS to 20
Message-Id: <20110524103128.10334.73391.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update SH_DMAC_MAX_CHANNELS to support the 20 DMA
channels included in the sh73a0 SY-DMAC hardware.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/dma/shdma.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/dma/shdma.h
+++ work/drivers/dma/shdma.h	2011-05-24 17:08:55.000000000 +0900
@@ -17,7 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 
-#define SH_DMAC_MAX_CHANNELS 6
+#define SH_DMAC_MAX_CHANNELS 20
 #define SH_DMA_SLAVE_NUMBER 256
 #define SH_DMA_TCR_MAX 0x00FFFFFF	/* 16MB */
 
