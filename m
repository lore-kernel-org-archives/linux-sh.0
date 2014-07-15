From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 15 Jul 2014 20:18:37 +0000
Subject: [PATCH 2/7] dmaengine: shdma: Make channel filter ignore unrelated devices
Message-Id: <1405455522-20676-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The shdma_chan_filter() function relies on the DMA channel being
embedded in an shdma_chan structure. If this assumption isn't true, for
instance when the system contains DMA channels supported by an unrelated
driver, the function will crash.

Avoid this by returning false directly when the channel belongs to an
unrelated device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/shdma-base.c | 84 ++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index b35007e..94b6bde 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -206,45 +206,6 @@ static int shdma_setup_slave(struct shdma_chan *schan, int slave_id,
 	return 0;
 }
 
-/*
- * This is the standard shdma filter function to be used as a replacement to the
- * "old" method, using the .private pointer. If for some reason you allocate a
- * channel without slave data, use something like ERR_PTR(-EINVAL) as a filter
- * parameter. If this filter is used, the slave driver, after calling
- * dma_request_channel(), will also have to call dmaengine_slave_config() with
- * .slave_id, .direction, and either .src_addr or .dst_addr set.
- * NOTE: this filter doesn't support multiple DMAC drivers with the DMA_SLAVE
- * capability! If this becomes a requirement, hardware glue drivers, using this
- * services would have to provide their own filters, which first would check
- * the device driver, similar to how other DMAC drivers, e.g., sa11x0-dma.c, do
- * this, and only then, in case of a match, call this common filter.
- * NOTE 2: This filter function is also used in the DT case by shdma_of_xlate().
- * In that case the MID-RID value is used for slave channel filtering and is
- * passed to this function in the "arg" parameter.
- */
-bool shdma_chan_filter(struct dma_chan *chan, void *arg)
-{
-	struct shdma_chan *schan = to_shdma_chan(chan);
-	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
-	const struct shdma_ops *ops = sdev->ops;
-	int match = (long)arg;
-	int ret;
-
-	if (match < 0)
-		/* No slave requested - arbitrary channel */
-		return true;
-
-	if (!schan->dev->of_node && match >= slave_num)
-		return false;
-
-	ret = ops->set_slave(schan, match, 0, true);
-	if (ret < 0)
-		return false;
-
-	return true;
-}
-EXPORT_SYMBOL(shdma_chan_filter);
-
 static int shdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct shdma_chan *schan = to_shdma_chan(chan);
@@ -295,6 +256,51 @@ esetslave:
 	return ret;
 }
 
+/*
+ * This is the standard shdma filter function to be used as a replacement to the
+ * "old" method, using the .private pointer. If for some reason you allocate a
+ * channel without slave data, use something like ERR_PTR(-EINVAL) as a filter
+ * parameter. If this filter is used, the slave driver, after calling
+ * dma_request_channel(), will also have to call dmaengine_slave_config() with
+ * .slave_id, .direction, and either .src_addr or .dst_addr set.
+ * NOTE: this filter doesn't support multiple DMAC drivers with the DMA_SLAVE
+ * capability! If this becomes a requirement, hardware glue drivers, using this
+ * services would have to provide their own filters, which first would check
+ * the device driver, similar to how other DMAC drivers, e.g., sa11x0-dma.c, do
+ * this, and only then, in case of a match, call this common filter.
+ * NOTE 2: This filter function is also used in the DT case by shdma_of_xlate().
+ * In that case the MID-RID value is used for slave channel filtering and is
+ * passed to this function in the "arg" parameter.
+ */
+bool shdma_chan_filter(struct dma_chan *chan, void *arg)
+{
+	struct shdma_chan *schan;
+	struct shdma_dev *sdev;
+	int match = (long)arg;
+	int ret;
+
+	/* Only support channels handled by this driver. */
+	if (chan->device->device_alloc_chan_resources !+	    shdma_alloc_chan_resources)
+		return false;
+
+	if (match < 0)
+		/* No slave requested - arbitrary channel */
+		return true;
+
+	schan = to_shdma_chan(chan);
+	if (!schan->dev->of_node && match >= slave_num)
+		return false;
+
+	sdev = to_shdma_dev(schan->dma_chan.device);
+	ret = sdev->ops->set_slave(schan, match, 0, true);
+	if (ret < 0)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(shdma_chan_filter);
+
 static dma_async_tx_callback __ld_cleanup(struct shdma_chan *schan, bool all)
 {
 	struct shdma_desc *desc, *_desc;
-- 
1.8.5.5

