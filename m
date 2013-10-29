From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 29 Oct 2013 06:52:21 +0000
Subject: [PATCH 2/3] rcar-hpbdma: initialise plane information when halted
Message-Id: <87bo287en9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
	<87eh747eoj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eh747eoj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Simon <horms@verge.net.au>, Max Filippov <max.filippov@cogentembedded.com>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-kernel@vger.kernel.org

Plane information should be initialized when halted.
It may restart from the wrong plane without this patch.

Reviewed-by: Max Filippov <max.filippov@cogentembedded.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-hpbdma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index 496180a..19af32d 100644
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

