From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Dec 2008 09:17:09 +0000
Subject: [PATCH 01/04] sh: make gpio_get/set_value() O(1)
Message-Id: <20081225091709.7670.50390.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch modifies the table based SuperH gpio implementation to
make use of direct table lookups. With this change the functions
gpio_get_value() and gpio_set_value() are O(1).

Tested on Migo-R using bitbanging mmc. Performance is improved from
11 KBytes/s to 26 Kbytes/s.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/gpio.h |    7 +++++-
 arch/sh/kernel/gpio.c      |   48 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 12 deletions(-)

--- 0001/arch/sh/include/asm/gpio.h
+++ work/arch/sh/include/asm/gpio.h	2008-11-05 17:13:25.000000000 +0900
@@ -20,7 +20,7 @@
 #endif
 
 typedef unsigned short pinmux_enum_t;
-typedef unsigned char pinmux_flag_t;
+typedef unsigned short pinmux_flag_t;
 
 #define PINMUX_TYPE_NONE            0
 #define PINMUX_TYPE_FUNCTION        1
@@ -34,6 +34,11 @@ typedef unsigned char pinmux_flag_t;
 #define PINMUX_FLAG_WANT_PULLUP     (1 << 3)
 #define PINMUX_FLAG_WANT_PULLDOWN   (1 << 4)
 
+#define PINMUX_FLAG_DBIT_SHIFT      5
+#define PINMUX_FLAG_DBIT            (0x1f << PINMUX_FLAG_DBIT_SHIFT)
+#define PINMUX_FLAG_DREG_SHIFT      10
+#define PINMUX_FLAG_DREG            (0x3f << PINMUX_FLAG_DREG_SHIFT)
+
 struct pinmux_gpio {
 	pinmux_enum_t enum_id;
 	pinmux_flag_t flags;
--- 0001/arch/sh/kernel/gpio.c
+++ work/arch/sh/kernel/gpio.c	2008-11-05 17:19:48.000000000 +0900
@@ -95,14 +95,13 @@ static int read_write_reg(unsigned long 
 	return 0;
 }
 
-static int get_data_reg(struct pinmux_info *gpioc, unsigned gpio,
-			struct pinmux_data_reg **drp, int *bitp)
+static int setup_data_reg(struct pinmux_info *gpioc, unsigned gpio)
 {
-	pinmux_enum_t enum_id = gpioc->gpios[gpio].enum_id;
+	struct pinmux_gpio *gpiop = &gpioc->gpios[gpio];
 	struct pinmux_data_reg *data_reg;
 	int k, n;
 
-	if (!enum_in_range(enum_id, &gpioc->data))
+	if (!enum_in_range(gpiop->enum_id, &gpioc->data))
 		return -1;
 
 	k = 0;
@@ -113,19 +112,38 @@ static int get_data_reg(struct pinmux_in
 			break;
 
 		for (n = 0; n < data_reg->reg_width; n++) {
-			if (data_reg->enum_ids[n] = enum_id) {
-				*drp = data_reg;
-				*bitp = n;
+			if (data_reg->enum_ids[n] = gpiop->enum_id) {
+				gpiop->flags &= ~PINMUX_FLAG_DREG;
+				gpiop->flags |= (k << PINMUX_FLAG_DREG_SHIFT);
+				gpiop->flags &= ~PINMUX_FLAG_DBIT;
+				gpiop->flags |= (n << PINMUX_FLAG_DBIT_SHIFT);
 				return 0;
-
 			}
 		}
 		k++;
 	}
 
+	BUG();
+
 	return -1;
 }
 
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
 static int get_config_reg(struct pinmux_info *gpioc, pinmux_enum_t enum_id,
 			  struct pinmux_cfg_reg **crp, int *indexp,
 			  unsigned long **cntp)
@@ -341,7 +359,8 @@ int __gpio_request(unsigned gpio)
 			BUG();
 	}
 
-	gpioc->gpios[gpio].flags = pinmux_type;
+	gpioc->gpios[gpio].flags &= ~PINMUX_FLAG_TYPE;
+	gpioc->gpios[gpio].flags |= pinmux_type;
 
 	ret = 0;
  err_unlock:
@@ -364,7 +383,8 @@ void gpio_free(unsigned gpio)
 
 	pinmux_type = gpioc->gpios[gpio].flags & PINMUX_FLAG_TYPE;
 	pinmux_config_gpio(gpioc, gpio, pinmux_type, GPIO_CFG_FREE);
-	gpioc->gpios[gpio].flags = PINMUX_TYPE_NONE;
+	gpioc->gpios[gpio].flags &= ~PINMUX_FLAG_TYPE;
+	gpioc->gpios[gpio].flags |= PINMUX_TYPE_NONE;
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 }
@@ -401,7 +421,8 @@ static int pinmux_direction(struct pinmu
 			       GPIO_CFG_REQ) != 0)
 		BUG();
 
-	gpioc->gpios[gpio].flags = new_pinmux_type;
+	gpioc->gpios[gpio].flags &= ~PINMUX_FLAG_TYPE;
+	gpioc->gpios[gpio].flags |= new_pinmux_type;
 
 	ret = 0;
  err_out:
@@ -494,9 +515,14 @@ EXPORT_SYMBOL(gpio_set_value);
 
 int register_pinmux(struct pinmux_info *pip)
 {
+	int k;
+
 	registered_gpio = pip;
 	pr_info("pinmux: %s handling gpio %d -> %d\n",
 		pip->name, pip->first_gpio, pip->last_gpio);
 
+	for (k = pip->first_gpio; k <= pip->last_gpio; k++)
+		setup_data_reg(pip, k);
+
 	return 0;
 }
