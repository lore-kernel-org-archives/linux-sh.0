From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 03 Jan 2013 18:17:47 +0000
Subject: [PATCH 16/22] sh-pfc: Expose real groups and functions in pinctrl/pinmux operations
Message-Id: <1357237073-15600-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh-pfc driver exposes one fake group and function per GPIO pin. As
the pinctrl and pinmux APIs are not used by any SuperH and SH Mobile
board or driver, drop the fake groups and functions and replace them by
a real pinctrl and pinmux implementation.

Groups and functions must now be explicitly provided by PFC SoC-specific
data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c    |   49 ++++++++++++------
 drivers/pinctrl/sh-pfc/core.h    |    2 +
 drivers/pinctrl/sh-pfc/pinctrl.c |  100 ++++++++++++++++++++------------------
 drivers/pinctrl/sh-pfc/sh_pfc.h  |   35 +++++++++++++
 4 files changed, 121 insertions(+), 65 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 6ec06c5..912b579 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -350,41 +350,44 @@ static int sh_pfc_get_config_reg(struct sh_pfc *pfc, pinmux_enum_t enum_id,
 	return -1;
 }
 
-static int sh_pfc_gpio_to_enum(struct sh_pfc *pfc, unsigned gpio, int pos,
-			       pinmux_enum_t *enum_idp)
+static pinmux_enum_t sh_pfc_gpio_to_mark(struct sh_pfc *pfc, unsigned gpio)
 {
-	pinmux_enum_t *data = pfc->info->gpio_data;
-	pinmux_enum_t enum_id;
-	int k;
+	if (sh_pfc_gpio_is_pin(pfc, gpio))
+		return pfc->info->pins[gpio].enum_id;
 
-	if (sh_pfc_gpio_is_pin(pfc, gpio)) {
-		enum_id = pfc->info->pins[gpio].enum_id;
-	} else if (sh_pfc_gpio_is_function(pfc, gpio)) {
+	if (sh_pfc_gpio_is_function(pfc, gpio)) {
 		unsigned int offset = gpio - pfc->info->nr_pins;
-		enum_id = pfc->info->func_gpios[offset].enum_id;
-	} else {
-		pr_err("non data/mark enum_id for gpio %d\n", gpio);
-		return -1;
+		return pfc->info->func_gpios[offset].enum_id;
 	}
 
+	pr_err("non data/mark enum_id for gpio %d\n", gpio);
+	return SH_PFC_MARK_INVALID;
+}
+
+static int sh_pfc_mark_to_enum(struct sh_pfc *pfc, pinmux_enum_t mark, int pos,
+			      pinmux_enum_t *enum_idp)
+{
+	pinmux_enum_t *data = pfc->info->gpio_data;
+	int k;
+
 	if (pos) {
 		*enum_idp = data[pos + 1];
 		return pos + 1;
 	}
 
 	for (k = 0; k < pfc->info->gpio_data_size; k++) {
-		if (data[k] = enum_id) {
+		if (data[k] = mark) {
 			*enum_idp = data[k + 1];
 			return k + 1;
 		}
 	}
 
-	pr_err("cannot locate data/mark enum_id for gpio %d\n", gpio);
+	pr_err("cannot locate data/mark enum_id for mark %d\n", mark);
 	return -1;
 }
 
-int sh_pfc_config_gpio(struct sh_pfc *pfc, unsigned gpio, int pinmux_type,
-		       int cfg_mode)
+int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type,
+		      int cfg_mode)
 {
 	struct pinmux_cfg_reg *cr = NULL;
 	pinmux_enum_t enum_id;
@@ -423,7 +426,7 @@ int sh_pfc_config_gpio(struct sh_pfc *pfc, unsigned gpio, int pinmux_type,
 	field = 0;
 	value = 0;
 	while (1) {
-		pos = sh_pfc_gpio_to_enum(pfc, gpio, pos, &enum_id);
+		pos = sh_pfc_mark_to_enum(pfc, mark, pos, &enum_id);
 		if (pos <= 0)
 			goto out_err;
 
@@ -495,6 +498,18 @@ int sh_pfc_config_gpio(struct sh_pfc *pfc, unsigned gpio, int pinmux_type,
 	return -1;
 }
 
+int sh_pfc_config_gpio(struct sh_pfc *pfc, unsigned gpio, int pinmux_type,
+		       int cfg_mode)
+{
+	pinmux_enum_t mark;
+
+	mark = sh_pfc_gpio_to_mark(pfc, gpio);
+	if (mark = SH_PFC_MARK_INVALID)
+		return -1;
+
+	return sh_pfc_config_mux(pfc, mark, pinmux_type, cfg_mode);
+}
+
 static int sh_pfc_probe(struct platform_device *pdev)
 {
 	struct sh_pfc_soc_info *info;
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index f22d03f..6df12ee 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -49,6 +49,8 @@ void sh_pfc_write_bit(struct pinmux_data_reg *dr, unsigned long in_pos,
 		      unsigned long value);
 int sh_pfc_get_data_reg(struct sh_pfc *pfc, unsigned gpio,
 			struct pinmux_data_reg **drp, int *bitp);
+int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type,
+		      int cfg_mode);
 int sh_pfc_config_gpio(struct sh_pfc *pfc, unsigned gpio, int pinmux_type,
 		       int cfg_mode);
 
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 56f3791..6ee4105 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -29,9 +29,6 @@ struct sh_pfc_pinctrl {
 	struct pinctrl_dev *pctl;
 	struct sh_pfc *pfc;
 
-	struct pinmux_func **functions;
-	unsigned int nr_functions;
-
 	struct pinctrl_pin_desc *pads;
 	unsigned int nr_pads;
 };
@@ -40,7 +37,7 @@ static int sh_pfc_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pmx->nr_pads;
+	return pmx->pfc->info->nr_groups;
 }
 
 static const char *sh_pfc_get_group_name(struct pinctrl_dev *pctldev,
@@ -48,16 +45,16 @@ static const char *sh_pfc_get_group_name(struct pinctrl_dev *pctldev,
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pmx->pads[selector].name;
+	return pmx->pfc->info->groups[selector].name;
 }
 
-static int sh_pfc_get_group_pins(struct pinctrl_dev *pctldev, unsigned group,
+static int sh_pfc_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
 				 const unsigned **pins, unsigned *num_pins)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins = &pmx->pads[group].number;
-	*num_pins = 1;
+	*pins = pmx->pfc->info->groups[selector].pins;
+	*num_pins = pmx->pfc->info->groups[selector].nr_pins;
 
 	return 0;
 }
@@ -79,7 +76,7 @@ static int sh_pfc_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pmx->nr_functions;
+	return pmx->pfc->info->nr_functions;
 }
 
 static const char *sh_pfc_get_function_name(struct pinctrl_dev *pctldev,
@@ -87,30 +84,67 @@ static const char *sh_pfc_get_function_name(struct pinctrl_dev *pctldev,
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pmx->functions[selector]->name;
+	return pmx->pfc->info->functions[selector].name;
 }
 
-static int sh_pfc_get_function_groups(struct pinctrl_dev *pctldev, unsigned func,
+static int sh_pfc_get_function_groups(struct pinctrl_dev *pctldev,
+				      unsigned selector,
 				      const char * const **groups,
 				      unsigned * const num_groups)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups = &pmx->functions[func]->name;
-	*num_groups = 1;
+	*groups = pmx->pfc->info->functions[selector].groups;
+	*num_groups = pmx->pfc->info->functions[selector].nr_groups;
 
 	return 0;
 }
 
-static int sh_pfc_noop_enable(struct pinctrl_dev *pctldev, unsigned func,
+static int sh_pfc_func_enable(struct pinctrl_dev *pctldev, unsigned selector,
 			      unsigned group)
 {
-	return 0;
+	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct sh_pfc *pfc = pmx->pfc;
+	const struct sh_pfc_pin_group *grp = &pfc->info->groups[group];
+	unsigned long flags;
+	unsigned int i;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&pfc->lock, flags);
+
+	for (i = 0; i < grp->nr_pins; ++i) {
+		if (sh_pfc_config_mux(pfc, grp->mux[i], PINMUX_TYPE_FUNCTION,
+				      GPIO_CFG_DRYRUN))
+			goto done;
+
+		if (sh_pfc_config_mux(pfc, grp->mux[i], PINMUX_TYPE_FUNCTION,
+				      GPIO_CFG_REQ))
+			goto done;
+	}
+
+	ret = 0;
+
+done:
+	spin_unlock_irqrestore(&pfc->lock, flags);
+	return ret;
 }
 
-static void sh_pfc_noop_disable(struct pinctrl_dev *pctldev, unsigned func,
+static void sh_pfc_func_disable(struct pinctrl_dev *pctldev, unsigned selector,
 				unsigned group)
 {
+	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct sh_pfc *pfc = pmx->pfc;
+	const struct sh_pfc_pin_group *grp = &pfc->info->groups[group];
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&pfc->lock, flags);
+
+	for (i = 0; i < grp->nr_pins; ++i)
+		sh_pfc_config_mux(pfc, grp->mux[i], PINMUX_TYPE_FUNCTION,
+				  GPIO_CFG_FREE);
+
+	spin_unlock_irqrestore(&pfc->lock, flags);
 }
 
 static int sh_pfc_reconfig_pin(struct sh_pfc *pfc, unsigned offset,
@@ -230,8 +264,8 @@ static struct pinmux_ops sh_pfc_pinmux_ops = {
 	.get_functions_count	= sh_pfc_get_functions_count,
 	.get_function_name	= sh_pfc_get_function_name,
 	.get_function_groups	= sh_pfc_get_function_groups,
-	.enable			= sh_pfc_noop_enable,
-	.disable		= sh_pfc_noop_disable,
+	.enable			= sh_pfc_func_enable,
+	.disable		= sh_pfc_func_disable,
 	.gpio_request_enable	= sh_pfc_gpio_request_enable,
 	.gpio_disable_free	= sh_pfc_gpio_disable_free,
 	.gpio_set_direction	= sh_pfc_gpio_set_direction,
@@ -329,32 +363,6 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 	return 0;
 }
 
-static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
-{
-	int i, fn;
-
-	for (i = 0; i < pfc->info->nr_func_gpios; i++) {
-		struct pinmux_func *func = pfc->info->func_gpios + i;
-
-		if (func->enum_id)
-			pmx->nr_functions++;
-	}
-
-	pmx->functions = devm_kzalloc(pfc->dev, pmx->nr_functions *
-				      sizeof(*pmx->functions), GFP_KERNEL);
-	if (unlikely(!pmx->functions))
-		return -ENOMEM;
-
-	for (i = fn = 0; i < pfc->info->nr_func_gpios; i++) {
-		struct pinmux_func *func = pfc->info->func_gpios + i;
-
-		if (func->enum_id)
-			pmx->functions[fn++] = func;
-	}
-
-	return 0;
-}
-
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 {
 	struct sh_pfc_pinctrl *pmx;
@@ -371,10 +379,6 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	if (unlikely(ret != 0))
 		return ret;
 
-	ret = sh_pfc_map_functions(pfc, pmx);
-	if (unlikely(ret != 0))
-		return ret;
-
 	pmx->pctl = pinctrl_register(&sh_pfc_pinctrl_desc, pfc->dev, pmx);
 	if (IS_ERR(pmx->pctl))
 		return PTR_ERR(pmx->pctl);
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index f9d4480..7cb7bce 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -16,6 +16,8 @@
 
 typedef unsigned short pinmux_enum_t;
 
+#define SH_PFC_MARK_INVALID	((pinmux_enum_t)-1)
+
 enum {
 	PINMUX_TYPE_NONE,
 
@@ -40,6 +42,34 @@ struct sh_pfc_pin {
 	const char *name;
 };
 
+#define SH_PFC_PIN_GROUP(n)				\
+	{						\
+		.name = #n,				\
+		.pins = n##_pins,			\
+		.mux = n##_mux,				\
+		.nr_pins = ARRAY_SIZE(n##_pins),	\
+	}
+
+struct sh_pfc_pin_group {
+	const char *name;
+	const unsigned int *pins;
+	const unsigned int *mux;
+	unsigned int nr_pins;
+};
+
+#define SH_PFC_FUNCTION(n)				\
+	{						\
+		.name = #n,				\
+		.groups = n##_groups,			\
+		.nr_groups = ARRAY_SIZE(n##_groups),	\
+	}
+
+struct sh_pfc_function {
+	const char *name;
+	const char * const *groups;
+	unsigned int nr_groups;
+};
+
 struct pinmux_func {
 	const pinmux_enum_t enum_id;
 	const char *name;
@@ -111,6 +141,11 @@ struct sh_pfc_soc_info {
 
 	struct sh_pfc_pin *pins;
 	unsigned int nr_pins;
+	const struct sh_pfc_pin_group *groups;
+	unsigned int nr_groups;
+	const struct sh_pfc_function *functions;
+	unsigned int nr_functions;
+
 	struct pinmux_func *func_gpios;
 	unsigned int nr_func_gpios;
 
-- 
1.7.8.6

