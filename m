From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:53 +0000
Subject: [PATCH v2 04/15] pinctrl: sh-pfc: Add r8a7793 pinmux info
Message-Id: <1430403544-26742-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds the r8a7793 pinmux info to the PFC driver.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[uli: minor reformat to fit mainline, fixed typos, split]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/core.c        |  6 ++++++
 drivers/pinctrl/sh-pfc/core.h        |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7793.c | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 7b2c949..21326de 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -481,6 +481,12 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.data = &r8a7791_pinmux_info,
 	},
 #endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7793
+	{
+		.compatible = "renesas,pfc-r8a7793",
+		.data = &r8a7793_pinmux_info,
+	},
+#endif
 #ifdef CONFIG_PINCTRL_PFC_SH73A0
 	{
 		.compatible = "renesas,pfc-sh73a0",
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 6dc8a6f..b151b77 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -71,6 +71,7 @@ extern const struct sh_pfc_soc_info r8a7778_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7779_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7790_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7791_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7793_pinmux_info;
 extern const struct sh_pfc_soc_info sh7203_pinmux_info;
 extern const struct sh_pfc_soc_info sh7264_pinmux_info;
 extern const struct sh_pfc_soc_info sh7269_pinmux_info;
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7793.c b/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
index 0b23346..5037432 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
@@ -6012,3 +6012,22 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 	{ },
 };
+
+const struct sh_pfc_soc_info r8a7793_pinmux_info = {
+	.name = "r8a77930_pfc",
+	.unlock_reg = 0xe6060000, /* PMMR */
+
+	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
+
+	.pins = pinmux_pins,
+	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.groups = pinmux_groups,
+	.nr_groups = ARRAY_SIZE(pinmux_groups),
+	.functions = pinmux_functions,
+	.nr_functions = ARRAY_SIZE(pinmux_functions),
+
+	.cfg_regs = pinmux_config_regs,
+
+	.gpio_data = pinmux_data,
+	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+};
-- 
2.3.5

