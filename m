From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 03 Jan 2013 18:17:45 +0000
Subject: [PATCH 14/22] sh-pfc: Rename struct pinmux_pin to struct sh_pfc_pin
Message-Id: <1357237073-15600-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

And drop the pinmux_flag_t typedef.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c        |    4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7722.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7723.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7724.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7785.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7786.c  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-shx3.c    |    2 +-
 drivers/pinctrl/sh-pfc/pinctrl.c     |    2 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h      |    7 +++----
 19 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 7b9eb41..e758ab1 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -235,7 +235,7 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 
 static int sh_pfc_setup_data_reg(struct sh_pfc *pfc, unsigned gpio)
 {
-	struct pinmux_pin *gpiop = &pfc->info->pins[gpio];
+	struct sh_pfc_pin *gpiop = &pfc->info->pins[gpio];
 	struct pinmux_data_reg *data_reg;
 	int k, n;
 
@@ -292,7 +292,7 @@ static void sh_pfc_setup_data_regs(struct sh_pfc *pfc)
 int sh_pfc_get_data_reg(struct sh_pfc *pfc, unsigned gpio,
 			struct pinmux_data_reg **drp, int *bitp)
 {
-	struct pinmux_pin *gpiop = &pfc->info->pins[gpio];
+	struct sh_pfc_pin *gpiop = &pfc->info->pins[gpio];
 	int k, n;
 
 	if (!sh_pfc_gpio_is_pin(pfc, gpio))
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index a22763e..ccf9161 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1654,7 +1654,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(TRACEAUD_FROM_MEMC_MARK,			MSEL5CR_30_1,	MSEL5CR_29_0),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	GPIO_PORT_ALL(),
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index f771239..0e53674 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -1450,7 +1450,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_IPSR_MODSEL_DATA(IP12_17_15, SCK4_B, SEL_SCIF4_1),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7203.c b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
index 3651eef..7dea3b45 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7203.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
@@ -703,7 +703,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(SSCK0_PF_MARK, PF0MD_11),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 
 	/* PA */
 	_GPIO_PORT(PA7),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index 738ddad..3a50132 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -1072,7 +1072,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(SD_D2_MARK, PK0MD_10),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 
 	/* Port A */
 	_GPIO_PORT(PA3),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
index e13668b..4b98e24 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -1452,7 +1452,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(PWM1A_MARK, PJ0MD_100),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	/* Port A */
 	_GPIO_PORT(PA1),
 	_GPIO_PORT(PA0),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 3a1961b..b15a16a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -929,7 +929,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(MFIv4_MARK,		MSEL4CR_6_1),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	GPIO_PORT_ALL(),
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index b63bd0b..ab1033b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1543,7 +1543,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(FSIAISLD_PU_MARK, PORT55_FN1, PORT55_IN_PU),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	GPIO_PORT_ALL(),
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7720.c b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
index a350fdc..77aea48 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7720.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
@@ -606,7 +606,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(SIM_CLK_MARK, PSELD_1_0_10, PTV0_FN),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	_GPIO_PORT(PTA7),
 	_GPIO_PORT(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7722.c b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
index 48aefcc..c1c88b3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7722.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
@@ -787,7 +787,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(KEYOUT5_IN5_MARK, HIZA14_KEYSC, KEYOUT5_IN5),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	_GPIO_PORT(PTA7),
 	_GPIO_PORT(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7723.c b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
index d642449..1fdfe48 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7723.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
@@ -923,7 +923,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(SIUBISLD_MARK, PSD1_PSD0_FN2, PTZ0_FN),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	_GPIO_PORT(PTA7),
 	_GPIO_PORT(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7724.c b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
index bd74a5e..01c31ab 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7724.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
@@ -1192,7 +1192,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(SCIF3_I_TXD_MARK,	PSB14_1, PTZ3_FN),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	_GPIO_PORT(PTA7),
 	_GPIO_PORT(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index e3bfeff..20c44dd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -1384,7 +1384,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_IPSR_DATA(IP11_28, ST_CLKOUT),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7757.c b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
index a8118c4..c7bfb7c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7757.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
@@ -1114,7 +1114,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(ON_DQ0_MARK, PS8_8_FN2, PTZ0_FN),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	_GPIO_PORT(PTA7),
 	_GPIO_PORT(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7785.c b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
index 9d62c9f..36f84db 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7785.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
@@ -702,7 +702,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(IRQOUT_MARK, P2MSEL2_1),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	/* PA */
 	_GPIO_PORT(PA7),
 	_GPIO_PORT(PA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7786.c b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
index a5a5570..c3d3194 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7786.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
@@ -427,7 +427,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(SSI3_SCK_MARK,	P2MSEL6_1, P2MSEL5_1, PJ1_FN),
 };
 
-static struct pinmux_pin pinmux_pins[] = {
+static struct sh_pfc_pin pinmux_pins[] = {
 	/* PA */
 	_GPIO_PORT(PA7),
 	_GPIO_PORT(PA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-shx3.c b/drivers/pinctrl/sh-pfc/pfc-shx3.c
index ca5f345..48e7a73 100644
--- a/drivers/pinctrl/sh-pfc/pfc-shx3.c
+++ b/drivers/pinctrl/sh-pfc/pfc-shx3.c
@@ -306,7 +306,7 @@ static pinmux_enum_t shx3_pinmux_data[] = {
 	PINMUX_DATA(IRQOUT_MARK,	PH0_FN),
 };
 
-static struct pinmux_pin shx3_pinmux_pins[] = {
+static struct sh_pfc_pin shx3_pinmux_pins[] = {
 	/* PA */
 	_GPIO_PORT(PA7),
 	_GPIO_PORT(PA6),
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index d860b9f..56f3791 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -317,7 +317,7 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 
 	for (i = 0; i < pmx->nr_pads; i++) {
 		struct pinctrl_pin_desc *pin = pmx->pads + i;
-		struct pinmux_pin *gpio = pfc->info->pins + i;
+		struct sh_pfc_pin *gpio = pfc->info->pins + i;
 
 		pin->number = i;
 		pin->name = gpio->name;
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 940170a..dae9e15 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -15,7 +15,6 @@
 #include <asm-generic/gpio.h>
 
 typedef unsigned short pinmux_enum_t;
-typedef unsigned short pinmux_flag_t;
 
 enum {
 	PINMUX_TYPE_NONE,
@@ -35,9 +34,9 @@ enum {
 #define PINMUX_FLAG_DREG_SHIFT      10
 #define PINMUX_FLAG_DREG            (0x3f << PINMUX_FLAG_DREG_SHIFT)
 
-struct pinmux_pin {
+struct sh_pfc_pin {
 	const pinmux_enum_t enum_id;
-	pinmux_flag_t flags;
+	unsigned short flags;
 	const char *name;
 };
 
@@ -110,7 +109,7 @@ struct sh_pfc_soc_info {
 	struct pinmux_range output;
 	struct pinmux_range function;
 
-	struct pinmux_pin *pins;
+	struct sh_pfc_pin *pins;
 	unsigned int nr_pins;
 	struct pinmux_func *func_gpios;
 	unsigned int nr_func_gpios;
-- 
1.7.8.6

