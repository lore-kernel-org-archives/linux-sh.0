From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Sep 2011 07:50:58 +0000
Subject: [PATCH] sh: pfc: Add GPIO IRQ support
Message-Id: <20110928075058.17622.91741.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add GPIO IRQ support to the shared PFC code in drivers/sh/pfc.c

The enums pointed out by a certain GPIO will be matched against
a table for IRQ to enum mappings.

Only the shared PFC code is updated by this patch. SoC specific
changes are also needed to allow platforms to make use of this
feature.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of "sh: pfc: Remove unused gpio_in_use member"

 drivers/sh/pfc.c       |   27 +++++++++++++++++++++++++++
 include/linux/sh_pfc.h |   11 +++++++++++
 2 files changed, 38 insertions(+)

--- 0001/drivers/sh/pfc.c
+++ work/drivers/sh/pfc.c	2011-09-28 15:02:21.000000000 +0900
@@ -577,6 +577,32 @@ static void sh_gpio_set(struct gpio_chip
 	sh_gpio_set_value(chip_to_pinmux(chip), offset, value);
 }
 
+static int sh_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct pinmux_info *gpioc = chip_to_pinmux(chip);
+	pinmux_enum_t enum_id;
+	pinmux_enum_t *enum_ids;
+	int i, k, pos;
+
+	pos = 0;
+	enum_id = 0;
+	while (1) {
+		pos = get_gpio_enum_id(gpioc, offset, pos, &enum_id);
+		if (pos <= 0 || !enum_id)
+			break;
+
+		for (i = 0; i < gpioc->gpio_irq_size; i++) {
+			enum_ids = gpioc->gpio_irq[i].enum_ids;
+			for (k = 0; enum_ids[k]; k++) {
+				if (enum_ids[k] = enum_id)
+					return gpioc->gpio_irq[i].irq;
+			}
+		}
+	}
+
+	return -ENOSYS;
+}
+
 int register_pinmux(struct pinmux_info *pip)
 {
 	struct gpio_chip *chip = &pip->chip;
@@ -592,6 +618,7 @@ int register_pinmux(struct pinmux_info *
 	chip->get = sh_gpio_get;
 	chip->direction_output = sh_gpio_direction_output;
 	chip->set = sh_gpio_set;
+	chip->to_irq = sh_gpio_to_irq;
 
 	WARN_ON(pip->first_gpio != 0); /* needs testing */
 
--- 0004/include/linux/sh_pfc.h
+++ work/include/linux/sh_pfc.h	2011-09-28 15:01:46.000000000 +0900
@@ -61,6 +61,14 @@ struct pinmux_data_reg {
 	.reg = r, .reg_width = r_width,	\
 	.enum_ids = (pinmux_enum_t [r_width]) \
 
+struct pinmux_irq {
+	int irq;
+	pinmux_enum_t *enum_ids;
+};
+
+#define PINMUX_IRQ(irq_nr, ids...)			   \
+	{ .irq = irq_nr, .enum_ids = (pinmux_enum_t []) { ids, 0 } }	\
+
 struct pinmux_range {
 	pinmux_enum_t begin;
 	pinmux_enum_t end;
@@ -87,6 +95,9 @@ struct pinmux_info {
 	pinmux_enum_t *gpio_data;
 	unsigned int gpio_data_size;
 
+	struct pinmux_irq *gpio_irq;
+	unsigned int gpio_irq_size;
+
 	struct gpio_chip chip;
 };
 
