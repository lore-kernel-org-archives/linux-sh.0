From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 Jul 2012 10:29:37 +0000
Subject: [PATCH 1/7 v2] dmaengine: shdma: (cosmetic) simplify a static function
Message-Id: <1341484183-10757-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

dmae_find_slave() needs only the slave_id field from the slave object, no
need to pass the pointer to the object, pass the slave_id directly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/sh/shdma.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index c393b35..f06906f 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -304,18 +304,18 @@ static void sh_dmae_setup_xfer(struct shdma_chan *schan,
 }
 
 static const struct sh_dmae_slave_config *dmae_find_slave(
-	struct sh_dmae_chan *sh_chan, struct sh_dmae_slave *slave)
+	struct sh_dmae_chan *sh_chan, unsigned int slave_id)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	const struct sh_dmae_slave_config *cfg;
 	int i;
 
-	if (slave->shdma_slave.slave_id >= SH_DMA_SLAVE_NUMBER)
+	if (slave_id >= SH_DMA_SLAVE_NUMBER)
 		return NULL;
 
 	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
-		if (cfg->slave_id = slave->shdma_slave.slave_id)
+		if (cfg->slave_id = slave_id)
 			return cfg;
 
 	return NULL;
@@ -328,7 +328,7 @@ static int sh_dmae_set_slave(struct shdma_chan *schan,
 						    shdma_chan);
 	struct sh_dmae_slave *slave = container_of(sslave, struct sh_dmae_slave,
 						   shdma_slave);
-	const struct sh_dmae_slave_config *cfg = dmae_find_slave(sh_chan, slave);
+	const struct sh_dmae_slave_config *cfg = dmae_find_slave(sh_chan, sslave->slave_id);
 	if (!cfg)
 		return -ENODEV;
 
-- 
1.7.2.5

