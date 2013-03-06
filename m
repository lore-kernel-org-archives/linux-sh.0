From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 12:52:44 +0000
Subject: [PATCH v3 23/29] sh-pfc: Add support for sparse pin numbers
Message-Id: <1362574370-17889-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PFC driver assumes that the value of the GPIO_PORTxxx enumeration
names are equal to the port number. This isn't true when the port number
space is sparse, as with the SH73A0.

Fix the issue by adding support for pin numbers ranges specified through
SoC data. When no range is specified the driver considers that the PFC
implements a single contiguous range for all pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c    | 19 +++++++++-
 drivers/pinctrl/sh-pfc/core.h    |  2 +
 drivers/pinctrl/sh-pfc/gpio.c    |  6 +--
 drivers/pinctrl/sh-pfc/pinctrl.c | 80 ++++++++++++++++++++++++++--------------
 drivers/pinctrl/sh-pfc/sh_pfc.h  |  2 +
 5 files changed, 78 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 667db99..79824826 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -80,7 +80,24 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 
 struct sh_pfc_pin *sh_pfc_get_pin(struct sh_pfc *pfc, unsigned int pin)
 {
-	return &pfc->info->pins[pin];
+	unsigned int offset;
+	unsigned int i;
+
+	if (pfc->info->ranges = NULL)
+		return &pfc->info->pins[pin];
+
+	for (i = 0, offset = 0; i < pfc->info->nr_ranges; ++i) {
+		const struct pinmux_range *range = &pfc->info->ranges[i];
+
+		if (pin <= range->end)
+			return pin >= range->begin
+			     ? &pfc->info->pins[offset + pin - range->begin]
+			     : NULL;
+
+		offset += range->end - range->begin + 1;
+	}
+
+	return NULL;
 }
 
 static int sh_pfc_enum_in_range(pinmux_enum_t enum_id, struct pinmux_range *r)
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 6ea3d4f..b8b3e87 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -32,6 +32,8 @@ struct sh_pfc {
 	unsigned int num_windows;
 	struct sh_pfc_window *window;
 
+	unsigned int nr_pins;
+
 	struct sh_pfc_chip *gpio;
 	struct sh_pfc_chip *func;
 
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 45090d8..4158d97 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -45,7 +45,7 @@ static int gpio_pin_request(struct gpio_chip *gc, unsigned offset)
 	struct sh_pfc *pfc = gpio_to_pfc(gc);
 	struct sh_pfc_pin *pin = sh_pfc_get_pin(pfc, offset);
 
-	if (pin->enum_id = 0)
+	if (pin = NULL || pin->enum_id = 0)
 		return -EINVAL;
 
 	return pinctrl_request_gpio(offset);
@@ -127,7 +127,7 @@ static void gpio_pin_setup(struct sh_pfc_chip *chip)
 	gc->dev = pfc->dev;
 	gc->owner = THIS_MODULE;
 	gc->base = 0;
-	gc->ngpio = pfc->info->nr_pins;
+	gc->ngpio = pfc->nr_pins;
 }
 
 /* -----------------------------------------------------------------------------
@@ -184,7 +184,7 @@ static void gpio_function_setup(struct sh_pfc_chip *chip)
 
 	gc->label = pfc->info->name;
 	gc->owner = THIS_MODULE;
-	gc->base = pfc->info->nr_pins;
+	gc->base = pfc->nr_pins;
 	gc->ngpio = pfc->info->nr_func_gpios;
 }
 
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 78bd277..c951c81 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -28,7 +28,6 @@
 struct sh_pfc_pinctrl {
 	struct pinctrl_dev *pctl;
 	struct pinctrl_desc pctl_desc;
-	struct pinctrl_gpio_range range;
 
 	struct sh_pfc *pfc;
 
@@ -37,6 +36,8 @@ struct sh_pfc_pinctrl {
 
 	struct pinctrl_pin_desc *pads;
 	unsigned int nr_pads;
+
+	struct pinctrl_gpio_range *ranges;
 };
 
 static int sh_pfc_get_groups_count(struct pinctrl_dev *pctldev)
@@ -294,29 +295,59 @@ static const struct pinconf_ops sh_pfc_pinconf_ops = {
 	.pin_config_dbg_show	= sh_pfc_pinconf_dbg_show,
 };
 
-/* pinmux ranges -> pinctrl pin descs */
-static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
+/* PFC ranges -> pinctrl pin descs */
+static int sh_pfc_map_pins(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
-	int i;
-
-	pmx->nr_pads = pfc->info->nr_pins;
+	const struct pinmux_range *ranges;
+	struct pinmux_range def_range;
+	unsigned int nr_ranges;
+	unsigned int nr_pins;
+	unsigned int i;
+	unsigned int j;
+
+	if (pfc->info->ranges = NULL) {
+		def_range.begin = 0;
+		def_range.end = pfc->info->nr_pins - 1;
+		ranges = &def_range;
+		nr_ranges = 1;
+	} else {
+		ranges = pfc->info->ranges;
+		nr_ranges = pfc->info->nr_ranges;
+	}
 
-	pmx->pads = devm_kzalloc(pfc->dev, sizeof(*pmx->pads) * pmx->nr_pads,
+	pmx->pads = devm_kzalloc(pfc->dev,
+				 sizeof(*pmx->pads) * pfc->info->nr_pins,
 				 GFP_KERNEL);
-	if (unlikely(!pmx->pads)) {
-		pmx->nr_pads = 0;
+	if (unlikely(!pmx->pads))
 		return -ENOMEM;
-	}
 
-	for (i = 0; i < pmx->nr_pads; i++) {
-		struct pinctrl_pin_desc *pin = pmx->pads + i;
-		struct sh_pfc_pin *gpio = pfc->info->pins + i;
+	pmx->ranges = devm_kzalloc(pfc->dev, sizeof(*pmx->ranges) * nr_ranges,
+				   GFP_KERNEL);
+	if (unlikely(!pmx->ranges))
+		return -ENOMEM;
+
+	for (i = 0, nr_pins = 0; i < nr_ranges; ++i) {
+		const struct pinmux_range *pfc_range = &ranges[i];
+		struct pinctrl_gpio_range *range = &pmx->ranges[i];
+
+		range->name = DRV_NAME;
+		range->id = i;
+		range->npins = pfc_range->end - pfc_range->begin + 1;
+		range->base = pfc_range->begin;
+		range->pin_base = pfc_range->begin;
 
-		pin->number = i;
-		pin->name = gpio->name;
+		for (j = 0; j < range->npins; j++, nr_pins++) {
+			struct pinctrl_pin_desc *pin = &pmx->pads[nr_pins];
+			struct sh_pfc_pin *gpio = &pfc->info->pins[nr_pins];
+
+			pin->number = range->pin_base + j;
+			pin->name = gpio->name;
+		}
 	}
 
-	return 0;
+	pfc->nr_pins = ranges[nr_ranges-1].end + 1;
+
+	return nr_ranges;
 }
 
 static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
@@ -348,6 +379,7 @@ static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 {
 	struct sh_pfc_pinctrl *pmx;
+	int nr_ranges;
 	int ret;
 
 	pmx = devm_kzalloc(pfc->dev, sizeof(*pmx), GFP_KERNEL);
@@ -357,9 +389,9 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	pmx->pfc = pfc;
 	pfc->pinctrl = pmx;
 
-	ret = sh_pfc_map_gpios(pfc, pmx);
-	if (unlikely(ret != 0))
-		return ret;
+	nr_ranges = sh_pfc_map_pins(pfc, pmx);
+	if (unlikely(nr_ranges < 0))
+		return nr_ranges;
 
 	ret = sh_pfc_map_functions(pfc, pmx);
 	if (unlikely(ret != 0))
@@ -371,19 +403,13 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	pmx->pctl_desc.pmxops = &sh_pfc_pinmux_ops;
 	pmx->pctl_desc.confops = &sh_pfc_pinconf_ops;
 	pmx->pctl_desc.pins = pmx->pads;
-	pmx->pctl_desc.npins = pmx->nr_pads;
+	pmx->pctl_desc.npins = pfc->info->nr_pins;
 
 	pmx->pctl = pinctrl_register(&pmx->pctl_desc, pfc->dev, pmx);
 	if (IS_ERR(pmx->pctl))
 		return PTR_ERR(pmx->pctl);
 
-	pmx->range.name = DRV_NAME,
-	pmx->range.id = 0;
-	pmx->range.npins = pfc->info->nr_pins;
-	pmx->range.base = 0;
-	pmx->range.pin_base = 0;
-
-	pinctrl_add_gpio_range(pmx->pctl, &pmx->range);
+	pinctrl_add_gpio_ranges(pmx->pctl, pmx->ranges, nr_ranges);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 43c858d..dbcaa60 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -111,6 +111,8 @@ struct sh_pfc_soc_info {
 
 	struct sh_pfc_pin *pins;
 	unsigned int nr_pins;
+	const struct pinmux_range *ranges;
+	unsigned int nr_ranges;
 	struct pinmux_func *func_gpios;
 	unsigned int nr_func_gpios;
 
-- 
1.8.1.5

