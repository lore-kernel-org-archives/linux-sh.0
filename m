From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:39:44 +0000
Subject: [PATCH 25/25] sh-pfc: Return an error if a pin doesn't support the requested direction
Message-Id: <1363214384-3870-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When setting a pin direction verify that the requested direction is
supported, and return an error if it isn't.

This requires pin configuration information to be supplied by SoC data.
The check is a no-op if the information is not supplied.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pinctrl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 52179bb..aef268b 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -218,8 +218,18 @@ static int sh_pfc_gpio_set_direction(struct pinctrl_dev *pctldev,
 	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
 	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
 	unsigned long flags;
+	unsigned int dir;
 	int ret;
 
+	/* Check if the requested direction is supported by the pin. Not all SoC
+	 * provide pin config data, so perform the check conditionally.
+	 */
+	if (pin->configs) {
+		dir = input ? SH_PFC_PIN_CFG_INPUT : SH_PFC_PIN_CFG_OUTPUT;
+		if (!(pin->configs & dir))
+			return -EINVAL;
+	}
+
 	spin_lock_irqsave(&pfc->lock, flags);
 
 	ret = sh_pfc_config_mux(pfc, pin->enum_id, new_type);
-- 
1.8.1.5

