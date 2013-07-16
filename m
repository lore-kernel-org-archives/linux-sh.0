From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 00:11:17 +0000
Subject: [PATCH v2 25/27] sh-pfc: Rename struct sh_pfc nr_pins field to nr_gpio_pins
Message-Id: <1373933479-17727-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The field contains the number of pins with an associated GPIO port. This
is currently equal to the total number of pins but will be modified when
adding support for pins without a GPIO port. Rename the field
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.h    | 2 +-
 drivers/pinctrl/sh-pfc/gpio.c    | 4 ++--
 drivers/pinctrl/sh-pfc/pinctrl.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index f02ba1d..93963a1 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -34,7 +34,7 @@ struct sh_pfc {
 	unsigned int num_windows;
 	struct sh_pfc_window *window;
 
-	unsigned int nr_pins;
+	unsigned int nr_gpio_pins;
 
 	struct sh_pfc_chip *gpio;
 	struct sh_pfc_chip *func;
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 87ae38b..7661be5 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -245,7 +245,7 @@ static int gpio_pin_setup(struct sh_pfc_chip *chip)
 	gc->dev = pfc->dev;
 	gc->owner = THIS_MODULE;
 	gc->base = 0;
-	gc->ngpio = pfc->nr_pins;
+	gc->ngpio = pfc->nr_gpio_pins;
 
 	return 0;
 }
@@ -293,7 +293,7 @@ static int gpio_function_setup(struct sh_pfc_chip *chip)
 
 	gc->label = pfc->info->name;
 	gc->owner = THIS_MODULE;
-	gc->base = pfc->nr_pins;
+	gc->base = pfc->nr_gpio_pins;
 	gc->ngpio = pfc->info->nr_func_gpios;
 
 	return 0;
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index bc8b028..314255d 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -632,7 +632,7 @@ static int sh_pfc_map_pins(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 		}
 	}
 
-	pfc->nr_pins = ranges[nr_ranges-1].end + 1;
+	pfc->nr_gpio_pins = ranges[nr_ranges-1].end + 1;
 
 	return nr_ranges;
 }
-- 
1.8.1.5

