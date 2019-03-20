From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Mar 2019 10:21:38 +0000
Subject: [PATCH v3 07/10 PARTIAL] pinctrl: sh-pfc: Absorb enum IDs in PINMUX_CFG_REG_VAR() macro
Message-Id: <20190320102141.19316-8-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20190320102141.19316-1-geert+renesas@glider.be>
In-Reply-To: <20190320102141.19316-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently the PINMUX_CFG_REG_VAR() macro must be followed by
initialization data, specifying all enum IDs.  Hence the macro itself
does not know anything about the enum IDs, preventing the macro from
performing any validation on it.

Make the macro accept the enum IDs as a parameter, and update all users.
Note that array data enclosed by curly braces cannot be passed to a
macro as a parameter, hence both the register field widths and the enum
IDs are wrapped using the GROUP() macro.

No functional changes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch is incomplete!
It contains only the generic and r8a7791 parts.

v3:
  - Incorporate change that was accidentally part of the previous patch,

v2:
  - Improve comment.
---
 drivers/pinctrl/sh-pfc/pfc-emev2.c       |  47 +++++----
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    | 111 +++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     |  81 +++++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     |  89 +++++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     | 107 ++++++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 123 ++++++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     |  86 +++++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     |  98 ++++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c |  20 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     |  21 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     |  21 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    |  21 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    |   7 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    |   7 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    |  14 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    |  13 +--
 drivers/pinctrl/sh-pfc/pfc-sh7734.c      |  83 ++++++++-------
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  25 +++--
 18 files changed, 572 insertions(+), 402 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index b96c9a207cf8971d..1292ec8d268fc41f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -5701,8 +5701,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_0_FN, FN_IP15_17_15 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
