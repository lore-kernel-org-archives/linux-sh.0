From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:47:25 +0000
Subject: [PATCH v2 3/3] DMA: shdma: add DT support
Message-Id: <1370533645-23690-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This patch adds Device Tree support to the shdma driver. No special DT
properties are used, only standard DMA DT bindings are implemented. Since
shdma controllers reside on SoCs, their configuration is SoC-specific and
shall be passed to the driver from the SoC platform data, using the
auxdata procedure.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: merge DT binding documentation into the patch

 Documentation/devicetree/bindings/dma/shdma.txt |   61 +++++++++++++++++++++++
 drivers/dma/sh/shdma-base.c                     |   51 +++++++++++++++++--
 drivers/dma/sh/shdma.c                          |   44 ++++++++++++++--
 include/linux/shdma-base.h                      |    5 ++
 4 files changed, 149 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/shdma.txt

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
new file mode 100644
index 0000000..f99618e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/shdma.txt
@@ -0,0 +1,61 @@
+* SHDMA Device Tree bindings
+
+Only generic DMA controller bindings are used for SHDMA DT nodes.
+
+* DMA controller
+
+Required properties:
+- compatible:	should be "renesas,shdma"
+- #dma-cells:	should be <1>, see "dmas" property below
+
+Optional properties (currently unused):
+- dma-channels:	number of DMA channels
+- dma-requests:	number of DMA request signals
+
+Example:
+	dma0: shdma@fe000020 {
+		compatible = "renesas,shdma";
+		reg = <0xfe000020 0x89e0>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 129 4
+				0 109 4
+				0 110 4
+				0 111 4
+				0 112 4
+				0 113 4
+				0 114 4
+				0 115 4
+				0 116 4
+				0 117 4
+				0 118 4
+				0 119 4
+				0 120 4
+				0 121 4
+				0 122 4
+				0 123 4
+				0 124 4
+				0 125 4
+				0 126 4
+				0 127 4
+				0 128 4>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14", "ch15",
+				"ch16", "ch17", "ch18", "ch19";
+		#dma-cells = <1>;
+		dma-channels = <20>;
+		dma-requests = <256>;
+	};
+
+* DMA client
+
+Required properties:
+- dmas:		a list of <[DMA controller phandle] [MID/RID value]> pairs
+- dma-names:	a list of DMA channel names, one per "dmas" entry
+
+Example:
+	dmas = <&dma0 0xd1
+		&dma0 0xd2>;
+	dma-names = "tx", "rx";
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 4acb85a..4fd8293 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -14,6 +14,8 @@
  */
 
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/shdma-base.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
@@ -175,7 +177,18 @@ static int shdma_setup_slave(struct shdma_chan *schan, int slave_id)
 {
 	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
 	const struct shdma_ops *ops = sdev->ops;
-	int ret;
+	int ret, match;
+
+	if (schan->dev->of_node) {
+		match = schan->hw_req;
+		ret = ops->set_slave(schan, match, true);
+		if (ret < 0)
+			return ret;
+
+		slave_id = schan->slave_id;
+	} else {
+		match = slave_id;
+	}
 
 	if (slave_id < 0 || slave_id >= slave_num)
 		return -EINVAL;
@@ -183,7 +196,7 @@ static int shdma_setup_slave(struct shdma_chan *schan, int slave_id)
 	if (test_and_set_bit(slave_id, shdma_slave_used))
 		return -EBUSY;
 
-	ret = ops->set_slave(schan, slave_id, false);
+	ret = ops->set_slave(schan, match, false);
 	if (ret < 0) {
 		clear_bit(slave_id, shdma_slave_used);
 		return ret;
@@ -206,23 +219,26 @@ static int shdma_setup_slave(struct shdma_chan *schan, int slave_id)
  * services would have to provide their own filters, which first would check
  * the device driver, similar to how other DMAC drivers, e.g., sa11x0-dma.c, do
  * this, and only then, in case of a match, call this common filter.
+ * NOTE 2: This filter function is also used in the DT case by shdma_xlate().
+ * In that case the MID-RID value is used for slave channel filtering and is
+ * passed to this function in the "arg" parameter.
  */
 bool shdma_chan_filter(struct dma_chan *chan, void *arg)
 {
 	struct shdma_chan *schan = to_shdma_chan(chan);
 	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
 	const struct shdma_ops *ops = sdev->ops;
-	int slave_id = (int)arg;
+	int match = (int)arg;
 	int ret;
 
-	if (slave_id < 0)
+	if (match < 0)
 		/* No slave requested - arbitrary channel */
 		return true;
 
-	if (slave_id >= slave_num)
+	if (!schan->dev->of_node && match >= slave_num)
 		return false;
 
-	ret = ops->set_slave(schan, slave_id, true);
+	ret = ops->set_slave(schan, match, true);
 	if (ret < 0)
 		return false;
 
@@ -867,6 +883,29 @@ void shdma_chan_remove(struct shdma_chan *schan)
 }
 EXPORT_SYMBOL(shdma_chan_remove);
 
+struct dma_chan *shdma_xlate(struct of_phandle_args *dma_spec,
+				 struct of_dma *ofdma)
+{
+	struct shdma_dev *sdev = ofdma->of_dma_data;
+	u32 id = dma_spec->args[0];
+	dma_cap_mask_t mask;
+	struct dma_chan *chan;
+
+	if (dma_spec->args_count != 1 || !sdev)
+		return NULL;
+
+	dma_cap_zero(mask);
+	/* Only slave DMA channels can be allocated via DT */
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_channel(mask, shdma_chan_filter, (void *)id);
+	if (chan)
+		to_shdma_chan(chan)->hw_req = id;
+
+	return chan;
+}
+EXPORT_SYMBOL(shdma_xlate);
+
 int shdma_init(struct device *dev, struct shdma_dev *sdev,
 		    int chan_num)
 {
diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index a5a1887..db497d6 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -20,6 +20,8 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
@@ -301,20 +303,32 @@ static void sh_dmae_setup_xfer(struct shdma_chan *schan,
 	}
 }
 
+/*
+ * Find a slave channel configuration from the contoller list by either a slave
+ * ID in the non-DT case, or by a MID/RID value in the DT case
+ */
 static const struct sh_dmae_slave_config *dmae_find_slave(
-	struct sh_dmae_chan *sh_chan, int slave_id)
+	struct sh_dmae_chan *sh_chan, int match)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	const struct sh_dmae_slave_config *cfg;
 	int i;
 
-	if (slave_id >= SH_DMA_SLAVE_NUMBER)
-		return NULL;
+	if (!sh_chan->shdma_chan.dev->of_node) {
+		if (match >= SH_DMA_SLAVE_NUMBER)
+			return NULL;
 
-	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
-		if (cfg->slave_id = slave_id)
-			return cfg;
+		for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
+			if (cfg->slave_id = match)
+				return cfg;
+	} else {
+		for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
+			if (cfg->mid_rid = match) {
+				sh_chan->shdma_chan.slave_id = cfg->slave_id;
+				return cfg;
+			}
+	}
 
 	return NULL;
 }
