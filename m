From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 16:14:09 +0000
Subject: [PATCH 2/8] shdma: fdt: allocate and use local hwid bitmap for shdma mux
Message-Id: <1401898455-31064-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move the shdma-of.c code to allocating and using a slave bitmap for
tracking allocation of the slave channels used by the mid-rid stored
in the phandle for the mux.

This means that we can have multiple shdma muxes in the system without
any issue of slave-ids clashing and all the child dma units will be
able to properly protect against the re-use of a mid/rid pair.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/dma/sh/shdma-base.c |  2 ++
 drivers/dma/sh/shdma-of.c   | 16 ++++++++++++++++
 include/linux/shdma-base.h  |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 5b18c88..861e1f5 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -986,6 +986,8 @@ int shdma_init(struct device *dev, struct shdma_dev *sdev,
 	dma_dev->dev = dev;
 	sdev->slave_used = shdma_global_slave_used;
 
+	shdma_of_setup(dev, sdev);
+
 	return 0;
 }
 EXPORT_SYMBOL(shdma_init);
diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index b4ff9d3..894c48e 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -17,6 +17,10 @@
 #include <linux/platform_device.h>
 #include <linux/shdma-base.h>
 
+struct shdma_of_state {
+	unsigned long	slave_used[256 / sizeof(unsigned long)];
+};
+
 #define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
 
 static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
@@ -41,11 +45,23 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
+void shdma_of_setup(struct device *dev, struct shdma_dev *shdev)
+{
+	struct shdma_of_state *ofs = dev_get_platdata(dev->parent);
+
+	shdev->slave_used = ofs->slave_used;
+}
+
 static int shdma_of_probe(struct platform_device *pdev)
 {
 	const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
+	struct shdma_of_state *ofs;
 	int ret;
 
+	ofs = devm_kzalloc(&pdev->dev, sizeof(*ofs), GFP_KERNEL);
+	if (!ofs)
+		return -ENOMEM;
+
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 shdma_of_xlate, pdev);
 	if (ret < 0)
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index 6966593..0a3e422 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -131,4 +131,10 @@ bool shdma_chan_filter(struct dma_chan *chan, void *arg);
 #define shdma_chan_filter NULL
 #endif
 
+#ifdef CONFIG_OF
+extern void shdma_of_setup(struct device *dev, struct shdma_dev *sdev);
+#else
+static inline void shdma_of_setup(struct device *dev, struct shdma_dev *sdev) { }
+#endif
+
 #endif
-- 
2.0.0.rc2

