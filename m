From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 Nov 2009 07:38:01 +0000
Subject: [PATCH] sh: Break out SuperH PFC code
Message-Id: <20091127073801.19796.38165.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This file breaks out the SuperH PFC code from
arch/sh/kernel/gpio.c + arch/sh/include/asm/gpio.h
to drivers/sh/pfc.c + include/linux/sh_pfc.h.

Similar to the INTC stuff. The non-SuperH specific
file location makes it possible to share the code
between multiple architectures.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/gpio.h |   82 ------
 arch/sh/kernel/Makefile    |    1 
 arch/sh/kernel/gpio.c      |  584 --------------------------------------------
 drivers/sh/Makefile        |    1 
 drivers/sh/pfc.c           |  584 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sh_pfc.h     |   96 +++++++
 6 files changed, 682 insertions(+), 666 deletions(-)

--- 0001/arch/sh/include/asm/gpio.h
+++ work/arch/sh/include/asm/gpio.h	2009-11-27 16:18:13.000000000 +0900
@@ -20,7 +20,7 @@
 #endif
 
 #define ARCH_NR_GPIOS 512
-#include <asm-generic/gpio.h>
+#include <linux/sh_pfc.h>
 
 #ifdef CONFIG_GPIOLIB
 
@@ -53,84 +53,4 @@ static inline int irq_to_gpio(unsigned i
 
 #endif /* CONFIG_GPIOLIB */
 
-typedef unsigned short pinmux_enum_t;
-typedef unsigned short pinmux_flag_t;
-
-#define PINMUX_TYPE_NONE            0
-#define PINMUX_TYPE_FUNCTION        1
-#define PINMUX_TYPE_GPIO            2
-#define PINMUX_TYPE_OUTPUT          3
-#define PINMUX_TYPE_INPUT           4
-#define PINMUX_TYPE_INPUT_PULLUP    5
-#define PINMUX_TYPE_INPUT_PULLDOWN  6
-
-#define PINMUX_FLAG_TYPE            (0x7)
-#define PINMUX_FLAG_WANT_PULLUP     (1 << 3)
-#define PINMUX_FLAG_WANT_PULLDOWN   (1 << 4)
-
-#define PINMUX_FLAG_DBIT_SHIFT      5
-#define PINMUX_FLAG_DBIT            (0x1f << PINMUX_FLAG_DBIT_SHIFT)
-#define PINMUX_FLAG_DREG_SHIFT      10
-#define PINMUX_FLAG_DREG            (0x3f << PINMUX_FLAG_DREG_SHIFT)
-
-struct pinmux_gpio {
-	pinmux_enum_t enum_id;
-	pinmux_flag_t flags;
-};
-
-#define PINMUX_GPIO(gpio, data_or_mark) [gpio] = { data_or_mark }
-#define PINMUX_DATA(data_or_mark, ids...) data_or_mark, ids, 0
-
-struct pinmux_cfg_reg {
-	unsigned long reg, reg_width, field_width;
-	unsigned long *cnt;
-	pinmux_enum_t *enum_ids;
-};
-
-#define PINMUX_CFG_REG(name, r, r_width, f_width) \
-	.reg = r, .reg_width = r_width, .field_width = f_width,		\
-	.cnt = (unsigned long [r_width / f_width]) {}, \
-	.enum_ids = (pinmux_enum_t [(r_width / f_width) * (1 << f_width)]) \
-
-struct pinmux_data_reg {
-	unsigned long reg, reg_width, reg_shadow;
-	pinmux_enum_t *enum_ids;
-};
-
-#define PINMUX_DATA_REG(name, r, r_width) \
-	.reg = r, .reg_width = r_width,	\
-	.enum_ids = (pinmux_enum_t [r_width]) \
-
-struct pinmux_range {
-	pinmux_enum_t begin;
-	pinmux_enum_t end;
-	pinmux_enum_t force;
-};
-
-struct pinmux_info {
-	char *name;
-	pinmux_enum_t reserved_id;
-	struct pinmux_range data;
-	struct pinmux_range input;
-	struct pinmux_range input_pd;
-	struct pinmux_range input_pu;
-	struct pinmux_range output;
-	struct pinmux_range mark;
-	struct pinmux_range function;
-
-	unsigned first_gpio, last_gpio;
-
-	struct pinmux_gpio *gpios;
-	struct pinmux_cfg_reg *cfg_regs;
-	struct pinmux_data_reg *data_regs;
-
-	pinmux_enum_t *gpio_data;
-	unsigned int gpio_data_size;
-
-	unsigned long *gpio_in_use;
-	struct gpio_chip chip;
-};
-
-int register_pinmux(struct pinmux_info *pip);
-
 #endif /* __ASM_SH_GPIO_H */
--- 0001/arch/sh/kernel/Makefile
+++ work/arch/sh/kernel/Makefile	2009-11-27 16:10:18.000000000 +0900
@@ -32,7 +32,6 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
-obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
--- 0001/arch/sh/kernel/gpio.c
+++ /dev/null	2009-11-24 12:00:12.283019273 +0900
@@ -1,584 +0,0 @@
-/*
- * Pinmuxed GPIO support for SuperH.
- *
- * Copyright (C) 2008 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/bitops.h>
-#include <linux/gpio.h>
-
-static int enum_in_range(pinmux_enum_t enum_id, struct pinmux_range *r)
-{
-	if (enum_id < r->begin)
-		return 0;
-
-	if (enum_id > r->end)
-		return 0;
-
-	return 1;
-}
-
-static unsigned long gpio_read_raw_reg(unsigned long reg,
-				       unsigned long reg_width)
-{
-	switch (reg_width) {
-	case 8:
-		return ctrl_inb(reg);
-	case 16:
-		return ctrl_inw(reg);
-	case 32:
-		return ctrl_inl(reg);
-	}
-
-	BUG();
-	return 0;
-}
-
-static void gpio_write_raw_reg(unsigned long reg,
-			       unsigned long reg_width,
-			       unsigned long data)
-{
-	switch (reg_width) {
-	case 8:
-		ctrl_outb(data, reg);
-		return;
-	case 16:
-		ctrl_outw(data, reg);
-		return;
-	case 32:
-		ctrl_outl(data, reg);
-		return;
-	}
-
-	BUG();
-}
-
-static void gpio_write_bit(struct pinmux_data_reg *dr,
-			   unsigned long in_pos, unsigned long value)
-{
-	unsigned long pos;
-
-	pos = dr->reg_width - (in_pos + 1);
-
-#ifdef DEBUG
-	pr_info("write_bit addr = %lx, value = %ld, pos = %ld, "
-		"r_width = %ld\n",
-		dr->reg, !!value, pos, dr->reg_width);
-#endif
-
-	if (value)
-		set_bit(pos, &dr->reg_shadow);
-	else
-		clear_bit(pos, &dr->reg_shadow);
-
-	gpio_write_raw_reg(dr->reg, dr->reg_width, dr->reg_shadow);
-}
-
-static int gpio_read_reg(unsigned long reg, unsigned long reg_width,
-			 unsigned long field_width, unsigned long in_pos)
-{
-	unsigned long data, mask, pos;
-
-	data = 0;
-	mask = (1 << field_width) - 1;
-	pos = reg_width - ((in_pos + 1) * field_width);
-
-#ifdef DEBUG
-	pr_info("read_reg: addr = %lx, pos = %ld, "
-		"r_width = %ld, f_width = %ld\n",
-		reg, pos, reg_width, field_width);
-#endif
-
-	data = gpio_read_raw_reg(reg, reg_width);
-	return (data >> pos) & mask;
-}
-
-static void gpio_write_reg(unsigned long reg, unsigned long reg_width,
-			   unsigned long field_width, unsigned long in_pos,
-			   unsigned long value)
-{
-	unsigned long mask, pos;
-
-	mask = (1 << field_width) - 1;
-	pos = reg_width - ((in_pos + 1) * field_width);
-
-#ifdef DEBUG
-	pr_info("write_reg addr = %lx, value = %ld, pos = %ld, "
-		"r_width = %ld, f_width = %ld\n",
-		reg, value, pos, reg_width, field_width);
-#endif
-
-	mask = ~(mask << pos);
-	value = value << pos;
-
-	switch (reg_width) {
-	case 8:
-		ctrl_outb((ctrl_inb(reg) & mask) | value, reg);
-		break;
-	case 16:
-		ctrl_outw((ctrl_inw(reg) & mask) | value, reg);
-		break;
-	case 32:
-		ctrl_outl((ctrl_inl(reg) & mask) | value, reg);
-		break;
-	}
-}
-
-static int setup_data_reg(struct pinmux_info *gpioc, unsigned gpio)
-{
-	struct pinmux_gpio *gpiop = &gpioc->gpios[gpio];
-	struct pinmux_data_reg *data_reg;
-	int k, n;
-
-	if (!enum_in_range(gpiop->enum_id, &gpioc->data))
-		return -1;
-
-	k = 0;
-	while (1) {
-		data_reg = gpioc->data_regs + k;
-
-		if (!data_reg->reg_width)
-			break;
-
-		for (n = 0; n < data_reg->reg_width; n++) {
-			if (data_reg->enum_ids[n] = gpiop->enum_id) {
-				gpiop->flags &= ~PINMUX_FLAG_DREG;
-				gpiop->flags |= (k << PINMUX_FLAG_DREG_SHIFT);
-				gpiop->flags &= ~PINMUX_FLAG_DBIT;
-				gpiop->flags |= (n << PINMUX_FLAG_DBIT_SHIFT);
-				return 0;
-			}
-		}
-		k++;
-	}
-
-	BUG();
-
-	return -1;
-}
-
-static void setup_data_regs(struct pinmux_info *gpioc)
-{
-	struct pinmux_data_reg *drp;
-	int k;
-
-	for (k = gpioc->first_gpio; k <= gpioc->last_gpio; k++)
-		setup_data_reg(gpioc, k);
-
-	k = 0;
-	while (1) {
-		drp = gpioc->data_regs + k;
-
-		if (!drp->reg_width)
-			break;
-
-		drp->reg_shadow = gpio_read_raw_reg(drp->reg, drp->reg_width);
-		k++;
-	}
-}
-
-static int get_data_reg(struct pinmux_info *gpioc, unsigned gpio,
-			struct pinmux_data_reg **drp, int *bitp)
-{
-	struct pinmux_gpio *gpiop = &gpioc->gpios[gpio];
-	int k, n;
-
-	if (!enum_in_range(gpiop->enum_id, &gpioc->data))
-		return -1;
-
-	k = (gpiop->flags & PINMUX_FLAG_DREG) >> PINMUX_FLAG_DREG_SHIFT;
-	n = (gpiop->flags & PINMUX_FLAG_DBIT) >> PINMUX_FLAG_DBIT_SHIFT;
-	*drp = gpioc->data_regs + k;
-	*bitp = n;
-	return 0;
-}
-
-static int get_config_reg(struct pinmux_info *gpioc, pinmux_enum_t enum_id,
-			  struct pinmux_cfg_reg **crp, int *indexp,
-			  unsigned long **cntp)
-{
-	struct pinmux_cfg_reg *config_reg;
-	unsigned long r_width, f_width;
-	int k, n;
-
-	k = 0;
-	while (1) {
-		config_reg = gpioc->cfg_regs + k;
-
-		r_width = config_reg->reg_width;
-		f_width = config_reg->field_width;
-
-		if (!r_width)
-			break;
-		for (n = 0; n < (r_width / f_width) * 1 << f_width; n++) {
-			if (config_reg->enum_ids[n] = enum_id) {
-				*crp = config_reg;
-				*indexp = n;
-				*cntp = &config_reg->cnt[n / (1 << f_width)];
-				return 0;
-			}
-		}
-		k++;
-	}
-
-	return -1;
-}
-
-static int get_gpio_enum_id(struct pinmux_info *gpioc, unsigned gpio,
-			    int pos, pinmux_enum_t *enum_idp)
-{
-	pinmux_enum_t enum_id = gpioc->gpios[gpio].enum_id;
-	pinmux_enum_t *data = gpioc->gpio_data;
-	int k;
-
-	if (!enum_in_range(enum_id, &gpioc->data)) {
-		if (!enum_in_range(enum_id, &gpioc->mark)) {
-			pr_err("non data/mark enum_id for gpio %d\n", gpio);
-			return -1;
-		}
-	}
-
-	if (pos) {
-		*enum_idp = data[pos + 1];
-		return pos + 1;
-	}
-
-	for (k = 0; k < gpioc->gpio_data_size; k++) {
-		if (data[k] = enum_id) {
-			*enum_idp = data[k + 1];
-			return k + 1;
-		}
-	}
-
-	pr_err("cannot locate data/mark enum_id for gpio %d\n", gpio);
-	return -1;
-}
-
-static void write_config_reg(struct pinmux_info *gpioc,
-			     struct pinmux_cfg_reg *crp,
-			     int index)
-{
-	unsigned long ncomb, pos, value;
-
-	ncomb = 1 << crp->field_width;
-	pos = index / ncomb;
-	value = index % ncomb;
-
-	gpio_write_reg(crp->reg, crp->reg_width, crp->field_width, pos, value);
-}
-
-static int check_config_reg(struct pinmux_info *gpioc,
-			    struct pinmux_cfg_reg *crp,
-			    int index)
-{
-	unsigned long ncomb, pos, value;
-
-	ncomb = 1 << crp->field_width;
-	pos = index / ncomb;
-	value = index % ncomb;
-
-	if (gpio_read_reg(crp->reg, crp->reg_width,
-			  crp->field_width, pos) = value)
-		return 0;
-
-	return -1;
-}
-
-enum { GPIO_CFG_DRYRUN, GPIO_CFG_REQ, GPIO_CFG_FREE };
-
-static int pinmux_config_gpio(struct pinmux_info *gpioc, unsigned gpio,
-			      int pinmux_type, int cfg_mode)
-{
-	struct pinmux_cfg_reg *cr = NULL;
-	pinmux_enum_t enum_id;
-	struct pinmux_range *range;
-	int in_range, pos, index;
-	unsigned long *cntp;
-
-	switch (pinmux_type) {
-
-	case PINMUX_TYPE_FUNCTION:
-		range = NULL;
-		break;
-
-	case PINMUX_TYPE_OUTPUT:
-		range = &gpioc->output;
-		break;
-
-	case PINMUX_TYPE_INPUT:
-		range = &gpioc->input;
-		break;
-
-	case PINMUX_TYPE_INPUT_PULLUP:
-		range = &gpioc->input_pu;
-		break;
-
-	case PINMUX_TYPE_INPUT_PULLDOWN:
-		range = &gpioc->input_pd;
-		break;
-
-	default:
-		goto out_err;
-	}
-
-	pos = 0;
-	enum_id = 0;
-	index = 0;
-	while (1) {
-		pos = get_gpio_enum_id(gpioc, gpio, pos, &enum_id);
-		if (pos <= 0)
-			goto out_err;
-
-		if (!enum_id)
-			break;
-
-		in_range = enum_in_range(enum_id, &gpioc->function);
-		if (!in_range && range) {
-			in_range = enum_in_range(enum_id, range);
-
-			if (in_range && enum_id = range->force)
-				continue;
-		}
-
-		if (!in_range)
-			continue;
-
-		if (get_config_reg(gpioc, enum_id, &cr, &index, &cntp) != 0)
-			goto out_err;
-
-		switch (cfg_mode) {
-		case GPIO_CFG_DRYRUN:
-			if (!*cntp || !check_config_reg(gpioc, cr, index))
-				continue;
-			break;
-
-		case GPIO_CFG_REQ:
-			write_config_reg(gpioc, cr, index);
-			*cntp = *cntp + 1;
-			break;
-
-		case GPIO_CFG_FREE:
-			*cntp = *cntp - 1;
-			break;
-		}
-	}
-
-	return 0;
- out_err:
-	return -1;
-}
-
-static DEFINE_SPINLOCK(gpio_lock);
-
-static struct pinmux_info *chip_to_pinmux(struct gpio_chip *chip)
-{
-	return container_of(chip, struct pinmux_info, chip);
-}
-
-static int sh_gpio_request(struct gpio_chip *chip, unsigned offset)
-{
-	struct pinmux_info *gpioc = chip_to_pinmux(chip);
-	struct pinmux_data_reg *dummy;
-	unsigned long flags;
-	int i, ret, pinmux_type;
-
-	ret = -EINVAL;
-
-	if (!gpioc)
-		goto err_out;
-
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	if ((gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE) != PINMUX_TYPE_NONE)
-		goto err_unlock;
-
-	/* setup pin function here if no data is associated with pin */
-
-	if (get_data_reg(gpioc, offset, &dummy, &i) != 0)
-		pinmux_type = PINMUX_TYPE_FUNCTION;
-	else
-		pinmux_type = PINMUX_TYPE_GPIO;
-
-	if (pinmux_type = PINMUX_TYPE_FUNCTION) {
-		if (pinmux_config_gpio(gpioc, offset,
-				       pinmux_type,
-				       GPIO_CFG_DRYRUN) != 0)
-			goto err_unlock;
-
-		if (pinmux_config_gpio(gpioc, offset,
-				       pinmux_type,
-				       GPIO_CFG_REQ) != 0)
-			BUG();
-	}
-
-	gpioc->gpios[offset].flags &= ~PINMUX_FLAG_TYPE;
-	gpioc->gpios[offset].flags |= pinmux_type;
-
-	ret = 0;
- err_unlock:
-	spin_unlock_irqrestore(&gpio_lock, flags);
- err_out:
-	return ret;
-}
-
-static void sh_gpio_free(struct gpio_chip *chip, unsigned offset)
-{
-	struct pinmux_info *gpioc = chip_to_pinmux(chip);
-	unsigned long flags;
-	int pinmux_type;
-
-	if (!gpioc)
-		return;
-
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	pinmux_type = gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE;
-	pinmux_config_gpio(gpioc, offset, pinmux_type, GPIO_CFG_FREE);
-	gpioc->gpios[offset].flags &= ~PINMUX_FLAG_TYPE;
-	gpioc->gpios[offset].flags |= PINMUX_TYPE_NONE;
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
-}
-
-static int pinmux_direction(struct pinmux_info *gpioc,
-			    unsigned gpio, int new_pinmux_type)
-{
-	int pinmux_type;
-	int ret = -EINVAL;
-
-	if (!gpioc)
-		goto err_out;
-
-	pinmux_type = gpioc->gpios[gpio].flags & PINMUX_FLAG_TYPE;
-
-	switch (pinmux_type) {
-	case PINMUX_TYPE_GPIO:
-		break;
-	case PINMUX_TYPE_OUTPUT:
-	case PINMUX_TYPE_INPUT:
-	case PINMUX_TYPE_INPUT_PULLUP:
-	case PINMUX_TYPE_INPUT_PULLDOWN:
-		pinmux_config_gpio(gpioc, gpio, pinmux_type, GPIO_CFG_FREE);
-		break;
-	default:
-		goto err_out;
-	}
-
-	if (pinmux_config_gpio(gpioc, gpio,
-			       new_pinmux_type,
-			       GPIO_CFG_DRYRUN) != 0)
-		goto err_out;
-
-	if (pinmux_config_gpio(gpioc, gpio,
-			       new_pinmux_type,
-			       GPIO_CFG_REQ) != 0)
-		BUG();
-
-	gpioc->gpios[gpio].flags &= ~PINMUX_FLAG_TYPE;
-	gpioc->gpios[gpio].flags |= new_pinmux_type;
-
-	ret = 0;
- err_out:
-	return ret;
-}
-
-static int sh_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	struct pinmux_info *gpioc = chip_to_pinmux(chip);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&gpio_lock, flags);
-	ret = pinmux_direction(gpioc, offset, PINMUX_TYPE_INPUT);
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
-	return ret;
-}
-
-static void sh_gpio_set_value(struct pinmux_info *gpioc,
-			     unsigned gpio, int value)
-{
-	struct pinmux_data_reg *dr = NULL;
-	int bit = 0;
-
-	if (!gpioc || get_data_reg(gpioc, gpio, &dr, &bit) != 0)
-		BUG();
-	else
-		gpio_write_bit(dr, bit, value);
-}
-
-static int sh_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
-				    int value)
-{
-	struct pinmux_info *gpioc = chip_to_pinmux(chip);
-	unsigned long flags;
-	int ret;
-
-	sh_gpio_set_value(gpioc, offset, value);
-	spin_lock_irqsave(&gpio_lock, flags);
-	ret = pinmux_direction(gpioc, offset, PINMUX_TYPE_OUTPUT);
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
-	return ret;
-}
-
-static int sh_gpio_get_value(struct pinmux_info *gpioc, unsigned gpio)
-{
-	struct pinmux_data_reg *dr = NULL;
-	int bit = 0;
-
-	if (!gpioc || get_data_reg(gpioc, gpio, &dr, &bit) != 0) {
-		BUG();
-		return 0;
-	}
-
-	return gpio_read_reg(dr->reg, dr->reg_width, 1, bit);
-}
-
-static int sh_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	return sh_gpio_get_value(chip_to_pinmux(chip), offset);
-}
-
-static void sh_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-{
-	sh_gpio_set_value(chip_to_pinmux(chip), offset, value);
-}
-
-int register_pinmux(struct pinmux_info *pip)
-{
-	struct gpio_chip *chip = &pip->chip;
-
-	pr_info("sh pinmux: %s handling gpio %d -> %d\n",
-		pip->name, pip->first_gpio, pip->last_gpio);
-
-	setup_data_regs(pip);
-
-	chip->request = sh_gpio_request;
-	chip->free = sh_gpio_free;
-	chip->direction_input = sh_gpio_direction_input;
-	chip->get = sh_gpio_get;
-	chip->direction_output = sh_gpio_direction_output;
-	chip->set = sh_gpio_set;
-
-	WARN_ON(pip->first_gpio != 0); /* needs testing */
-
-	chip->label = pip->name;
-	chip->owner = THIS_MODULE;
-	chip->base = pip->first_gpio;
-	chip->ngpio = (pip->last_gpio - pip->first_gpio) + 1;
-
-	return gpiochip_add(chip);
-}
--- 0001/drivers/sh/Makefile
+++ work/drivers/sh/Makefile	2009-11-27 16:10:18.000000000 +0900
@@ -3,4 +3,5 @@
 #
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_MAPLE)		+= maple/
+obj-$(CONFIG_GENERIC_GPIO)	+= pfc.o
 obj-y				+= intc.o