-			     1, 2, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(1, 2, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP0_31 [1] */
 		0, 0,
 		/* IP0_30_29 [2] */
@@ -5757,10 +5758,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP0_1 [1] */
 		FN_D1, 0,
 		/* IP0_0 [1] */
-		FN_D0, 0, }
+		FN_D0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xE6060024, 32,
-			     3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2) {
+			     GROUP(3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2),
+			     GROUP(
 		/* IP1_31_29 [3] */
 		FN_A18, FN_DREQ1, FN_SCIFA1_RXD_C, 0, FN_SCIFB1_RXD_C,
 		0, 0, 0,
@@ -5793,10 +5795,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_A8, FN_MSIOF1_SS1, FN_I2C0_SCL, 0,
 		/* IP1_1_0 [2] */
 		FN_A7, FN_MSIOF1_SYNC,
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xE6060028, 32,
-			     2, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 3) {
+			     GROUP(2, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 3),
+			     GROUP(
 		/* IP2_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP2_29_27 [3] */
@@ -5829,10 +5832,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_A20, FN_SPCLK, 0, 0,
 		/* IP2_2_0 [3] */
 		FN_A19, FN_DACK1, FN_SCIFA1_TXD_C, 0,
-		FN_SCIFB1_TXD_C, 0, FN_SCIFB1_SCK_B, 0, }
+		FN_SCIFB1_TXD_C, 0, FN_SCIFB1_SCK_B, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xE606002C, 32,
-			     1, 3, 3, 3, 2, 2, 2, 2, 2, 3, 3, 3, 3) {
+			     GROUP(1, 3, 3, 3, 2, 2, 2, 2, 2, 3, 3, 3, 3),
+			     GROUP(
 		/* IP3_31 [1] */
 		0, 0,
 		/* IP3_30_28 [3] */
@@ -5867,10 +5871,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SCIFB1_RXD_B, FN_PWM1, FN_TPU_TO1, 0,
 		/* IP3_2_0 [3] */
 		FN_EX_CS4_N, FN_ATARD0_N, FN_MSIOF2_RXD, 0, FN_EX_WAIT2,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xE6060030, 32,
-			     1, 3, 2, 2, 2, 1, 1, 1, 3, 3, 3, 2, 3, 3, 2) {
+			     GROUP(1, 3, 2, 2, 2, 1, 1, 1, 3, 3, 3, 2,
+				   3, 3, 2),
+			     GROUP(
 		/* IP4_31 [1] */
 		0, 0,
 		/* IP4_30_28 [3] */
@@ -5909,10 +5915,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_MSIOF2_SYNC_C, FN_GLO_I0_D,
 		0, 0, 0,
 		/* IP4_1_0 [2] */
-		FN_SSI_SDATA0, FN_I2C0_SCL_B, FN_IIC0_SCL_B, FN_MSIOF2_SCK_C, }
+		FN_SSI_SDATA0, FN_I2C0_SCL_B, FN_IIC0_SCL_B, FN_MSIOF2_SCK_C,
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xE6060034, 32,
-			     3, 3, 2, 2, 2, 3, 2, 3, 3, 3, 3, 3) {
+			     GROUP(3, 3, 2, 2, 2, 3, 2, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP5_31_29 [3] */
 		FN_SSI_SDATA9, FN_RX3_D, FN_CAN0_RX_D,
 		0, 0, 0, 0, 0,
@@ -5947,10 +5955,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP5_2_0 [3] */
 		FN_SSI_WS5, FN_MSIOF1_SYNC_C, FN_TS_SCK0, FN_GLO_I1,
 		FN_MSIOF2_TXD_D, FN_VI1_R3_B,
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xE6060038, 32,
-			     2, 3, 3, 3, 2, 3, 2, 2, 2, 2, 2, 3, 3) {
+			     GROUP(2, 3, 3, 3, 2, 3, 2, 2, 2, 2, 2, 3, 3),
+			     GROUP(
 		/* IP6_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP6_29_27 [3] */
@@ -5987,10 +5996,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP6_2_0 [3] */
 		FN_AUDIO_CLKB, FN_STP_OPWM_0_B, FN_MSIOF1_SCK_B,
 		FN_SCIF_CLK, FN_DVC_MUTE, FN_BPFCLK_E,
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xE606003C, 32,
-			     2, 3, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 3) {
+			     GROUP(2, 3, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 3),
+			     GROUP(
 		/* IP7_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP7_29_27 [3] */
@@ -6028,10 +6038,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP7_2_0 [3] */
 		FN_IRQ9, FN_DU1_DOTCLKIN_B, FN_CAN_CLK_D, FN_GPS_MAG_C,
 		FN_SCIF_CLK_B, FN_GPS_MAG_D,
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR8", 0xE6060040, 32,
-			     1, 3, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(1, 3, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP8_31 [1] */
 		0, 0,
 		/* IP8_30_28 [3] */
@@ -6071,10 +6082,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		/* IP8_2_0 [3] */
 		FN_DU1_DG3, FN_LCDOUT11, FN_VI1_DATA5_B, 0, FN_SSI_WS78_B,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xE6060044, 32,
-			     3, 2, 2, 2, 2, 2, 2, 1, 3, 1, 1, 3, 1, 1, 3, 3) {
+			     GROUP(3, 2, 2, 2, 2, 2, 2, 1, 3, 1, 1, 3,
+				   1, 1, 3, 3),
+			     GROUP(
 		/* IP9_31_29 [3] */
 		FN_VI0_G0, FN_IIC1_SCL, FN_STP_IVCXO27_0_C, FN_I2C4_SCL,
 		FN_HCTS2_N, FN_SCIFB2_CTS_N, FN_ATAWR1_N, 0,
@@ -6114,10 +6127,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0,
 		/* IP9_2_0 [3] */
 		FN_DU1_DB6, FN_LCDOUT22, FN_I2C3_SCL_C, FN_RX3, FN_SCIFA3_RXD,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR10", 0xE6060048, 32,
-			     3, 2, 2, 3, 3, 2, 2, 3, 3, 3, 3, 3) {
+			     GROUP(3, 2, 2, 3, 3, 2, 2, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP10_31_29 [3] */
 		FN_VI0_R4, FN_VI2_DATA5, FN_GLO_SCLK_B, FN_TX0_C, FN_I2C1_SCL_D,
 		0, 0, 0,
@@ -6151,11 +6165,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_HSCK2, FN_SCIFB2_SCK, FN_ATARD1_N, 0,
 		/* IP10_2_0 [3] */
 		FN_VI0_G1, FN_IIC1_SDA, FN_STP_ISCLK_0_C, FN_I2C4_SDA,
-		FN_HRTS2_N, FN_SCIFB2_RTS_N, FN_ATADIR1_N, 0, }
+		FN_HRTS2_N, FN_SCIFB2_RTS_N, FN_ATADIR1_N, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xE606004C, 32,
-			     2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2,
-			     3, 3, 3, 3, 3) {
+			     GROUP(2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
+				   2, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP11_31_30 [2] */
 		FN_ETH_CRS_DV, FN_AVB_LINK, FN_I2C2_SDA_C, 0,
 		/* IP11_29_28 [2] */
@@ -6198,10 +6213,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0,
 		/* IP11_2_0 [3] */
 		FN_VI0_R5, FN_VI2_DATA6, FN_GLO_SDATA_B, FN_RX0_C,
-		FN_I2C1_SDA_D, 0, 0, 0, }
+		FN_I2C1_SDA_D, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR12", 0xE6060050, 32,
-			     2, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2) {
+			     GROUP(2, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2),
+			     GROUP(
 		/* IP12_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP12_29_27 [3] */
@@ -6239,11 +6255,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP12_3_2 [2] */
 		FN_ETH_RXD0, FN_AVB_PHY_INT, FN_I2C3_SDA, FN_IIC0_SDA,
 		/* IP12_1_0 [2] */
-		FN_ETH_RX_ER, FN_AVB_CRS, FN_I2C3_SCL, FN_IIC0_SCL, }
+		FN_ETH_RX_ER, FN_AVB_CRS, FN_I2C3_SCL, FN_IIC0_SCL, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR13", 0xE6060054, 32,
-			     1, 3, 1, 1, 1, 2, 1, 3, 3, 1, 1, 1, 1, 1, 1,
-			     3, 2, 2, 3) {
+			     GROUP(1, 3, 1, 1, 1, 2, 1, 3, 3, 1, 1, 1,
+				   1, 1, 1, 3, 2, 2, 3),
+			     GROUP(
 		/* IP13_31 [1] */
 		0, 0,
 		/* IP13_30_28 [3] */
@@ -6290,10 +6307,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP13_2_0 [3] */
 		FN_STP_ISD_0, FN_AVB_TX_ER, FN_SCIFB2_SCK_C,
 		FN_ADICLK_B, FN_MSIOF0_SS1_C,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR14", 0xE6060058, 32,
-			     3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 2) {
+			     GROUP(3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1,
+				   1, 1, 2),
+			     GROUP(
 		/* IP14_31_29 [3] */
 		FN_MSIOF0_SS2, FN_MMC_D7, FN_ADICHS2, FN_RX0_E,
 		FN_VI1_VSYNC_N_C, FN_IIC0_SDA_C, FN_VI1_G5_B, 0,
@@ -6333,10 +6352,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP14_2 [1] */
 		FN_SD2_CLK, FN_MMC_CLK,
 		/* IP14_1_0 [2] */
-		FN_SD1_WP, FN_PWM1_B, FN_I2C1_SDA_C, 0, }
+		FN_SD1_WP, FN_PWM1_B, FN_I2C1_SDA_C, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR15", 0xE606005C, 32,
-			     2, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2) {
+			     GROUP(2, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2),
+			     GROUP(
 		/* IP15_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP15_29_27 [3] */
@@ -6374,10 +6394,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP15_3_2 [2] */
 		FN_SIM0_CLK, FN_IECLK, FN_CAN_CLK_C, 0,
 		/* IP15_1_0 [2] */
-		FN_SIM0_RST, FN_IETX, FN_CAN1_TX_D, 0, }
+		FN_SIM0_RST, FN_IETX, FN_CAN1_TX_D, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR16", 0xE6060160, 32,
-			     4, 4, 4, 4, 4, 2, 2, 2, 3, 3) {
+			     GROUP(4, 4, 4, 4, 4, 2, 2, 2, 3, 3),
+			     GROUP(
 		/* IP16_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -6406,11 +6427,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP16_2_0 [3] */
 		FN_HRX1, FN_SCIFB1_RXD, FN_VI1_R0_B,
 		FN_GLO_SDATA_C, FN_VI1_DATA6_C,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL", 0xE6060090, 32,
-			     1, 2, 2, 2, 3, 2, 1, 1, 1, 1,
-			     3, 2, 2, 2, 1, 2, 2, 2) {
+			     GROUP(1, 2, 2, 2, 3, 2, 1, 1, 1, 1, 3, 2,
+				   2, 2, 1, 2, 2, 2),
+			     GROUP(
 		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SCIF1 [2] */
@@ -6451,11 +6473,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_TSIF0 [2] */
 		FN_SEL_TSIF0_0, FN_SEL_TSIF0_1, FN_SEL_TSIF0_2, FN_SEL_TSIF0_3,
 		/* SEL_SOF0 [2] */
-		FN_SEL_SOF0_0, FN_SEL_SOF0_1, FN_SEL_SOF0_2, 0, }
+		FN_SEL_SOF0_0, FN_SEL_SOF0_1, FN_SEL_SOF0_2, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
-			     3, 1, 1, 3, 2, 1, 1, 2, 2,
-			     1, 3, 2, 1, 2, 2, 2, 1, 1, 1) {
+			     GROUP(3, 1, 1, 3, 2, 1, 1, 2, 2, 1, 3, 2,
+				   1, 2, 2, 2, 1, 1, 1),
+			     GROUP(
 		/* SEL_SCIF0 [3] */
 		FN_SEL_SCIF0_0, FN_SEL_SCIF0_1, FN_SEL_SCIF0_2,
 		FN_SEL_SCIF0_3, FN_SEL_SCIF0_4,
@@ -6499,11 +6522,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SSI8 [1] */
-		FN_SEL_SSI8_0, FN_SEL_SSI8_1, }
+		FN_SEL_SSI8_0, FN_SEL_SSI8_1, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL3", 0xE6060098, 32,
-			     2, 2, 2, 2, 2, 2, 2, 2,
-			     1, 1, 2, 2, 3, 2, 2, 2, 1) {
+			     GROUP(2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2,
+				   3, 2, 2, 2, 1),
+			     GROUP(
 		/* SEL_HSCIF2 [2] */
 		FN_SEL_HSCIF2_0, FN_SEL_HSCIF2_1,
 		FN_SEL_HSCIF2_2, FN_SEL_HSCIF2_3,
@@ -6541,11 +6565,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* RESERVED [1] */
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL4", 0xE606009C, 32,
-			     3, 2, 2, 1, 1, 1, 1, 3, 2,
-			     2, 3, 1, 1, 1, 2, 2, 2, 2) {
+			     GROUP(3, 2, 2, 1, 1, 1, 1, 3, 2, 2, 3, 1,
+				   1, 1, 2, 2, 2, 2),
+			     GROUP(
 		/* SEL_SOF1 [3] */
 		FN_SEL_SOF1_0, FN_SEL_SOF1_1, FN_SEL_SOF1_2, FN_SEL_SOF1_3,
 		FN_SEL_SOF1_4,
@@ -6587,7 +6612,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* RESERVED [2] */
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 3848c104543d383e..95eb51168ed83856 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -139,16 +139,17 @@ struct pinmux_cfg_reg {
  *   - name: Register name (unused, for documentation purposes only)
  *   - r: Physical register address
  *   - r_width: Width of the register (in bits)
- *   - var_fw0, var_fwn...: List of widths of the register fields (in bits),
- *                          From left to right (i.e. MSB to LSB)
- * This macro must be followed by initialization data: For each register field
- * (from left to right, i.e. MSB to LSB), 2^var_fwi enum IDs must be specified,
- * one for each possible combination of the register field bit values.
+ *   - f_widths: List of widths of the register fields (in bits), from left
+ *               to right (i.e. MSB to LSB), wrapped using the GROUP() macro.
+ *   - ids: For each register field (from left to right, i.e. MSB to LSB),
+ *          2^f_widths[i] enum IDs must be specified, one for each possible
+ *          combination of the register field bit values, all wrapped using
+ *          the GROUP() macro.
  */
-#define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
-	.reg = r, .reg_width = r_width,	\
-	.var_field_width = (const u8 []) { var_fw0, var_fwn, 0 }, \
-	.enum_ids = (const u16 [])
+#define PINMUX_CFG_REG_VAR(name, r, r_width, f_widths, ids)		\
+	.reg = r, .reg_width = r_width,					\
+	.var_field_width = (const u8 []) { f_widths, 0 },		\
+	.enum_ids = (const u16 []) { ids }
 
 struct pinmux_drive_reg_field {
 	u16 pin;
@@ -667,7 +668,9 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
  */
 #define PORTCR(nr, reg)							\
 	{								\
-		PINMUX_CFG_REG_VAR("PORT" nr "CR", reg, 8, 2, 2, 1, 3) {\
+		PINMUX_CFG_REG_VAR("PORT" nr "CR", reg, 8,		\
+				   GROUP(2, 2, 1, 3),			\
+				   GROUP(				\
 			/* PULMD[1:0], handled by .set_bias() */	\
 			0, 0, 0, 0,					\
 			/* IE and OE */					\
@@ -679,7 +682,7 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 			PORT##nr##_FN2, PORT##nr##_FN3,			\
 			PORT##nr##_FN4, PORT##nr##_FN5,			\
 			PORT##nr##_FN6, PORT##nr##_FN7			\
-		}							\
+		))							\
 	}
 
 /*
-- 
2.17.1
