From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:00:46 +0000
Subject: [PATCH 02/05] sh: pfc: Convert index to field and value pair
Message-Id: <20111213160046.4021.598.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the way the PFC code is passing bitfield
selection between configure register functions.

Convert the code from using index only to bitfield
number and selected value. First step towards future
variable bitfield width support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/pfc.c |   45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

--- 0017/drivers/sh/pfc.c
+++ work/drivers/sh/pfc.c	2011-12-12 18:43:53.000000000 +0900
@@ -287,7 +287,8 @@ static int get_data_reg(struct pinmux_in
 }
 
 static int get_config_reg(struct pinmux_info *gpioc, pinmux_enum_t enum_id,
-			  struct pinmux_cfg_reg **crp, int *indexp,
+			  struct pinmux_cfg_reg **crp,
+			  int *fieldp, int *valuep,
 			  unsigned long **cntp)
 {
 	struct pinmux_cfg_reg *config_reg;
@@ -306,7 +307,8 @@ static int get_config_reg(struct pinmux_
 		for (n = 0; n < (r_width / f_width) * (1 << f_width); n++) {
 			if (config_reg->enum_ids[n] = enum_id) {
 				*crp = config_reg;
-				*indexp = n;
+				*fieldp = n / (1 << f_width);
+				*valuep = n % (1 << f_width);
 				*cntp = &config_reg->cnt[n / (1 << f_width)];
 				return 0;
 			}
@@ -349,36 +351,22 @@ static int get_gpio_enum_id(struct pinmu
 
 static void write_config_reg(struct pinmux_info *gpioc,
 			     struct pinmux_cfg_reg *crp,
-			     int index)
+			     int field, int value)
 {
-	unsigned long ncomb, pos, value;
-	void __iomem *mapped_reg;
-
-	ncomb = 1 << crp->field_width;
-	pos = index / ncomb;
-	value = index % ncomb;
-
-	mapped_reg = pfc_phys_to_virt(gpioc, crp->reg);
+	void __iomem *mapped_reg = pfc_phys_to_virt(gpioc, crp->reg);
 
 	gpio_write_reg(mapped_reg, crp->reg_width, crp->field_width,
-		       pos, value, crp->reg);
+		       field, value, crp->reg);
 }
 
 static int check_config_reg(struct pinmux_info *gpioc,
 			    struct pinmux_cfg_reg *crp,
-			    int index)
+			    int field, int value)
 {
-	unsigned long ncomb, pos, value;
-	void __iomem *mapped_reg;
-
-	ncomb = 1 << crp->field_width;
-	pos = index / ncomb;
-	value = index % ncomb;
-
-	mapped_reg = pfc_phys_to_virt(gpioc, crp->reg);
+	void __iomem *mapped_reg = pfc_phys_to_virt(gpioc, crp->reg);
 
 	if (gpio_read_reg(mapped_reg, crp->reg_width,
-			  crp->field_width, pos, crp->reg) = value)
+			  crp->field_width, field, crp->reg) = value)
 		return 0;
 
 	return -1;
@@ -392,7 +380,7 @@ static int pinmux_config_gpio(struct pin
 	struct pinmux_cfg_reg *cr = NULL;
 	pinmux_enum_t enum_id;
 	struct pinmux_range *range;
-	int in_range, pos, index;
+	int in_range, pos, field, value;
 	unsigned long *cntp;
 
 	switch (pinmux_type) {
@@ -423,7 +411,8 @@ static int pinmux_config_gpio(struct pin
 
 	pos = 0;
 	enum_id = 0;
-	index = 0;
+	field = 0;
+	value = 0;
 	while (1) {
 		pos = get_gpio_enum_id(gpioc, gpio, pos, &enum_id);
 		if (pos <= 0)
@@ -470,17 +459,19 @@ static int pinmux_config_gpio(struct pin
 		if (!in_range)
 			continue;
 
-		if (get_config_reg(gpioc, enum_id, &cr, &index, &cntp) != 0)
+		if (get_config_reg(gpioc, enum_id, &cr,
+				   &field, &value, &cntp) != 0)
 			goto out_err;
 
 		switch (cfg_mode) {
 		case GPIO_CFG_DRYRUN:
-			if (!*cntp || !check_config_reg(gpioc, cr, index))
+			if (!*cntp || !check_config_reg(gpioc, cr,
+							field, value))
 				continue;
 			break;
 
 		case GPIO_CFG_REQ:
-			write_config_reg(gpioc, cr, index);
+			write_config_reg(gpioc, cr, field, value);
 			*cntp = *cntp + 1;
 			break;
 
