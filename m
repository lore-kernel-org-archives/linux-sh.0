From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:21:44 +0000
Subject: [PATCH] sh: sh_mobile ceu clock framework support
Message-Id: <20081031112144.2989.26449.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add clock framework support to the sh_mobile ceu and
adjust the board specific code accordingly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-ap325rxa.c            |    2 +-
 arch/sh/boards/mach-migor/setup.c          |    2 +-
 drivers/media/video/sh_mobile_ceu_camera.c |   20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2008-10-28 17:14:13.000000000 +0900
@@ -303,6 +303,7 @@ static struct resource ceu_resources[]  
 static struct platform_device ceu_device = {
 	.name		= "sh_mobile_ceu",
+	.id             = 0, /* "ceu0" clock */
 	.num_resources	= ARRAY_SIZE(ceu_resources),
 	.resource	= ceu_resources,
 	.dev		= {
@@ -375,7 +376,6 @@ static int __init ap325rxa_devices_setup
 	gpio_direction_output(GPIO_PTS3, 1);
 
 	/* CEU */
-	clk_always_enable("mstp203");
 	gpio_request(GPIO_FN_VIO_CLK2, NULL);
 	gpio_request(GPIO_FN_VIO_VD2, NULL);
 	gpio_request(GPIO_FN_VIO_HD2, NULL);
--- 0007/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-28 17:13:57.000000000 +0900
@@ -433,6 +433,7 @@ static struct resource migor_ceu_resourc
 
 static struct platform_device migor_ceu_device = {
 	.name		= "sh_mobile_ceu",
+	.id             = 0, /* "ceu0" clock */
 	.num_resources	= ARRAY_SIZE(migor_ceu_resources),
 	.resource	= migor_ceu_resources,
 	.dev	= {
@@ -554,7 +555,6 @@ static int __init migor_devices_setup(vo
 #endif
 
 	/* CEU */
-	clk_always_enable("mstp203"); /* CEU */
 	gpio_request(GPIO_FN_VIO_CLK2, NULL);
 	gpio_request(GPIO_FN_VIO_VD2, NULL);
 	gpio_request(GPIO_FN_VIO_HD2, NULL);
--- 0001/drivers/media/video/sh_mobile_ceu_camera.c
+++ work/drivers/media/video/sh_mobile_ceu_camera.c	2008-10-28 17:12:25.000000000 +0900
@@ -31,6 +31,7 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/videodev2.h>
+#include <linux/clk.h>
 
 #include <media/v4l2-common.h>
 #include <media/v4l2-dev.h>
@@ -89,6 +90,7 @@ struct sh_mobile_ceu_dev {
 
 	unsigned int irq;
 	void __iomem *base;
+	struct clk *clk;
 	unsigned long video_limit;
 
 	/* lock used to protect videobuf */
@@ -309,6 +311,8 @@ static int sh_mobile_ceu_add_device(stru
 	if (ret)
 		goto err;
 
+	clk_enable(pcdev->clk);
+
 	ceu_write(pcdev, CAPSR, 1 << 16); /* reset */
 	while (ceu_read(pcdev, CSTSR) & 1)
 		msleep(1);
@@ -342,6 +346,8 @@ static void sh_mobile_ceu_remove_device(
 	}
 	spin_unlock_irqrestore(&pcdev->lock, flags);
 
+	clk_disable(pcdev->clk);
+
 	icd->ops->release(icd);
 
 	dev_info(&icd->dev,
@@ -550,6 +556,7 @@ static int sh_mobile_ceu_probe(struct pl
 	struct sh_mobile_ceu_dev *pcdev;
 	struct resource *res;
 	void __iomem *base;
+	char clk_name[8];
 	unsigned int irq;
 	int err = 0;
 
@@ -615,6 +622,14 @@ static int sh_mobile_ceu_probe(struct pl
 		goto exit_release_mem;
 	}
 
+	snprintf(clk_name, sizeof(clk_name), "ceu%d", pdev->id);
+	pcdev->clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(pcdev->clk)) {
+		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		err = PTR_ERR(pcdev->clk);
+		goto exit_free_irq;
+	}
+
 	pcdev->ici.priv = pcdev;
 	pcdev->ici.dev.parent = &pdev->dev;
 	pcdev->ici.nr = pdev->id;
@@ -623,10 +638,12 @@ static int sh_mobile_ceu_probe(struct pl
 
 	err = soc_camera_host_register(&pcdev->ici);
 	if (err)
-		goto exit_free_irq;
+		goto exit_free_clk;
 
 	return 0;
 
+exit_free_clk:
+	clk_put(pcdev->clk);
 exit_free_irq:
 	free_irq(pcdev->irq, pcdev);
 exit_release_mem:
@@ -645,6 +662,7 @@ static int sh_mobile_ceu_remove(struct p
 	struct sh_mobile_ceu_dev *pcdev = platform_get_drvdata(pdev);
 
 	soc_camera_host_unregister(&pcdev->ici);
+	clk_put(pcdev->clk);
 	free_irq(pcdev->irq, pcdev);
 	if (platform_get_resource(pdev, IORESOURCE_MEM, 1))
 		dma_release_declared_memory(&pdev->dev);
