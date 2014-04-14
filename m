From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 18:33:13 +0000
Subject: [PATCH v2 2/6] gpio: rcar: Add minimal runtime PM support
Message-Id: <1397500397-12607-3-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1397500397-12607-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1397500397-12607-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-gpio@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

This is just enough to automatically enable the functional clock, if
present. Clock management during suspend/resume is still to be added.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org
---
v2:
  - Use pm_runtime_put() instead of pm_runtime_put_sync()
---
 drivers/gpio/gpio-rcar.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 03c91482432c..bfcfeeefcf78 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -26,6 +26,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
@@ -377,6 +378,9 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
@@ -460,6 +464,8 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 err1:
 	irq_domain_remove(p->irq_domain);
 err0:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -473,6 +479,8 @@ static int gpio_rcar_remove(struct platform_device *pdev)
 		return ret;
 
 	irq_domain_remove(p->irq_domain);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
-- 
1.7.9.5

