From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 19 Apr 2010 08:39:39 +0000
Subject: [PATCH] SH: fix error paths in DMA driver
Message-Id: <Pine.LNX.4.64.1004191035480.4080@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If channel allocation is failing, mark the channel unused and give PM a chance
to power down the hardware.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

2.6.34?

 drivers/dma/shdma.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index bbc3dfe..549bae9 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -288,6 +288,7 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
 	struct sh_desc *desc;
 	struct sh_dmae_slave *param = chan->private;
+	int ret;
 
 	pm_runtime_get_sync(sh_chan->dev);
 
@@ -299,11 +300,15 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 		struct sh_dmae_slave_config *cfg;
 
 		cfg = sh_dmae_find_slave(sh_chan, param);
-		if (!cfg)
-			return -EINVAL;
+		if (!cfg) {
+			ret = -EINVAL;
+			goto efindslave;
+		}
 
-		if (test_and_set_bit(param->slave_id, sh_dmae_slave_used))
-			return -EBUSY;
+		if (test_and_set_bit(param->slave_id, sh_dmae_slave_used)) {
+			ret = -EBUSY;
+			goto etestused;
+		}
 
 		param->config = cfg;
 
@@ -332,10 +337,20 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 	}
 	spin_unlock_bh(&sh_chan->desc_lock);
 
-	if (!sh_chan->descs_allocated)
-		pm_runtime_put(sh_chan->dev);
+	if (!sh_chan->descs_allocated) {
+		ret = -ENOMEM;
+		goto edescalloc;
+	}
 
 	return sh_chan->descs_allocated;
+
+edescalloc:
+	if (param)
+		clear_bit(param->slave_id, sh_dmae_slave_used);
+etestused:
+efindslave:
+	pm_runtime_put(sh_chan->dev);
+	return ret;
 }
 
 /*
-- 
1.6.2.4

