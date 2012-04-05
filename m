From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Apr 2012 09:07:15 +0000
Subject: [PATCH] ASoC: fsi:  Add missing argument to device_prep_slave_sg()
Message-Id: <1333616835-973-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

An extra paramter, context, was added to device_prep_slave_sg()
by "dmaengine: add context parameter to prep_slave_sg and prep_dma_cyclic".
This patch updates the FSI driver so that it compiles once again.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 sound/soc/sh/fsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 378cc5b..a2114e5 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1003,7 +1003,7 @@ static void fsi_dma_do_tasklet(unsigned long data)
 
 	desc = chan->device->device_prep_slave_sg(chan, &sg, 1, dir,
 						  DMA_PREP_INTERRUPT |
-						  DMA_CTRL_ACK);
+						  DMA_CTRL_ACK, NULL);
 	if (!desc) {
 		dev_err(dai->dev, "device_prep_slave_sg() fail\n");
 		return;
-- 
1.7.9.1

