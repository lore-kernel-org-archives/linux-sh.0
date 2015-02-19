From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:52:41 +0000
Subject: [PATCH 12/19] ASoC: rsnd: dma-names cares 1st DMAC only
Message-Id: <87egpm1rqf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
But, in result of DMA ML discussion, 2nd DMAC was concluded that it is
not a general purpose DMAC (2nd DMAC is for Device to Device inside
sound system). Additionally, current DMAEngine can't support Device to
Device, and we don't have correct DT bindings for it at this point.
So the easiest solution for it is that move it from DMAEngine to rsnd
driver.

dma-names on DT was implemented as no difference between 1st / 2nd
DMAC's, since rsnd had assumed that both DMACs are implemented as
DMAEngine. That style was "src_dst". But now, 2nd DMAC was implemented
as non DMAEngine, and it doesn't need dma-names anymore. So, this
dma-names rule is no longer needed.

In upstream code, no SoC/platform is supporting DMA for rsnd driver yet.
This means there is no compatible issue if this patch changes
dma-names's naming rule of DT.
This patch assumes dma-names are tx/rx base for 1st DMAC on DT.
ex)
	"mem_ssi0" -> "ssi0-rx"
	"ssi0_mem" -> "ssi0-tx"

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/dma.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 9cb5785..5b0c344 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -54,25 +54,28 @@ static void rsnd_dmaen_complete(void *data)
 
 #define DMA_NAME_SIZE 16
 #define MOD_MAX 4 /* MEM/SSI/SRC/DVC */
-static int _rsnd_dmaen_of_name(char *dma_name, struct rsnd_mod *mod)
-{
-	if (mod)
-		return snprintf(dma_name, DMA_NAME_SIZE / 2, "%s%d",
-				rsnd_mod_dma_name(mod), rsnd_mod_id(mod));
-	else
-		return snprintf(dma_name, DMA_NAME_SIZE / 2, "mem");
-
-}
 
 static void rsnd_dmaen_of_name(struct rsnd_mod *mod_from,
 			     struct rsnd_mod *mod_to,
 			     char *dma_name)
 {
-	int index = 0;
+	char *fmt;
+	struct rsnd_mod *mod;
+
+	if ((!mod_from && !mod_to) ||
+	    (mod_from && mod_to))
+		return;
+
+	if (mod_from) {
+		fmt = "%s%d-tx";
+		mod = mod_from;
+	} else {
+		fmt = "%s%d-rx";
+		mod = mod_to;
+	}
 
-	index = _rsnd_dmaen_of_name(dma_name + index, mod_from);
-	*(dma_name + index++) = '_';
-	index = _rsnd_dmaen_of_name(dma_name + index, mod_to);
+	snprintf(dma_name, DMA_NAME_SIZE, fmt,
+		 rsnd_mod_dma_name(mod), rsnd_mod_id(mod));
 }
 
 static void rsnd_dmaen_stop(struct rsnd_dma *dma)
-- 
1.7.9.5

