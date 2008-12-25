From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Dec 2008 09:17:34 +0000
Subject: [PATCH 04/04] sh: use gpiolib
Message-Id: <20081225091734.7670.31100.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the SuperH gpio code to make use of gpiolib. The
gpiolib callbacks get() and set() are lockless, but we use our own
spinlock for the other operations to make sure hardware register
bitfield accesses stay atomic.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 r2dplus builds both with and without CONFIG_GENERIC_GPIO.
 Migo-R builds and works well.

 arch/sh/Kconfig            |    7 ++
 arch/sh/boards/Kconfig     |    4 -
 arch/sh/include/asm/gpio.h |   61 ++++++++++++++-----------
 arch/sh/kernel/Makefile_32 |    2 
 arch/sh/kernel/Makefile_64 |    2 
 arch/sh/kernel/gpio.c      |  106 ++++++++++++++++++++++----------------------
 drivers/serial/sh-sci.h    |    2 
 7 files changed, 100 insertions(+), 84 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-12-25 17:20:17.000000000 +0900
@@ -126,6 +126,13 @@ config ARCH_HAS_ILOG2_U64
 config ARCH_NO_VIRT_TO_BUS
 	def_bool y
 
+config ARCH_WANT_OPTIONAL_GPIOLIB
+	def_bool y
+	depends on !ARCH_REQUIRE_GPIOLIB
+
+config ARCH_REQUIRE_GPIOLIB
+	def_bool n
+
 config IO_TRAPPED
 	bool
 
--- 0001/arch/sh/boards/Kconfig
+++ work/arch/sh/boards/Kconfig	2008-12-25 17:20:17.000000000 +0900
@@ -165,7 +165,7 @@ config SH_SH7785LCR_29BIT_PHYSMAPS
 config SH_MIGOR
 	bool "Migo-R"
 	depends on CPU_SUBTYPE_SH7722
-	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
           by Renesas System Solutions Asia Pte. Ltd.
@@ -173,7 +173,7 @@ config SH_MIGOR
 config SH_AP325RXA
 	bool "AP-325RXA"
 	depends on CPU_SUBTYPE_SH7723
-	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Renesas "AP-325RXA" support.
 	  Compatible with ALGO SYSTEM CO.,LTD. "AP-320A"
--- 0012/arch/sh/include/asm/gpio.h
+++ work/arch/sh/include/asm/gpio.h	2008-12-25 17:28:31.000000000 +0900
@@ -19,6 +19,40 @@
 #include <cpu/gpio.h>
 #endif
 
+#define ARCH_NR_GPIOS 512
+#include <asm-generic/gpio.h>
+
+#ifdef CONFIG_GPIOLIB
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
+	WARN_ON(1);
+	return -ENOSYS;
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	WARN_ON(1);
+	return -EINVAL;
+}
+
+#endif /* CONFIG_GPIOLIB */
+
 typedef unsigned short pinmux_enum_t;
 typedef unsigned short pinmux_flag_t;
 
@@ -94,34 +128,9 @@ struct pinmux_info {
 	unsigned int gpio_data_size;
 
 	unsigned long *gpio_in_use;
+	struct gpio_chip chip;
 };
 
 int register_pinmux(struct pinmux_info *pip);
 
-int __gpio_request(unsigned gpio);
-static inline int gpio_request(unsigned gpio, const char *label)
-{
-	return __gpio_request(gpio);
-}
-void gpio_free(unsigned gpio);
-int gpio_direction_input(unsigned gpio);
-int gpio_direction_output(unsigned gpio, int value);
-int gpio_get_value(unsigned gpio);
-void gpio_set_value(unsigned gpio, int value);
-
-/* IRQ modes are unspported */
-static inline int gpio_to_irq(unsigned gpio)
-{
-	WARN_ON(1);
-	return -EINVAL;
-}
-
-static inline int irq_to_gpio(unsigned irq)
-{
-	WARN_ON(1);
-	return -EINVAL;
-}
-
-#include <asm-generic/gpio.h>
-
 #endif /* __ASM_SH_GPIO_H */
