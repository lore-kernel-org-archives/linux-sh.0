From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Sep 2014 21:55:55 +0000
Subject: [PATCH v2] pinctrl: sh-pfc: sh73a0: Remove unnecessary SoC data allocation
Message-Id: <1410386155-3896-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SoC data structure allocated at init time only holds a regulator
pointer that is only used in the init function. Replace it with a local
variable and get rid of the SoC data structure allocation altogether.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c       | 10 +---------
 drivers/pinctrl/sh-pfc/core.h       |  1 -
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 19 ++++---------------
 drivers/pinctrl/sh-pfc/sh_pfc.h     |  1 -
 4 files changed, 5 insertions(+), 26 deletions(-)

Changes since v1:

- Remove the unused sh_pfc soc_data field and sh_pfc_soc_operations exit
  field.

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index ded027a..2e3fe0b 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -548,7 +548,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	 */
 	ret = sh_pfc_register_pinctrl(pfc);
 	if (unlikely(ret != 0))
-		goto error;
+		return ret;
 
 #ifdef CONFIG_GPIO_SH_PFC
 	/*
@@ -570,11 +570,6 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	dev_info(pfc->dev, "%s support registered\n", info->name);
 
 	return 0;
-
-error:
-	if (info->ops && info->ops->exit)
-		info->ops->exit(pfc);
-	return ret;
 }
 
 static int sh_pfc_remove(struct platform_device *pdev)
@@ -586,9 +581,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
 #endif
 	sh_pfc_unregister_pinctrl(pfc);
 
-	if (pfc->info->ops && pfc->info->ops->exit)
-		pfc->info->ops->exit(pfc);
-
 	return 0;
 }
 
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 55f2323..69e1047 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -33,7 +33,6 @@ struct sh_pfc_pin_range {
 struct sh_pfc {
 	struct device *dev;
 	const struct sh_pfc_soc_info *info;
-	void *soc_data;
 	spinlock_t lock;
 
 	unsigned int num_windows;
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 0bd8f44..43d7673 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3824,35 +3824,24 @@ static void sh73a0_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
  * SoC information
  */
 
-struct sh73a0_pinmux_data {
-	struct regulator_dev *vccq_mc0;
-};
-
 static int sh73a0_pinmux_soc_init(struct sh_pfc *pfc)
 {
-	struct sh73a0_pinmux_data *data;
 	struct regulator_config cfg = { };
+	struct regulator_dev *vccq;
 	int ret;
 
-	data = devm_kzalloc(pfc->dev, sizeof(*data), GFP_KERNEL);
-	if (data = NULL)
-		return -ENOMEM;
-
 	cfg.dev = pfc->dev;
 	cfg.init_data = &sh73a0_vccq_mc0_init_data;
 	cfg.driver_data = pfc;
 
-	data->vccq_mc0 = devm_regulator_register(pfc->dev,
-						 &sh73a0_vccq_mc0_desc, &cfg);
-	if (IS_ERR(data->vccq_mc0)) {
-		ret = PTR_ERR(data->vccq_mc0);
+	vccq = devm_regulator_register(pfc->dev, &sh73a0_vccq_mc0_desc, &cfg);
+	if (IS_ERR(vccq)) {
+		ret = PTR_ERR(vccq);
 		dev_err(pfc->dev, "Failed to register VCCQ MC0 regulator: %d\n",
 			ret);
 		return ret;
 	}
 
-	pfc->soc_data = data;
-
 	return 0;
 }
 
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 1eac070..126009d 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -116,7 +116,6 @@ struct sh_pfc;
 
 struct sh_pfc_soc_operations {
 	int (*init)(struct sh_pfc *pfc);
-	void (*exit)(struct sh_pfc *pfc);
 	unsigned int (*get_bias)(struct sh_pfc *pfc, unsigned int pin);
 	void (*set_bias)(struct sh_pfc *pfc, unsigned int pin,
 			 unsigned int bias);
-- 
1.8.5.5

