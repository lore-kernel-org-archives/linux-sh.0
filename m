From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:00:55 +0000
Subject: [PATCH 03/05] sh: pfc: Add config_reg_helper() function
Message-Id: <20111213160055.4021.37352.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a helper function for shared config reg access
calculations. This allows us to reduce the amount
of duplicated code, and at the same time prepare
for a common place for future variable bitwidth
config reg support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/pfc.c |   76 ++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

--- 0019/drivers/sh/pfc.c
+++ work/drivers/sh/pfc.c	2011-12-12 21:02:51.000000000 +0900
@@ -167,41 +167,52 @@ static void gpio_write_bit(struct pinmux
 	gpio_write_raw_reg(dr->mapped_reg, dr->reg_width, dr->reg_shadow);
 }
 
-static int gpio_read_reg(void __iomem *mapped_reg, unsigned long reg_width,
-			 unsigned long field_width, unsigned long in_pos,
-			 unsigned long reg)
+static void config_reg_helper(struct pinmux_info *gpioc,
+			      struct pinmux_cfg_reg *crp,
+			      unsigned long in_pos,
+			      void __iomem **mapped_regp,
+			      unsigned long *maskp,
+			      unsigned long *posp)
 {
-	unsigned long data, mask, pos;
+	*mapped_regp = pfc_phys_to_virt(gpioc, crp->reg);
 
-	data = 0;
-	mask = (1 << field_width) - 1;
-	pos = reg_width - ((in_pos + 1) * field_width);
+	*maskp = (1 << crp->field_width) - 1;
+	*posp = crp->reg_width - ((in_pos + 1) * crp->field_width);
+}
+
+static int read_config_reg(struct pinmux_info *gpioc,
+			   struct pinmux_cfg_reg *crp,
+			   unsigned long field)
+{
+	void __iomem *mapped_reg;
+	unsigned long mask, pos;
+
+	config_reg_helper(gpioc, crp, field, &mapped_reg, &mask, &pos);
 
-	pr_debug("read_reg: addr = %lx, pos = %ld, "
+	pr_debug("read_reg: addr = %lx, field = %ld, "
 		 "r_width = %ld, f_width = %ld\n",
-		 reg, pos, reg_width, field_width);
+		 crp->reg, field, crp->reg_width, crp->field_width);
 
-	data = gpio_read_raw_reg(mapped_reg, reg_width);
-	return (data >> pos) & mask;
+	return (gpio_read_raw_reg(mapped_reg, crp->reg_width) >> pos) & mask;
 }
 
-static void gpio_write_reg(void __iomem *mapped_reg, unsigned long reg_width,
-			   unsigned long field_width, unsigned long in_pos,
-			   unsigned long value, unsigned long reg)
+static void write_config_reg(struct pinmux_info *gpioc,
+			     struct pinmux_cfg_reg *crp,
+			     unsigned long field, unsigned long value)
 {
+	void __iomem *mapped_reg;
 	unsigned long mask, pos;
 
-	mask = (1 << field_width) - 1;
-	pos = reg_width - ((in_pos + 1) * field_width);
+	config_reg_helper(gpioc, crp, field, &mapped_reg, &mask, &pos);
 
-	pr_debug("write_reg addr = %lx, value = %ld, pos = %ld, "
+	pr_debug("write_reg addr = %lx, value = %ld, field = %ld, "
 		 "r_width = %ld, f_width = %ld\n",
-		 reg, value, pos, reg_width, field_width);
+		 crp->reg, value, field, crp->reg_width, crp->field_width);
 
 	mask = ~(mask << pos);
 	value = value << pos;
 
-	switch (reg_width) {
+	switch (crp->reg_width) {
 	case 8:
 		iowrite8((ioread8(mapped_reg) & mask) | value, mapped_reg);
 		break;
@@ -349,29 +360,6 @@ static int get_gpio_enum_id(struct pinmu
 	return -1;
 }
 
-static void write_config_reg(struct pinmux_info *gpioc,
-			     struct pinmux_cfg_reg *crp,
-			     int field, int value)
-{
-	void __iomem *mapped_reg = pfc_phys_to_virt(gpioc, crp->reg);
-
-	gpio_write_reg(mapped_reg, crp->reg_width, crp->field_width,
-		       field, value, crp->reg);
-}
-
-static int check_config_reg(struct pinmux_info *gpioc,
-			    struct pinmux_cfg_reg *crp,
-			    int field, int value)
-{
-	void __iomem *mapped_reg = pfc_phys_to_virt(gpioc, crp->reg);
-
-	if (gpio_read_reg(mapped_reg, crp->reg_width,
-			  crp->field_width, field, crp->reg) = value)
-		return 0;
-
-	return -1;
-}
-
 enum { GPIO_CFG_DRYRUN, GPIO_CFG_REQ, GPIO_CFG_FREE };
 
 static int pinmux_config_gpio(struct pinmux_info *gpioc, unsigned gpio,
@@ -465,8 +453,8 @@ static int pinmux_config_gpio(struct pin
 
 		switch (cfg_mode) {
 		case GPIO_CFG_DRYRUN:
-			if (!*cntp || !check_config_reg(gpioc, cr,
-							field, value))
+			if (!*cntp ||
+			    (read_config_reg(gpioc, cr, field) != value))
 				continue;
 			break;
 
