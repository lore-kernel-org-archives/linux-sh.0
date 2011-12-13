From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:00:37 +0000
Subject: [PATCH 01/05] sh: pfc: Add gpio_read_bit() for data register access
Message-Id: <20111213160037.4021.88360.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Introduce gpio_read_bit() for data register read access
and modify sh_gpio_get_value() to make use of the new
function instead of gpio_read_reg(). The purpose of
this change is to update the code to only use the
gpio_read_reg() function for config register access.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/pfc.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- 0013/drivers/sh/pfc.c
+++ work/drivers/sh/pfc.c	2011-12-12 18:33:48.000000000 +0900
@@ -135,6 +135,19 @@ static void gpio_write_raw_reg(void __io
 	BUG();
 }
 
+static int gpio_read_bit(struct pinmux_data_reg *dr,
+			 unsigned long in_pos)
+{
+	unsigned long pos;
+
+	pos = dr->reg_width - (in_pos + 1);
+
+	pr_debug("read_bit: addr = %lx, pos = %ld, "
+		 "r_width = %ld\n", dr->reg, pos, dr->reg_width);
+
+	return (gpio_read_raw_reg(dr->mapped_reg, dr->reg_width) >> pos) & 1;
+}
+
 static void gpio_write_bit(struct pinmux_data_reg *dr,
 			   unsigned long in_pos, unsigned long value)
 {
@@ -644,7 +657,7 @@ static int sh_gpio_get_value(struct pinm
 	if (!gpioc || get_data_reg(gpioc, gpio, &dr, &bit) != 0)
 		return -EINVAL;
 
-	return gpio_read_reg(dr->mapped_reg, dr->reg_width, 1, bit, dr->reg);
+	return gpio_read_bit(dr, bit);
 }
 
 static int sh_gpio_get(struct gpio_chip *chip, unsigned offset)
