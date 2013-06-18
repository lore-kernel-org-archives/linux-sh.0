From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 18 Jun 2013 10:59:31 +0000
Subject: [PATCH] clocksource: sh_cmt: Use devm_* managed helpers
Message-Id: <1371553171-23530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>

This simplifies the main error path by getting rid of it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

The patch is based on top of renesas-next-20130618 plus Magnus'
"clocksource: sh_cmt: 32-bit control register support" patch.

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 0965e98..7001e4d 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -681,20 +681,18 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 	struct sh_timer_config *cfg = pdev->dev.platform_data;
 	struct resource *res, *res2;
 	int irq, ret;
-	ret = -ENXIO;
 
-	memset(p, 0, sizeof(*p));
 	p->pdev = pdev;
 
 	if (!cfg) {
 		dev_err(&p->pdev->dev, "missing platform data\n");
-		goto err0;
+		return -ENXIO;
 	}
 
 	res = platform_get_resource(p->pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
-		goto err0;
+		return -ENXIO;
 	}
 
 	/* optional resource for the shared timer start/stop register */
@@ -703,23 +701,23 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 	irq = platform_get_irq(p->pdev, 0);
 	if (irq < 0) {
 		dev_err(&p->pdev->dev, "failed to get irq\n");
-		goto err0;
+		return -ENXIO;
 	}
 
 	/* map memory, let mapbase point to our channel */
-	p->mapbase = ioremap_nocache(res->start, resource_size(res));
+	p->mapbase = devm_ioremap_resource(&pdev->dev, res);
 	if (p->mapbase = NULL) {
 		dev_err(&p->pdev->dev, "failed to remap I/O memory\n");
-		goto err0;
+		return -ENXIO;
 	}
 
 	/* map second resource for CMSTR */
-	p->mapbase_str = ioremap_nocache(res2 ? res2->start :
-					 res->start - cfg->channel_offset,
-					 res2 ? resource_size(res2) : 2);
+	p->mapbase_str = devm_ioremap_nocache(&pdev->dev, res2 ? res2->start :
+					      res->start - cfg->channel_offset,
+					      res2 ? resource_size(res2) : 2);
 	if (p->mapbase_str = NULL) {
 		dev_err(&p->pdev->dev, "failed to remap I/O second memory\n");
-		goto err1;
+		return -ENXIO;
 	}
 
 	/* request irq using setup_irq() (too early for request_irq()) */
@@ -730,11 +728,10 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 			     IRQF_IRQPOLL  | IRQF_NOBALANCING;
 
 	/* get hold of clock */
-	p->clk = clk_get(&p->pdev->dev, "cmt_fck");
+	p->clk = devm_clk_get(&p->pdev->dev, "cmt_fck");
 	if (IS_ERR(p->clk)) {
 		dev_err(&p->pdev->dev, "cannot get clock\n");
-		ret = PTR_ERR(p->clk);
-		goto err2;
+		return PTR_ERR(p->clk);
 	}
 
 	if (res2 && (resource_size(res2) = 4)) {
@@ -773,27 +770,19 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 			      cfg->clocksource_rating);
 	if (ret) {
 		dev_err(&p->pdev->dev, "registration failed\n");
-		goto err3;
+		return ret;
 	}
 	p->cs_enabled = false;
 
 	ret = setup_irq(irq, &p->irqaction);
 	if (ret) {
 		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
-		goto err3;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, p);
 
 	return 0;
-err3:
-	clk_put(p->clk);
-err2:
-	iounmap(p->mapbase_str);
-err1:
-	iounmap(p->mapbase);
-err0:
-	return ret;
 }
 
 static int sh_cmt_probe(struct platform_device *pdev)
@@ -812,7 +801,7 @@ static int sh_cmt_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
 	if (p = NULL) {
 		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
@@ -820,7 +809,6 @@ static int sh_cmt_probe(struct platform_device *pdev)
 
 	ret = sh_cmt_setup(p, pdev);
 	if (ret) {
-		kfree(p);
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
-- 
Regards,

Laurent Pinchart

