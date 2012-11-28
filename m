From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 28 Nov 2012 06:49:47 +0000
Subject: [PATCH 3.7] dma: sh: Don't use ENODEV for failing slave lookup
Message-Id: <Pine.LNX.4.64.1211280740190.32652@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "Koul, Vinod" <vinod.koul@intel.com>

If dmaengine driver's .device_alloc_chan_resources() method returns -ENODEV,
dma_request_channel() will decide, that the driver has been removed and will
remove the device from its list. To prevent this use ENXIO if a slave lookup
fails.

Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Hi Vinod

Could you please push this patch to Linus for 3.7 ASAP? I think, it should 
also go to "stable."

Thanks
Guennadi

 drivers/dma/sh/shdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index f41bcc5..910d878 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -326,7 +326,7 @@ static int sh_dmae_set_slave(struct shdma_chan *schan,
 						    shdma_chan);
 	const struct sh_dmae_slave_config *cfg = dmae_find_slave(sh_chan, slave_id);
 	if (!cfg)
-		return -ENODEV;
+		return -ENXIO;
 
 	if (!try)
 		sh_chan->config = cfg;
-- 
1.7.2.5

