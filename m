From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:21:23 +0000
Subject: [PATCH] sh: sh_mobile keysc clock framework support
Message-Id: <20081031112123.2988.39875.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add clock framework support to the sh_mobile keysc driver and
adjust the board specific code accordingly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c   |    2 +-
 arch/sh/boards/mach-se/7722/setup.c |    3 +--
 drivers/input/keyboard/sh_keysc.c   |   28 +++++++++++++++++++++++-----
 3 files changed, 25 insertions(+), 8 deletions(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-28 16:49:10.000000000 +0900
@@ -89,6 +89,7 @@ static struct resource sh_keysc_resource
 
 static struct platform_device sh_keysc_device = {
 	.name           = "sh_keysc",
+	.id             = 0, /* "keysc0" clock */
 	.num_resources  = ARRAY_SIZE(sh_keysc_resources),
 	.resource       = sh_keysc_resources,
 	.dev	= {
@@ -479,7 +480,6 @@ static int __init migor_devices_setup(vo
 	ctrl_outl(0x00110080, BSC_CS4WCR);
 
 	/* KEYSC */
-	clk_always_enable("mstp214"); /* KEYSC */
 	gpio_request(GPIO_FN_KEYOUT0, NULL);
 	gpio_request(GPIO_FN_KEYOUT1, NULL);
 	gpio_request(GPIO_FN_KEYOUT2, NULL);
--- 0001/arch/sh/boards/mach-se/7722/setup.c
+++ work/arch/sh/boards/mach-se/7722/setup.c	2008-10-28 16:49:03.000000000 +0900
@@ -130,6 +130,7 @@ static struct resource sh_keysc_resource
 
 static struct platform_device sh_keysc_device = {
 	.name           = "sh_keysc",
+	.id             = 0, /* "keysc0" clock */
 	.num_resources  = ARRAY_SIZE(sh_keysc_resources),
 	.resource       = sh_keysc_resources,
 	.dev	= {
@@ -146,8 +147,6 @@ static struct platform_device *se7722_de
 
 static int __init se7722_devices_setup(void)
 {
-	clk_always_enable("mstp214"); /* KEYSC */
-
 	return platform_add_devices(se7722_devices,
 		ARRAY_SIZE(se7722_devices));
 }
--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2008-10-28 16:46:27.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <asm/sh_keysc.h>
 
@@ -39,6 +40,7 @@ static const struct {
 
 struct sh_keysc_priv {
 	void __iomem *iomem_base;
+	struct clk *clk;
 	unsigned long last_keys;
 	struct input_dev *input;
 	struct sh_keysc_info pdata;
@@ -125,6 +127,7 @@ static int __devinit sh_keysc_probe(stru
 	struct sh_keysc_info *pdata;
 	struct resource *res;
 	struct input_dev *input;
+	char clk_name[8];
 	int i, k;
 	int irq, error;
 
@@ -165,11 +168,19 @@ static int __devinit sh_keysc_probe(stru
 		goto err1;
 	}
 
+	snprintf(clk_name, sizeof(clk_name), "keysc%d", pdev->id);
+	priv->clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		error = PTR_ERR(priv->clk);
+		goto err2;
+	}
+
 	priv->input = input_allocate_device();
 	if (!priv->input) {
 		dev_err(&pdev->dev, "failed to allocate input device\n");
 		error = -ENOMEM;
-		goto err2;
+		goto err3;
 	}
 
 	input = priv->input;
@@ -187,7 +198,7 @@ static int __devinit sh_keysc_probe(stru
 	error = request_irq(irq, sh_keysc_isr, 0, pdev->name, pdev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto err3;
+		goto err4;
 	}
 
 	for (i = 0; i < SH_KEYSC_MAXKEYS; i++) {
@@ -199,18 +210,22 @@ static int __devinit sh_keysc_probe(stru
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register input device\n");
-		goto err4;
+		goto err5;
 	}
 
+	clk_enable(priv->clk);
+
 	iowrite16((sh_keysc_mode[pdata->mode].kymd << 8) |
 		  pdata->scan_timing, priv->iomem_base + KYCR1_OFFS);
 	iowrite16(0, priv->iomem_base + KYOUTDR_OFFS);
 	iowrite16(KYCR2_IRQ_LEVEL, priv->iomem_base + KYCR2_OFFS);
 	return 0;
- err4:
+ err5:
 	free_irq(irq, pdev);
- err3:
+ err4:
 	input_free_device(input);
+ err3:
+	clk_put(priv->clk);
  err2:
 	iounmap(priv->iomem_base);
  err1:
@@ -230,6 +245,9 @@ static int __devexit sh_keysc_remove(str
 	free_irq(platform_get_irq(pdev, 0), pdev);
 	iounmap(priv->iomem_base);
 
+	clk_disable(priv->clk);
+	clk_put(priv->clk);
+
 	platform_set_drvdata(pdev, NULL);
 	kfree(priv);
 	return 0;
