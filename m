From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 08:59:35 +0000
Subject: [PATCH 2/3] dma: rcar-audmapp: don't keep audmapp_slave_config for each channeles
Message-Id: <87r42my4nb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87tx7iy4ot.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87tx7iy4ot.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@gmail.com

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current audmapp driver is keeping audmapp_slave_config
for each channeles, but, nessasary information is only "chcr".
Current style (= keeping audmapp_slave_config) is
not good match for DT support.
Keep "chcr" instead of audmapp_slave_config

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-audmapp.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rcar-audmapp.c b/drivers/dma/sh/rcar-audmapp.c
index 858483b..dd00775 100644
--- a/drivers/dma/sh/rcar-audmapp.c
+++ b/drivers/dma/sh/rcar-audmapp.c
@@ -45,9 +45,9 @@
 
 struct audmapp_chan {
 	struct shdma_chan shdma_chan;
-	struct audmapp_slave_config *config;
 	void __iomem *base;
 	dma_addr_t slave_addr;
+	u32 chcr;
 };
 
 struct audmapp_device {
@@ -103,9 +103,8 @@ static void audmapp_start_xfer(struct shdma_chan *schan,
 	struct audmapp_chan *auchan = to_chan(schan);
 	struct audmapp_device *audev = to_dev(auchan);
 	struct audmapp_desc *desc = to_desc(sdesc);
-	struct audmapp_slave_config *cfg = auchan->config;
 	struct device *dev = audev->dev;
-	u32 chcr = cfg->chcr | PDMACHCR_DE;
+	u32 chcr = auchan->chcr | PDMACHCR_DE;
 
 	dev_dbg(dev, "src/dst/chcr = %pad/%pad/%08x\n",
 		&desc->src, &desc->dst, chcr);
@@ -145,7 +144,7 @@ static int audmapp_set_slave(struct shdma_chan *schan, int slave_id,
 	if (try)
 		return 0;
 
-	auchan->config	= cfg;
+	auchan->chcr	= cfg->chcr;
 	auchan->slave_addr = slave_addr ? : cfg->dst;
 
 	return 0;
@@ -156,11 +155,6 @@ static int audmapp_desc_setup(struct shdma_chan *schan,
 			      dma_addr_t src, dma_addr_t dst, size_t *len)
 {
 	struct audmapp_desc *desc = to_desc(sdesc);
-	struct audmapp_chan *auchan = to_chan(schan);
-	struct audmapp_slave_config *cfg = auchan->config;
-
-	if (!cfg)
-		return -ENODEV;
 
 	if (*len > (size_t)AUDMAPP_LEN_MAX)
 		*len = (size_t)AUDMAPP_LEN_MAX;
-- 
1.7.9.5

