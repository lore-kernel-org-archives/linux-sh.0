From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 27 Feb 2015 17:38:04 +0000
Subject: [PATCH 3/4] pinctrl: sh-pfc: Use u32 to store register data
Message-Id: <1425058685-12956-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As PFC registers are either 8, 16, or 32 bits wide, use u32 (mostly
replacing unsigned long) to store (parts of) register values and masks.

Switch the shadow register operations from {set,clear}_bit() to plain C
bit operations, as the former can operate on long data only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 25 +++++++++++++------------
 drivers/pinctrl/sh-pfc/core.h |  5 ++---
 drivers/pinctrl/sh-pfc/gpio.c | 13 ++++++-------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 466b899ec78b15d7..1758043cfcec253b 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -144,8 +144,7 @@ static int sh_pfc_enum_in_range(u16 enum_id, const struct pinmux_range *r)
 	return 1;
 }
 
-unsigned long sh_pfc_read_raw_reg(void __iomem *mapped_reg,
-				  unsigned long reg_width)
+u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned long reg_width)
 {
 	switch (reg_width) {
 	case 8:
@@ -161,7 +160,7 @@ unsigned long sh_pfc_read_raw_reg(void __iomem *mapped_reg,
 }
 
 void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned long reg_width,
-			  unsigned long data)
+			  u32 data)
 {
 	switch (reg_width) {
 	case 8:
@@ -181,8 +180,7 @@ void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned long reg_width,
 static void sh_pfc_config_reg_helper(struct sh_pfc *pfc,
 				     const struct pinmux_cfg_reg *crp,
 				     unsigned long in_pos,
-				     void __iomem **mapped_regp,
-				     unsigned long *maskp,
+				     void __iomem **mapped_regp, u32 *maskp,
 				     unsigned long *posp)
 {
 	unsigned int k;
@@ -202,14 +200,15 @@ static void sh_pfc_config_reg_helper(struct sh_pfc *pfc,
 
 static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 				    const struct pinmux_cfg_reg *crp,
-				    unsigned long field, unsigned long value)
+				    unsigned long field, u32 value)
 {
 	void __iomem *mapped_reg;
-	unsigned long mask, pos, data;
+	unsigned long pos;
+	u32 mask, data;
 
 	sh_pfc_config_reg_helper(pfc, crp, field, &mapped_reg, &mask, &pos);
 
-	dev_dbg(pfc->dev, "write_reg addr = %lx, value = %ld, field = %ld, "
+	dev_dbg(pfc->dev, "write_reg addr = %lx, value = 0x%x, field = %ld, "
 		"r_width = %u, f_width = %u\n",
 		crp->reg, value, field, crp->reg_width, crp->field_width);
 
@@ -230,11 +229,12 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 
 static int sh_pfc_get_config_reg(struct sh_pfc *pfc, u16 enum_id,
 				 const struct pinmux_cfg_reg **crp, int *fieldp,
-				 int *valuep)
+				 u32 *valuep)
 {
 	const struct pinmux_cfg_reg *config_reg;
-	unsigned long r_width, f_width, curr_width, ncomb;
-	unsigned int k, m, n, pos, bit_pos;
+	unsigned long r_width, f_width, curr_width;
+	unsigned int k, m, pos, bit_pos;
+	u32 ncomb, n;
 
 	k = 0;
 	while (1) {
@@ -300,7 +300,8 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 	const struct pinmux_cfg_reg *cr = NULL;
 	u16 enum_id;
 	const struct pinmux_range *range;
-	int in_range, pos, field, value;
+	int in_range, pos, field;
+	u32 value;
 	int ret;
 
 	switch (pinmux_type) {
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 6b59d63b9c01e7a6..8a10dd50ccdd2e0c 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -57,10 +57,9 @@ int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
 int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
 
-unsigned long sh_pfc_read_raw_reg(void __iomem *mapped_reg,
-				  unsigned long reg_width);
+u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned long reg_width);
 void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned long reg_width,
-			  unsigned long data);
+			  u32 data);
 
 int sh_pfc_get_pin_index(struct sh_pfc *pfc, unsigned int pin);
 int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type);
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 80f641ee4dea3146..f2bb7d7398cdfc24 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -21,7 +21,7 @@
 
 struct sh_pfc_gpio_data_reg {
 	const struct pinmux_data_reg *info;
-	unsigned long shadow;
+	u32 shadow;
 };
 
 struct sh_pfc_gpio_pin {
@@ -59,8 +59,8 @@ static void gpio_get_data_reg(struct sh_pfc_chip *chip, unsigned int offset,
 	*bit = gpio_pin->dbit;
 }
 
-static unsigned long gpio_read_data_reg(struct sh_pfc_chip *chip,
-					const struct pinmux_data_reg *dreg)
+static u32 gpio_read_data_reg(struct sh_pfc_chip *chip,
+			      const struct pinmux_data_reg *dreg)
 {
 	void __iomem *mem = dreg->reg - chip->mem->phys + chip->mem->virt;
 
@@ -68,8 +68,7 @@ static unsigned long gpio_read_data_reg(struct sh_pfc_chip *chip,
 }
 
 static void gpio_write_data_reg(struct sh_pfc_chip *chip,
-				const struct pinmux_data_reg *dreg,
-				unsigned long value)
+				const struct pinmux_data_reg *dreg, u32 value)
 {
 	void __iomem *mem = dreg->reg - chip->mem->phys + chip->mem->virt;
 
@@ -162,9 +161,9 @@ static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
 	pos = reg->info->reg_width - (bit + 1);
 
 	if (value)
-		set_bit(pos, &reg->shadow);
+		reg->shadow |= BIT(pos);
 	else
-		clear_bit(pos, &reg->shadow);
+		reg->shadow &= ~BIT(pos);
 
 	gpio_write_data_reg(chip, reg->info, reg->shadow);
 }
-- 
1.9.1

