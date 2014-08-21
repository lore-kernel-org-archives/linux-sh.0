From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 21 Aug 2014 00:53:03 +0000
Subject: [PATCH] dma: rcar-audmapp: Fix for no corresponding slave ID
Message-Id: <87d2buk6j7.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

In case of no corresponding slave ID, the audmapp_set_slave() returns
-ENXIO same as sh_dmae_set_slave() of shdmac.c.
DMAEngine might return wrong channel without this patch

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Jun Watanabe <jun.watanabe.ue@renesas.com>,
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-audmapp.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rcar-audmapp.c b/drivers/dma/sh/rcar-audmapp.c
index dabbf0a..80fd2ae 100644
--- a/drivers/dma/sh/rcar-audmapp.c
+++ b/drivers/dma/sh/rcar-audmapp.c
@@ -117,7 +117,7 @@ static void audmapp_start_xfer(struct shdma_chan *schan,
 	audmapp_write(auchan, chcr,	PDMACHCR);
 }
 
-static void audmapp_get_config(struct audmapp_chan *auchan, int slave_id,
+static int audmapp_get_config(struct audmapp_chan *auchan, int slave_id,
 			      u32 *chcr, dma_addr_t *dst)
 {
 	struct audmapp_device *audev = to_dev(auchan);
@@ -131,20 +131,22 @@ static void audmapp_get_config(struct audmapp_chan *auchan, int slave_id,
 	if (!pdata) { /* DT */
 		*chcr = ((u32)slave_id) << 16;
 		auchan->shdma_chan.slave_id = (slave_id) >> 8;
-		return;
+		return 0;
 	}
 
 	/* non-DT */
 
 	if (slave_id >= AUDMAPP_SLAVE_NUMBER)
-		return;
+		return -ENXIO;
 
 	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
 		if (cfg->slave_id = slave_id) {
 			*chcr	= cfg->chcr;
 			*dst	= cfg->dst;
-			break;
+			return 0;
 		}
+
+	return -ENXIO;
 }
 
 static int audmapp_set_slave(struct shdma_chan *schan, int slave_id,
@@ -153,8 +155,11 @@ static int audmapp_set_slave(struct shdma_chan *schan, int slave_id,
 	struct audmapp_chan *auchan = to_chan(schan);
 	u32 chcr;
 	dma_addr_t dst;
+	int ret;
 
-	audmapp_get_config(auchan, slave_id, &chcr, &dst);
+	ret = audmapp_get_config(auchan, slave_id, &chcr, &dst);
+	if (ret < 0)
+		return ret;
 
 	if (try)
 		return 0;
-- 
1.7.9.5

