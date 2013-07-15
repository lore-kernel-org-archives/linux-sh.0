From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 15 Jul 2013 23:39:55 +0000
Subject: [PATCH 07/19] sh-pfc: Replace pinmux_enum_id typedef with u16
Message-Id: <1373931607-4599-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The typedef only conceals the real variable type without bringing any
additional value (see Documentation/CodingStyle, section 5.b). Moreover,
it polutes the pinmux namespace. Replace it with the integer type it
used to hide.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c        | 13 ++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c  |  3 +--
 drivers/pinctrl/sh-pfc/pfc-sh7264.c  |  3 +--
 drivers/pinctrl/sh-pfc/pfc-sh7269.c  |  3 +--
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7722.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7723.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7724.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7785.c  |  3 +--
 drivers/pinctrl/sh-pfc/pfc-sh7786.c  |  3 +--
 drivers/pinctrl/sh-pfc/pfc-shx3.c    |  3 +--
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 26 ++++++++++++--------------
 21 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 1c8597c..96b0224 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -98,8 +98,7 @@ int sh_pfc_get_pin_index(struct sh_pfc *pfc, unsigned int pin)
 	return -EINVAL;
 }
 
-static int sh_pfc_enum_in_range(pinmux_enum_t enum_id,
-				const struct pinmux_range *r)
+static int sh_pfc_enum_in_range(u16 enum_id, const struct pinmux_range *r)
 {
 	if (enum_id < r->begin)
 		return 0;
@@ -194,7 +193,7 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 	sh_pfc_write_raw_reg(mapped_reg, crp->reg_width, data);
 }
 