--- /dev/null
+++ work/drivers/sh/pfc.c	2009-11-27 16:10:19.000000000 +0900
@@ -0,0 +1,584 @@
+/*
+ * Pinmuxed GPIO support for SuperH.
+ *
+ * Copyright (C) 2008 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/bitops.h>
+#include <linux/gpio.h>
+
+static int enum_in_range(pinmux_enum_t enum_id, struct pinmux_range *r)
+{
+	if (enum_id < r->begin)
+		return 0;
+
+	if (enum_id > r->end)
+		return 0;
+
+	return 1;
+}
+
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
+static int gpio_read_reg(unsigned long reg, unsigned long reg_width,
+			 unsigned long field_width, unsigned long in_pos)
+{
+	unsigned long data, mask, pos;
+
+	data = 0;
+	mask = (1 << field_width) - 1;
+	pos = reg_width - ((in_pos + 1) * field_width);
+
+#ifdef DEBUG
+	pr_info("read_reg: addr = %lx, pos = %ld, "
+		"r_width = %ld, f_width = %ld\n",
+		reg, pos, reg_width, field_width);
+#endif
+
+	data = gpio_read_raw_reg(reg, reg_width);
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
+
+#ifdef DEBUG
+	pr_info("write_reg addr = %lx, value = %ld, pos = %ld, "
+		"r_width = %ld, f_width = %ld\n",
+		reg, value, pos, reg_width, field_width);
+#endif
+
+	mask = ~(mask << pos);
+	value = value << pos;
+
+	switch (reg_width) {
+	case 8:
+		ctrl_outb((ctrl_inb(reg) & mask) | value, reg);
+		break;
+	case 16:
+		ctrl_outw((ctrl_inw(reg) & mask) | value, reg);
+		break;
+	case 32:
+		ctrl_outl((ctrl_inl(reg) & mask) | value, reg);
+		break;
+	}
+}
+
+static int setup_data_reg(struct pinmux_info *gpioc, unsigned gpio)
+{
+	struct pinmux_gpio *gpiop = &gpioc->gpios[gpio];
+	struct pinmux_data_reg *data_reg;
+	int k, n;
+
+	if (!enum_in_range(gpiop->enum_id, &gpioc->data))
+		return -1;
+
+	k = 0;
+	while (1) {
+		data_reg = gpioc->data_regs + k;
+
+		if (!data_reg->reg_width)
+			break;
+
+		for (n = 0; n < data_reg->reg_width; n++) {
+			if (data_reg->enum_ids[n] = gpiop->enum_id) {
+				gpiop->flags &= ~PINMUX_FLAG_DREG;
+				gpiop->flags |= (k << PINMUX_FLAG_DREG_SHIFT);
+				gpiop->flags &= ~PINMUX_FLAG_DBIT;
+				gpiop->flags |= (n << PINMUX_FLAG_DBIT_SHIFT);
+				return 0;
+			}
+		}
+		k++;
+	}
+
+	BUG();
+
+	return -1;
+}
+
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
+static int get_data_reg(struct pinmux_info *gpioc, unsigned gpio,
+			struct pinmux_data_reg **drp, int *bitp)
+{
+	struct pinmux_gpio *gpiop = &gpioc->gpios[gpio];
+	int k, n;
+
+	if (!enum_in_range(gpiop->enum_id, &gpioc->data))
+		return -1;
+
+	k = (gpiop->flags & PINMUX_FLAG_DREG) >> PINMUX_FLAG_DREG_SHIFT;
+	n = (gpiop->flags & PINMUX_FLAG_DBIT) >> PINMUX_FLAG_DBIT_SHIFT;
+	*drp = gpioc->data_regs + k;
+	*bitp = n;
+	return 0;
+}
+
+static int get_config_reg(struct pinmux_info *gpioc, pinmux_enum_t enum_id,
+			  struct pinmux_cfg_reg **crp, int *indexp,
+			  unsigned long **cntp)
+{
+	struct pinmux_cfg_reg *config_reg;
+	unsigned long r_width, f_width;
+	int k, n;
+
+	k = 0;
+	while (1) {
+		config_reg = gpioc->cfg_regs + k;
+
+		r_width = config_reg->reg_width;
+		f_width = config_reg->field_width;
+
+		if (!r_width)
+			break;
+		for (n = 0; n < (r_width / f_width) * 1 << f_width; n++) {
+			if (config_reg->enum_ids[n] = enum_id) {
+				*crp = config_reg;
+				*indexp = n;
+				*cntp = &config_reg->cnt[n / (1 << f_width)];
+				return 0;
+			}
+		}
+		k++;
+	}
+
+	return -1;
+}
+
+static int get_gpio_enum_id(struct pinmux_info *gpioc, unsigned gpio,
+			    int pos, pinmux_enum_t *enum_idp)
+{
+	pinmux_enum_t enum_id = gpioc->gpios[gpio].enum_id;
+	pinmux_enum_t *data = gpioc->gpio_data;
+	int k;
+
+	if (!enum_in_range(enum_id, &gpioc->data)) {
+		if (!enum_in_range(enum_id, &gpioc->mark)) {
+			pr_err("non data/mark enum_id for gpio %d\n", gpio);
+			return -1;
+		}
+	}
+
+	if (pos) {
+		*enum_idp = data[pos + 1];
+		return pos + 1;
+	}
+
+	for (k = 0; k < gpioc->gpio_data_size; k++) {
+		if (data[k] = enum_id) {
+			*enum_idp = data[k + 1];
+			return k + 1;
+		}
+	}
+
+	pr_err("cannot locate data/mark enum_id for gpio %d\n", gpio);
+	return -1;
+}
+
+static void write_config_reg(struct pinmux_info *gpioc,
+			     struct pinmux_cfg_reg *crp,
+			     int index)
+{
+	unsigned long ncomb, pos, value;
+
+	ncomb = 1 << crp->field_width;
+	pos = index / ncomb;
+	value = index % ncomb;
+
+	gpio_write_reg(crp->reg, crp->reg_width, crp->field_width, pos, value);
+}
+
+static int check_config_reg(struct pinmux_info *gpioc,
+			    struct pinmux_cfg_reg *crp,
+			    int index)
+{
+	unsigned long ncomb, pos, value;
+
+	ncomb = 1 << crp->field_width;
+	pos = index / ncomb;
+	value = index % ncomb;
+
+	if (gpio_read_reg(crp->reg, crp->reg_width,
+			  crp->field_width, pos) = value)
+		return 0;
+
+	return -1;
+}
+
+enum { GPIO_CFG_DRYRUN, GPIO_CFG_REQ, GPIO_CFG_FREE };
+
+static int pinmux_config_gpio(struct pinmux_info *gpioc, unsigned gpio,
+			      int pinmux_type, int cfg_mode)
+{
+	struct pinmux_cfg_reg *cr = NULL;
+	pinmux_enum_t enum_id;
+	struct pinmux_range *range;
+	int in_range, pos, index;
+	unsigned long *cntp;
+
+	switch (pinmux_type) {
+
+	case PINMUX_TYPE_FUNCTION:
+		range = NULL;
+		break;
+
+	case PINMUX_TYPE_OUTPUT:
+		range = &gpioc->output;
+		break;
+
+	case PINMUX_TYPE_INPUT:
+		range = &gpioc->input;
+		break;
+
+	case PINMUX_TYPE_INPUT_PULLUP:
+		range = &gpioc->input_pu;
+		break;
+
+	case PINMUX_TYPE_INPUT_PULLDOWN:
+		range = &gpioc->input_pd;
+		break;
+
+	default:
+		goto out_err;
+	}
+
+	pos = 0;
+	enum_id = 0;
+	index = 0;
+	while (1) {
+		pos = get_gpio_enum_id(gpioc, gpio, pos, &enum_id);
+		if (pos <= 0)
+			goto out_err;
+
+		if (!enum_id)
+			break;
+
+		in_range = enum_in_range(enum_id, &gpioc->function);
+		if (!in_range && range) {
+			in_range = enum_in_range(enum_id, range);
+
+			if (in_range && enum_id = range->force)
+				continue;
+		}
+
+		if (!in_range)
+			continue;
+
+		if (get_config_reg(gpioc, enum_id, &cr, &index, &cntp) != 0)
+			goto out_err;
+
+		switch (cfg_mode) {
+		case GPIO_CFG_DRYRUN:
+			if (!*cntp || !check_config_reg(gpioc, cr, index))
+				continue;
+			break;
+
+		case GPIO_CFG_REQ:
+			write_config_reg(gpioc, cr, index);
+			*cntp = *cntp + 1;
+			break;
+
+		case GPIO_CFG_FREE:
+			*cntp = *cntp - 1;
+			break;
+		}
+	}
+
+	return 0;
+ out_err:
+	return -1;
+}
+
+static DEFINE_SPINLOCK(gpio_lock);
+
+static struct pinmux_info *chip_to_pinmux(struct gpio_chip *chip)
+{
+	return container_of(chip, struct pinmux_info, chip);
+}
+
+static int sh_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
+	struct pinmux_data_reg *dummy;
+	unsigned long flags;
+	int i, ret, pinmux_type;
+
+	ret = -EINVAL;
+
+	if (!gpioc)
+		goto err_out;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	if ((gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE) != PINMUX_TYPE_NONE)
+		goto err_unlock;
+
+	/* setup pin function here if no data is associated with pin */
+
+	if (get_data_reg(gpioc, offset, &dummy, &i) != 0)
+		pinmux_type = PINMUX_TYPE_FUNCTION;
+	else
+		pinmux_type = PINMUX_TYPE_GPIO;
+
+	if (pinmux_type = PINMUX_TYPE_FUNCTION) {
+		if (pinmux_config_gpio(gpioc, offset,
+				       pinmux_type,
+				       GPIO_CFG_DRYRUN) != 0)
+			goto err_unlock;
+
+		if (pinmux_config_gpio(gpioc, offset,
+				       pinmux_type,
+				       GPIO_CFG_REQ) != 0)
+			BUG();
+	}
+
+	gpioc->gpios[offset].flags &= ~PINMUX_FLAG_TYPE;
+	gpioc->gpios[offset].flags |= pinmux_type;
+
+	ret = 0;
+ err_unlock:
+	spin_unlock_irqrestore(&gpio_lock, flags);
+ err_out:
+	return ret;
+}
+
+static void sh_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
+	unsigned long flags;
+	int pinmux_type;
+
+	if (!gpioc)
+		return;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	pinmux_type = gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE;
+	pinmux_config_gpio(gpioc, offset, pinmux_type, GPIO_CFG_FREE);
+	gpioc->gpios[offset].flags &= ~PINMUX_FLAG_TYPE;
+	gpioc->gpios[offset].flags |= PINMUX_TYPE_NONE;
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+}
+
+static int pinmux_direction(struct pinmux_info *gpioc,
+			    unsigned gpio, int new_pinmux_type)
+{
+	int pinmux_type;
+	int ret = -EINVAL;
+
+	if (!gpioc)
+		goto err_out;
+
+	pinmux_type = gpioc->gpios[gpio].flags & PINMUX_FLAG_TYPE;
+
+	switch (pinmux_type) {
+	case PINMUX_TYPE_GPIO:
+		break;
+	case PINMUX_TYPE_OUTPUT:
+	case PINMUX_TYPE_INPUT:
+	case PINMUX_TYPE_INPUT_PULLUP:
+	case PINMUX_TYPE_INPUT_PULLDOWN:
+		pinmux_config_gpio(gpioc, gpio, pinmux_type, GPIO_CFG_FREE);
+		break;
+	default:
+		goto err_out;
+	}
+
+	if (pinmux_config_gpio(gpioc, gpio,
+			       new_pinmux_type,
+			       GPIO_CFG_DRYRUN) != 0)
+		goto err_out;
+
+	if (pinmux_config_gpio(gpioc, gpio,
+			       new_pinmux_type,
+			       GPIO_CFG_REQ) != 0)
+		BUG();
+
+	gpioc->gpios[gpio].flags &= ~PINMUX_FLAG_TYPE;
+	gpioc->gpios[gpio].flags |= new_pinmux_type;
+
+	ret = 0;
+ err_out:
+	return ret;
+}
+
+static int sh_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+	ret = pinmux_direction(gpioc, offset, PINMUX_TYPE_INPUT);
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return ret;
+}
+
+static void sh_gpio_set_value(struct pinmux_info *gpioc,
+			     unsigned gpio, int value)
+{
+	struct pinmux_data_reg *dr = NULL;
+	int bit = 0;
+
+	if (!gpioc || get_data_reg(gpioc, gpio, &dr, &bit) != 0)
+		BUG();
+	else
+		gpio_write_bit(dr, bit, value);
+}
+
+static int sh_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+				    int value)
+{
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
+	unsigned long flags;
+	int ret;
+
+	sh_gpio_set_value(gpioc, offset, value);
+	spin_lock_irqsave(&gpio_lock, flags);
+	ret = pinmux_direction(gpioc, offset, PINMUX_TYPE_OUTPUT);
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return ret;
+}
+
+static int sh_gpio_get_value(struct pinmux_info *gpioc, unsigned gpio)
+{
+	struct pinmux_data_reg *dr = NULL;
+	int bit = 0;
+
+	if (!gpioc || get_data_reg(gpioc, gpio, &dr, &bit) != 0) {
+		BUG();
+		return 0;
+	}
+
+	return gpio_read_reg(dr->reg, dr->reg_width, 1, bit);
+}
+
+static int sh_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	return sh_gpio_get_value(chip_to_pinmux(chip), offset);
+}
+
+static void sh_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	sh_gpio_set_value(chip_to_pinmux(chip), offset, value);
+}
+
+int register_pinmux(struct pinmux_info *pip)
+{
+	struct gpio_chip *chip = &pip->chip;
+
+	pr_info("sh pinmux: %s handling gpio %d -> %d\n",
+		pip->name, pip->first_gpio, pip->last_gpio);
+
+	setup_data_regs(pip);
+
+	chip->request = sh_gpio_request;
+	chip->free = sh_gpio_free;
+	chip->direction_input = sh_gpio_direction_input;
+	chip->get = sh_gpio_get;
+	chip->direction_output = sh_gpio_direction_output;
+	chip->set = sh_gpio_set;
+
+	WARN_ON(pip->first_gpio != 0); /* needs testing */
+
+	chip->label = pip->name;
+	chip->owner = THIS_MODULE;
+	chip->base = pip->first_gpio;
+	chip->ngpio = (pip->last_gpio - pip->first_gpio) + 1;
+
+	return gpiochip_add(chip);
+}
--- /dev/null
+++ work/include/linux/sh_pfc.h	2009-11-27 16:18:32.000000000 +0900
@@ -0,0 +1,96 @@
+/*
+ * SuperH Pin Function Controller Support
+ *
+ * Copyright (c) 2008 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __SH_PFC_H
+#define __SH_PFC_H
+
+#include <asm-generic/gpio.h>
+
+typedef unsigned short pinmux_enum_t;
+typedef unsigned short pinmux_flag_t;
+
+#define PINMUX_TYPE_NONE            0
+#define PINMUX_TYPE_FUNCTION        1
+#define PINMUX_TYPE_GPIO            2
+#define PINMUX_TYPE_OUTPUT          3
+#define PINMUX_TYPE_INPUT           4
+#define PINMUX_TYPE_INPUT_PULLUP    5
+#define PINMUX_TYPE_INPUT_PULLDOWN  6
+
+#define PINMUX_FLAG_TYPE            (0x7)
+#define PINMUX_FLAG_WANT_PULLUP     (1 << 3)
+#define PINMUX_FLAG_WANT_PULLDOWN   (1 << 4)
+
+#define PINMUX_FLAG_DBIT_SHIFT      5
+#define PINMUX_FLAG_DBIT            (0x1f << PINMUX_FLAG_DBIT_SHIFT)
+#define PINMUX_FLAG_DREG_SHIFT      10
+#define PINMUX_FLAG_DREG            (0x3f << PINMUX_FLAG_DREG_SHIFT)
+
+struct pinmux_gpio {
+	pinmux_enum_t enum_id;
+	pinmux_flag_t flags;
+};
+
+#define PINMUX_GPIO(gpio, data_or_mark) [gpio] = { data_or_mark }
+#define PINMUX_DATA(data_or_mark, ids...) data_or_mark, ids, 0
+
+struct pinmux_cfg_reg {
+	unsigned long reg, reg_width, field_width;
+	unsigned long *cnt;
+	pinmux_enum_t *enum_ids;
+};
+
+#define PINMUX_CFG_REG(name, r, r_width, f_width) \
+	.reg = r, .reg_width = r_width, .field_width = f_width,		\
+	.cnt = (unsigned long [r_width / f_width]) {}, \
+	.enum_ids = (pinmux_enum_t [(r_width / f_width) * (1 << f_width)]) \
+
+struct pinmux_data_reg {
+	unsigned long reg, reg_width, reg_shadow;
+	pinmux_enum_t *enum_ids;
+};
+
+#define PINMUX_DATA_REG(name, r, r_width) \
+	.reg = r, .reg_width = r_width,	\
+	.enum_ids = (pinmux_enum_t [r_width]) \
+
+struct pinmux_range {
+	pinmux_enum_t begin;
+	pinmux_enum_t end;
+	pinmux_enum_t force;
+};
+
+struct pinmux_info {
+	char *name;
+	pinmux_enum_t reserved_id;
+	struct pinmux_range data;
+	struct pinmux_range input;
+	struct pinmux_range input_pd;
+	struct pinmux_range input_pu;
+	struct pinmux_range output;
+	struct pinmux_range mark;
+	struct pinmux_range function;
+
+	unsigned first_gpio, last_gpio;
+
+	struct pinmux_gpio *gpios;
+	struct pinmux_cfg_reg *cfg_regs;
+	struct pinmux_data_reg *data_regs;
+
+	pinmux_enum_t *gpio_data;
+	unsigned int gpio_data_size;
+
+	unsigned long *gpio_in_use;
+	struct gpio_chip chip;
+};
+
+int register_pinmux(struct pinmux_info *pip);
+
+#endif /* __SH_PFC_H */
