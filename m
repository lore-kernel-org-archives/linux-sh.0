From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 04:46:47 +0000
Subject: [PATCH 02/05] dmaengine: shdma: Common SH_DMA_SLAVE_NUMBER
Message-Id: <20100319044647.17051.25902.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move SHDMA_SLAVE_NUMBER from asm/dmaengine.h to
shdma.h. Set it to 256 to support a wide range
of processors. The amount of memory consumed by
this change is limited to 256 bits.

While at it, rename to SH_DMA_SLAVE_NUMBER to
match with the rest of the file.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/dmaengine.h |    1 -
 drivers/dma/shdma.c             |    4 ++--
 drivers/dma/shdma.h             |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

--- 0003/arch/sh/include/asm/dmaengine.h
+++ work/arch/sh/include/asm/dmaengine.h	2010-03-18 16:42:03.000000000 +0900
@@ -34,7 +34,6 @@ enum {
 	SHDMA_SLAVE_SIUA_RX,
 	SHDMA_SLAVE_SIUB_TX,
 	SHDMA_SLAVE_SIUB_RX,
-	SHDMA_SLAVE_NUMBER,	/* Must stay last */
 };
 
 struct sh_dmae_slave_config {
--- 0003/drivers/dma/shdma.c
+++ work/drivers/dma/shdma.c	2010-03-18 16:42:15.000000000 +0900
@@ -44,7 +44,7 @@ enum sh_dmae_desc_status {
 #define LOG2_DEFAULT_XFER_SIZE	2
 
 /* A bitmask with bits enough for enum sh_dmae_slave_chan_id */
-static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SHDMA_SLAVE_NUMBER)];
+static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SH_DMA_SLAVE_NUMBER)];
 
 static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all);
 
@@ -274,7 +274,7 @@ static struct sh_dmae_slave_config *sh_d
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	int i;
 
-	if (param->slave_id >= SHDMA_SLAVE_NUMBER)
+	if (param->slave_id >= SH_DMA_SLAVE_NUMBER)
 		return NULL;
 
 	for (i = 0; i < pdata->slave_num; i++)
--- 0001/drivers/dma/shdma.h
+++ work/drivers/dma/shdma.h	2010-03-18 16:42:03.000000000 +0900
@@ -19,6 +19,7 @@
 
 #include <asm/dmaengine.h>
 
+#define SH_DMA_SLAVE_NUMBER 256
 #define SH_DMA_TCR_MAX 0x00FFFFFF	/* 16MB */
 
 struct device;
