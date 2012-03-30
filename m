From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 30 Mar 2012 08:20:58 +0000
Subject: [PATCH] ASoC: fsi: update for dmaengine prep_slave_sg fallout.
Message-Id: <20120330082058.GE26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Leading up to the ->device_prep_slave_sg change in
185ecb5f4fd43911c35956d4cc7d94a1da30417f 'dmaengine: add context
parameter to prep_slave_sg and prep_dma_cyclic' a generic wrapper was
added in place to guard against the API change, though the fsi driver
wasn't updated in the process (presumably its dmaengine support hadn't
been merged yet at the time). This trivially switches over to the new
wrapper and gets it building again.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

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
 
