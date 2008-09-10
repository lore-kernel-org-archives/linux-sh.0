From: roel kluin <roel.kluin@gmail.com>
Date: Wed, 10 Sep 2008 17:34:44 +0000
Subject: [PATCH] rtc-sh: Unsigned rtc->{periodic,carry,alarm}_irq cannot be
Message-Id: <48C80534.5020807@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

possibly since commit b420b1a7a17ea88531d0e12b2f2679a0c8365803
---
rtc-sh: Unsigned rtc->{periodic,carry,alarm}_irq cannot be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 1f88e9e..690a780 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -575,7 +575,7 @@ static int __devinit sh_rtc_probe(struct platform_device *pdev)
 	struct sh_rtc *rtc;
 	struct resource *res;
 	unsigned int tmp;
-	int ret = -ENOENT;
+	int ret;
 
 	rtc = kzalloc(sizeof(struct sh_rtc), GFP_KERNEL);
 	if (unlikely(!rtc))
@@ -584,26 +584,33 @@ static int __devinit sh_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&rtc->lock);
 
 	/* get periodic/carry/alarm irqs */
-	rtc->periodic_irq = platform_get_irq(pdev, 0);
-	if (unlikely(rtc->periodic_irq < 0)) {
+	ret = platform_get_irq(pdev, 0);
+	if (unlikely(ret < 0)) {
+		ret = -ENOENT;
 		dev_err(&pdev->dev, "No IRQ for period\n");
 		goto err_badres;
 	}
+	rtc->periodic_irq = ret;
 
-	rtc->carry_irq = platform_get_irq(pdev, 1);
-	if (unlikely(rtc->carry_irq < 0)) {
+	ret = platform_get_irq(pdev, 1);
+	if (unlikely(ret < 0)) {
+		ret = -ENOENT;
 		dev_err(&pdev->dev, "No IRQ for carry\n");
 		goto err_badres;
 	}
+	rtc->carry_irq = ret;
 
-	rtc->alarm_irq = platform_get_irq(pdev, 2);
-	if (unlikely(rtc->alarm_irq < 0)) {
+	ret = platform_get_irq(pdev, 2);
+	if (unlikely(ret < 0)) {
+		ret = -ENOENT;
 		dev_err(&pdev->dev, "No IRQ for alarm\n");
 		goto err_badres;
 	}
+	rtc->alarm_irq = ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (unlikely(res = NULL)) {
+		ret = -ENOENT;
 		dev_err(&pdev->dev, "No IO resource\n");
 		goto err_badres;
 	}
