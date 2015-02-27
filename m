From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 27 Feb 2015 17:38:05 +0000
Subject: [PATCH 4/4] pinctrl: sh-pfc: Use unsigned int for register/field widths and offsets
Message-Id: <1425058685-12956-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As register and field widths and offsets are in the range 0..32, use
unsigned int (mostly replacing unsigned long) to store them in local
variables and for passing them around.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 25 ++++++++++++-------------
 drivers/pinctrl/sh-pfc/core.h |  4 ++--
 drivers/pinctrl/sh-pfc/gpio.c |  6 ++----
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 1758043cfcec253b..0350c64229ea0734 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -144,7 +144,7 @@ static int sh_pfc_enum_in_range(u16 enum_id, const struct pinmux_range *r)
 	return 1;
 }
 
-u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned long reg_width)
+u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width)
 {
 	switch (reg_width) {
 	case 8:
@@ -159,7 +159,7 @@ u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned long reg_width)
 	return 0;
 }
 
-void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned long reg_width,
+void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
 			  u32 data)
 {
 	switch (reg_width) {
@@ -179,9 +179,9 @@ void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned long reg_width,
 
 static void sh_pfc_config_reg_helper(struct sh_pfc *pfc,
 				     const struct pinmux_cfg_reg *crp,
-				     unsigned long in_pos,
+				     unsigned int in_pos,
 				     void __iomem **mapped_regp, u32 *maskp,
-				     unsigned long *posp)
+				     unsigned int *posp)
 {
 	unsigned int k;
 
@@ -200,15 +200,15 @@ static void sh_pfc_config_reg_helper(struct sh_pfc *pfc,
 
 static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 				    const struct pinmux_cfg_reg *crp,
-				    unsigned long field, u32 value)
+				    unsigned int field, u32 value)
 {
 	void __iomem *mapped_reg;
-	unsigned long pos;
+	unsigned int pos;
 	u32 mask, data;
 
 	sh_pfc_config_reg_helper(pfc, crp, field, &mapped_reg, &mask, &pos);
 
-	dev_dbg(pfc->dev, "write_reg addr = %lx, value = 0x%x, field = %ld, "
+	dev_dbg(pfc->dev, "write_reg addr = %lx, value = 0x%x, field = %u, "
 		"r_width = %u, f_width = %u\n",
 		crp->reg, value, field, crp->reg_width, crp->field_width);
 
@@ -228,12 +228,11 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 }
 
 static int sh_pfc_get_config_reg(struct sh_pfc *pfc, u16 enum_id,
-				 const struct pinmux_cfg_reg **crp, int *fieldp,
-				 u32 *valuep)
+				 const struct pinmux_cfg_reg **crp,
+				 unsigned int *fieldp, u32 *valuep)
 {
 	const struct pinmux_cfg_reg *config_reg;
-	unsigned long r_width, f_width, curr_width;
-	unsigned int k, m, pos, bit_pos;
+	unsigned int r_width, f_width, curr_width, k, m, pos, bit_pos;
 	u32 ncomb, n;
 
 	k = 0;
@@ -300,9 +299,9 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 	const struct pinmux_cfg_reg *cr = NULL;
 	u16 enum_id;
 	const struct pinmux_range *range;
-	int in_range, pos, field;
+	int in_range, pos, ret;
+	unsigned int field;
 	u32 value;
-	int ret;
 
 	switch (pinmux_type) {
 	case PINMUX_TYPE_GPIO:
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 8a10dd50ccdd2e0c..6dc8a6fc27468b39 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -57,8 +57,8 @@ int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
 int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
 
-u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned long reg_width);
-void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned long reg_width,
+u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
+void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
 			  u32 data);
 
 int sh_pfc_get_pin_index(struct sh_pfc *pfc, unsigned int pin);
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index f2bb7d7398cdfc24..b68d24099593d3b8 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -153,8 +153,7 @@ static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
 			       int value)
 {
 	struct sh_pfc_gpio_data_reg *reg;
-	unsigned long pos;
-	unsigned int bit;
+	unsigned int pos, bit;
 
 	gpio_get_data_reg(chip, offset, &reg, &bit);
 
@@ -185,8 +184,7 @@ static int gpio_pin_get(struct gpio_chip *gc, unsigned offset)
 {
 	struct sh_pfc_chip *chip = gpio_to_pfc_chip(gc);
 	struct sh_pfc_gpio_data_reg *reg;
-	unsigned long pos;
-	unsigned int bit;
+	unsigned int pos, bit;
 
 	gpio_get_data_reg(chip, offset, &reg, &bit);
 
-- 
1.9.1

