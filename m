From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 03 Jan 2013 18:17:36 +0000
Subject: [PATCH 05/22] sh-pfc: Replace first_gpio and last_gpio with nr_gpios
Message-Id: <1357237073-15600-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SoC information first_gpio field is always equal to 0, and the
last_gpio field is the index of the last entry in the pinmux_gpios
array. Replace the first_gpio and last_gpio fields by a nr_gpios field,
and initialize it to ARRAY_SIZE(pinmux_gpios).

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c        |    2 +-
 drivers/pinctrl/sh-pfc/gpio.c        |   11 ++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7203.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7264.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7269.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7720.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7722.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7723.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7724.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7757.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7785.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7786.c  |    5 ++---
 drivers/pinctrl/sh-pfc/pfc-shx3.c    |    3 +--
 drivers/pinctrl/sh-pfc/pinctrl.c     |   17 +++++------------
 drivers/pinctrl/sh-pfc/sh_pfc.h      |    4 ++--
 20 files changed, 43 insertions(+), 69 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index d323c24f..fbf51c8 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -260,7 +260,7 @@ static void sh_pfc_setup_data_regs(struct sh_pfc *pfc)
 	struct pinmux_data_reg *drp;
 	int k;
 
-	for (k = pfc->info->first_gpio; k <= pfc->info->last_gpio; k++)
+	for (k = 0; k < pfc->info->nr_gpios; k++)
 		sh_pfc_setup_data_reg(pfc, k);
 
 	k = 0;
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index a535075..f46f069 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -130,12 +130,10 @@ static void sh_pfc_gpio_setup(struct sh_pfc_chip *chip)
 	gc->set = sh_gpio_set;
 	gc->to_irq = sh_gpio_to_irq;
 
-	WARN_ON(pfc->info->first_gpio != 0); /* needs testing */
-
 	gc->label = pfc->info->name;
 	gc->owner = THIS_MODULE;
-	gc->base = pfc->info->first_gpio;
-	gc->ngpio = (pfc->info->last_gpio - pfc->info->first_gpio) + 1;
+	gc->base = 0;
+	gc->ngpio = pfc->info->nr_gpios;
 }
 
 int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
@@ -157,9 +155,8 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 
 	pfc->gpio = chip;
 