@@ -841,6 +855,14 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto edmadevreg;
 
+	if (pdev->dev.of_node) {
+		int of_err = of_dma_controller_register(pdev->dev.of_node,
+							shdma_xlate, shdev);
+		if (of_err < 0 && of_err != -ENODEV)
+			dev_err(&pdev->dev,
+				"could not register of_dma_controller\n");
+	}
+
 	return err;
 
 edmadevreg:
@@ -889,6 +911,9 @@ static int sh_dmae_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(dma_dev);
 
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
+
 	if (errirq > 0)
 		free_irq(errirq, shdev);
 
@@ -920,11 +945,18 @@ static int sh_dmae_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id sh_dmae_of_match[] = {
+	{ .compatible = "renesas,shdma", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
+
 static struct platform_driver sh_dmae_driver = {
 	.driver 	= {
 		.owner	= THIS_MODULE,
 		.pm	= &sh_dmae_pm,
 		.name	= SH_DMAE_DRV_NAME,
+		.of_match_table = sh_dmae_of_match,
 	},
 	.remove		= sh_dmae_remove,
 	.shutdown	= sh_dmae_shutdown,
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index 9a93897..0815a0e 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -19,6 +19,7 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/of_dma.h>
 #include <linux/types.h>
 
 /**
@@ -68,6 +69,8 @@ struct shdma_chan {
 	int id;				/* Raw id of this channel */
 	int irq;			/* Channel IRQ */
 	int slave_id;			/* Client ID for slave DMA */
+	int hw_req;			/* DMA request line for slave DMA - same
+					 * as MID/RID, used with DT */
 	enum shdma_pm_state pm_state;
 };
 
@@ -123,5 +126,7 @@ int shdma_init(struct device *dev, struct shdma_dev *sdev,
 		    int chan_num);
 void shdma_cleanup(struct shdma_dev *sdev);
 bool shdma_chan_filter(struct dma_chan *chan, void *arg);
+struct dma_chan *shdma_xlate(struct of_phandle_args *dma_spec,
+			     struct of_dma *ofdma);
 
 #endif
-- 
1.7.2.5

