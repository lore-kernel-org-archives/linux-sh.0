From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 15:50:02 +0000
Subject: [PATCH/RFC 1/3] pinctrl: sh-pfc: support sparse GPIO numbers
Message-Id: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Not on all sh-/r-mobile platfotms all pins are numbered contiguously from 0
to N-1. On all ARM-based platforms datasheets use simple numbers to identify
them, unlike some SuperH-based SoC, naming pins, using strings, e.g. A31:A0,
B11:B0, C31:C0, etc. So far the sg-pfc pinctrl driver supported only
contiguous pin numbering. This patch adds support for sparse pin numbers to
support sh73a0 and any other similar SoCs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kzm9g.c         |   30 ++++----
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    2 +
 drivers/pinctrl/sh-pfc/core.h                |    1 +
 drivers/pinctrl/sh-pfc/gpio.c                |    6 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c          |    9 ++
 drivers/pinctrl/sh-pfc/pinctrl.c             |  111 ++++++++++++++++++++++----
 drivers/pinctrl/sh-pfc/sh_pfc.h              |    2 +
 7 files changed, 129 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 949ef36..1b6ed86 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -51,14 +51,14 @@
 /*
  * external GPIO
  */
-#define GPIO_PCF8575_BASE	(GPIO_NR)
-#define GPIO_PCF8575_PORT10	(GPIO_NR + 8)
-#define GPIO_PCF8575_PORT11	(GPIO_NR + 9)
-#define GPIO_PCF8575_PORT12	(GPIO_NR + 10)
-#define GPIO_PCF8575_PORT13	(GPIO_NR + 11)
-#define GPIO_PCF8575_PORT14	(GPIO_NR + 12)
-#define GPIO_PCF8575_PORT15	(GPIO_NR + 13)
-#define GPIO_PCF8575_PORT16	(GPIO_NR + 14)
+#define GPIO_PCF8575_BASE	(SH73A0_MAX_FN)
+#define GPIO_PCF8575_PORT10	(GPIO_PCF8575_BASE + 8)
+#define GPIO_PCF8575_PORT11	(GPIO_PCF8575_BASE + 9)
+#define GPIO_PCF8575_PORT12	(GPIO_PCF8575_BASE + 10)
+#define GPIO_PCF8575_PORT13	(GPIO_PCF8575_BASE + 11)
+#define GPIO_PCF8575_PORT14	(GPIO_PCF8575_BASE + 12)
+#define GPIO_PCF8575_PORT15	(GPIO_PCF8575_BASE + 13)
+#define GPIO_PCF8575_PORT16	(GPIO_PCF8575_BASE + 14)
 
 /* Dummy supplies, where voltage doesn't matter */
 static struct regulator_consumer_supply dummy_supplies[] = {
@@ -434,7 +434,7 @@ static struct sh_mobile_sdhi_info sdhi2_info = {
 			  TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
-	.cd_gpio	= GPIO_PORT13,
+	.cd_gpio	= 13,
 };
 
 static struct resource sdhi2_resources[] = {
@@ -667,14 +667,14 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_CS4_, NULL); /* CS4 */
 
 	/* SMSC */
-	gpio_request_one(GPIO_PORT224, GPIOF_IN, NULL); /* IRQ3 */
+	gpio_request_one(224, GPIOF_IN, NULL); /* IRQ3 */
 
 	/* LCDC */
-	gpio_request_one(GPIO_PORT222, GPIOF_OUT_INIT_HIGH, NULL); /* LCDCDON */
-	gpio_request_one(GPIO_PORT226, GPIOF_OUT_INIT_HIGH, NULL); /* SC */
+	gpio_request_one(222, GPIOF_OUT_INIT_HIGH, NULL); /* LCDCDON */
+	gpio_request_one(226, GPIOF_OUT_INIT_HIGH, NULL); /* SC */
 
 	/* Touchscreen */
-	gpio_request_one(GPIO_PORT223, GPIOF_IN, NULL); /* IRQ8 */
+	gpio_request_one(223, GPIOF_IN, NULL); /* IRQ8 */
 
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0,		NULL);
@@ -698,7 +698,7 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHID0_1,		NULL);
 	gpio_request(GPIO_FN_SDHID0_0,		NULL);
 	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
