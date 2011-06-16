From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 Jun 2011 05:08:28 +0000
Subject: [PATCH 3/3 v2] dmaengine: shdma: fixup parameter definition on
Message-Id: <w3p8vt2ics3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

chan_pdata->dmars_bit is unsigned int

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/shdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 3d22eb8..41a21b3 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -211,7 +211,7 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	const struct sh_dmae_channel *chan_pdata = &pdata->channel[sh_chan->id];
 	u16 __iomem *addr = shdev->dmars;
-	int shift = chan_pdata->dmars_bit;
+	unsigned int shift = chan_pdata->dmars_bit;
 
 	if (dmae_is_busy(sh_chan))
 		return -EBUSY;
-- 
1.7.4.1

