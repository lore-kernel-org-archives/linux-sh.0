From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:53:50 +0000
Subject: [PATCH v4 08/81] sh-pfc: Remove all use of __devinit/__devexit
Message-Id: <1356735303-29474-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_HOTPLUG is going away as an option in v3.8 so __devinit/__devexit
are no longer needed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/sh/pfc/gpio.c    |    6 +++---
 drivers/sh/pfc/pinctrl.c |   20 +++++++++-----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index 038fa07..6a24f07 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -165,7 +165,7 @@ static int sh_pfc_gpio_match(struct gpio_chip *gc, void *data)
 	return !!strstr(gc->label, data);
 }
 
-static int __devinit sh_pfc_gpio_probe(struct platform_device *pdev)
+static int sh_pfc_gpio_probe(struct platform_device *pdev)
 {
 	struct sh_pfc_chip *chip;
 	struct gpio_chip *gc;
@@ -184,7 +184,7 @@ static int __devinit sh_pfc_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit sh_pfc_gpio_remove(struct platform_device *pdev)
+static int sh_pfc_gpio_remove(struct platform_device *pdev)
 {
 	struct sh_pfc_chip *chip = platform_get_drvdata(pdev);
 	int ret;
@@ -199,7 +199,7 @@ static int __devexit sh_pfc_gpio_remove(struct platform_device *pdev)
 
 static struct platform_driver sh_pfc_gpio_driver = {
 	.probe		= sh_pfc_gpio_probe,
-	.remove		= __devexit_p(sh_pfc_gpio_remove),
+	.remove		= sh_pfc_gpio_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 0646bf6..4109b76 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -328,10 +328,10 @@ static struct pinctrl_desc sh_pfc_pinctrl_desc = {
 	.confops	= &sh_pfc_pinconf_ops,
 };
 
-static inline void __devinit sh_pfc_map_one_gpio(struct sh_pfc *pfc,
-						 struct sh_pfc_pinctrl *pmx,
-						 struct pinmux_gpio *gpio,
-						 unsigned offset)
+static inline void sh_pfc_map_one_gpio(struct sh_pfc *pfc,
+				       struct sh_pfc_pinctrl *pmx,
+				       struct pinmux_gpio *gpio,
+				       unsigned offset)
 {
 	struct pinmux_data_reg *dummy;
 	unsigned long flags;
@@ -351,8 +351,7 @@ static inline void __devinit sh_pfc_map_one_gpio(struct sh_pfc *pfc,
 }
 
 /* pinmux ranges -> pinctrl pin descs */
-static int __devinit sh_pfc_map_gpios(struct sh_pfc *pfc,
-				      struct sh_pfc_pinctrl *pmx)
+static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
 	unsigned long flags;
 	int i;
@@ -396,8 +395,7 @@ static int __devinit sh_pfc_map_gpios(struct sh_pfc *pfc,
 	return 0;
 }
 
-static int __devinit sh_pfc_map_functions(struct sh_pfc *pfc,
-					  struct sh_pfc_pinctrl *pmx)
+static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
 	unsigned long flags;
 	int i, fn;
@@ -421,7 +419,7 @@ static int __devinit sh_pfc_map_functions(struct sh_pfc *pfc,
 	return 0;
 }
 
-static int __devinit sh_pfc_pinctrl_probe(struct platform_device *pdev)
+static int sh_pfc_pinctrl_probe(struct platform_device *pdev)
 {
 	struct sh_pfc *pfc;
 	int ret;
@@ -465,7 +463,7 @@ free_pads:
 	return ret;
 }
 
-static int __devexit sh_pfc_pinctrl_remove(struct platform_device *pdev)
+static int sh_pfc_pinctrl_remove(struct platform_device *pdev)
 {
 	struct sh_pfc_pinctrl *pmx = platform_get_drvdata(pdev);
 
@@ -482,7 +480,7 @@ static int __devexit sh_pfc_pinctrl_remove(struct platform_device *pdev)
 
 static struct platform_driver sh_pfc_pinctrl_driver = {
 	.probe		= sh_pfc_pinctrl_probe,
-	.remove		= __devexit_p(sh_pfc_pinctrl_remove),
+	.remove		= sh_pfc_pinctrl_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
-- 
1.7.8.6