-	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
+	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	/* enable Micro SD */
 	gpio_request(GPIO_FN_SDHID2_0,		NULL);
@@ -707,7 +707,7 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHID2_3,		NULL);
 	gpio_request(GPIO_FN_SDHICMD2,		NULL);
 	gpio_request(GPIO_FN_SDHICLK2,		NULL);
-	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
+	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	/* enable USB */
 	gpio_request(GPIO_FN_VBUS_0,	NULL);
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index a256372..9c5e728 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -514,4 +514,6 @@ enum {
 
 extern struct smp_operations sh73a0_smp_ops;
 
+#define SH73A0_MAX_FN (309 - GPIO_PORT309 + GPIO_NR)
+
 #endif /* __ASM_SH73A0_H__ */
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 6df12ee..ec94e0f 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -53,6 +53,7 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type,
 		      int cfg_mode);
 int sh_pfc_config_gpio(struct sh_pfc *pfc, unsigned gpio, int pinmux_type,
 		       int cfg_mode);
+int sh_pfc_pin_to_idx(struct sh_pfc_soc_info *info, unsigned int pin);
 
 extern struct sh_pfc_soc_info r8a7740_pinmux_info;
 extern struct sh_pfc_soc_info r8a7779_pinmux_info;
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 5e37124..4b14482 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -50,9 +50,10 @@ static void gpio_pin_free(struct gpio_chip *gc, unsigned offset)
 	return pinctrl_free_gpio(offset);
 }
 
