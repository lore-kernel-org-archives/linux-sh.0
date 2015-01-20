From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Jan 2015 13:02:39 +0000
Subject: Re: [PATCH 7/8 v2] ASoC: fsi: remove slave_id settings for DMAEngine
Message-Id: <4060965.ckzs3UAxrx@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <87bnluaxtt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnluaxtt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday 20 January 2015 04:18:17 Kuninori Morimoto wrote:
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 8869971..c4eb234 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1374,10 +1374,9 @@ static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct dev
>                                 shdma_chan_filter, (void *)io->dma_id,
>                                 dev, is_play ? "tx" : "rx");
>         if (io->chan) {
> -               struct dma_slave_config cfg;
> +               struct dma_slave_config cfg = {};
>                 int ret;
>  
> -               cfg.slave_id    = io->dma_id;
>                 cfg.dst_addr    = 0; /* use default addr */
>                 cfg.src_addr    = 0; /* use default addr */
>                 cfg.direction   = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;

As the dma_slave_config structure is now initialized to all-zeroes, the
two address assignments are not strictly required any more.

However, I also suspect that that particular initialization to zero
is also incorrect: When booting with DT, the dst_addr/src_addr fields
are no longer passed in the platform data for the DMA engine but
are expected to be set by the slave driver.

Also set the correct address width, which has the same problem.

	Arnd

8<---
ASoC: fsi: use correct FIFO address for DMA

Passing the FIFO address using platform data is deprecated and does
not work with devicetree due to the lack of that platform data, so
the fsi driver should instead fill the correct address itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index b87b22e88e43..9d5f1f7d0b8c 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -250,6 +250,7 @@ struct fsi_clk {
 
 struct fsi_priv {
 	void __iomem *base;
+	resource_size_t phys;
 	struct fsi_master *master;
 
 	struct fsi_stream playback;
@@ -294,6 +295,7 @@ struct fsi_core {
 
 struct fsi_master {
 	void __iomem *base;
+	resource_size_t phys;
 	struct fsi_priv fsia;
 	struct fsi_priv fsib;
 	const struct fsi_core *core;
@@ -1375,8 +1377,10 @@ static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct dev
 		int ret;
 
 		cfg.slave_id	= io->dma_id;
-		cfg.dst_addr	= 0; /* use default addr */
-		cfg.src_addr	= 0; /* use default addr */
+		cfg.dst_addr	= is_play ? fsi->phys + REG_DODT : 0;
+		cfg.src_addr	= is_play ? 0 : fsi->phys + REG_DIDT;
+		cfg.dst_addr_width = is_play ? DMA_SLAVE_BUSWIDTH_4_BYTES : 0;
+		cfg.src_addr_width = is_play ? 0 : DMA_SLAVE_BUSWIDTH_4_BYTES;
 		cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
 		ret = dmaengine_slave_config(io->chan, &cfg);
@@ -1929,6 +1931,7 @@ static int fsi_probe(struct platform_device *pdev)
 
 	master->base = devm_ioremap_nocache(&pdev->dev,
 					    res->start, resource_size(res));
+	master->phys = res->start;
 	if (!master->base) {
 		dev_err(&pdev->dev, "Unable to ioremap FSI registers.\n");
 		return -ENXIO;
@@ -1941,6 +1944,7 @@ static int fsi_probe(struct platform_device *pdev)
 	/* FSI A setting */
 	fsi		= &master->fsia;
 	fsi->base	= master->base;
+	fsi->phys	= master->phys;
 	fsi->master	= master;
 	fsi_port_info_init(fsi, &info.port_a);
 	fsi_handler_init(fsi, &info.port_a);
@@ -1953,6 +1957,7 @@ static int fsi_probe(struct platform_device *pdev)
 	/* FSI B setting */
 	fsi		= &master->fsib;
 	fsi->base	= master->base + 0x40;
+	fsi->phys	= master->phys + 0x40;
 	fsi->master	= master;
 	fsi_port_info_init(fsi, &info.port_b);
 	fsi_handler_init(fsi, &info.port_b);

