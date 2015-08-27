From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 27 Aug 2015 20:07:23 +0000
Subject: [PATCH] pinctrl: sh-pfc: Get rid of CONFIG_ARCH_SHMOBILE_LEGACY
Message-Id: <1440706043-3406-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1440705812-2960-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440705812-2960-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Shmobile is all multiplatform these days, so get rid of the reference to
CONFIG_ARCH_SHMOBILE_LEGACY.

Move the legacy code to do the non-DT mapping between GPIOs and pins
inside the existing #ifdef CONFIG_SUPERH section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
  - Against renesas-devel-20150826-v4.2-rc8,
  - This must not be applied to a branch that still has
    CONFIG_ARCH_SHMOBILE_LEGACY.

 drivers/pinctrl/sh-pfc/gpio.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 685b3c24627daf03..a917c62f07124b0b 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -341,7 +341,6 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	struct sh_pfc_chip *chip;
 	phys_addr_t address;
 	unsigned int i;
-	int ret;
 
 	if (pfc->info->data_regs = NULL)
 		return 0;
@@ -379,29 +378,27 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	if (IS_ENABLED(CONFIG_OF) && pfc->dev->of_node)
 		return 0;
 
-	if (IS_ENABLED(CONFIG_SUPERH) ||
-	    IS_ENABLED(CONFIG_ARCH_SHMOBILE_LEGACY)) {
-		/*
-		 * Register the GPIO to pin mappings. As pins with GPIO ports
-		 * must come first in the ranges, skip the pins without GPIO
-		 * ports by stopping at the first range that contains such a
-		 * pin.
-		 */
-		for (i = 0; i < pfc->nr_ranges; ++i) {
-			const struct sh_pfc_pin_range *range = &pfc->ranges[i];
-
-			if (range->start >= pfc->nr_gpio_pins)
-				break;
-
-			ret = gpiochip_add_pin_range(&chip->gpio_chip,
-				dev_name(pfc->dev), range->start, range->start,
-				range->end - range->start + 1);
-			if (ret < 0)
-				return ret;
-		}
+#ifdef CONFIG_SUPERH
+	/*
+	 * Register the GPIO to pin mappings. As pins with GPIO ports
+	 * must come first in the ranges, skip the pins without GPIO
+	 * ports by stopping at the first range that contains such a
+	 * pin.
+	 */
+	for (i = 0; i < pfc->nr_ranges; ++i) {
+		const struct sh_pfc_pin_range *range = &pfc->ranges[i];
+		int ret;
+
+		if (range->start >= pfc->nr_gpio_pins)
+			break;
+
+		ret = gpiochip_add_pin_range(&chip->gpio_chip,
+			dev_name(pfc->dev), range->start, range->start,
+			range->end - range->start + 1);
+		if (ret < 0)
+			return ret;
 	}
 
-#ifdef CONFIG_SUPERH
 	/* Register the function GPIOs chip. */
 	if (pfc->info->nr_func_gpios = 0)
 		return 0;
-- 
1.9.1

