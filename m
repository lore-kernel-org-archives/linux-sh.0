From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 12:52:23 +0000
Subject: [PATCH v3 02/29] sh-pfc: Declare operation structures as const
Message-Id: <1362574370-17889-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The pinconf, pinctrl and pinmux operation structures hold function
pointers that are never modified. Declare them as const.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pinctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 11e0e13..887930e 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -70,7 +70,7 @@ static void sh_pfc_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	seq_printf(s, "%s", DRV_NAME);
 }
 
-static struct pinctrl_ops sh_pfc_pinctrl_ops = {
+static const struct pinctrl_ops sh_pfc_pinctrl_ops = {
 	.get_groups_count	= sh_pfc_get_groups_count,
 	.get_group_name		= sh_pfc_get_group_name,
 	.get_group_pins		= sh_pfc_get_group_pins,
@@ -252,7 +252,7 @@ static int sh_pfc_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return sh_pfc_reconfig_pin(pmx->pfc, offset, type);
 }
 
-static struct pinmux_ops sh_pfc_pinmux_ops = {
+static const struct pinmux_ops sh_pfc_pinmux_ops = {
 	.get_functions_count	= sh_pfc_get_functions_count,
 	.get_function_name	= sh_pfc_get_function_name,
 	.get_function_groups	= sh_pfc_get_function_groups,
@@ -308,7 +308,7 @@ static void sh_pfc_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 	seq_printf(s, " %s", pinmux_type_str[config]);
 }
 
-static struct pinconf_ops sh_pfc_pinconf_ops = {
+static const struct pinconf_ops sh_pfc_pinconf_ops = {
 	.pin_config_get		= sh_pfc_pinconf_get,
 	.pin_config_set		= sh_pfc_pinconf_set,
 	.pin_config_dbg_show	= sh_pfc_pinconf_dbg_show,
-- 
1.8.1.5

