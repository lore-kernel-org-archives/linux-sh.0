From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 07 May 2015 16:10:34 +0000
Subject: [PATCH 1/4] pinctrl: sh-pfc: Add r8a7793 support
Message-Id: <1431015037-25254-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Regarding pin control, r8a7791 and r8a7793 are identical, so it is
sufficient to add an sh_pfc_soc_info structure to enable r8a7793 support.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/core.c        |  6 ++++++
 drivers/pinctrl/sh-pfc/core.h        |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 23 +++++++++++++++++++++++
 3 files changed, 30 insertions(+)

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
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index fdd2c87..cbf8ec3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -6181,6 +6181,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A7791
 const struct sh_pfc_soc_info r8a7791_pinmux_info = {
 	.name = "r8a77910_pfc",
 	.unlock_reg = 0xe6060000, /* PMMR */
@@ -6199,3 +6200,25 @@ const struct sh_pfc_soc_info r8a7791_pinmux_info = {
 	.gpio_data = pinmux_data,
 	.gpio_data_size = ARRAY_SIZE(pinmux_data),
 };
+#endif
+
+#ifdef CONFIG_PINCTRL_PFC_R8A7793
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
+#endif
-- 
2.3.5

