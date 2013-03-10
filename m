From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Mar 2013 18:35:59 +0000
Subject: [PATCH 20/23] sh-pfc: Remove pinconf support
Message-Id: <1362940562-8570-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pinconf support isn't properly implemented and isn't used. Remove it for
now.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pinctrl.c | 54 ----------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 28e575c..84aa457 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -230,59 +230,6 @@ static const struct pinmux_ops sh_pfc_pinmux_ops = {
 	.gpio_set_direction	= sh_pfc_gpio_set_direction,
 };
 
-static int sh_pfc_pinconf_get(struct pinctrl_dev *pctldev, unsigned _pin,
-			      unsigned long *config)
-{
-	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
-	struct sh_pfc *pfc = pmx->pfc;
-	int idx = sh_pfc_get_pin_index(pfc, _pin);
-	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
-
-	*config = cfg->type;
-
-	return 0;
-}
-
-static int sh_pfc_pinconf_set(struct pinctrl_dev *pctldev, unsigned pin,
-			      unsigned long config)
-{
-	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
-
-	/* Validate the new type */
-	if (config >= PINMUX_FLAG_TYPE)
-		return -EINVAL;
-
-	return sh_pfc_reconfig_pin(pmx, pin, config);
-}
-
-static void sh_pfc_pinconf_dbg_show(struct pinctrl_dev *pctldev,
-				    struct seq_file *s, unsigned pin)
-{
-	const char *pinmux_type_str[] = {
-		[PINMUX_TYPE_NONE]		= "none",
-		[PINMUX_TYPE_FUNCTION]		= "function",
-		[PINMUX_TYPE_GPIO]		= "gpio",
-		[PINMUX_TYPE_OUTPUT]		= "output",
-		[PINMUX_TYPE_INPUT]		= "input",
-		[PINMUX_TYPE_INPUT_PULLUP]	= "input bias pull up",
-		[PINMUX_TYPE_INPUT_PULLDOWN]	= "input bias pull down",
-	};
-	unsigned long config;
-	int rc;
-
-	rc = sh_pfc_pinconf_get(pctldev, pin, &config);
-	if (unlikely(rc != 0))
-		return;
-
-	seq_printf(s, " %s", pinmux_type_str[config]);
-}
-
-static const struct pinconf_ops sh_pfc_pinconf_ops = {
-	.pin_config_get		= sh_pfc_pinconf_get,
-	.pin_config_set		= sh_pfc_pinconf_set,
-	.pin_config_dbg_show	= sh_pfc_pinconf_dbg_show,
-};
-
 /* PFC ranges -> pinctrl pin descs */
 static int sh_pfc_map_pins(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
@@ -356,7 +303,6 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	pmx->pctl_desc.owner = THIS_MODULE;
 	pmx->pctl_desc.pctlops = &sh_pfc_pinctrl_ops;
 	pmx->pctl_desc.pmxops = &sh_pfc_pinmux_ops;
-	pmx->pctl_desc.confops = &sh_pfc_pinconf_ops;
 	pmx->pctl_desc.pins = pmx->pins;
 	pmx->pctl_desc.npins = pfc->info->nr_pins;
 
-- 
1.8.1.5

