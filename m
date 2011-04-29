From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 29 Apr 2011 17:09:25 +0000
Subject: [PATCH 2/2] dmaengine: shdma: add runtime- and system-level power
Message-Id: <Pine.LNX.4.64.1104291908090.17813@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104291901200.17813@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104291901200.17813@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>

This patch extends and fixes runtime power management in the shdma
driver to support powering down the DMA controller and adds support
for system-level suspend and resume.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/shdma.h |    1 +
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index d0f402b..dcc1b21 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1254,6 +1254,8 @@ rst_err:
 	spin_unlock_irq(&sh_dmae_lock);
 
 	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	if (dmars)
 		iounmap(shdev->dmars);
 emapdmars:
@@ -1313,12 +1315,78 @@ static void sh_dmae_shutdown(struct platform_device *pdev)
 	sh_dmae_ctl_stop(shdev);
 }
 
+static int sh_dmae_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int sh_dmae_runtime_resume(struct device *dev)
+{
+	struct sh_dmae_device *shdev = dev_get_drvdata(dev);
+
+	return sh_dmae_rst(shdev);
+}
+
+#ifdef CONFIG_PM
+static int sh_dmae_suspend(struct device *dev)
+{
+	struct sh_dmae_device *shdev = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < shdev->pdata->channel_num; i++) {
+		struct sh_dmae_chan *sh_chan = shdev->chan[i];
+		if (sh_chan->descs_allocated)
+			sh_chan->pm_error = pm_runtime_put_sync(dev);
+	}
+
+	return 0;
+}
+
+static int sh_dmae_resume(struct device *dev)
+{
+	struct sh_dmae_device *shdev = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < shdev->pdata->channel_num; i++) {
+		struct sh_dmae_chan *sh_chan = shdev->chan[i];
+		struct sh_dmae_slave *param = sh_chan->common.private;
+
+		if (!sh_chan->descs_allocated)
+			continue;
+
+		if (!sh_chan->pm_error)
+			pm_runtime_get_sync(dev);
+
+		if (param) {
+			const struct sh_dmae_slave_config *cfg = param->config;
+			dmae_set_dmars(sh_chan, cfg->mid_rid);
+			dmae_set_chcr(sh_chan, cfg->chcr);
+		} else {
+			dmae_init(sh_chan);
+		}
+	}
+
+	return 0;
+}
+#else
+#define sh_dmae_suspend NULL
+#define sh_dmae_resume NULL
+#endif
+
+const struct dev_pm_ops sh_dmae_pm = {
+	.suspend		= sh_dmae_suspend,
+	.resume			= sh_dmae_resume,
+	.runtime_suspend	= sh_dmae_runtime_suspend,
+	.runtime_resume		= sh_dmae_runtime_resume,
+};
+
 static struct platform_driver sh_dmae_driver = {
 	.remove		= __exit_p(sh_dmae_remove),
 	.shutdown	= sh_dmae_shutdown,
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "sh-dma-engine",
+		.pm	= &sh_dmae_pm,
 	},
 };
 
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 52e4fb1..3f9d3cd 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -37,6 +37,7 @@ struct sh_dmae_chan {
 	int id;				/* Raw id of this channel */
 	u32 __iomem *base;
 	char dev_id[16];		/* unique name per DMAC of channel */
+	int pm_error;
 };
 
 struct sh_dmae_device {
-- 
1.7.2.5

