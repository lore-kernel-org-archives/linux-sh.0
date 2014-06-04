From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 16:14:08 +0000
Subject: [PATCH 1/8] shdma: fdt: allow moving of the shdma_slave_used fields
Message-Id: <1401898455-31064-2-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The shdma_slave_used is used to track the DMA hardware channels that are
claimed by clients. This works when the system has a global number space
as used by the platform clients, however when we are using fdt possible
space is much bigger (if we used phandle+hwid).

It is much easier for the OF case to change to using the hwid of the
channel and make the allocation bitmap part of the mux device that holds
all the dma controllers that can access the set of hwids that need
protecting. So change the code to make it that each sdev points to an
bitmap that can be allocated via the shdma-of.c when needed.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/dma/sh/shdma-base.c | 17 +++++++++--------
 include/linux/shdma-base.h  |  1 +
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index b35007e..5b18c88 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -49,7 +49,7 @@ static unsigned int slave_num = 256;
 module_param(slave_num, uint, 0444);
 
 /* A bitmask with slave_num bits */
-static unsigned long *shdma_slave_used;
+static unsigned long *shdma_global_slave_used;
 
 /* Called under spin_lock_irq(&schan->chan_lock") */
 static void shdma_chan_xfer_ld_queue(struct shdma_chan *schan)
@@ -192,12 +192,12 @@ static int shdma_setup_slave(struct shdma_chan *schan, int slave_id,
 	if (slave_id < 0 || slave_id >= slave_num)
 		return -EINVAL;
 
-	if (test_and_set_bit(slave_id, shdma_slave_used))
+	if (test_and_set_bit(slave_id, sdev->slave_used))
 		return -EBUSY;
 
 	ret = ops->set_slave(schan, match, slave_addr, false);
 	if (ret < 0) {
-		clear_bit(slave_id, shdma_slave_used);
+		clear_bit(slave_id, sdev->slave_used);
 		return ret;
 	}
 
@@ -290,7 +290,7 @@ static int shdma_alloc_chan_resources(struct dma_chan *chan)
 edescalloc:
 	if (slave)
 esetslave:
-		clear_bit(slave->slave_id, shdma_slave_used);
+		clear_bit(slave->slave_id, sdev->slave_used);
 	chan->private = NULL;
 	return ret;
 }
@@ -440,7 +440,7 @@ static void shdma_free_chan_resources(struct dma_chan *chan)
 
 	if (schan->slave_id >= 0) {
 		/* The caller is holding dma_list_mutex */
-		clear_bit(schan->slave_id, shdma_slave_used);
+		clear_bit(schan->slave_id, sdev->slave_used);
 		chan->private = NULL;
 	}
 
@@ -984,6 +984,7 @@ int shdma_init(struct device *dev, struct shdma_dev *sdev,
 	dma_dev->device_control = shdma_control;
 
 	dma_dev->dev = dev;
+	sdev->slave_used = shdma_global_slave_used;
 
 	return 0;
 }
@@ -997,9 +998,9 @@ EXPORT_SYMBOL(shdma_cleanup);
 
 static int __init shdma_enter(void)
 {
-	shdma_slave_used = kzalloc(DIV_ROUND_UP(slave_num, BITS_PER_LONG) *
+	shdma_global_slave_used = kzalloc(DIV_ROUND_UP(slave_num, BITS_PER_LONG) *
 				    sizeof(long), GFP_KERNEL);
-	if (!shdma_slave_used)
+	if (!shdma_global_slave_used)
 		return -ENOMEM;
 	return 0;
 }
@@ -1007,7 +1008,7 @@ module_init(shdma_enter);
 
 static void __exit shdma_exit(void)
 {
-	kfree(shdma_slave_used);
+	kfree(shdma_global_slave_used);
 }
 module_exit(shdma_exit);
 
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index abdf1f2..6966593 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -106,6 +106,7 @@ struct shdma_ops {
 };
 
 struct shdma_dev {
+	unsigned long *slave_used;	/* bitmap of slave ids used */
 	struct dma_device dma_dev;
 	struct shdma_chan **schan;
 	const struct shdma_ops *ops;
-- 
2.0.0.rc2

