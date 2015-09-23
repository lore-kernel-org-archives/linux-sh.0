From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 23 Sep 2015 13:59:14 +0000
Subject: [PATCH] pinctrl: sh-pfc: Rename .gpio_data[] to .pinmux_data[]
Message-Id: <1443016754-24203-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The sh_pfc_soc_info.gpio_data[] array contains not only GPIO data, but
also various other pinmux-related data (functions and marks).
Every single driver already calls its local array pinmux_data[].
Hence rename the sh_pfc_soc_info member to "pinmux_data".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c        | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-emev2.c   | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 8 ++++----
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 8 ++++----
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7203.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7264.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7269.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7720.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7722.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7723.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7724.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7757.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7785.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7786.c  | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-shx3.c    | 4 ++--
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 6 +++---
 24 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index bcf3017318db3a74..e6a5174d3acb8e62 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -272,7 +272,7 @@ static int sh_pfc_get_config_reg(struct sh_pfc *pfc, u16 enum_id,
 static int sh_pfc_mark_to_enum(struct sh_pfc *pfc, u16 mark, int pos,
 			      u16 *enum_idp)
 {
-	const u16 *data = pfc->info->gpio_data;
+	const u16 *data = pfc->info->pinmux_data;
 	unsigned int k;
 
 	if (pos) {
@@ -280,7 +280,7 @@ static int sh_pfc_mark_to_enum(struct sh_pfc *pfc, u16 mark, int pos,
 		return pos + 1;
 	}
 
-	for (k = 0; k < pfc->info->gpio_data_size; k++) {
+	for (k = 0; k < pfc->info->pinmux_data_size; k++) {
 		if (data[k] = mark) {
 			*enum_idp = data[k + 1];
 			return k + 1;
diff --git a/drivers/pinctrl/sh-pfc/pfc-emev2.c b/drivers/pinctrl/sh-pfc/pfc-emev2.c
index 849c6943ed308ee0..02118ab336fcbd6c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-emev2.c
+++ b/drivers/pinctrl/sh-pfc/pfc-emev2.c
@@ -1706,6 +1706,6 @@ const struct sh_pfc_soc_info emev2_pinmux_info = {
 
 	.cfg_regs	= pinmux_config_regs,
 
-	.gpio_data	= pinmux_data,
-	.gpio_data_size	= ARRAY_SIZE(pinmux_data),
+	.pinmux_data	= pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index d51d5fd77bbdc659..d9d9228b15faf6f3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -2734,11 +2734,11 @@ const struct sh_pfc_soc_info r8a73a4_pinmux_info = {
 	.functions = pinmux_functions,
 	.nr_functions = ARRAY_SIZE(pinmux_functions),
 
-	.cfg_regs	= pinmux_config_regs,
-	.data_regs	= pinmux_data_regs,
+	.cfg_regs = pinmux_config_regs,
+	.data_regs = pinmux_data_regs,
 
-	.gpio_data	= pinmux_data,
-	.gpio_data_size	= ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 
 	.gpio_irq = pinmux_irqs,
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 44223b3df3529b55..279e9dd442e44729 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3774,8 +3774,8 @@ const struct sh_pfc_soc_info r8a7740_pinmux_info = {
 	.cfg_regs	= pinmux_config_regs,
 	.data_regs	= pinmux_data_regs,
 
-	.gpio_data	= pinmux_data,
-	.gpio_data_size	= ARRAY_SIZE(pinmux_data),
+	.pinmux_data	= pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 
 	.gpio_irq	= pinmux_irqs,
 	.gpio_irq_size	= ARRAY_SIZE(pinmux_irqs),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 581d3c44aa4a7c36..6bafdeef28d8a50a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -3140,6 +3140,6 @@ const struct sh_pfc_soc_info r8a7778_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 4be082e6a02efa5c..71fb5e4cf8281129 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -3868,6 +3868,6 @@ const struct sh_pfc_soc_info r8a7779_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 47dfa9745d6056d9..5b9b6e1fae9e81ee 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -5701,6 +5701,6 @@ const struct sh_pfc_soc_info r8a7790_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index a58a0dec6994ad4a..156f88d6af979874 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -6319,8 +6319,8 @@ const struct sh_pfc_soc_info r8a7791_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
 #endif
 
@@ -6340,7 +6340,7 @@ const struct sh_pfc_soc_info r8a7793_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
 #endif
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 185554e150997c73..241cf34e1b0341ef 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -4422,6 +4422,6 @@ const struct sh_pfc_soc_info r8a7794_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index dce06ed0209090c9..4d3337c18657e700 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -2812,6 +2812,6 @@ const struct sh_pfc_soc_info r8a7795_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7203.c b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
index 3bda7bafd0ab5a55..61b27ec48876ece8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7203.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
@@ -1587,6 +1587,6 @@ const struct sh_pfc_soc_info sh7203_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index e1cb6dc050285173..8070765311dbf7a4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -2126,6 +2126,6 @@ const struct sh_pfc_soc_info sh7264_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
index 7a11320ad96d391a..a50d22bef1f44451 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -2830,6 +2830,6 @@ const struct sh_pfc_soc_info sh7269_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index bec265245ad9d33f..6a69c8c5d9433d7e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3865,8 +3865,8 @@ const struct sh_pfc_soc_info sh73a0_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 
 	.gpio_irq = pinmux_irqs,
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7720.c b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
index 13d05f88bc01c78d..e07a82df42c83a8f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7720.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
@@ -1201,6 +1201,6 @@ const struct sh_pfc_soc_info sh7720_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7722.c b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
index 914d872c37a40a21..29c69133b0ef88d0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7722.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
@@ -1741,6 +1741,6 @@ const struct sh_pfc_soc_info sh7722_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7723.c b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
index 4eb7eae2e6d04065..8ea18df034927948 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7723.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
@@ -1893,6 +1893,6 @@ const struct sh_pfc_soc_info sh7723_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7724.c b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
index 74a1a7f1317c7ce0..7f6c36c1a8fa8db5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7724.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
@@ -2175,6 +2175,6 @@ const struct sh_pfc_soc_info sh7724_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 59158a75e45a9fb5..e7deb51de7dc4fd4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2445,6 +2445,6 @@ const struct sh_pfc_soc_info sh7734_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7757.c b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
index 625661a88c527039..0555a1fe076ed353 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7757.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
@@ -2238,6 +2238,6 @@ const struct sh_pfc_soc_info sh7757_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7785.c b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
index b38dd7e3e375806c..1934cbec39651cb7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7785.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
@@ -1269,6 +1269,6 @@ const struct sh_pfc_soc_info sh7785_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7786.c b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
index 6cb4e0aaf20b0217..c98585d80de8df4e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7786.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
@@ -813,6 +813,6 @@ const struct sh_pfc_soc_info sh7786_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.data_regs = pinmux_data_regs,
 
-	.gpio_data = pinmux_data,
-	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-shx3.c b/drivers/pinctrl/sh-pfc/pfc-shx3.c
index a3fcb2284d911174..3f60c900645eebd5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-shx3.c
+++ b/drivers/pinctrl/sh-pfc/pfc-shx3.c
@@ -554,8 +554,8 @@ const struct sh_pfc_soc_info shx3_pinmux_info = {
 	.nr_pins	= ARRAY_SIZE(pinmux_pins),
 	.func_gpios	= pinmux_func_gpios,
 	.nr_func_gpios	= ARRAY_SIZE(pinmux_func_gpios),
-	.gpio_data	= pinmux_data,
-	.gpio_data_size	= ARRAY_SIZE(pinmux_data),
+	.pinmux_data	= pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 	.cfg_regs	= pinmux_config_regs,
 	.data_regs	= pinmux_data_regs,
 };
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 12bfb706845e7047..e18e306b4ac276c7 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -163,8 +163,8 @@ struct sh_pfc_soc_info {
 	const struct pinmux_cfg_reg *cfg_regs;
 	const struct pinmux_data_reg *data_regs;
 
-	const u16 *gpio_data;
-	unsigned int gpio_data_size;
+	const u16 *pinmux_data;
+	unsigned int pinmux_data_size;
 
 	const struct pinmux_irq *gpio_irq;
 	unsigned int gpio_irq_size;
@@ -177,7 +177,7 @@ struct sh_pfc_soc_info {
  */
 
 /*
- * sh_pfc_soc_info gpio_data array macros
+ * sh_pfc_soc_info pinmux_data array macros
  */
 
 #define PINMUX_DATA(data_or_mark, ids...)	data_or_mark, ids, 0
-- 
1.9.1

