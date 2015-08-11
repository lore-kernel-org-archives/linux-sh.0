From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 11 Aug 2015 12:47:18 +0000
Subject: [PATCH] ASoC: rsnd: Silence DMA slave ID compile warning on 64-bit
Message-Id: <1439297238-28943-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On arm64:

    sound/soc/sh/rcar/dma.c: In function 'rsnd_dmaen_init':
    sound/soc/sh/rcar/dma.c:180:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
	     (void *)id);
	     ^
    include/linux/dmaengine.h:1185:75: note: in definition of macro 'dma_request_channel'
     #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
									       ^

Add an intermediate cast to "uintptr_t" to kill the compile warning.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/sh/rcar/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 305b129298538850..bfbb8a5e93bdce6c 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -177,7 +177,7 @@ static int rsnd_dmaen_init(struct rsnd_dai_stream *io,
 		dma_cap_set(DMA_SLAVE, mask);
 
 		dmaen->chan = dma_request_channel(mask, shdma_chan_filter,
-						  (void *)id);
+						  (void *)(uintptr_t)id);
 	}
 	if (IS_ERR_OR_NULL(dmaen->chan)) {
 		dmaen->chan = NULL;
-- 
1.9.1

