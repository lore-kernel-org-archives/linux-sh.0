From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:50:48 +0000
Subject: [PATCH 01/19] ASoC: rsnd: remove SH-DMA-BASE specific implementation
Message-Id: <87twyi1rtk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas R-Car sound had SH-DMA-BASE specific implementation before,
but, now, it is no longer needed. Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/core.c |    1 -
 sound/soc/sh/rcar/rsnd.h |    1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1b53605..0b14d37 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -94,7 +94,6 @@
  *
  */
 #include <linux/pm_runtime.h>
-#include <linux/shdma-base.h>
 #include "rsnd.h"
 
 #define RSND_RATES SNDRV_PCM_RATE_8000_96000
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index e7914bd..5ffde9b 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -171,7 +171,6 @@ u32 rsnd_get_adinr(struct rsnd_mod *mod);
  *	R-Car DMA
  */
 struct rsnd_dma {
-	struct sh_dmae_slave	slave;
 	struct dma_chan		*chan;
 	enum dma_transfer_direction dir;
 	dma_addr_t		addr;
-- 
1.7.9.5

