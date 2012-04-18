From: kuninori.morimoto.gx@renesas.com
Date: Wed, 18 Apr 2012 02:13:04 +0000
Subject: [PATCH forward] ASoC: fsi: update for dmaengine prep_slave_sg fallout.
Message-Id: <87r4vl4wk2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120330082058.GE26543@linux-sh.org>
	<8762dj9fa4.wl%kuninori.morimoto.gx@renesas.com>
	<87sjg45h50.wl%kuninori.morimoto.gx@renesas.com>
	<20120416082702.GC3238@opensource.wolfsonmicro.com>
	<20120416121044.GD7368@linux-sh.org>
	<20120416121724.GA3219@opensource.wolfsonmicro.com>
In-Reply-To: <20120416121724.GA3219@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-sh@vger.kernel.org


From: Paul Mundt <lethal@linux-sh.org>

Leading up to the ->device_prep_slave_sg change in
185ecb5f4fd43911c35956d4cc7d94a1da30417f 'dmaengine: add context
parameter to prep_slave_sg and prep_dma_cyclic' a generic wrapper was
added in place to guard against the API change, though the fsi driver
wasn't updated in the process (presumably its dmaengine support hadn't
been merged yet at the time). This trivially switches over to the new
wrapper and gets it building again.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Nothing happened on ALSA ML.
So I forward this patch.
I added my Acked-by on it.

 sound/soc/sh/fsi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 378cc5b..74ed2df 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1001,11 +1001,10 @@ static void fsi_dma_do_tasklet(unsigned long data)
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
-	desc = chan->device->device_prep_slave_sg(chan, &sg, 1, dir,
-						  DMA_PREP_INTERRUPT |
-						  DMA_CTRL_ACK);
+	desc = dmaengine_prep_slave_sg(chan, &sg, 1, dir,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-		dev_err(dai->dev, "device_prep_slave_sg() fail\n");
+		dev_err(dai->dev, "dmaengine_prep_slave_sg() fail\n");
 		return;
 	}
 