--- 0001/arch/sh/kernel/Makefile_32
+++ work/arch/sh/kernel/Makefile_32	2008-12-25 17:36:49.000000000 +0900
@@ -27,7 +27,7 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
-obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
+obj-$(CONFIG_ARCH_REQUIRE_GPIOLIB)	+= gpio.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 
--- 0001/arch/sh/kernel/Makefile_64
+++ work/arch/sh/kernel/Makefile_64	2008-12-25 17:37:06.000000000 +0900
@@ -15,6 +15,6 @@ obj-$(CONFIG_KEXEC)		+= machine_kexec.o 
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
-obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
+obj-$(CONFIG_ARCH_REQUIRE_GPIOLIB)	+= gpio.o
 
 EXTRA_CFLAGS += -Werror
--- 0012/arch/sh/kernel/gpio.c
+++ work/arch/sh/kernel/gpio.c	2008-12-25 17:20:17.000000000 +0900
@@ -19,22 +19,6 @@
 #include <linux/bitops.h>
 #include <linux/gpio.h>
 
-static struct pinmux_info *registered_gpio;
-
-static struct pinmux_info *gpio_controller(unsigned gpio)
-{
-	if (!registered_gpio)
-		return NULL;
-
-	if (gpio < registered_gpio->first_gpio)
-		return NULL;
-
-	if (gpio > registered_gpio->last_gpio)
-		return NULL;
-
-	return registered_gpio;
-}
-
 static int enum_in_range(pinmux_enum_t enum_id, struct pinmux_range *r)
 {
 	if (enum_id < r->begin)
@@ -398,9 +382,14 @@ static int pinmux_config_gpio(struct pin
 
 static DEFINE_SPINLOCK(gpio_lock);
 
-int __gpio_request(unsigned gpio)
+static struct pinmux_info *chip_to_pinmux(struct gpio_chip *chip)
+{
+	return container_of(chip, struct pinmux_info, chip);
+}
+
+static int sh_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
-	struct pinmux_info *gpioc = gpio_controller(gpio);
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
 	struct pinmux_data_reg *dummy;
 	unsigned long flags;
 	int i, ret, pinmux_type;
@@ -412,30 +401,30 @@ int __gpio_request(unsigned gpio)
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-	if ((gpioc->gpios[gpio].flags & PINMUX_FLAG_TYPE) != PINMUX_TYPE_NONE)
+	if ((gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE) != PINMUX_TYPE_NONE)
 		goto err_unlock;
 
 	/* setup pin function here if no data is associated with pin */
 
-	if (get_data_reg(gpioc, gpio, &dummy, &i) != 0)
+	if (get_data_reg(gpioc, offset, &dummy, &i) != 0)
 		pinmux_type = PINMUX_TYPE_FUNCTION;
 	else
 		pinmux_type = PINMUX_TYPE_GPIO;
 
 	if (pinmux_type = PINMUX_TYPE_FUNCTION) {
-		if (pinmux_config_gpio(gpioc, gpio,
+		if (pinmux_config_gpio(gpioc, offset,
 				       pinmux_type,
 				       GPIO_CFG_DRYRUN) != 0)
 			goto err_unlock;
 
-		if (pinmux_config_gpio(gpioc, gpio,
+		if (pinmux_config_gpio(gpioc, offset,
 				       pinmux_type,
 				       GPIO_CFG_REQ) != 0)
 			BUG();
 	}
 
-	gpioc->gpios[gpio].flags &= ~PINMUX_FLAG_TYPE;
-	gpioc->gpios[gpio].flags |= pinmux_type;
+	gpioc->gpios[offset].flags &= ~PINMUX_FLAG_TYPE;
+	gpioc->gpios[offset].flags |= pinmux_type;
 
 	ret = 0;
  err_unlock:
@@ -443,11 +432,10 @@ int __gpio_request(unsigned gpio)
  err_out:
 	return ret;
 }
-EXPORT_SYMBOL(__gpio_request);
 
-void gpio_free(unsigned gpio)
+static void sh_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
-	struct pinmux_info *gpioc = gpio_controller(gpio);
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
 	unsigned long flags;
 	int pinmux_type;
 
@@ -456,14 +444,13 @@ void gpio_free(unsigned gpio)
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-	pinmux_type = gpioc->gpios[gpio].flags & PINMUX_FLAG_TYPE;
-	pinmux_config_gpio(gpioc, gpio, pinmux_type, GPIO_CFG_FREE);
-	gpioc->gpios[gpio].flags &= ~PINMUX_FLAG_TYPE;
-	gpioc->gpios[gpio].flags |= PINMUX_TYPE_NONE;
+	pinmux_type = gpioc->gpios[offset].flags & PINMUX_FLAG_TYPE;
+	pinmux_config_gpio(gpioc, offset, pinmux_type, GPIO_CFG_FREE);
+	gpioc->gpios[offset].flags &= ~PINMUX_FLAG_TYPE;
+	gpioc->gpios[offset].flags |= PINMUX_TYPE_NONE;
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 }
-EXPORT_SYMBOL(gpio_free);
 
 static int pinmux_direction(struct pinmux_info *gpioc,
 			    unsigned gpio, int new_pinmux_type)
@@ -507,21 +494,20 @@ static int pinmux_direction(struct pinmu
 	return ret;
 }
 
-int gpio_direction_input(unsigned gpio)
+static int sh_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	struct pinmux_info *gpioc = gpio_controller(gpio);
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&gpio_lock, flags);
-	ret = pinmux_direction(gpioc, gpio, PINMUX_TYPE_INPUT);
+	ret = pinmux_direction(gpioc, offset, PINMUX_TYPE_INPUT);
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	return ret;
 }
-EXPORT_SYMBOL(gpio_direction_input);
 
-static void __gpio_set_value(struct pinmux_info *gpioc,
+static void sh_gpio_set_value(struct pinmux_info *gpioc,
 			     unsigned gpio, int value)
 {
 	struct pinmux_data_reg *dr = NULL;
@@ -533,22 +519,22 @@ static void __gpio_set_value(struct pinm
 		gpio_write_bit(dr, bit, value);
 }
 
-int gpio_direction_output(unsigned gpio, int value)
+static int sh_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+				    int value)
 {
-	struct pinmux_info *gpioc = gpio_controller(gpio);
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
 	unsigned long flags;
 	int ret;
 
-	__gpio_set_value(gpioc, gpio, value);
+	sh_gpio_set_value(gpioc, offset, value);
 	spin_lock_irqsave(&gpio_lock, flags);
-	ret = pinmux_direction(gpioc, gpio, PINMUX_TYPE_OUTPUT);
+	ret = pinmux_direction(gpioc, offset, PINMUX_TYPE_OUTPUT);
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	return ret;
 }
-EXPORT_SYMBOL(gpio_direction_output);
 
-static int __gpio_get_value(struct pinmux_info *gpioc, unsigned gpio)
+static int sh_gpio_get_value(struct pinmux_info *gpioc, unsigned gpio)
 {
 	struct pinmux_data_reg *dr = NULL;
 	int bit = 0;
@@ -561,24 +547,38 @@ static int __gpio_get_value(struct pinmu
 	return gpio_read_reg(dr->reg, dr->reg_width, 1, bit);
 }
 
-int gpio_get_value(unsigned gpio)
+static int sh_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return __gpio_get_value(gpio_controller(gpio), gpio);
+	return sh_gpio_get_value(chip_to_pinmux(chip), offset);
 }
-EXPORT_SYMBOL(gpio_get_value);
 
-void gpio_set_value(unsigned gpio, int value)
+static void sh_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	__gpio_set_value(gpio_controller(gpio), gpio, value);
+	sh_gpio_set_value(chip_to_pinmux(chip), offset, value);
 }
-EXPORT_SYMBOL(gpio_set_value);
 
 int register_pinmux(struct pinmux_info *pip)
 {
-	registered_gpio = pip;
-	setup_data_regs(pip);
-	pr_info("pinmux: %s handling gpio %d -> %d\n",
+	struct gpio_chip *chip = &pip->chip;
+
+	pr_info("sh pinmux: %s handling gpio %d -> %d\n",
 		pip->name, pip->first_gpio, pip->last_gpio);
 
-	return 0;
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
 }
--- 0001/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2008-12-25 17:31:11.000000000 +0900
@@ -1,6 +1,6 @@
 #include <linux/serial_core.h>
 #include <asm/io.h>
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 
 #if defined(CONFIG_H83007) || defined(CONFIG_H83068)
 #include <asm/regs306x.h>