-static int sh_pfc_get_config_reg(struct sh_pfc *pfc, pinmux_enum_t enum_id,
+static int sh_pfc_get_config_reg(struct sh_pfc *pfc, u16 enum_id,
 				 const struct pinmux_cfg_reg **crp, int *fieldp,
 				 int *valuep)
 {
@@ -238,10 +237,10 @@ static int sh_pfc_get_config_reg(struct sh_pfc *pfc, pinmux_enum_t enum_id,
 	return -EINVAL;
 }
 
-static int sh_pfc_mark_to_enum(struct sh_pfc *pfc, pinmux_enum_t mark, int pos,
-			      pinmux_enum_t *enum_idp)
+static int sh_pfc_mark_to_enum(struct sh_pfc *pfc, u16 mark, int pos,
+			      u16 *enum_idp)
 {
-	const pinmux_enum_t *data = pfc->info->gpio_data;
+	const u16 *data = pfc->info->gpio_data;
 	int k;
 
 	if (pos) {
@@ -264,7 +263,7 @@ static int sh_pfc_mark_to_enum(struct sh_pfc *pfc, pinmux_enum_t mark, int pos,
 int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 {
 	const struct pinmux_cfg_reg *cr = NULL;
-	pinmux_enum_t enum_id;
+	u16 enum_id;
 	const struct pinmux_range *range;
 	int in_range, pos, field, value;
 	int ret;
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 82bf6ab..d5cbbc7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -431,7 +431,7 @@ enum {
 #define _PORT_DATA(pfx, sfx)	PORT_DATA_IO(pfx)
 #define PINMUX_DATA_ALL()    CPU_ALL_PORT(_PORT_DATA, , unused)
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	/* specify valid pin states for each pin in GPIO mode */
 	PINMUX_DATA_ALL(),
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 3fb1e0b..214ac6c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -586,7 +586,7 @@ enum {
 #define _PORT_DATA(pfx, sfx)	PORT_DATA_IO(pfx)
 #define PINMUX_DATA_GP_ALL()	CPU_ALL_PORT(_PORT_DATA, , unused)
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(),
 
 	/* Port0 */
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index f903910..018d8bc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -579,7 +579,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
 	PINMUX_DATA(PENC0_MARK,		FN_PENC0),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 8e22ca6..290de9a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -664,7 +664,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
 	PINMUX_DATA(AVS1_MARK, FN_AVS1),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 14f3ec2..3713c00 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -844,7 +844,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
 	PINMUX_DATA(VI1_DATA7_VI1_B7_MARK, FN_VI1_DATA7_VI1_B7),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7203.c b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
index f63d51d..4487814 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7203.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
@@ -272,8 +272,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
-
+static const u16 pinmux_data[] = {
 	/* PA */
 	PINMUX_DATA(PA7_DATA, PA7_IN),
 	PINMUX_DATA(PA6_DATA, PA6_IN),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index 2846752..641c6af 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -604,8 +604,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
-
+static const u16 pinmux_data[] = {
 	/* Port A */
 	PINMUX_DATA(PA3_DATA, PA3_IN),
 	PINMUX_DATA(PA2_DATA, PA2_IN),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
index 4c401a7..415812f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -781,8 +781,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
-
+static const u16 pinmux_data[] = {
 	/* Port A */
 	PINMUX_DATA(PA1_DATA, PA1_IN),
 	PINMUX_DATA(PA0_DATA, PA0_IN),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index cd431e4..f269c46 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -387,7 +387,7 @@ enum {
 #define _PORT_DATA(pfx, sfx)	PORT_DATA_IO(pfx)
 #define PINMUX_DATA_GP_ALL()	CPU_ALL_PORT(_PORT_DATA, , unused)
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(),
 
 	/* IRQ */
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 7956df5..985acd0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -469,7 +469,7 @@ enum {
 #define _PORT_DATA(pfx, sfx)	PORT_DATA_IO(pfx)
 #define PINMUX_DATA_GP_ALL()    CPU_ALL_PORT(_PORT_DATA, , unused)
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	/* specify valid pin states for each pin in GPIO mode */
 	PINMUX_DATA_GP_ALL(),
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7720.c b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
index 3b96d61..1009fc9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7720.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
@@ -232,7 +232,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	/* PTA GPIO */
 	PINMUX_DATA(PTA7_DATA, PTA7_IN, PTA7_OUT),
 	PINMUX_DATA(PTA6_DATA, PTA6_IN, PTA6_OUT),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7722.c b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
index 0982c4ff..0c8d011 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7722.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
@@ -263,7 +263,7 @@ enum {
 	PINMUX_FUNCTION_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	/* PTA */
 	PINMUX_DATA(PTA7_DATA, PTA7_IN, PTA7_OUT),
 	PINMUX_DATA(PTA6_DATA, PTA6_IN),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7723.c b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
index da0dbb0..853093e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7723.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
@@ -344,7 +344,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	/* PTA GPIO */
 	PINMUX_DATA(PTA7_DATA, PTA7_IN, PTA7_OUT),
 	PINMUX_DATA(PTA6_DATA, PTA6_IN, PTA6_OUT),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7724.c b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
index e8563cf..fe2693f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7724.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
@@ -526,7 +526,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	/* PTA GPIO */
 	PINMUX_DATA(PTA7_DATA, PTA7_IN, PTA7_OUT),
 	PINMUX_DATA(PTA6_DATA, PTA6_IN, PTA6_OUT),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 2fd5b7d..1e1e3e0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -592,7 +592,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
 	PINMUX_DATA(CLKOUT_MARK, FN_CLKOUT),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7757.c b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
index d974b08..f427116 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7757.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
@@ -486,7 +486,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
+static const u16 pinmux_data[] = {
 	/* PTA GPIO */
 	PINMUX_DATA(PTA7_DATA, PTA7_IN, PTA7_OUT),
 	PINMUX_DATA(PTA6_DATA, PTA6_IN, PTA6_OUT),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7785.c b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
index ddae426..209289c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7785.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
@@ -325,8 +325,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
-
+static const u16 pinmux_data[] = {
 	/* PA GPIO */
 	PINMUX_DATA(PA7_DATA, PA7_IN, PA7_OUT),
 	PINMUX_DATA(PA6_DATA, PA6_IN, PA6_OUT),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7786.c b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
index c855fca..353fde1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7786.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
@@ -172,8 +172,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t pinmux_data[] = {
-
+static const u16 pinmux_data[] = {
 	/* PA GPIO */
 	PINMUX_DATA(PA7_DATA, PA7_IN, PA7_OUT),
 	PINMUX_DATA(PA6_DATA, PA6_IN, PA6_OUT),
diff --git a/drivers/pinctrl/sh-pfc/pfc-shx3.c b/drivers/pinctrl/sh-pfc/pfc-shx3.c
index 50d9c5d..48a6c60 100644
--- a/drivers/pinctrl/sh-pfc/pfc-shx3.c
+++ b/drivers/pinctrl/sh-pfc/pfc-shx3.c
@@ -127,8 +127,7 @@ enum {
 	PINMUX_MARK_END,
 };
 
-static const pinmux_enum_t shx3_pinmux_data[] = {
-
+static const u16 shx3_pinmux_data[] = {
 	/* PA GPIO */
 	PINMUX_DATA(PA7_DATA, PA7_IN, PA7_OUT),
 	PINMUX_DATA(PA6_DATA, PA6_IN, PA6_OUT),
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 363ea8c..7ad1b04 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -14,8 +14,6 @@
 #include <linux/bug.h>
 #include <linux/stringify.h>
 
-typedef unsigned short pinmux_enum_t;
-
 enum {
 	PINMUX_TYPE_NONE,
 	PINMUX_TYPE_FUNCTION,
@@ -30,7 +28,7 @@ enum {
 #define SH_PFC_PIN_CFG_PULL_DOWN	(1 << 3)
 
 struct sh_pfc_pin {
-	pinmux_enum_t enum_id;
+	u16 enum_id;
 	const char *name;
 	unsigned int configs;
 };
@@ -64,7 +62,7 @@ struct sh_pfc_function {
 };
 
 struct pinmux_func {
-	pinmux_enum_t enum_id;
+	u16 enum_id;
 	const char *name;
 };
 
@@ -83,27 +81,27 @@ struct pinmux_func {
 
 struct pinmux_cfg_reg {
 	unsigned long reg, reg_width, field_width;
-	const pinmux_enum_t *enum_ids;
+	const u16 *enum_ids;
 	const unsigned long *var_field_width;
 };
 
 #define PINMUX_CFG_REG(name, r, r_width, f_width) \
 	.reg = r, .reg_width = r_width, .field_width = f_width,		\
-	.enum_ids = (pinmux_enum_t [(r_width / f_width) * (1 << f_width)])
+	.enum_ids = (u16 [(r_width / f_width) * (1 << f_width)])
 
 #define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
 	.reg = r, .reg_width = r_width,	\
 	.var_field_width = (unsigned long [r_width]) { var_fw0, var_fwn, 0 }, \
-	.enum_ids = (pinmux_enum_t [])
+	.enum_ids = (u16 [])
 
 struct pinmux_data_reg {
 	unsigned long reg, reg_width;
-	const pinmux_enum_t *enum_ids;
+	const u16 *enum_ids;
 };
 
 #define PINMUX_DATA_REG(name, r, r_width) \
 	.reg = r, .reg_width = r_width,	\
-	.enum_ids = (pinmux_enum_t [r_width]) \
+	.enum_ids = (u16 [r_width]) \
 
 struct pinmux_irq {
 	int irq;
@@ -114,9 +112,9 @@ struct pinmux_irq {
 	{ .irq = irq_nr, .gpios = (unsigned short []) { ids, 0 } }	\
 
 struct pinmux_range {
-	pinmux_enum_t begin;
-	pinmux_enum_t end;
-	pinmux_enum_t force;
+	u16 begin;
+	u16 end;
+	u16 force;
 };
 
 struct sh_pfc;
@@ -152,7 +150,7 @@ struct sh_pfc_soc_info {
 	const struct pinmux_cfg_reg *cfg_regs;
 	const struct pinmux_data_reg *data_regs;
 
-	const pinmux_enum_t *gpio_data;
+	const u16 *gpio_data;
 	unsigned int gpio_data_size;
 
 	const struct pinmux_irq *gpio_irq;
@@ -199,7 +197,7 @@ struct sh_pfc_soc_info {
 #define PORT_ALL(str)	CPU_ALL_PORT(_PORT_ALL, PORT, str)
 #define GPIO_FN(str) PINMUX_GPIO_FN(GPIO_FN_##str, PINMUX_FN_BASE, str##_MARK)
 
-/* helper macro for pinmux_enum_t */
+/* helper macro for pinmux data arrays */
 #define PORT_DATA_IO(nr)	\
 	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0, PORT##nr##_OUT,	\
 		    PORT##nr##_IN)
-- 
1.8.1.5

