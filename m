From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 16 Dec 2013 19:25:17 +0000
Subject: [PATCH 4/4] pinctrl: sh-pfc: ARM: Constify pins and cfg_regs arrays
Message-Id: <1387221917-15437-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The arrays are never modified, declare them as const.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 32dd478..d39ca87 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -1272,7 +1272,7 @@ static const u16 pinmux_data[] = {
 #define R8A73A4_PIN_IO_PU_PD(pin)       SH_PFC_PIN_CFG(pin, __IO | __PUD)
 #define R8A73A4_PIN_O(pin)              SH_PFC_PIN_CFG(pin, __O)
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	R8A73A4_PIN_IO_PU_PD(0), R8A73A4_PIN_IO_PU_PD(1),
 	R8A73A4_PIN_IO_PU_PD(2), R8A73A4_PIN_IO_PU_PD(3),
 	R8A73A4_PIN_IO_PU_PD(4), R8A73A4_PIN_IO_PU_PD(5),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index a189b96..f4d3024 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1543,7 +1543,7 @@ static const u16 pinmux_data[] = {
 #define R8A7740_PIN_O(pin)		SH_PFC_PIN_CFG(pin, __O)
 #define R8A7740_PIN_O_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __O | __PUD)
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* Table 56-1 (I/O and Pull U/D) */
 	R8A7740_PIN_IO_PD(0),		R8A7740_PIN_IO_PD(1),
 	R8A7740_PIN_IO_PD(2),		R8A7740_PIN_IO_PD(3),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 8b1881c..c7d610d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1260,7 +1260,7 @@ static const u16 pinmux_data[] = {
  */
 #define PIN_NUMBER(row, col)		(1000+((row)-1)*25+(col)-1)
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 
 	/* Pins not associated with a GPIO port */
@@ -2104,7 +2104,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(vin1),
 };
 
-static struct pinmux_cfg_reg pinmux_config_regs[] = {
+static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ PINMUX_CFG_REG("GPSR0", 0xfffc0004, 32, 1) {
 		GP_0_31_FN,	FN_IP1_14_11,
 		GP_0_30_FN,	FN_IP1_10_8,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index d3e94e3..f5c01e1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -1410,7 +1410,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MODSEL_DATA(IP12_17_15, SCK4_B, SEL_SCIF4_1),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 293a51a..a8ba257 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -1731,7 +1731,7 @@ static const u16 pinmux_data[] = {
 #define PIN_NUMBER(r, c) (((r) - 'A') * 31 + (c) + 200)
 #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 
 	/* Pins not associated with a GPIO port */
@@ -4237,7 +4237,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(vin3),
 };
 
-static struct pinmux_cfg_reg pinmux_config_regs[] = {
+static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
 		GP_0_31_FN, FN_IP3_17_15,
 		GP_0_30_FN, FN_IP3_14_12,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index ea02d37..d73a5f3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1674,7 +1674,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MODSEL_DATA(IP16_11_10, CAN1_RX_B, SEL_CAN1_1),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
@@ -3056,7 +3056,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(usb1),
 };
 
-static struct pinmux_cfg_reg pinmux_config_regs[] = {
+static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
 		GP_0_31_FN, FN_IP1_22_20,
 		GP_0_30_FN, FN_IP1_19_17,
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index bcdd5c3..e9c522b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -844,7 +844,7 @@ static const u16 pinmux_data[] = {
 #define SH7372_PIN_O(pin)		SH_PFC_PIN_CFG(pin, __O)
 #define SH7372_PIN_O_PU_PD(pin)		SH_PFC_PIN_CFG(pin, __O | __PUD)
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* Table 57-1 (I/O and Pull U/D) */
 	SH7372_PIN_IO_PD(0),		SH7372_PIN_IO_PD(1),
 	SH7372_PIN_O(2),		SH7372_PIN_I_PD(3),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index dc7c7fb..6f6ba10 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1179,7 +1179,7 @@ static const u16 pinmux_data[] = {
  */
 #define PIN_NUMBER(row, col)		(1000+((row)-1)*34+(col)-1)
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* Table 25-1 (I/O and Pull U/D) */
 	SH73A0_PIN_I_PD(0),
 	SH73A0_PIN_I_PU(1),
-- 
1.8.3.2

