From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Sep 2014 13:33:19 +0000
Subject: [PATCH] pinctrl: sh-pfc: sh73a0: Remove unnecessary SoC data allocation
Message-Id: <1410355999-13266-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

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
 
-- 
Regards,

Laurent Pinchart

