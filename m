From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 04:46:38 +0000
Subject: [PATCH 01/05] dmaengine: shdma: Remove sh_dmae_slave_chan_id enum
Message-Id: <20100319044638.17051.97049.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch replaces the sh_dmae_slave_chan_id enum
with an unsigned int. The purpose of this chainge is
to make it possible to separate the slave id enums
from the dmaengine header.

The slave id enums varies with processor model, so in
the future it makes sense to put these in the processor
specific headers together with the pinmux enums.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/dmaengine.h |    6 +++---
 arch/sh/include/asm/siu.h       |    8 ++++----
 drivers/dma/shdma.c             |    8 ++++----
 drivers/serial/sh-sci.c         |    4 ++--
 include/linux/serial_sci.h      |    4 ++--
 5 files changed, 15 insertions(+), 15 deletions(-)

--- 0001/arch/sh/include/asm/dmaengine.h
+++ work/arch/sh/include/asm/dmaengine.h	2010-03-18 23:30:46.000000000 +0900
@@ -17,7 +17,7 @@
 
 #define SH_DMAC_MAX_CHANNELS	6
 
-enum sh_dmae_slave_chan_id {
+enum {
 	SHDMA_SLAVE_SCIF0_TX,
 	SHDMA_SLAVE_SCIF0_RX,
 	SHDMA_SLAVE_SCIF1_TX,
@@ -38,7 +38,7 @@ enum sh_dmae_slave_chan_id {
 };
 
 struct sh_dmae_slave_config {
-	enum sh_dmae_slave_chan_id	slave_id;
+	unsigned int			slave_id;
 	dma_addr_t			addr;
 	u32				chcr;
 	char				mid_rid;
@@ -68,7 +68,7 @@ struct device;
 
 /* Used by slave DMA clients to request DMA to/from a specific peripheral */
 struct sh_dmae_slave {
-	enum sh_dmae_slave_chan_id	slave_id; /* Set by the platform */
+	unsigned int			slave_id; /* Set by the platform */
 	struct device			*dma_dev; /* Set by the platform */
 	struct sh_dmae_slave_config	*config;  /* Set by the driver */
 };
--- 0001/arch/sh/include/asm/siu.h
+++ work/arch/sh/include/asm/siu.h	2010-03-19 13:25:31.000000000 +0900
@@ -17,10 +17,10 @@ struct device;
 
 struct siu_platform {
 	struct device *dma_dev;
-	enum sh_dmae_slave_chan_id dma_slave_tx_a;
-	enum sh_dmae_slave_chan_id dma_slave_rx_a;
-	enum sh_dmae_slave_chan_id dma_slave_tx_b;
-	enum sh_dmae_slave_chan_id dma_slave_rx_b;
+	unsigned int dma_slave_tx_a;
+	unsigned int dma_slave_rx_a;
+	unsigned int dma_slave_tx_b;
+	unsigned int dma_slave_rx_b;
 };
 
 #endif /* ASM_SIU_H */
--- 0001/drivers/dma/shdma.c
+++ work/drivers/dma/shdma.c	2010-03-18 23:30:46.000000000 +0900
@@ -266,7 +266,7 @@ static struct sh_desc *sh_dmae_get_desc(
 }
 
 static struct sh_dmae_slave_config *sh_dmae_find_slave(
-	struct sh_dmae_chan *sh_chan, enum sh_dmae_slave_chan_id slave_id)
+	struct sh_dmae_chan *sh_chan, struct sh_dmae_slave *param)
 {
 	struct dma_device *dma_dev = sh_chan->common.device;
 	struct sh_dmae_device *shdev = container_of(dma_dev,
@@ -274,11 +274,11 @@ static struct sh_dmae_slave_config *sh_d
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	int i;
 
-	if ((unsigned)slave_id >= SHDMA_SLAVE_NUMBER)
+	if (param->slave_id >= SHDMA_SLAVE_NUMBER)
 		return NULL;
 
 	for (i = 0; i < pdata->slave_num; i++)
-		if (pdata->slave[i].slave_id = slave_id)
+		if (pdata->slave[i].slave_id = param->slave_id)
 			return pdata->slave + i;
 
 	return NULL;
@@ -299,7 +299,7 @@ static int sh_dmae_alloc_chan_resources(
 	if (param) {
 		struct sh_dmae_slave_config *cfg;
 
-		cfg = sh_dmae_find_slave(sh_chan, param->slave_id);
+		cfg = sh_dmae_find_slave(sh_chan, param);
 		if (!cfg)
 			return -EINVAL;
 
--- 0001/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2010-03-18 23:30:46.000000000 +0900
@@ -91,8 +91,8 @@ struct sci_port {
 	struct dma_chan			*chan_rx;
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct device			*dma_dev;
-	enum sh_dmae_slave_chan_id	slave_tx;
-	enum sh_dmae_slave_chan_id	slave_rx;
+	unsigned int			slave_tx;
+	unsigned int			slave_rx;
 	struct dma_async_tx_descriptor	*desc_tx;
 	struct dma_async_tx_descriptor	*desc_rx[2];
 	dma_cookie_t			cookie_tx;
--- 0002/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2010-03-18 23:30:46.000000000 +0900
@@ -33,8 +33,8 @@ struct plat_sci_port {
 	char		*clk;			/* clock string */
 	struct device	*dma_dev;
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	enum sh_dmae_slave_chan_id dma_slave_tx;
-	enum sh_dmae_slave_chan_id dma_slave_rx;
+	unsigned int dma_slave_tx;
+	unsigned int dma_slave_rx;
 #endif
 };
 
