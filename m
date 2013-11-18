From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Nov 2013 02:45:16 +0000
Subject: [PATCH] ASoC: rcar: fixup dma_async_issue_pending() timing
Message-Id: <87k3g677if.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

DMAEngine will stall without this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 78c35b4..f57e519 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -200,9 +200,8 @@ static void rsnd_dma_do_work(struct work_struct *work)
 			return;
 		}
 
+		dma_async_issue_pending(dma->chan);
 	}
-
-	dma_async_issue_pending(dma->chan);
 }
 
 int rsnd_dma_available(struct rsnd_dma *dma)
-- 
1.7.9.5

