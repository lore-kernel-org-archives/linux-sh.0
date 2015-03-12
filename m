From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Mar 2015 10:09:14 +0000
Subject: [PATCH v3 2/4] pinctrl: sh-pfc: Use unsigned int for register/field widths and offsets
Message-Id: <1426154956-26583-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1426154956-26583-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426154956-26583-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As register and field widths and offsets are in the range 1..32, use
unsigned int (mostly replacing unsigned long) to store them in local
variables and for passing them around.

Move to one variable per line, move variables to the beginning of the
block where they are used, and drop superfluous initializations while we
are at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - Remove superfluous initializations of local variables,
  - Add Acked-by,

v2:
  - Move to one variable per line and move variables to the beginning of
    the block where they are used for the code that is touched.
---
 drivers/pinctrl/sh-pfc/core.c | 59 +++++++++++++++++++++----------------------
 drivers/pinctrl/sh-pfc/core.h |  4 +--
 drivers/pinctrl/sh-pfc/gpio.c |  4 +--
 3 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 5591baf9738b5de9..c33e2474a8676cbc 100644
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
 
@@ -228,27 +228,28 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 }
 
 static int sh_pfc_get_config_reg(struct sh_pfc *pfc, u16 enum_id,
-				 const struct pinmux_cfg_reg **crp, int *fieldp,
-				 u32 *valuep)
+				 const struct pinmux_cfg_reg **crp,
+				 unsigned int *fieldp, u32 *valuep)
 {
-	const struct pinmux_cfg_reg *config_reg;
-	unsigned long r_width, f_width, curr_width;
-	unsigned int k, m, pos, bit_pos;
-	u32 ncomb, n;
+	unsigned int k = 0;
 
-	k = 0;
 	while (1) {
-		config_reg = pfc->info->cfg_regs + k;
-
-		r_width = config_reg->reg_width;
-		f_width = config_reg->field_width;
+		const struct pinmux_cfg_reg *config_reg +			pfc->info->cfg_regs + k;
+		unsigned int r_width = config_reg->reg_width;
+		unsigned int f_width = config_reg->field_width;
+		unsigned int curr_width;
+		unsigned int bit_pos;
+		unsigned int pos = 0;
+		unsigned int m = 0;
 
 		if (!r_width)
 			break;
 
-		pos = 0;
-		m = 0;
 		for (bit_pos = 0; bit_pos < r_width; bit_pos += curr_width) {
+			u32 ncomb;
+			u32 n;
+
 			if (f_width)
 				curr_width = f_width;
 			else
@@ -297,12 +298,8 @@ static int sh_pfc_mark_to_enum(struct sh_pfc *pfc, u16 mark, int pos,
 
 int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 {
-	const struct pinmux_cfg_reg *cr = NULL;
-	u16 enum_id;
 	const struct pinmux_range *range;
-	int in_range, pos, field;
-	u32 value;
-	int ret;
+	int pos = 0;
 
 	switch (pinmux_type) {
 	case PINMUX_TYPE_GPIO:
@@ -322,13 +319,15 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 		return -EINVAL;
 	}
 
-	pos = 0;
-	enum_id = 0;
-	field = 0;
-	value = 0;
-
 	/* Iterate over all the configuration fields we need to update. */
 	while (1) {
+		const struct pinmux_cfg_reg *cr;
+		unsigned int field;
+		u16 enum_id;
+		u32 value;
+		int in_range;
+		int ret;
+
 		pos = sh_pfc_mark_to_enum(pfc, mark, pos, &enum_id);
 		if (pos < 0)
 			return pos;
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
index f2bb7d7398cdfc24..aa2fc77a1925e839 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -153,8 +153,8 @@ static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
 			       int value)
 {
 	struct sh_pfc_gpio_data_reg *reg;
-	unsigned long pos;
 	unsigned int bit;
+	unsigned int pos;
 
 	gpio_get_data_reg(chip, offset, &reg, &bit);
 
@@ -185,8 +185,8 @@ static int gpio_pin_get(struct gpio_chip *gc, unsigned offset)
 {
 	struct sh_pfc_chip *chip = gpio_to_pfc_chip(gc);
 	struct sh_pfc_gpio_data_reg *reg;
-	unsigned long pos;
 	unsigned int bit;
+	unsigned int pos;
 
 	gpio_get_data_reg(chip, offset, &reg, &bit);
 
-- 
1.9.1

