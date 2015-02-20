From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:22:11 +0000
Subject: [PATCH 01/24 v2] dmaengine: export symbol of of_dma_request_slave_channel()
Message-Id: <87egpkop98.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current DMAEngine implementation of DT bindings can't support
DT subnode. This patch export symbols of of_dma_request_slave_channel()
for subnode DMA DT bingings.

ex)

rcar_sound: rcar_sound@ec500000 {
	...
	rcar_sound,dvc {
		dvc0: dvc@0 {
			dmas = <&audma0 0xbc>;
			dma-names = "tx";
		};
		dvc1: dvc@1 {
			dmas = <&audma0 0xbe>;
			dma-names = "tx";
		};
	};
	...
};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - new patch

 drivers/dma/of-dma.c   |    1 +
 include/linux/of_dma.h |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index ca31f1b..cbd4a8a 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -194,6 +194,7 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 
 	return ERR_PTR(ret_no_channel);
 }
+EXPORT_SYMBOL_GPL(of_dma_request_slave_channel);
 
 /**
  * of_dma_simple_xlate - Simple DMA engine translation function
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index 56bc026..687a0ac 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -37,8 +37,8 @@ extern int of_dma_controller_register(struct device_node *np,
 		(struct of_phandle_args *, struct of_dma *),
 		void *data);
 extern void of_dma_controller_free(struct device_node *np);
-extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
-						     const char *name);
+struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
+					      const char *name);
 extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 		struct of_dma *ofdma);
 extern struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,
-- 
1.7.9.5

