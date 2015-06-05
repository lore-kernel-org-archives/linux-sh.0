From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 05 Jun 2015 10:59:17 +0000
Subject: [PATCH 01/10] sh-vou: hook up the clock correctly
Message-Id: <1433501966-30176-2-git-send-email-hverkuil@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1433501966-30176-1-git-send-email-hverkuil@xs4all.nl>
In-Reply-To: <1433501966-30176-1-git-send-email-hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>, Magnus Damm <damm@opensource.se>

From: Hans Verkuil <hans.verkuil@cisco.com>

Bitrot has set in for this driver and the sh-vou.0 clock was never enabled,
so this driver didn't do anything. In addition, the clock was incorrectly
defined in clock-sh7724.c. Fix this.

While we're at it: use proper resource managed calls.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Magnus Damm <damm@opensource.se>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |  2 +-
 drivers/media/platform/sh_vou.c        | 54 ++++++++++++----------------------
 2 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index c187b95..f1df899 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -343,7 +343,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("2ddmac0", &mstp_clks[HWBLK_2DDMAC]),
 	CLKDEV_DEV_ID("sh_fsi.0", &mstp_clks[HWBLK_SPU]),
 	CLKDEV_CON_ID("jpu0", &mstp_clks[HWBLK_JPU]),
-	CLKDEV_DEV_ID("sh-vou.0", &mstp_clks[HWBLK_VOU]),
+	CLKDEV_CON_ID("sh-vou.0", &mstp_clks[HWBLK_VOU]),
 	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU0]),
 	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[HWBLK_CEU0]),
 	CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU0]),
diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/sh_vou.c
index 829e85c..9e98233 100644
--- a/drivers/media/platform/sh_vou.c
+++ b/drivers/media/platform/sh_vou.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/videodev2.h>
 #include <linux/module.h>
+#include <linux/clk.h>
 
 #include <media/sh_vou.h>
 #include <media/v4l2-common.h>
@@ -65,6 +66,7 @@ struct sh_vou_device {
 	struct video_device vdev;
 	atomic_t use_count;
 	struct sh_vou_pdata *pdata;
+	struct clk *clk;
 	spinlock_t lock;
 	void __iomem *base;
 	/* State information */
@@ -1300,7 +1302,7 @@ static int sh_vou_probe(struct platform_device *pdev)
 	struct i2c_adapter *i2c_adap;
 	struct video_device *vdev;
 	struct sh_vou_device *vou_dev;
-	struct resource *reg_res, *region;
+	struct resource *reg_res;
 	struct v4l2_subdev *subdev;
 	int irq, ret;
 
@@ -1312,10 +1314,16 @@ static int sh_vou_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	vou_dev = kzalloc(sizeof(*vou_dev), GFP_KERNEL);
+	vou_dev = devm_kzalloc(&pdev->dev, sizeof(*vou_dev), GFP_KERNEL);
 	if (!vou_dev)
 		return -ENOMEM;
 
+	vou_dev->clk = devm_clk_get(&pdev->dev, "sh-vou.0");
+	if (IS_ERR(vou_dev->clk)) {
+		dev_err(&pdev->dev, "cannot get clock\n");
+		return PTR_ERR(vou_dev->clk);
+	}
+
 	INIT_LIST_HEAD(&vou_dev->queue);
 	spin_lock_init(&vou_dev->lock);
 	mutex_init(&vou_dev->fop_lock);
@@ -1340,28 +1348,18 @@ static int sh_vou_probe(struct platform_device *pdev)
 	pix->sizeimage		= VOU_MAX_IMAGE_WIDTH * 2 * 480;
 	pix->colorspace		= V4L2_COLORSPACE_SMPTE170M;
 
-	region = request_mem_region(reg_res->start, resource_size(reg_res),
-				    pdev->name);
-	if (!region) {
-		dev_err(&pdev->dev, "VOU region already claimed\n");
-		ret = -EBUSY;
-		goto ereqmemreg;
-	}
+	vou_dev->base = devm_ioremap_resource(&pdev->dev, reg_res);
+	if (IS_ERR(vou_dev->base))
+		return PTR_ERR(vou_dev->base);
 
-	vou_dev->base = ioremap(reg_res->start, resource_size(reg_res));
-	if (!vou_dev->base) {
-		ret = -ENOMEM;
-		goto emap;
-	}
-
-	ret = request_irq(irq, sh_vou_isr, 0, "vou", vou_dev);
+	ret = devm_request_irq(&pdev->dev, irq, sh_vou_isr, 0, "vou", vou_dev);
 	if (ret < 0)
-		goto ereqirq;
+		return ret;
 
 	ret = v4l2_device_register(&pdev->dev, &vou_dev->v4l2_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Error registering v4l2 device\n");
-		goto ev4l2devreg;
+		return ret;
 	}
 
 	vdev = &vou_dev->vdev;
@@ -1383,6 +1381,7 @@ static int sh_vou_probe(struct platform_device *pdev)
 		goto ei2cgadap;
 	}
 
+	clk_prepare_enable(vou_dev->clk);
 	ret = sh_vou_hw_init(vou_dev);
 	if (ret < 0)
 		goto ereset;
@@ -1403,43 +1402,28 @@ static int sh_vou_probe(struct platform_device *pdev)
 evregdev:
 ei2cnd:
 ereset:
+	clk_disable_unprepare(vou_dev->clk);
 	i2c_put_adapter(i2c_adap);
 ei2cgadap:
 	pm_runtime_disable(&pdev->dev);
 	v4l2_device_unregister(&vou_dev->v4l2_dev);
-ev4l2devreg:
-	free_irq(irq, vou_dev);
-ereqirq:
-	iounmap(vou_dev->base);
-emap:
-	release_mem_region(reg_res->start, resource_size(reg_res));
-ereqmemreg:
-	kfree(vou_dev);
 	return ret;
 }
 
 static int sh_vou_remove(struct platform_device *pdev)
 {
-	int irq = platform_get_irq(pdev, 0);
 	struct v4l2_device *v4l2_dev = platform_get_drvdata(pdev);
 	struct sh_vou_device *vou_dev = container_of(v4l2_dev,
 						struct sh_vou_device, v4l2_dev);
 	struct v4l2_subdev *sd = list_entry(v4l2_dev->subdevs.next,
 					    struct v4l2_subdev, list);
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
-	struct resource *reg_res;
 
-	if (irq > 0)
-		free_irq(irq, vou_dev);
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(&vou_dev->vdev);
+	clk_disable_unprepare(vou_dev->clk);
 	i2c_put_adapter(client->adapter);
 	v4l2_device_unregister(&vou_dev->v4l2_dev);
-	iounmap(vou_dev->base);
-	reg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (reg_res)
-		release_mem_region(reg_res->start, resource_size(reg_res));
-	kfree(vou_dev);
 	return 0;
 }
 
-- 
2.1.4

