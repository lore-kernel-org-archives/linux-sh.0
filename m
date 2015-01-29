From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Jan 2015 01:03:42 +0000
Subject: [PATCH 8/9 v4] ASoC: fsi: remove slave_id settings for DMAEngine
Message-Id: <87a912tn13.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sif3lbi7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sif3lbi7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current fsi sets dma_slave_config :: slave_id field for DMAEngine,
but it is no longer needed. Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - no change

 sound/soc/sh/fsi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 8869971..c4eb234 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1374,10 +1374,9 @@ static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct dev
 				shdma_chan_filter, (void *)io->dma_id,
 				dev, is_play ? "tx" : "rx");
 	if (io->chan) {
-		struct dma_slave_config cfg;
+		struct dma_slave_config cfg = {};
 		int ret;
 
-		cfg.slave_id	= io->dma_id;
 		cfg.dst_addr	= 0; /* use default addr */
 		cfg.src_addr	= 0; /* use default addr */
 		cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-- 
1.7.9.5

