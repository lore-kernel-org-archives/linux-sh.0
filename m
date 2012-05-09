From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 09 May 2012 15:09:20 +0000
Subject: [PATCH 8/9 v3] ASoC: fsi: prepare for conversion to the shdma base library
Message-Id: <1336576161-27082-9-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1336576161-27082-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336576161-27082-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/sh/fsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 74ed2df..c28314b 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1532,8 +1532,8 @@ static void fsi_handler_init(struct fsi_priv *fsi)
 	fsi->capture.priv	= fsi;
 
 	if (fsi->info->tx_id) {
-		fsi->playback.slave.slave_id	= fsi->info->tx_id;
-		fsi->playback.handler		= &fsi_dma_push_handler;
+		fsi->playback.slave.shdma_slave.slave_id = fsi->info->tx_id;
+		fsi->playback.handler = &fsi_dma_push_handler;
 	}
 }
 
-- 
1.7.2.5

