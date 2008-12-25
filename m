From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Dec 2008 09:17:26 +0000
Subject: [PATCH 03/04] sh: lockless gpio_set_value()
Message-Id: <20081225091726.7670.92231.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch optimizes the gpio data register handling for gpio_set_value().

Instead of using the good old spinlock-plus-read-modify-write strategy
we now use a shadow register and atomic operations.

This improves the bitbanging mmc performance on Migo-R from 26 Kbytes/s
to 40 Kbytes/s.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/gpio.h |    2 
 arch/sh/kernel/gpio.c      |  106 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 82 insertions(+), 26 deletions(-)

--- 0010/arch/sh/include/asm/gpio.h
+++ work/arch/sh/include/asm/gpio.h	2008-12-25 16:06:24.000000000 +0900
@@ -59,7 +59,7 @@ struct pinmux_cfg_reg {
 	.enum_ids = (pinmux_enum_t [(r_width / f_width) * (1 << f_width)]) \
 
 struct pinmux_data_reg {
-	unsigned long reg, reg_width;
+	unsigned long reg, reg_width, reg_shadow;
 	pinmux_enum_t *enum_ids;
 };
 
--- 0011/arch/sh/kernel/gpio.c
+++ work/arch/sh/kernel/gpio.c	2008-12-25 16:30:21.000000000 +0900
@@ -46,6 +46,62 @@ static int enum_in_range(pinmux_enum_t e
 	return 1;
 }
 
+static unsigned long gpio_read_raw_reg(unsigned long reg,
+				       unsigned long reg_width)
+{
+	switch (reg_width) {
+	case 8:
+		return ctrl_inb(reg);
+	case 16:
+		return ctrl_inw(reg);
+	case 32:
+		return ctrl_inl(reg);
+	}
+
+	BUG();
+	return 0;
+}
+
+static void gpio_write_raw_reg(unsigned long reg,
+			       unsigned long reg_width,
+			       unsigned long data)
+{
+	switch (reg_width) {
+	case 8:
+		ctrl_outb(data, reg);
+		return;
+	case 16:
+		ctrl_outw(data, reg);
+		return;
+	case 32:
+		ctrl_outl(data, reg);
+		return;
+	}
+
+	BUG();
+}
+
+static void gpio_write_bit(struct pinmux_data_reg *dr,
+			   unsigned long in_pos, unsigned long value)
+{
+	unsigned long pos;
+
+	pos = dr->reg_width - (in_pos + 1);
+
+#ifdef DEBUG
+	pr_info("write_bit addr = %lx, value = %ld, pos = %ld, "
+		"r_width = %ld\n",
+		dr->reg, !!value, pos, dr->reg_width);
+#endif
+
+	if (value)
+		set_bit(pos, &dr->reg_shadow);
+	else
+		clear_bit(pos, &dr->reg_shadow);
+
+	gpio_write_raw_reg(dr->reg, dr->reg_width, dr->reg_shadow);
+}
+
 static int gpio_read_reg(unsigned long reg, unsigned long reg_width,
 			 unsigned long field_width, unsigned long in_pos)
 {
@@ -61,18 +117,7 @@ static int gpio_read_reg(unsigned long r
 		reg, pos, reg_width, field_width);
 #endif
 
-	switch (reg_width) {
-	case 8:
-		data = ctrl_inb(reg);
-		break;
-	case 16:
-		data = ctrl_inw(reg);
-		break;
-	case 32:
-		data = ctrl_inl(reg);
-		break;
-	}
-
+	data = gpio_read_raw_reg(reg, reg_width);
 	return (data >> pos) & mask;
 }
 
@@ -140,6 +185,26 @@ static int setup_data_reg(struct pinmux_
 	return -1;
 }
 
+static void setup_data_regs(struct pinmux_info *gpioc)
+{
+	struct pinmux_data_reg *drp;
+	int k;
+
+	for (k = gpioc->first_gpio; k <= gpioc->last_gpio; k++)
+		setup_data_reg(gpioc, k);
+
+	k = 0;
+	while (1) {
+		drp = gpioc->data_regs + k;
+
+		if (!drp->reg_width)
+			break;
+
+		drp->reg_shadow = gpio_read_raw_reg(drp->reg, drp->reg_width);
+		k++;
+	}
+}
+
 static int get_data_reg(struct pinmux_info *gpioc, unsigned gpio,
 			struct pinmux_data_reg **drp, int *bitp)
 {
@@ -465,7 +530,7 @@ static void __gpio_set_value(struct pinm
 	if (!gpioc || get_data_reg(gpioc, gpio, &dr, &bit) != 0)
 		BUG();
 	else
-		gpio_write_reg(dr->reg, dr->reg_width, 1, bit, !!value);
+		gpio_write_bit(dr, bit, value);
 }
 
 int gpio_direction_output(unsigned gpio, int value)
@@ -474,8 +539,8 @@ int gpio_direction_output(unsigned gpio,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&gpio_lock, flags);
 	__gpio_set_value(gpioc, gpio, value);
+	spin_lock_irqsave(&gpio_lock, flags);
 	ret = pinmux_direction(gpioc, gpio, PINMUX_TYPE_OUTPUT);
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
@@ -504,25 +569,16 @@ EXPORT_SYMBOL(gpio_get_value);
 
 void gpio_set_value(unsigned gpio, int value)
 {
-	struct pinmux_info *gpioc = gpio_controller(gpio);
-	unsigned long flags;
-
-	spin_lock_irqsave(&gpio_lock, flags);
-	__gpio_set_value(gpioc, gpio, value);
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	__gpio_set_value(gpio_controller(gpio), gpio, value);
 }
 EXPORT_SYMBOL(gpio_set_value);
 
 int register_pinmux(struct pinmux_info *pip)
 {
-	int k;
-
 	registered_gpio = pip;
+	setup_data_regs(pip);
 	pr_info("pinmux: %s handling gpio %d -> %d\n",
 		pip->name, pip->first_gpio, pip->last_gpio);
 
-	for (k = pip->first_gpio; k <= pip->last_gpio; k++)
-		setup_data_reg(pip, k);
-
 	return 0;
 }
