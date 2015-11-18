From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Nov 2015 21:16:48 +0000
Subject: [PATCH] ASoC: sh: fix fsi build warnings for 64 bit
Message-Id: <4237757.xIRJLSDgsa@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org

As this driver can now be compiled for ARM64, we get a new warning
as a result of passing a DMA filter data pointer through an 'int':

sound/soc/sh/fsi.c: In function 'fsi_dma_probe':
sound/soc/sh/fsi.c:1372:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     shdma_chan_filter, (void *)io->dma_id,

We already know that we only need the legacy filter function on
arch/sh, so we can hide the legacy DMA interface function
behind an #ifdef. This has the other advantage of no longer
depending on the shdma_chan_filter function to be visible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 0215c78cbddf..ead520182e26 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1362,15 +1362,18 @@ static int fsi_dma_push_start_stop(struct fsi_priv *fsi, struct fsi_stream *io,
 
 static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct device *dev)
 {
-	dma_cap_mask_t mask;
 	int is_play = fsi_stream_is_play(fsi, io);
 
+#ifdef CONFIG_SUPERH
+	dma_cap_mask_t mask;
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	io->chan = dma_request_slave_channel_compat(mask,
-				shdma_chan_filter, (void *)io->dma_id,
-				dev, is_play ? "tx" : "rx");
+	io->chan = dma_request_channel(mask, shdma_chan_filter,
+				       (void *)io->dma_id);
+#else
+	io->chan = dma_request_slave_channel(dev, is_play ? "tx" : "rx");
+#endif
 	if (io->chan) {
 		struct dma_slave_config cfg = {};
 		int ret;

