From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 03:49:46 +0000
Subject: [PATCH 9/9 v4] ASoC: fsi: Configure DMA slave settings
Message-Id: <87r3unlbhp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current FSI driver is assuming that dst_addr/src_addr of DMAEngine
will be set by platform data. But it should be set via
dmaengine_slave_config(). Special thanks to Arnd

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - new patch

 sound/soc/sh/fsi.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index dc28b03..bb20550 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -250,6 +250,7 @@ struct fsi_clk {
 
 struct fsi_priv {
 	void __iomem *base;
+	phys_addr_t phys;
 	struct fsi_master *master;
 
 	struct fsi_stream playback;
@@ -1374,9 +1375,15 @@ static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct dev
 		struct dma_slave_config cfg = {};
 		int ret;
 
-		cfg.dst_addr	= 0; /* use default addr */
-		cfg.src_addr	= 0; /* use default addr */
-		cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+		if (is_play) {
+			cfg.dst_addr		= fsi->phys + REG_DODT;
+			cfg.dst_addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES;
+			cfg.direction		= DMA_MEM_TO_DEV;
+		} else {
+			cfg.src_addr		= fsi->phys + REG_DIDT;
+			cfg.src_addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES;
+			cfg.direction		= DMA_DEV_TO_MEM;
+		}
 
 		ret = dmaengine_slave_config(io->chan, &cfg);
 		if (ret < 0) {
@@ -1940,6 +1947,7 @@ static int fsi_probe(struct platform_device *pdev)
 	/* FSI A setting */
 	fsi		= &master->fsia;
 	fsi->base	= master->base;
+	fsi->phys	= res->start;
 	fsi->master	= master;
 	fsi_port_info_init(fsi, &info.port_a);
 	fsi_handler_init(fsi, &info.port_a);
@@ -1952,6 +1960,7 @@ static int fsi_probe(struct platform_device *pdev)
 	/* FSI B setting */
 	fsi		= &master->fsib;
 	fsi->base	= master->base + 0x40;
+	fsi->phys	= res->start + 0x40;
 	fsi->master	= master;
 	fsi_port_info_init(fsi, &info.port_b);
 	fsi_handler_init(fsi, &info.port_b);
-- 
1.7.9.5