-static void gpio_pin_set_value(struct sh_pfc *pfc, unsigned gpio, int value)
+static void gpio_pin_set_value(struct sh_pfc *pfc, unsigned offset, int value)
 {
 	struct pinmux_data_reg *dr = NULL;
+	unsigned gpio = sh_pfc_pin_to_idx(pfc->info, offset);
 	int bit = 0;
 
 	if (sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
@@ -79,8 +80,9 @@ static int gpio_pin_get(struct gpio_chip *gc, unsigned offset)
 	struct sh_pfc *pfc = gpio_to_pfc(gc);
 	struct pinmux_data_reg *dr = NULL;
 	int bit = 0;
+	unsigned gpio = sh_pfc_pin_to_idx(pfc->info, offset);
 
-	if (sh_pfc_get_data_reg(pfc, gc->base + offset, &dr, &bit) != 0)
+	if (sh_pfc_get_data_reg(pfc, gc->base + gpio, &dr, &bit) != 0)
 		return -EINVAL;
 
 	return sh_pfc_read_bit(dr, bit);
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 9bcb81f..937986c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1766,6 +1766,13 @@ static const unsigned int i2c3_2_mux[] = {
 	PORT115_I2C_SCL3_MARK, PORT116_I2C_SDA3_MARK,
 };
 
+static struct pinmux_range pinmux_ranges[] = {
+	{.begin = 0, .end = 118,},
+	{.begin = 128, .end = 164,},
+	{.begin = 192, .end = 282,},
+	{.begin = 288, .end = 309,},
+};
+
 static const unsigned int lcd_data8_pins[] = {
 	/* D[0:7] */
 	192, 193, 194, 195, 196, 197, 198, 199,
@@ -3508,6 +3515,8 @@ struct sh_pfc_soc_info sh73a0_pinmux_info = {
 
 	.pins = pinmux_pins,
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.ranges = pinmux_ranges,
+	.nr_ranges = ARRAY_SIZE(pinmux_ranges),
 	.groups = pinmux_groups,
 	.nr_groups = ARRAY_SIZE(pinmux_groups),
 	.functions = pinmux_functions,
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 78b78d2..520245f 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -35,6 +35,29 @@ struct sh_pfc_pinctrl {
 	unsigned int nr_pads;
 };
 
+int sh_pfc_pin_to_idx(struct sh_pfc_soc_info *info, unsigned int pin)
+{
+	struct pinmux_range *range;
+	int i, idx;
+
+	if (!info->ranges)
+		return pin;
+
+	for (i = 0, idx = 0, range = info->ranges; i < info->nr_ranges;
+	     i++, range++) {
+		if (range->end >= pin) {
+			if (WARN(pin < range->begin, "Pin %u unmapped!\n", pin))
+				return -EINVAL;
+			pr_debug("%s(): mapped pin %u to %d in range #%d\n",
+				__func__, pin, pin + idx - range->begin, i);
+			return pin + idx - range->begin;
+		}
+		idx += range->end - range->begin + 1;
+	}
+
+	return -EINVAL;
+}
+
 static int sh_pfc_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
@@ -264,7 +287,11 @@ static int sh_pfc_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 	spin_lock_irqsave(&pfc->lock, flags);
 
-	pinmux_type = pfc->info->pins[offset].flags & PINMUX_FLAG_TYPE;
+	ret = sh_pfc_pin_to_idx(pfc->info, offset);
+	if (ret < 0)
+		goto err;
+
+	pinmux_type = pfc->info->pins[ret].flags & PINMUX_FLAG_TYPE;
 
 	switch (pinmux_type) {
 	case PINMUX_TYPE_GPIO:
@@ -293,14 +320,18 @@ static void sh_pfc_gpio_disable_free(struct pinctrl_dev *pctldev,
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 	struct sh_pfc *pfc = pmx->pfc;
 	unsigned long flags;
-	int pinmux_type;
+	int ret, pinmux_type;
 
 	spin_lock_irqsave(&pfc->lock, flags);
 
-	pinmux_type = pfc->info->pins[offset].flags & PINMUX_FLAG_TYPE;
+	ret = sh_pfc_pin_to_idx(pfc->info, offset);
+	if (ret < 0)
+		goto err;
 
-	sh_pfc_config_gpio(pfc, offset, pinmux_type, GPIO_CFG_FREE);
+	pinmux_type = pfc->info->pins[ret].flags & PINMUX_FLAG_TYPE;
 
+	sh_pfc_config_gpio(pfc, ret, pinmux_type, GPIO_CFG_FREE);
+err:
 	spin_unlock_irqrestore(&pfc->lock, flags);
 }
 
@@ -309,9 +340,14 @@ static int sh_pfc_gpio_set_direction(struct pinctrl_dev *pctldev,
 				     unsigned offset, bool input)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
-	int type = input ? PINMUX_TYPE_INPUT : PINMUX_TYPE_OUTPUT;
+	struct sh_pfc *pfc = pmx->pfc;
+	int ret, type = input ? PINMUX_TYPE_INPUT : PINMUX_TYPE_OUTPUT;
 
-	return sh_pfc_reconfig_pin(pmx->pfc, offset, type);
+	ret = sh_pfc_pin_to_idx(pfc->info, offset);
+	if (ret < 0)
+		return ret;
+
+	return sh_pfc_reconfig_pin(pfc, ret, type);
 }
 
 static struct pinmux_ops sh_pfc_pinmux_ops = {
@@ -330,8 +366,11 @@ static int sh_pfc_pinconf_get(struct pinctrl_dev *pctldev, unsigned pin,
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 	struct sh_pfc *pfc = pmx->pfc;
+	int ret = sh_pfc_pin_to_idx(pfc->info, pin);
+	if (ret < 0)
+		return ret;
 
-	*config = pfc->info->pins[pin].flags & PINMUX_FLAG_TYPE;
+	*config = pfc->info->pins[ret].flags & PINMUX_FLAG_TYPE;
 
 	return 0;
 }
@@ -340,12 +379,18 @@ static int sh_pfc_pinconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 			      unsigned long config)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct sh_pfc *pfc = pmx->pfc;
+	int ret;
 
 	/* Validate the new type */
 	if (config >= PINMUX_FLAG_TYPE)
 		return -EINVAL;
 
-	return sh_pfc_reconfig_pin(pmx->pfc, pin, config);
+	ret = sh_pfc_pin_to_idx(pfc->info, pin);
+	if (ret < 0)
+		return ret;
+
+	return sh_pfc_reconfig_pin(pfc, ret, config);
 }
 
 static void sh_pfc_pinconf_dbg_show(struct pinctrl_dev *pctldev,
@@ -389,12 +434,35 @@ static struct pinctrl_desc sh_pfc_pinctrl_desc = {
 	.confops	= &sh_pfc_pinconf_ops,
 };
 
+static int sh_pfc_fill_range(pinmux_enum_t begin, pinmux_enum_t end, pinmux_enum_t *idx,
+			     struct sh_pfc_soc_info *info, struct sh_pfc_pinctrl *pmx)
+{
+	int i, j;
+
+	if (WARN(*idx + end - begin >= pmx->nr_pads, "Invalid range %u..%u\n",
+		 begin, end))
+		return -EINVAL;
+
+	for (i = begin, j = *idx; i <= end; i++, j++) {
+		struct pinctrl_pin_desc *pin = pmx->pads + j;
+		struct sh_pfc_pin *gpio = info->pins + j;
+
+		pin->number = i;
+		pin->name = gpio->name;
+	}
+	*idx = j;
+
+	return 0;
+}
+
 /* pinmux ranges -> pinctrl pin descs */
 static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
+	struct sh_pfc_soc_info *info = pfc->info;
 	int i;
+	pinmux_enum_t idx = 0;
 
-	pmx->nr_pads = pfc->info->nr_pins;
+	pmx->nr_pads = info->nr_pins;
 
 	pmx->pads = devm_kzalloc(pfc->dev, sizeof(*pmx->pads) * pmx->nr_pads,
 				 GFP_KERNEL);
@@ -403,12 +471,19 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < pmx->nr_pads; i++) {
-		struct pinctrl_pin_desc *pin = pmx->pads + i;
-		struct sh_pfc_pin *gpio = pfc->info->pins + i;
-
-		pin->number = i;
-		pin->name = gpio->name;
+	if (!info->ranges) {
+		sh_pfc_fill_range(0, pmx->nr_pads - 1, &idx, info, pmx);
+	} else {
+		struct pinmux_range *range;
+		for (i = 0, range = info->ranges; i < info->nr_ranges;
+		     i++, range++) {
+			int ret = sh_pfc_fill_range(range->begin, range->end,
+						    &idx, info, pmx);
+			pr_debug("%s(): GPIO range #%d from %u to %u @ %d\n",
+				__func__, i, range->begin, range->end, idx);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	sh_pfc_pinctrl_desc.pins = pmx->pads;
@@ -437,6 +512,12 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	if (IS_ERR(pmx->pctl))
 		return PTR_ERR(pmx->pctl);
 
+	/*
+	 * We want both GPIO and pinctrl APIs to act on the same pin numbers:
+	 * whether you call gpio_request() from a driver, or export a GPIO to
+	 * user-space, or provide GPIO bindings in DT, or specify pinctrl groups
+	 * - in all cases you want to use the plain number from the datasheet
+	 */
 	sh_pfc_gpio_range.npins = pfc->info->nr_pins;
 	sh_pfc_gpio_range.base = 0;
 	sh_pfc_gpio_range.pin_base = 0;
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 7cb7bce..7ccfb6c 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -141,6 +141,8 @@ struct sh_pfc_soc_info {
 
 	struct sh_pfc_pin *pins;
 	unsigned int nr_pins;
+	struct pinmux_range *ranges;
+	unsigned int nr_ranges;
 	const struct sh_pfc_pin_group *groups;
 	unsigned int nr_groups;
 	const struct sh_pfc_function *functions;
-- 
1.7.2.5

