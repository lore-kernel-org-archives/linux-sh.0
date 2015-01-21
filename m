From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 04:13:33 +0000
Subject: [PATCH 1/8 v3] dmaengine: shdma: use normal interface for passing slave id
Message-Id: <87egqoojmm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

in dma_slave_config, which is incompatible with the way that the
dmaengine API normally works.

I've had a closer look at the existing code now and found that all
slave drivers that pass a slave_id in dma_slave_config for SH do that
right after passing the same ID into shdma_chan_filter, so we can just
rely on that. However, the various shdma drivers currently do not
remember the slave ID that was passed into the filter function when
used in non-DT mode and only check the value to find a matching channel,
unlike all other drivers.

There might still be drivers that are not part of the kernel that rely
on setting the slave_id to some other value, so to be on the safe side,
this adds another 'real_slave_id' field to shdma_chan that remembers
the ID and uses it when a driver passes a zero slave_id in dma_slave_config,
like most drivers do.

Eventually, the real_slave_id and slave_id fields should just get merged
into one field, but that requires other changes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/shdma-base.c |   73 +++++++++++++++++++++++++++++++------------
 include/linux/shdma-base.h  |    1 +
 2 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 8ee383d..10fcaba 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -171,8 +171,7 @@ static struct shdma_desc *shdma_get_desc(struct shdma_chan *schan)
 	return NULL;
 }
 
-static int shdma_setup_slave(struct shdma_chan *schan, int slave_id,
-			     dma_addr_t slave_addr)
+static int shdma_setup_slave(struct shdma_chan *schan, dma_addr_t slave_addr)
 {
 	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
 	const struct shdma_ops *ops = sdev->ops;
@@ -183,25 +182,23 @@ static int shdma_setup_slave(struct shdma_chan *schan, int slave_id,
 		ret = ops->set_slave(schan, match, slave_addr, true);
 		if (ret < 0)
 			return ret;
-
-		slave_id = schan->slave_id;
 	} else {
-		match = slave_id;
+		match = schan->real_slave_id;
 	}
 
-	if (slave_id < 0 || slave_id >= slave_num)
+	if (schan->real_slave_id < 0 || schan->real_slave_id >= slave_num)
 		return -EINVAL;
 
-	if (test_and_set_bit(slave_id, shdma_slave_used))
+	if (test_and_set_bit(schan->real_slave_id, shdma_slave_used))
 		return -EBUSY;
 
 	ret = ops->set_slave(schan, match, slave_addr, false);
 	if (ret < 0) {
-		clear_bit(slave_id, shdma_slave_used);
+		clear_bit(schan->real_slave_id, shdma_slave_used);
 		return ret;
 	}
 
-	schan->slave_id = slave_id;
+	schan->slave_id = schan->real_slave_id;
 
 	return 0;
 }
@@ -221,10 +218,12 @@ static int shdma_alloc_chan_resources(struct dma_chan *chan)
 	 */
 	if (slave) {
 		/* Legacy mode: .private is set in filter */
-		ret = shdma_setup_slave(schan, slave->slave_id, 0);
+		schan->real_slave_id = slave->slave_id;
+		ret = shdma_setup_slave(schan, 0);
 		if (ret < 0)
 			goto esetslave;
 	} else {
+		/* Normal mode: real_slave_id was set by filter */
 		schan->slave_id = -EINVAL;
 	}
 
