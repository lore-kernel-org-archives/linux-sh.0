From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Oct 2013 10:51:31 +0000
Subject: [PATCH 2/3] rcar-hpbdma: initialise plane information when halted
Message-Id: <87hacg187k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Plane information should be initialized when halted.
It may restart from the wrong plane without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-hpbdma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index b1ae8dc..0518135 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -286,6 +286,9 @@ static void hpb_dmae_halt(struct shdma_chan *schan)
 
 	ch_reg_write(chan, HPB_DMAE_DCMDR_DQEND, HPB_DMAE_DCMDR);
 	ch_reg_write(chan, HPB_DMAE_DSTPR_DMSTP, HPB_DMAE_DSTPR);
+
+	chan->plane_idx = 0;
+	chan->first_desc = true;
 }
 
 static const struct hpb_dmae_slave_config *
-- 
1.7.9.5

