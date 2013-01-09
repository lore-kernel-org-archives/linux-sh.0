From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 09 Jan 2013 00:52:30 +0000
Subject: [PATCH v2 10/29] sh-pfc: Remove unused sh_pfc_soc_info reserved_id field
Message-Id: <1357692769-1432-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The field is unused, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |    1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7203.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7264.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7269.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7720.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7722.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7723.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7724.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7757.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7785.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7786.c  |    1 -
 drivers/pinctrl/sh-pfc/pfc-shx3.c    |    1 -
 drivers/pinctrl/sh-pfc/sh_pfc.h      |    1 -
 17 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index f1ef9f7..957502e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2581,7 +2581,6 @@ static struct pinmux_irq pinmux_irqs[] = {
 
 struct sh_pfc_soc_info r8a7740_pinmux_info = {
 	.name		= "r8a7740_pfc",
-	.reserved_id	= PINMUX_RESERVED,
 	.input		= { PINMUX_INPUT_BEGIN,
 			    PINMUX_INPUT_END },
 	.input_pu	= { PINMUX_INPUT_PULLUP_BEGIN,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index c8018ce..bd5a70d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2605,7 +2605,6 @@ struct sh_pfc_soc_info r8a7779_pinmux_info = {
 
 	.unlock_reg = 0xfffc0000, /* PMMR */
 
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7203.c b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
index b9f5616..11852f9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7203.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
@@ -1573,7 +1573,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7203_pinmux_info = {
 	.name = "sh7203_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END, FORCE_IN },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END, FORCE_OUT },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index 063ccf9..eac6ec1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -2112,7 +2112,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7264_pinmux_info = {
 	.name = "sh7264_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END, FORCE_IN },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END, FORCE_OUT },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
index e05181e..8702016 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -2815,7 +2815,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7269_pinmux_info = {
 	.name = "sh7269_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END, FORCE_IN },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END, FORCE_OUT },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 0c56f57..c112074 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -1634,7 +1634,6 @@ static struct pinmux_irq pinmux_irqs[] = {
 
 struct sh_pfc_soc_info sh7372_pinmux_info = {
 	.name = "sh7372_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.input_pd = { PINMUX_INPUT_PULLDOWN_BEGIN, PINMUX_INPUT_PULLDOWN_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index aa18223..356f00a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2774,7 +2774,6 @@ static struct pinmux_irq pinmux_irqs[] = {
 
 struct sh_pfc_soc_info sh73a0_pinmux_info = {
 	.name = "sh73a0_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.input_pd = { PINMUX_INPUT_PULLDOWN_BEGIN, PINMUX_INPUT_PULLDOWN_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7720.c b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
index 3fdd140..5140ad2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7720.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
@@ -1215,7 +1215,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7720_pinmux_info = {
 	.name = "sh7720_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7722.c b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
index 9a23094..9bf5e54 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7722.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
@@ -1758,7 +1758,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7722_pinmux_info = {
 	.name = "sh7722_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pd = { PINMUX_INPUT_PULLDOWN_BEGIN, PINMUX_INPUT_PULLDOWN_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7723.c b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
index 7fc9407..3b5085c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7723.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
@@ -1883,7 +1883,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7723_pinmux_info = {
 	.name = "sh7723_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7724.c b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
index 0e26a3a..ef9f141 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7724.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
@@ -2205,7 +2205,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7724_pinmux_info = {
 	.name = "sh7724_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index be5cca6..df32e71 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2456,7 +2456,6 @@ struct sh_pfc_soc_info sh7734_pinmux_info = {
 
 	.unlock_reg = 0xFFFC0000,
 
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7757.c b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
index 851c0b4..e20036a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7757.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
@@ -2262,7 +2262,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7757_pinmux_info = {
 	.name = "sh7757_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7785.c b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
index 45b4909..1b57f40 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7785.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
@@ -1284,7 +1284,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7785_pinmux_info = {
 	.name = "sh7785_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7786.c b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
index 0eca522..f5d5cc9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7786.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
@@ -817,7 +817,6 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info sh7786_pinmux_info = {
 	.name = "sh7786_pfc",
-	.reserved_id = PINMUX_RESERVED,
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-shx3.c b/drivers/pinctrl/sh-pfc/pfc-shx3.c
index 6816219..cd741cc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-shx3.c
+++ b/drivers/pinctrl/sh-pfc/pfc-shx3.c
@@ -564,7 +564,6 @@ static struct pinmux_data_reg shx3_pinmux_data_regs[] = {
 
 struct sh_pfc_soc_info shx3_pinmux_info = {
 	.name		= "shx3_pfc",
-	.reserved_id	= PINMUX_RESERVED,
 	.input		= { PINMUX_INPUT_BEGIN,	   PINMUX_INPUT_END },
 	.input_pu	= { PINMUX_INPUT_PULLUP_BEGIN,
 			    PINMUX_INPUT_PULLUP_END },
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index c50fb51..2627a89 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -90,7 +90,6 @@ struct pinmux_range {
 
 struct sh_pfc_soc_info {
 	char *name;
-	pinmux_enum_t reserved_id;
 	struct pinmux_range input;
 	struct pinmux_range input_pd;
 	struct pinmux_range input_pu;
-- 
1.7.8.6

