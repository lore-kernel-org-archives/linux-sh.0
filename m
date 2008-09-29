From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Sep 2008 10:46:43 +0000
Subject: [PATCH] sh: Add GPIO and pinmux base code V2
Message-Id: <20080929104643.5355.23964.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds pinmux table parser code and gpiolib glue.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Requires the request/free gpiolib patch by David Brownell.

 arch/sh/Kconfig            |    3 
 arch/sh/include/asm/gpio.h |  105 ++++++++++
 arch/sh/kernel/Makefile_32 |    1 
 arch/sh/kernel/Makefile_64 |    1 
 arch/sh/kernel/gpio.c      |  440 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 550 insertions(+)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-09-29 15:49:52.000000000 +0900
@@ -60,6 +60,9 @@ config GENERIC_HARDIRQS_NO__DO_IRQ
 config GENERIC_IRQ_PROBE
 	def_bool y
 
+config GENERIC_GPIO
+	def_bool n
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 
--- 0003/arch/sh/include/asm/gpio.h
+++ work/arch/sh/include/asm/gpio.h	2008-09-29 15:51:42.000000000 +0900
@@ -1,6 +1,10 @@
 /*
  *  include/asm-sh/gpio.h
  *
+ * Generic GPIO API using gpiolib and pinmux table support for SuperH.
+ *
+ * Copyright (c) 2008 Magnus Damm
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -8,4 +12,105 @@
 #ifndef __ASM_SH_GPIO_H
 #define __ASM_SH_GPIO_H
 
+#define ARCH_NR_GPIOS 512
+#include <asm-generic/gpio.h>
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+static inline int gpio_cansleep(unsigned gpio)
+{
+	return __gpio_cansleep(gpio);
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return -ENOSYS;
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	return -EINVAL;
+}
+
+typedef unsigned short pinmux_enum_t;
+typedef unsigned char pinmux_flag_t;
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
+#define PINMUX_CFG_REG(name, r, r_width, f_width)			\
+	.reg = r, .reg_width = r_width, .field_width = f_width,		\
+	.cnt = (unsigned long [r_width / f_width]) {},			\
+	.enum_ids = (pinmux_enum_t [(r_width / f_width) * (1 << f_width)])
+
+struct pinmux_data_reg {
+	unsigned long reg, reg_width;
+	pinmux_enum_t *enum_ids;
+};
+
+#define PINMUX_DATA_REG(name, r, r_width)	\
+	.reg = r, .reg_width = r_width,		\
+	.enum_ids = (pinmux_enum_t [r_width])
+
+struct pinmux_range {
+	pinmux_enum_t begin;
+	pinmux_enum_t end;
+};
+
+struct pinmux_info {
+	struct gpio_chip chip;
+
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
+};
+
+int register_pinmux(struct pinmux_info *pip);
+
 #endif /* __ASM_SH_GPIO_H */
--- 0001/arch/sh/kernel/Makefile_32
+++ work/arch/sh/kernel/Makefile_32	2008-09-29 15:49:52.000000000 +0900
@@ -23,5 +23,6 @@ obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_GPIOLIB)		+= gpio.o
 
 EXTRA_CFLAGS += -Werror
--- 0001/arch/sh/kernel/Makefile_64
+++ work/arch/sh/kernel/Makefile_64	2008-09-29 15:49:52.000000000 +0900
@@ -18,5 +18,6 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
+obj-$(CONFIG_GPIOLIB)		+= gpio.o
 
 EXTRA_CFLAGS += -Werror
