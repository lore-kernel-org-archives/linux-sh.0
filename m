From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Jun 2015 23:27:17 +0000
Subject: [PATCH v2 2/4] sh-pfc: handle pin array holes
Message-Id: <2126373.2XeHMZH1yc@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4326653.qPvIJDU6F2@wasted.cogentembedded.com>
In-Reply-To: <4326653.qPvIJDU6F2@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

The pin array  handled by sh_pfc_init_ranges() and sh_pfc_map_pins() may contain
"holes" representing non-existing pins.  We have to first count  the pin ranges
and valid pins in order to calculate the size of the memory to be allocated,
then to skip over the non-existing pins when initializing the allocated arrays
(we still assume that a pin at index 0 always exists). We also have  to return
the number of valid pins  from sh_pfc_map_pins() instead of 0 on success.

As we have to touch devm_kzalloc() calls in sh_pfc_map_pins() anyway, use more
fitting devm_kcalloc() instead which additionally checks the array size.  And
since PINMUX_TYPE_NONE is #define'd as 0, stop re-initializing already zeroed
out 'pmx->configs' array.

While at it, add spaces around the minus signs in sh_pfc_init_ranges().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- added the handling of "holes" to sh_pfc_init_ranges();
- renamed the 'n' local variable in sh_pfc_map_pins() to 'num_pins' and declared
  it on a separate line;
- moved the 'info' local variable inside  2nd loop in sh_pfc_map_pins();
- added comment before the 2nd devm_kcalloc() call in sh_pfc_map_pins();
- added comment to the 2nd loop in sh_pfc_map_pins();
- renamed and refreshed the patch.

 drivers/pinctrl/sh-pfc/core.c    |   29 +++++++++++++++++++----------
 drivers/pinctrl/sh-pfc/pinctrl.c |   29 +++++++++++++++++++----------
 2 files changed, 38 insertions(+), 20 deletions(-)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/core.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/core.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/core.c
@@ -405,7 +405,10 @@ static int sh_pfc_init_ranges(struct sh_
 	 * last.
 	 */
 	for (i = 1, nr_ranges = 1; i < pfc->info->nr_pins; ++i) {
-		if (pfc->info->pins[i-1].pin != pfc->info->pins[i].pin - 1)
+		/* Check for the "holes" first */
+		if (!pfc->info->pins[i].enum_id && !pfc->info->pins[i].configs)
+			continue;
+		if (pfc->info->pins[i - 1].pin != pfc->info->pins[i].pin - 1)
 			nr_ranges++;
 	}
 
@@ -419,19 +422,25 @@ static int sh_pfc_init_ranges(struct sh_
 	range->start = pfc->info->pins[0].pin;
 
 	for (i = 1; i < pfc->info->nr_pins; ++i) {
-		if (pfc->info->pins[i-1].pin = pfc->info->pins[i].pin - 1)
+		if (pfc->info->pins[i - 1].pin = pfc->info->pins[i].pin - 1)
 			continue;
 
-		range->end = pfc->info->pins[i-1].pin;
-		if (!(pfc->info->pins[i-1].configs & SH_PFC_PIN_CFG_NO_GPIO))
-			pfc->nr_gpio_pins = range->end + 1;
-
-		range++;
-		range->start = pfc->info->pins[i].pin;
+		if (pfc->info->pins[i - 1].enum_id ||
+		    pfc->info->pins[i - 1].configs) {
+			range->end = pfc->info->pins[i - 1].pin;
+			if (!(pfc->info->pins[i - 1].configs &
+			      SH_PFC_PIN_CFG_NO_GPIO))
+				pfc->nr_gpio_pins = range->end + 1;
+		}
+
+		if (pfc->info->pins[i].enum_id || pfc->info->pins[i].configs) {
+			range++;
+			range->start = pfc->info->pins[i].pin;
+		}
 	}
 
-	range->end = pfc->info->pins[i-1].pin;
-	if (!(pfc->info->pins[i-1].configs & SH_PFC_PIN_CFG_NO_GPIO))
+	range->end = pfc->info->pins[i - 1].pin;
+	if (!(pfc->info->pins[i - 1].configs & SH_PFC_PIN_CFG_NO_GPIO))
 		pfc->nr_gpio_pins = range->end + 1;
 
 	return 0;
Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pinctrl.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pinctrl.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -570,33 +570,42 @@ static const struct pinconf_ops sh_pfc_p
 /* PFC ranges -> pinctrl pin descs */
 static int sh_pfc_map_pins(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
+	struct pinctrl_pin_desc *pin;
+	unsigned int num_pins;
 	unsigned int i;
 
+	/* Count the valid pins. */
+	for (i = 0, num_pins = 0; i < pfc->info->nr_pins; i++) {
+		if (pfc->info->pins[i].enum_id || pfc->info->pins[i].configs)
+			num_pins++;
+	}
+
 	/* Allocate and initialize the pins and configs arrays. */
-	pmx->pins = devm_kzalloc(pfc->dev,
-				 sizeof(*pmx->pins) * pfc->info->nr_pins,
+	pmx->pins = devm_kcalloc(pfc->dev, num_pins, sizeof(*pmx->pins),
 				 GFP_KERNEL);
 	if (unlikely(!pmx->pins))
 		return -ENOMEM;
 
-	pmx->configs = devm_kzalloc(pfc->dev,
-				    sizeof(*pmx->configs) * pfc->info->nr_pins,
+	/* Equivalent to setting the type field to PINMUX_TYPE_NONE */
+	pmx->configs = devm_kcalloc(pfc->dev, num_pins, sizeof(*pmx->configs),
 				    GFP_KERNEL);
 	if (unlikely(!pmx->configs))
 		return -ENOMEM;
 
-	for (i = 0; i < pfc->info->nr_pins; ++i) {
+	for (i = 0, pin = pmx->pins; i < pfc->info->nr_pins; i++) {
 		const struct sh_pfc_pin *info = &pfc->info->pins[i];
-		struct sh_pfc_pin_config *cfg = &pmx->configs[i];
-		struct pinctrl_pin_desc *pin = &pmx->pins[i];
+
+		/* Skip the "hole" */
+		if (!info->enum_id && !info->configs)
+			continue;
 
 		/* If the pin number is equal to -1 all pins are considered */
 		pin->number = info->pin != (u16)-1 ? info->pin : i;
 		pin->name = info->name;
-		cfg->type = PINMUX_TYPE_NONE;
+		pin++;
 	}
 
-	return 0;
+	return num_pins;
 }
 
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
@@ -621,7 +630,7 @@ int sh_pfc_register_pinctrl(struct sh_pf
 	pmx->pctl_desc.pmxops = &sh_pfc_pinmux_ops;
 	pmx->pctl_desc.confops = &sh_pfc_pinconf_ops;
 	pmx->pctl_desc.pins = pmx->pins;
-	pmx->pctl_desc.npins = pfc->info->nr_pins;
+	pmx->pctl_desc.npins = ret;
 
 	pmx->pctl = pinctrl_register(&pmx->pctl_desc, pfc->dev, pmx);
 	if (pmx->pctl = NULL)