@@ -258,11 +257,14 @@ esetslave:
 
 /*
  * This is the standard shdma filter function to be used as a replacement to the
- * "old" method, using the .private pointer. If for some reason you allocate a
- * channel without slave data, use something like ERR_PTR(-EINVAL) as a filter
+ * "old" method, using the .private pointer.
+ * You always have to pass a valid slave id as the argument, old drivers that
+ * pass ERR_PTR(-EINVAL) as a filter parameter and set it up in dma_slave_config
+ * need to be updated so we can remove the slave_id field from dma_slave_config.
  * parameter. If this filter is used, the slave driver, after calling
  * dma_request_channel(), will also have to call dmaengine_slave_config() with
- * .slave_id, .direction, and either .src_addr or .dst_addr set.
+ * .direction, and either .src_addr or .dst_addr set.
+ *
  * NOTE: this filter doesn't support multiple DMAC drivers with the DMA_SLAVE
  * capability! If this becomes a requirement, hardware glue drivers, using this
  * services would have to provide their own filters, which first would check
@@ -276,7 +278,7 @@ bool shdma_chan_filter(struct dma_chan *chan, void *arg)
 {
 	struct shdma_chan *schan;
 	struct shdma_dev *sdev;
-	int match = (long)arg;
+	int slave_id = (long)arg;
 	int ret;
 
 	/* Only support channels handled by this driver. */
@@ -284,19 +286,39 @@ bool shdma_chan_filter(struct dma_chan *chan, void *arg)
 	    shdma_alloc_chan_resources)
 		return false;
 
-	if (match < 0)
+	schan = to_shdma_chan(chan);
+	sdev = to_shdma_dev(chan->device);
+
+	/*
+	 * For DT, the schan->slave_id field is generated by the
+	 * set_slave function from the slave ID that is passed in
+	 * from xlate. For the non-DT case, the slave ID is
+	 * directly passed into the filter function by the driver
+	 */
+	if (schan->dev->of_node) {
+		ret = sdev->ops->set_slave(schan, slave_id, 0, true);
+		if (ret < 0)
+			return false;
+
+		schan->real_slave_id = schan->slave_id;
+		return true;
+	}
+
+	if (slave_id < 0) {
 		/* No slave requested - arbitrary channel */
+		dev_warn(sdev->dma_dev.dev, "invalid slave ID passed to dma_request_slave\n");
 		return true;
+	}
 
-	schan = to_shdma_chan(chan);
-	if (!schan->dev->of_node && match >= slave_num)
+	if (slave_id >= slave_num)
 		return false;
 
-	sdev = to_shdma_dev(schan->dma_chan.device);
-	ret = sdev->ops->set_slave(schan, match, 0, true);
+	ret = sdev->ops->set_slave(schan, slave_id, 0, true);
 	if (ret < 0)
 		return false;
 
+	schan->real_slave_id = slave_id;
+
 	return true;
 }
 EXPORT_SYMBOL(shdma_chan_filter);
@@ -452,6 +474,8 @@ static void shdma_free_chan_resources(struct dma_chan *chan)
 		chan->private = NULL;
 	}
 
+	schan->real_slave_id = 0;
+
 	spin_lock_irq(&schan->chan_lock);
 
 	list_splice_init(&schan->ld_free, &list);
@@ -764,11 +788,20 @@ static int shdma_config(struct dma_chan *chan,
 	 */
 	if (!config)
 		return -EINVAL;
+
+	/*
+	 * overriding the slave_id through dma_slave_config is deprecated,
+	 * but possibly some out-of-tree drivers still do it.
+	 */
+	if (WARN_ON_ONCE(config->slave_id &&
+			 config->slave_id != schan->real_slave_id))
+		schan->real_slave_id = config->slave_id;
+
 	/*
 	 * We could lock this, but you shouldn't be configuring the
 	 * channel, while using it...
 	 */
-	return shdma_setup_slave(schan, config->slave_id,
+	return shdma_setup_slave(schan,
 				 config->direction = DMA_DEV_TO_MEM ?
 				 config->src_addr : config->dst_addr);
 }
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index abdf1f2..dd0ba50 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -69,6 +69,7 @@ struct shdma_chan {
 	int id;				/* Raw id of this channel */
 	int irq;			/* Channel IRQ */
 	int slave_id;			/* Client ID for slave DMA */
+	int real_slave_id;		/* argument passed to filter function */
 	int hw_req;			/* DMA request line for slave DMA - same
 					 * as MID/RID, used with DT */
 	enum shdma_pm_state pm_state;
-- 
1.7.9.5