--- /dev/null
+++ work/arch/sh/kernel/gpio.c	2008-09-29 15:55:01.000000000 +0900
@@ -0,0 +1,440 @@
+/*
+ * Pinmuxed GPIO support for SuperH through gpiolib.
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
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+static DEFINE_SPINLOCK(gpio_register_lock);
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
+static int read_write_reg(unsigned long reg, unsigned long reg_width,
+			  unsigned long field_width, unsigned long in_pos,
+			  unsigned long value, int do_write)
+{
+	unsigned long flags, data, mask, pos;
+
+	flags = 0; /* kill silly warning */
+	data = 0;
+	mask = (1 << field_width) - 1;
+	pos = reg_width - ((in_pos + 1) * field_width);
+
+#ifdef DEBUG
+	pr_info("sh pinmux: %s, addr = %lx, value = %ld, pos = %ld, "
+		"r_width = %ld, f_width = %ld\n",
+		do_write ? "write" : "read", reg, value, pos,
+		reg_width, field_width);
+#endif
+
+	/* use spinlock to protect read-modify-write register access.
+	 * the read case does not need any protection.
+	 */
+
+	if (do_write)
+		spin_lock_irqsave(&gpio_register_lock, flags);
+
+	switch (reg_width) {
+	case 8:
+		data = ctrl_inb(reg);
+		break;
+	case 16:
+		data = ctrl_inw(reg);
+		break;
+	case 32:
+		data = ctrl_inl(reg);
+		break;
+	default:
+		BUG();
+	}
+
+	if (!do_write)
+		return (data >> pos) & mask;
+
+	data &= ~(mask << pos);
+	data |= value << pos;
+
+	switch (reg_width) {
+	case 8:
+		ctrl_outb(data, reg);
+		break;
+	case 16:
+		ctrl_outw(data, reg);
+		break;
+	case 32:
+		ctrl_outl(data, reg);
+		break;
+	}
+
+	spin_unlock_irqrestore(&gpio_register_lock, flags);
+	return 0;
+}
+
+static int get_data_reg(struct pinmux_info *gpioc, unsigned gpio,
+			struct pinmux_data_reg **drp, int *bitp)
+{
+	pinmux_enum_t enum_id = gpioc->gpios[gpio].enum_id;
+	struct pinmux_data_reg *data_reg;
+	int k, n;
+
+	if (!enum_in_range(enum_id, &gpioc->data))
+		return -ENXIO;
+
+	k = 0;
+	while (1) {
+		data_reg = gpioc->data_regs + k;
+
+		if (!data_reg->reg_width)
+			break;
+
+		for (n = 0; n < data_reg->reg_width; n++) {
+			if (data_reg->enum_ids[n] = enum_id) {
+				*drp = data_reg;
+				*bitp = n;
+				return 0;
+			}
+		}
+		k++;
+	}
+
+	return -ENXIO;
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
+
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
+	return -ENXIO;
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
+			return -ENXIO;
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
+	return -ENXIO;
+}
+
+static int write_config_reg(struct pinmux_info *gpioc,
+			    struct pinmux_cfg_reg *crp,
+			    int index)
+{
+	unsigned long ncomb, pos, value;
+
+	ncomb = 1 << crp->field_width;
+	pos = index / ncomb;
+	value = index % ncomb;
+
+	return read_write_reg(crp->reg, crp->reg_width,
+			      crp->field_width, pos, value, 1);
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
+	if (read_write_reg(crp->reg, crp->reg_width,
+			   crp->field_width, pos, 0, 0) = value)
+		return 0;
+
+	return -1;
+}
+
+enum { GPIO_CFG_DRYRUN, GPIO_CFG_REQ, GPIO_CFG_FREE };
+
+int pinmux_config_gpio(struct pinmux_info *gpioc, unsigned gpio,
+		       int pinmux_type, int cfg_mode)
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
+		if (!in_range && range)
+			in_range = enum_in_range(enum_id, range);
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
+			if (write_config_reg(gpioc, cr, index) != 0)
+				goto out_err;
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
+static struct pinmux_info *sh_pinmux_info(struct gpio_chip *chip)
+{
+	return container_of(chip, struct pinmux_info, chip);
+}
+
+static int sh_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct pinmux_info *gpioc = sh_pinmux_info(chip);
+	struct pinmux_data_reg *dummy;
+	int i, pinmux_type;
+
+	pinmux_type = gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE;
+
+	BUG_ON(pinmux_type != PINMUX_TYPE_NONE);
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
+			return -EBUSY;
+
+		if (pinmux_config_gpio(gpioc, offset,
+				       pinmux_type,
+				       GPIO_CFG_REQ) != 0)
+			BUG();
+	}
+
+	gpioc->gpios[offset].flags = pinmux_type;
+	return 0;
+}
+
+static void sh_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct pinmux_info *gpioc = sh_pinmux_info(chip);
+	int pinmux_type;
+
+	pinmux_type = gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE;
+	pinmux_config_gpio(gpioc, offset, pinmux_type, GPIO_CFG_FREE);
+	gpioc->gpios[offset].flags = PINMUX_TYPE_NONE;
+}
+
+static int sh_gpio_direction(struct gpio_chip *chip, unsigned offset,
+			     int new_pinmux_type)
+{
+	struct pinmux_info *gpioc = sh_pinmux_info(chip);
+	int pinmux_type;
+
+	pinmux_type = gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE;
+
+	switch (pinmux_type) {
+	case PINMUX_TYPE_GPIO:
+		break;
+	case PINMUX_TYPE_OUTPUT:
+	case PINMUX_TYPE_INPUT:
+	case PINMUX_TYPE_INPUT_PULLUP:
+	case PINMUX_TYPE_INPUT_PULLDOWN:
+		pinmux_config_gpio(gpioc, offset, pinmux_type, GPIO_CFG_FREE);
+		break;
+	default:
+		BUG();
+		return -EINVAL;
+	}
+
+	if (pinmux_config_gpio(gpioc, offset,
+			       new_pinmux_type,
+			       GPIO_CFG_DRYRUN) != 0)
+		return -EBUSY;
+
+	if (pinmux_config_gpio(gpioc, offset,
+			       new_pinmux_type,
+			       GPIO_CFG_REQ) != 0)
+		BUG();
+
+	gpioc->gpios[offset].flags = new_pinmux_type;
+	return 0;
+}
+
+static int sh_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return sh_gpio_direction(chip, offset, PINMUX_TYPE_INPUT);
+}
+
+static int sh_gpio_get_set_value(struct gpio_chip *chip, unsigned offset,
+				 int value, int do_write)
+{
+	struct pinmux_info *gpioc = sh_pinmux_info(chip);
+	struct pinmux_data_reg *dr = NULL;
+	int bit = 0;
+
+	if (get_data_reg(gpioc, offset, &dr, &bit) != 0)
+		BUG();
+	else
+		value = read_write_reg(dr->reg, dr->reg_width,
+				       1, bit, value, do_write);
+
+	return value;
+}
+
+static int sh_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+				    int value)
+{
+	sh_gpio_get_set_value(chip, offset, value, 1);
+	return sh_gpio_direction(chip, offset, PINMUX_TYPE_OUTPUT);
+}
+
+static int sh_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	return sh_gpio_get_set_value(chip, offset, 0, 0);
+}
+
+static void sh_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	sh_gpio_get_set_value(chip, offset, value, 1);
+}
+
+int register_pinmux(struct pinmux_info *pip)
+{
+	struct gpio_chip *chip = &pip->chip;
+
+	pr_info("sh pinmux: %s handling gpio %d -> %d\n",
+		pip->name, pip->first_gpio, pip->last_gpio);
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