-	pr_info("%s handling gpio %d -> %d\n",
-		pfc->info->name, pfc->info->first_gpio,
-		pfc->info->last_gpio);
+	pr_info("%s handling gpio 0 -> %u\n",
+		pfc->info->name, pfc->info->nr_gpios - 1);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 214788c..c189a86 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2597,10 +2597,9 @@ struct sh_pfc_soc_info r8a7740_pinmux_info = {
 	.function	= { PINMUX_FUNCTION_BEGIN,
 			    PINMUX_FUNCTION_END },
 
-	.first_gpio	= GPIO_PORT0,
-	.last_gpio	= GPIO_FN_TRACEAUD_FROM_MEMC,
-
 	.gpios		= pinmux_gpios,
+	.nr_gpios	= ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs	= pinmux_config_regs,
 	.data_regs	= pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 13feaa0..16ec97a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2612,10 +2612,9 @@ struct sh_pfc_soc_info r8a7779_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_GP_0_0,
-	.last_gpio = GPIO_FN_SCK4_B,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7203.c b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
index b302cce..8a9678e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7203.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
@@ -1580,10 +1580,9 @@ struct sh_pfc_soc_info sh7203_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PA7,
-	.last_gpio = GPIO_FN_LCD_DATA0,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index 1c4f638..e0bdd29 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -2119,10 +2119,9 @@ struct sh_pfc_soc_info sh7264_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PA3,
-	.last_gpio = GPIO_FN_LCD_M_DISP,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
index b406ed6..3466c21 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -2822,10 +2822,9 @@ struct sh_pfc_soc_info sh7269_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PA1,
-	.last_gpio = GPIO_FN_LCD_M_DISP,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index d44e7f0..332cf34 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -1643,10 +1643,9 @@ struct sh_pfc_soc_info sh7372_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PORT0,
-	.last_gpio = GPIO_FN_SDENC_DV_CLKI,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 709008e..004e6b5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2783,10 +2783,9 @@ struct sh_pfc_soc_info sh73a0_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PORT0,
-	.last_gpio = GPIO_FN_FSIAISLD_PU,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7720.c b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
index cfa8dc1..3e7eed0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7720.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
@@ -1223,10 +1223,9 @@ struct sh_pfc_soc_info sh7720_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PTA7,
-	.last_gpio = GPIO_FN_STATUS1,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7722.c b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
index 1354bdd..6df9809 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7722.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
@@ -1767,10 +1767,9 @@ struct sh_pfc_soc_info sh7722_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PTA7,
-	.last_gpio = GPIO_FN_KEYOUT5_IN5,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7723.c b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
index 7570010..2d068bb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7723.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
@@ -1891,10 +1891,9 @@ struct sh_pfc_soc_info sh7723_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PTA7,
-	.last_gpio = GPIO_FN_IDEA0,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7724.c b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
index 4bc2d9a..24fd6a9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7724.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
@@ -2213,10 +2213,9 @@ struct sh_pfc_soc_info sh7724_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PTA7,
-	.last_gpio = GPIO_FN_INTC_IRQ0,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 23d76d2..d67a572 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2463,10 +2463,9 @@ struct sh_pfc_soc_info sh7734_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_GP_0_0,
-	.last_gpio = GPIO_FN_ST_CLKOUT,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7757.c b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
index e525593..391edf1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7757.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
@@ -2270,10 +2270,9 @@ struct sh_pfc_soc_info sh7757_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PTA0,
-	.last_gpio = GPIO_FN_ON_DQ0,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7785.c b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
index 23a17f9..89da4ee 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7785.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
@@ -1292,10 +1292,9 @@ struct sh_pfc_soc_info sh7785_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PA7,
-	.last_gpio = GPIO_FN_IRQOUT,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7786.c b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
index 8269f5d..82dbc8c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7786.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
@@ -825,10 +825,9 @@ struct sh_pfc_soc_info sh7786_pinmux_info = {
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
-	.first_gpio = GPIO_PA7,
-	.last_gpio = GPIO_FN_IRL4,
-
 	.gpios = pinmux_gpios,
+	.nr_gpios = ARRAY_SIZE(pinmux_gpios),
+
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-shx3.c b/drivers/pinctrl/sh-pfc/pfc-shx3.c
index 78b2b9d..8c97a72f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-shx3.c
+++ b/drivers/pinctrl/sh-pfc/pfc-shx3.c
@@ -572,9 +572,8 @@ struct sh_pfc_soc_info shx3_pinmux_info = {
 	.output		= { PINMUX_OUTPUT_BEGIN,   PINMUX_OUTPUT_END },
 	.mark		= { PINMUX_MARK_BEGIN,     PINMUX_MARK_END },
 	.function	= { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
-	.first_gpio	= GPIO_PA7,
-	.last_gpio	= GPIO_FN_STATUS0,
 	.gpios		= shx3_pinmux_gpios,
+	.nr_gpios	= ARRAY_SIZE(shx3_pinmux_gpios),
 	.gpio_data	= shx3_pinmux_data,
 	.gpio_data_size	= ARRAY_SIZE(shx3_pinmux_data),
 	.cfg_regs	= shx3_pinmux_config_regs,
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 67d576c..33ac4f7 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -346,7 +346,7 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
 	int i;
 
-	pmx->nr_pads = pfc->info->last_gpio - pfc->info->first_gpio + 1;
+	pmx->nr_pads = pfc->info->nr_gpios;
 
 	pmx->pads = devm_kzalloc(pfc->dev, sizeof(*pmx->pads) * pmx->nr_pads,
 				 GFP_KERNEL);
@@ -355,17 +355,11 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 		return -ENOMEM;
 	}
 
-	/*
-	 * We don't necessarily have a 1:1 mapping between pin and linux
-	 * GPIO number, as the latter maps to the associated enum_id.
-	 * Care needs to be taken to translate back to pin space when
-	 * dealing with any pin configurations.
-	 */
 	for (i = 0; i < pmx->nr_pads; i++) {
 		struct pinctrl_pin_desc *pin = pmx->pads + i;
 		struct pinmux_gpio *gpio = pfc->info->gpios + i;
 
-		pin->number = pfc->info->first_gpio + i;
+		pin->number = i;
 		pin->name = gpio->name;
 
 		/* XXX */
@@ -424,10 +418,9 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	if (IS_ERR(pmx->pctl))
 		return PTR_ERR(pmx->pctl);
 
-	sh_pfc_gpio_range.npins = pfc->info->last_gpio
-				- pfc->info->first_gpio + 1;
-	sh_pfc_gpio_range.base = pfc->info->first_gpio;
-	sh_pfc_gpio_range.pin_base = pfc->info->first_gpio;
+	sh_pfc_gpio_range.npins = pfc->info->nr_gpios;
+	sh_pfc_gpio_range.base = 0;
+	sh_pfc_gpio_range.pin_base = 0;
 
 	pinctrl_add_gpio_range(pmx->pctl, &sh_pfc_gpio_range);
 
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 13049c4..67fe91b 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -99,9 +99,9 @@ struct sh_pfc_soc_info {
 	struct pinmux_range mark;
 	struct pinmux_range function;
 
-	unsigned first_gpio, last_gpio;
-
 	struct pinmux_gpio *gpios;
+	unsigned int nr_gpios;
+
 	struct pinmux_cfg_reg *cfg_regs;
 	struct pinmux_data_reg *data_regs;
 
-- 
1.7.8.6

