From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:01:05 +0000
Subject: [PATCH 04/05] sh: pfc: Variable bitfield width config register support
Message-Id: <20111213160105.4021.41308.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for variable config reg hardware by adding
the macro PINMUX_CFG_REG_VAR(). The width of each bitfield
needs to be passed to the macro, and the correct space must
be consumed by each bitfield in the enum table following the
macro. Data registers still need to have fixed bitfields.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/pfc.c       |   44 +++++++++++++++++++++++++++++++++-----------
 include/linux/sh_pfc.h |    9 ++++++++-
 2 files changed, 41 insertions(+), 12 deletions(-)

--- 0019/drivers/sh/pfc.c
+++ work/drivers/sh/pfc.c	2011-12-12 20:29:56.000000000 +0900
@@ -174,10 +174,19 @@ static void config_reg_helper(struct pin
 			      unsigned long *maskp,
 			      unsigned long *posp)
 {
+	int k;
+
 	*mapped_regp = pfc_phys_to_virt(gpioc, crp->reg);
 
-	*maskp = (1 << crp->field_width) - 1;
-	*posp = crp->reg_width - ((in_pos + 1) * crp->field_width);
+	if (crp->field_width) {
+		*maskp = (1 << crp->field_width) - 1;
+		*posp = crp->reg_width - ((in_pos + 1) * crp->field_width);
+	} else {
+		*maskp = (1 << crp->var_field_width[in_pos]) - 1;
+		*posp = crp->reg_width;
+		for (k = 0; k <= in_pos; k++)
+			*posp -= crp->var_field_width[k];
+	}
 }
 
 static int read_config_reg(struct pinmux_info *gpioc,
@@ -300,8 +309,8 @@ static int get_config_reg(struct pinmux_
 			  unsigned long **cntp)
 {
 	struct pinmux_cfg_reg *config_reg;
-	unsigned long r_width, f_width;
-	int k, n;
+	unsigned long r_width, f_width, curr_width, ncomb;
+	int k, m, n, pos, bit_pos;
 
 	k = 0;
 	while (1) {
@@ -312,14 +321,27 @@ static int get_config_reg(struct pinmux_
 
 		if (!r_width)
 			break;
-		for (n = 0; n < (r_width / f_width) * (1 << f_width); n++) {
-			if (config_reg->enum_ids[n] = enum_id) {
-				*crp = config_reg;
-				*fieldp = n / (1 << f_width);
-				*valuep = n % (1 << f_width);
-				*cntp = &config_reg->cnt[n / (1 << f_width)];
-				return 0;
+
+		pos = 0;
+		m = 0;
+		for (bit_pos = 0; bit_pos < r_width; bit_pos += curr_width) {
+			if (f_width)
+				curr_width = f_width;
+			else
+				curr_width = config_reg->var_field_width[m];
+
+			ncomb = 1 << curr_width;
+			for (n = 0; n < ncomb; n++) {
+				if (config_reg->enum_ids[pos + n] = enum_id) {
+					*crp = config_reg;
+					*fieldp = m;
+					*valuep = n;
+					*cntp = &config_reg->cnt[m];
+					return 0;
+				}
 			}
+			pos += ncomb;
+			m++;
 		}
 		k++;
 	}
--- 0013/include/linux/sh_pfc.h
+++ work/include/linux/sh_pfc.h	2011-12-12 19:40:30.000000000 +0900
@@ -45,12 +45,19 @@ struct pinmux_cfg_reg {
 	unsigned long reg, reg_width, field_width;
 	unsigned long *cnt;
 	pinmux_enum_t *enum_ids;
+	unsigned long *var_field_width;
 };
 
 #define PINMUX_CFG_REG(name, r, r_width, f_width) \
 	.reg = r, .reg_width = r_width, .field_width = f_width,		\
 	.cnt = (unsigned long [r_width / f_width]) {}, \
-	.enum_ids = (pinmux_enum_t [(r_width / f_width) * (1 << f_width)]) \
+	.enum_ids = (pinmux_enum_t [(r_width / f_width) * (1 << f_width)])
+
+#define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
+	.reg = r, .reg_width = r_width,	\
+	.cnt = (unsigned long [r_width]) {}, \
+	.var_field_width = (unsigned long [r_width]) { var_fw0, var_fwn, 0 }, \
+	.enum_ids = (pinmux_enum_t [])
 
 struct pinmux_data_reg {
 	unsigned long reg, reg_width, reg_shadow;
