From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Mar 2013 18:36:01 +0000
Subject: [PATCH 22/23] sh-pfc: Clean up pin configuration type handling
Message-Id: <1362940562-8570-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Set pin configuration type to

- PINMUX_TYPE_NONE at initialization time and when disabling a function
  or freeing a GPIO

- PINMUX_TYPE_FUNCTION when enabling a function

- PINMUX_TYPE_INPUT or PINMUX_TYPE_OUTPUT when setting the GPIO
  direction

Verify that the type is PINMUX_TYPE_NONE when enabling a function or
requesting a GPIO and return -EBUSY if it isn't.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pinctrl.c | 74 +++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 5e88881..cd9b823 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -119,11 +119,22 @@ static int sh_pfc_func_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	spin_lock_irqsave(&pfc->lock, flags);
 
 	for (i = 0; i < grp->nr_pins; ++i) {
+		int idx = sh_pfc_get_pin_index(pfc, grp->pins[i]);
+		struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
+
+		if (cfg->type != PINMUX_TYPE_NONE) {
+			ret = -EBUSY;
+			goto done;
+		}
+	}
+
+	for (i = 0; i < grp->nr_pins; ++i) {
 		ret = sh_pfc_config_mux(pfc, grp->mux[i], PINMUX_TYPE_FUNCTION);
 		if (ret < 0)
 			break;
 	}
 
+done:
 	spin_unlock_irqrestore(&pfc->lock, flags);
 	return ret;
 }
@@ -131,6 +142,22 @@ static int sh_pfc_func_enable(struct pinctrl_dev *pctldev, unsigned selector,
 static void sh_pfc_func_disable(struct pinctrl_dev *pctldev, unsigned selector,
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
+	for (i = 0; i < grp->nr_pins; ++i) {
+		int idx = sh_pfc_get_pin_index(pfc, grp->pins[i]);
+		struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
+
+		cfg->type = PINMUX_TYPE_NONE;
+	}
+
+	spin_unlock_irqrestore(&pfc->lock, flags);
 }
 
 static int sh_pfc_gpio_request_enable(struct pinctrl_dev *pctldev,
@@ -146,21 +173,17 @@ static int sh_pfc_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 	spin_lock_irqsave(&pfc->lock, flags);
 
-	switch (cfg->type) {
-	case PINMUX_TYPE_GPIO:
-	case PINMUX_TYPE_INPUT:
-	case PINMUX_TYPE_OUTPUT:
-		break;
-	case PINMUX_TYPE_FUNCTION:
-	default:
-		pr_err("Unsupported mux type (%d), bailing...\n", cfg->type);
-		ret = -ENOTSUPP;
-		goto err;
+	if (cfg->type != PINMUX_TYPE_NONE) {
+		pr_err("Pin %u is busy, can't configure it as GPIO.\n", offset);
+		ret = -EBUSY;
+		goto done;
 	}
 
+	cfg->type = PINMUX_TYPE_GPIO;
+
 	ret = 0;
 
-err:
+done:
 	spin_unlock_irqrestore(&pfc->lock, flags);
 
 	return ret;
@@ -170,6 +193,15 @@ static void sh_pfc_gpio_disable_free(struct pinctrl_dev *pctldev,
 				     struct pinctrl_gpio_range *range,
 				     unsigned offset)
 {
+	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct sh_pfc *pfc = pmx->pfc;
+	int idx = sh_pfc_get_pin_index(pfc, offset);
+	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
+	unsigned long flags;
+
+	spin_lock_irqsave(&pfc->lock, flags);
+	cfg->type = PINMUX_TYPE_NONE;
+	spin_unlock_irqrestore(&pfc->lock, flags);
 }
 
 static int sh_pfc_gpio_set_direction(struct pinctrl_dev *pctldev,
@@ -180,27 +212,14 @@ static int sh_pfc_gpio_set_direction(struct pinctrl_dev *pctldev,
 	struct sh_pfc *pfc = pmx->pfc;
 	int new_type = input ? PINMUX_TYPE_INPUT : PINMUX_TYPE_OUTPUT;
 	int idx = sh_pfc_get_pin_index(pfc, offset);
-	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
 	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
-	unsigned int mark = pin->enum_id;
+	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&pfc->lock, flags);
 
-	switch (cfg->type) {
-	case PINMUX_TYPE_GPIO:
-	case PINMUX_TYPE_OUTPUT:
-	case PINMUX_TYPE_INPUT:
-	case PINMUX_TYPE_INPUT_PULLUP:
-	case PINMUX_TYPE_INPUT_PULLDOWN:
-		break;
-	default:
-		ret = -EINVAL;
-		goto done;
-	}
-
-	ret = sh_pfc_config_mux(pfc, mark, new_type);
+	ret = sh_pfc_config_mux(pfc, pin->enum_id, new_type);
 	if (ret < 0)
 		goto done;
 
@@ -208,7 +227,6 @@ static int sh_pfc_gpio_set_direction(struct pinctrl_dev *pctldev,
 
 done:
 	spin_unlock_irqrestore(&pfc->lock, flags);
-
 	return ret;
 }
 
@@ -267,7 +285,7 @@ static int sh_pfc_map_pins(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 
 			pin->number = number;
 			pin->name = info->name;
-			cfg->type = PINMUX_TYPE_GPIO;
+			cfg->type = PINMUX_TYPE_NONE;
 		}
 	}
 
-- 
1.8.1.5

