From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Dec 2008 09:17:18 +0000
Subject: [PATCH 02/04] sh: lockless gpio_get_value()
Message-Id: <20081225091718.7670.26232.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch separates the register read and write functions to
allow lockless gpio_get_value().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/gpio.c |  126 ++++++++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

--- 0010/arch/sh/kernel/gpio.c
+++ work/arch/sh/kernel/gpio.c	2008-12-25 15:49:44.000000000 +0900
@@ -46,9 +46,8 @@ static int enum_in_range(pinmux_enum_t e
 	return 1;
 }
 
-static int read_write_reg(unsigned long reg, unsigned long reg_width,
-			  unsigned long field_width, unsigned long in_pos,
-			  unsigned long value, int do_write)
+static int gpio_read_reg(unsigned long reg, unsigned long reg_width,
+			 unsigned long field_width, unsigned long in_pos)
 {
 	unsigned long data, mask, pos;
 
@@ -57,10 +56,9 @@ static int read_write_reg(unsigned long 
 	pos = reg_width - ((in_pos + 1) * field_width);
 
 #ifdef DEBUG
-	pr_info("%s, addr = %lx, value = %ld, pos = %ld, "
+	pr_info("read_reg: addr = %lx, pos = %ld, "
 		"r_width = %ld, f_width = %ld\n",
-		do_write ? "write" : "read", reg, value, pos,
-		reg_width, field_width);
+		reg, pos, reg_width, field_width);
 #endif
 
 	switch (reg_width) {
@@ -75,24 +73,38 @@ static int read_write_reg(unsigned long 
 		break;
 	}
 
-	if (!do_write)
-		return (data >> pos) & mask;
+	return (data >> pos) & mask;
+}
+
+static void gpio_write_reg(unsigned long reg, unsigned long reg_width,
+			   unsigned long field_width, unsigned long in_pos,
+			   unsigned long value)
+{
+	unsigned long mask, pos;
+
+	mask = (1 << field_width) - 1;
+	pos = reg_width - ((in_pos + 1) * field_width);
 
-	data &= ~(mask << pos);
-	data |= value << pos;
+#ifdef DEBUG
+	pr_info("write_reg addr = %lx, value = %ld, pos = %ld, "
+		"r_width = %ld, f_width = %ld\n",
+		reg, value, pos, reg_width, field_width);
+#endif
+
+	mask = ~(mask << pos);
+	value = value << pos;
 
 	switch (reg_width) {
 	case 8:
-		ctrl_outb(data, reg);
+		ctrl_outb((ctrl_inb(reg) & mask) | value, reg);
 		break;
 	case 16:
-		ctrl_outw(data, reg);
+		ctrl_outw((ctrl_inw(reg) & mask) | value, reg);
 		break;
 	case 32:
-		ctrl_outl(data, reg);
+		ctrl_outl((ctrl_inl(reg) & mask) | value, reg);
 		break;
 	}
-	return 0;
 }
 
 static int setup_data_reg(struct pinmux_info *gpioc, unsigned gpio)
@@ -205,9 +217,9 @@ static int get_gpio_enum_id(struct pinmu
 	return -1;
 }
 
-static int write_config_reg(struct pinmux_info *gpioc,
-			    struct pinmux_cfg_reg *crp,
-			    int index)
+static void write_config_reg(struct pinmux_info *gpioc,
+			     struct pinmux_cfg_reg *crp,
+			     int index)
 {
 	unsigned long ncomb, pos, value;
 
@@ -215,8 +227,7 @@ static int write_config_reg(struct pinmu
 	pos = index / ncomb;
 	value = index % ncomb;
 
-	return read_write_reg(crp->reg, crp->reg_width,
-			      crp->field_width, pos, value, 1);
+	gpio_write_reg(crp->reg, crp->reg_width, crp->field_width, pos, value);
 }
 
 static int check_config_reg(struct pinmux_info *gpioc,
@@ -229,8 +240,8 @@ static int check_config_reg(struct pinmu
 	pos = index / ncomb;
 	value = index % ncomb;
 
-	if (read_write_reg(crp->reg, crp->reg_width,
-			   crp->field_width, pos, 0, 0) = value)
+	if (gpio_read_reg(crp->reg, crp->reg_width,
+			  crp->field_width, pos) = value)
 		return 0;
 
 	return -1;
@@ -238,8 +249,8 @@ static int check_config_reg(struct pinmu
 
 enum { GPIO_CFG_DRYRUN, GPIO_CFG_REQ, GPIO_CFG_FREE };
 
-int pinmux_config_gpio(struct pinmux_info *gpioc, unsigned gpio,
-		       int pinmux_type, int cfg_mode)
+static int pinmux_config_gpio(struct pinmux_info *gpioc, unsigned gpio,
+			      int pinmux_type, int cfg_mode)
 {
 	struct pinmux_cfg_reg *cr = NULL;
 	pinmux_enum_t enum_id;
@@ -305,8 +316,7 @@ int pinmux_config_gpio(struct pinmux_inf
 			break;
 
 		case GPIO_CFG_REQ:
-			if (write_config_reg(gpioc, cr, index) != 0)
-				goto out_err;
+			write_config_reg(gpioc, cr, index);
 			*cntp = *cntp + 1;
 			break;
 
@@ -393,9 +403,12 @@ EXPORT_SYMBOL(gpio_free);
 static int pinmux_direction(struct pinmux_info *gpioc,
 			    unsigned gpio, int new_pinmux_type)
 {
-	int ret, pinmux_type;
+	int pinmux_type;
+	int ret = -EINVAL;
+
+	if (!gpioc)
+		goto err_out;
 
-	ret = -EINVAL;
 	pinmux_type = gpioc->gpios[gpio].flags & PINMUX_FLAG_TYPE;
 
 	switch (pinmux_type) {
@@ -433,68 +446,59 @@ int gpio_direction_input(unsigned gpio)
 {
 	struct pinmux_info *gpioc = gpio_controller(gpio);
 	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (!gpioc)
-		goto err_out;
+	int ret;
 
 	spin_lock_irqsave(&gpio_lock, flags);
 	ret = pinmux_direction(gpioc, gpio, PINMUX_TYPE_INPUT);
 	spin_unlock_irqrestore(&gpio_lock, flags);
- err_out:
+
 	return ret;
 }
 EXPORT_SYMBOL(gpio_direction_input);
 
-static int __gpio_get_set_value(struct pinmux_info *gpioc,
-				unsigned gpio, int value,
-				int do_write)
+static void __gpio_set_value(struct pinmux_info *gpioc,
+			     unsigned gpio, int value)
 {
 	struct pinmux_data_reg *dr = NULL;
 	int bit = 0;
 
-	if (get_data_reg(gpioc, gpio, &dr, &bit) != 0)
+	if (!gpioc || get_data_reg(gpioc, gpio, &dr, &bit) != 0)
 		BUG();
 	else
-		value = read_write_reg(dr->reg, dr->reg_width,
-				       1, bit, !!value, do_write);
-
-	return value;
+		gpio_write_reg(dr->reg, dr->reg_width, 1, bit, !!value);
 }
 
 int gpio_direction_output(unsigned gpio, int value)
 {
 	struct pinmux_info *gpioc = gpio_controller(gpio);
 	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (!gpioc)
-		goto err_out;
+	int ret;
 
 	spin_lock_irqsave(&gpio_lock, flags);
-	__gpio_get_set_value(gpioc, gpio, value, 1);
+	__gpio_set_value(gpioc, gpio, value);
 	ret = pinmux_direction(gpioc, gpio, PINMUX_TYPE_OUTPUT);
 	spin_unlock_irqrestore(&gpio_lock, flags);
- err_out:
+
 	return ret;
 }
 EXPORT_SYMBOL(gpio_direction_output);
 
-int gpio_get_value(unsigned gpio)
+static int __gpio_get_value(struct pinmux_info *gpioc, unsigned gpio)
 {
-	struct pinmux_info *gpioc = gpio_controller(gpio);
-	unsigned long flags;
-	int value = 0;
+	struct pinmux_data_reg *dr = NULL;
+	int bit = 0;
 
-	if (!gpioc)
+	if (!gpioc || get_data_reg(gpioc, gpio, &dr, &bit) != 0) {
 		BUG();
-	else {
-		spin_lock_irqsave(&gpio_lock, flags);
-		value = __gpio_get_set_value(gpioc, gpio, 0, 0);
-		spin_unlock_irqrestore(&gpio_lock, flags);
+		return 0;
 	}
 
-	return value;
+	return gpio_read_reg(dr->reg, dr->reg_width, 1, bit);
+}
+
+int gpio_get_value(unsigned gpio)
+{
+	return __gpio_get_value(gpio_controller(gpio), gpio);
 }
 EXPORT_SYMBOL(gpio_get_value);
 
@@ -503,13 +507,9 @@ void gpio_set_value(unsigned gpio, int v
 	struct pinmux_info *gpioc = gpio_controller(gpio);
 	unsigned long flags;
 
-	if (!gpioc)
-		BUG();
-	else {
-		spin_lock_irqsave(&gpio_lock, flags);
-		__gpio_get_set_value(gpioc, gpio, value, 1);
-		spin_unlock_irqrestore(&gpio_lock, flags);
-	}
+	spin_lock_irqsave(&gpio_lock, flags);
+	__gpio_set_value(gpioc, gpio, value);
+	spin_unlock_irqrestore(&gpio_lock, flags);
 }
 EXPORT_SYMBOL(gpio_set_value);
 
