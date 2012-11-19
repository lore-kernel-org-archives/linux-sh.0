From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:22:20 +0000
Subject: [PATCH 191/493] sh: remove use of __devinit
Message-Id: <1353349642-3677-191-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-sh@vger.kernel.org 
---
 drivers/sh/pfc/gpio.c    | 2 +-
 drivers/sh/pfc/pinctrl.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index d08c978..8f4f431 100644
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
diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 99b3b4f..5dd1806 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -328,7 +328,7 @@ static struct pinctrl_desc sh_pfc_pinctrl_desc = {
 	.confops	= &sh_pfc_pinconf_ops,
 };
 
-static inline void __devinit sh_pfc_map_one_gpio(struct sh_pfc *pfc,
+static inline void sh_pfc_map_one_gpio(struct sh_pfc *pfc,
 						 struct sh_pfc_pinctrl *pmx,
 						 struct pinmux_gpio *gpio,
 						 unsigned offset)
@@ -351,7 +351,7 @@ static inline void __devinit sh_pfc_map_one_gpio(struct sh_pfc *pfc,
 }
 
 /* pinmux ranges -> pinctrl pin descs */
-static int __devinit sh_pfc_map_gpios(struct sh_pfc *pfc,
+static int sh_pfc_map_gpios(struct sh_pfc *pfc,
 				      struct sh_pfc_pinctrl *pmx)
 {
 	unsigned long flags;
@@ -396,7 +396,7 @@ static int __devinit sh_pfc_map_gpios(struct sh_pfc *pfc,
 	return 0;
 }
 
-static int __devinit sh_pfc_map_functions(struct sh_pfc *pfc,
+static int sh_pfc_map_functions(struct sh_pfc *pfc,
 					  struct sh_pfc_pinctrl *pmx)
 {
 	unsigned long flags;
@@ -421,7 +421,7 @@ static int __devinit sh_pfc_map_functions(struct sh_pfc *pfc,
 	return 0;
 }
 
-static int __devinit sh_pfc_pinctrl_probe(struct platform_device *pdev)
+static int sh_pfc_pinctrl_probe(struct platform_device *pdev)
 {
 	struct sh_pfc *pfc;
 	int ret;
-- 
1.8.0

