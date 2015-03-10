From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 10 Mar 2015 10:48:05 +0000
Subject: [PATCH] ASoC: rsnd: Use %pad to print dma_addr_t in rsnd_dmapp_init()
Message-Id: <1425984485-28421-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

sound/soc/sh/rcar/dma.c: In function 'rsnd_dmapp_init':
sound/soc/sh/rcar/dma.c:341:2: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
  dev_dbg(dev, "id/src/dst/chcr = %d/%x/%x/%08x\n",
  ^
sound/soc/sh/rcar/dma.c:341:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]

Fixes: 288f392e729dd4d3 ("ASoC: rsnd: add Audio DMAC peri peri support rework")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Perhaps this can still be folded in the original commit?

 sound/soc/sh/rcar/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 92fd55044ee6b494..2b73df84a76904dc 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -338,8 +338,8 @@ static int rsnd_dmapp_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 
 	rsnd_dmapp_stop(dma);
 
-	dev_dbg(dev, "id/src/dst/chcr = %d/%x/%x/%08x\n",
-		dmapp->dmapp_id, dma->src_addr, dma->dst_addr, dmapp->chcr);
+	dev_dbg(dev, "id/src/dst/chcr = %d/%pad/%pad/%08x\n",
+		dmapp->dmapp_id, &dma->src_addr, &dma->dst_addr, dmapp->chcr);
 
 	return 0;
 }
-- 
1.9.1

