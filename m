From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:01:14 +0000
Subject: [PATCH 05/05] sh: pfc: Unlock register support
Message-Id: <20111213160114.4021.61545.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add PFC support for a 32-bit unlock register. Needed to
drive the r8a7779 PFC that comes with a funky PMMR register.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/pfc.c       |   22 ++++++++++------------
 include/linux/sh_pfc.h |    2 ++
 2 files changed, 12 insertions(+), 12 deletions(-)

--- 0017/drivers/sh/pfc.c
+++ work/drivers/sh/pfc.c	2011-12-13 11:39:55.000000000 +0900
@@ -210,7 +210,7 @@ static void write_config_reg(struct pinm
 			     unsigned long field, unsigned long value)
 {
 	void __iomem *mapped_reg;
-	unsigned long mask, pos;
+	unsigned long mask, pos, data;
 
 	config_reg_helper(gpioc, crp, field, &mapped_reg, &mask, &pos);
 
@@ -221,17 +221,15 @@ static void write_config_reg(struct pinm
 	mask = ~(mask << pos);
 	value = value << pos;
 
-	switch (crp->reg_width) {
-	case 8:
-		iowrite8((ioread8(mapped_reg) & mask) | value, mapped_reg);
-		break;
-	case 16:
-		iowrite16((ioread16(mapped_reg) & mask) | value, mapped_reg);
-		break;
-	case 32:
-		iowrite32((ioread32(mapped_reg) & mask) | value, mapped_reg);
-		break;
-	}
+	data = gpio_read_raw_reg(mapped_reg, crp->reg_width);
+	data &= mask;
+	data |= value;
+
+	if (gpioc->unlock_reg)
+		gpio_write_raw_reg(pfc_phys_to_virt(gpioc, gpioc->unlock_reg),
+				   32, ~data);
+
+	gpio_write_raw_reg(mapped_reg, crp->reg_width, data);
 }
 
 static int setup_data_reg(struct pinmux_info *gpioc, unsigned gpio)
--- 0017/include/linux/sh_pfc.h
+++ work/include/linux/sh_pfc.h	2011-12-13 11:35:55.000000000 +0900
@@ -116,6 +116,8 @@ struct pinmux_info {
 	unsigned int num_resources;
 	struct pfc_window *window;
 
+	unsigned long unlock_reg;
+
 	struct gpio_chip chip;
 };
 
