From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:52 +0000
Subject: [PATCH v2 03/15] pinctrl: sh-pfc: Add r8a7793 PFC support part 3: pinmux config registers
Message-Id: <1430403544-26742-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Part of PFC support for R-Car M2-N (r8a7793) that defines the pinmux
configuration registers.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[uli: minor reformat to fit mainline, fixed typos, split]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7793.c | 1165 ++++++++++++++++++++++++++++++++++
 1 file changed, 1165 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7793.c b/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
index 2de729a..0b23346 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
@@ -4847,3 +4847,1168 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(vin1),
 	SH_PFC_FUNCTION(vin2),
 };
+
+static const struct pinmux_cfg_reg pinmux_config_regs[] = {
+	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
+		GP_0_31_FN, FN_IP1_22_20,
+		GP_0_30_FN, FN_IP1_19_17,
+		GP_0_29_FN, FN_IP1_16_14,
+		GP_0_28_FN, FN_IP1_13_11,
+		GP_0_27_FN, FN_IP1_10_8,
+		GP_0_26_FN, FN_IP1_7_6,
+		GP_0_25_FN, FN_IP1_5_4,
+		GP_0_24_FN, FN_IP1_3_2,
+		GP_0_23_FN, FN_IP1_1_0,
+		GP_0_22_FN, FN_IP0_30_29,
+		GP_0_21_FN, FN_IP0_28_27,
+		GP_0_20_FN, FN_IP0_26_25,
+		GP_0_19_FN, FN_IP0_24_23,
+		GP_0_18_FN, FN_IP0_22_21,
+		GP_0_17_FN, FN_IP0_20_19,
+		GP_0_16_FN, FN_IP0_18_16,
+		GP_0_15_FN, FN_IP0_15,
+		GP_0_14_FN, FN_IP0_14,
+		GP_0_13_FN, FN_IP0_13,
+		GP_0_12_FN, FN_IP0_12,
+		GP_0_11_FN, FN_IP0_11,
+		GP_0_10_FN, FN_IP0_10,
+		GP_0_9_FN, FN_IP0_9,
+		GP_0_8_FN, FN_IP0_8,
+		GP_0_7_FN, FN_IP0_7,
+		GP_0_6_FN, FN_IP0_6,
+		GP_0_5_FN, FN_IP0_5,
+		GP_0_4_FN, FN_IP0_4,
+		GP_0_3_FN, FN_IP0_3,
+		GP_0_2_FN, FN_IP0_2,
+		GP_0_1_FN, FN_IP0_1,
+		GP_0_0_FN, FN_IP0_0, }
+	},
+	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1) {
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		GP_1_25_FN, FN_IP3_21_20,
+		GP_1_24_FN, FN_IP3_19_18,
+		GP_1_23_FN, FN_IP3_17_16,
+		GP_1_22_FN, FN_IP3_15_14,
+		GP_1_21_FN, FN_IP3_13_12,
+		GP_1_20_FN, FN_IP3_11_9,
+		GP_1_19_FN, FN_RD_N,
+		GP_1_18_FN, FN_IP3_8_6,
+		GP_1_17_FN, FN_IP3_5_3,
+		GP_1_16_FN, FN_IP3_2_0,
+		GP_1_15_FN, FN_IP2_29_27,
+		GP_1_14_FN, FN_IP2_26_25,
+		GP_1_13_FN, FN_IP2_24_23,
+		GP_1_12_FN, FN_EX_CS0_N,
+		GP_1_11_FN, FN_IP2_22_21,
+		GP_1_10_FN, FN_IP2_20_19,
+		GP_1_9_FN, FN_IP2_18_16,
+		GP_1_8_FN, FN_IP2_15_13,
+		GP_1_7_FN, FN_IP2_12_10,
+		GP_1_6_FN, FN_IP2_9_7,
+		GP_1_5_FN, FN_IP2_6_5,
+		GP_1_4_FN, FN_IP2_4_3,
+		GP_1_3_FN, FN_IP2_2_0,
+		GP_1_2_FN, FN_IP1_31_29,
+		GP_1_1_FN, FN_IP1_28_26,
+		GP_1_0_FN, FN_IP1_25_23, }
+	},
+	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1) {
+		GP_2_31_FN, FN_IP6_7_6,
+		GP_2_30_FN, FN_IP6_5_3,
+		GP_2_29_FN, FN_IP6_2_0,
+		GP_2_28_FN, FN_AUDIO_CLKA,
+		GP_2_27_FN, FN_IP5_31_29,
+		GP_2_26_FN, FN_IP5_28_26,
+		GP_2_25_FN, FN_IP5_25_24,
+		GP_2_24_FN, FN_IP5_23_22,
+		GP_2_23_FN, FN_IP5_21_20,
+		GP_2_22_FN, FN_IP5_19_17,
+		GP_2_21_FN, FN_IP5_16_15,
+		GP_2_20_FN, FN_IP5_14_12,
+		GP_2_19_FN, FN_IP5_11_9,
+		GP_2_18_FN, FN_IP5_8_6,
+		GP_2_17_FN, FN_IP5_5_3,
+		GP_2_16_FN, FN_IP5_2_0,
+		GP_2_15_FN, FN_IP4_30_28,
+		GP_2_14_FN, FN_IP4_27_26,
+		GP_2_13_FN, FN_IP4_25_24,
+		GP_2_12_FN, FN_IP4_23_22,
+		GP_2_11_FN, FN_IP4_21,
+		GP_2_10_FN, FN_IP4_20,
+		GP_2_9_FN, FN_IP4_19,
+		GP_2_8_FN, FN_IP4_18_16,
+		GP_2_7_FN, FN_IP4_15_13,
+		GP_2_6_FN, FN_IP4_12_10,
+		GP_2_5_FN, FN_IP4_9_8,
+		GP_2_4_FN, FN_IP4_7_5,
+		GP_2_3_FN, FN_IP4_4_2,
+		GP_2_2_FN, FN_IP4_1_0,
+		GP_2_1_FN, FN_IP3_30_28,
+		GP_2_0_FN, FN_IP3_27_25 }
+	},
+	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1) {
+		GP_3_31_FN, FN_IP9_18_17,
+		GP_3_30_FN, FN_IP9_16,
+		GP_3_29_FN, FN_IP9_15_13,
+		GP_3_28_FN, FN_IP9_12,
+		GP_3_27_FN, FN_IP9_11,
+		GP_3_26_FN, FN_IP9_10_8,
+		GP_3_25_FN, FN_IP9_7,
+		GP_3_24_FN, FN_IP9_6,
+		GP_3_23_FN, FN_IP9_5_3,
+		GP_3_22_FN, FN_IP9_2_0,
+		GP_3_21_FN, FN_IP8_30_28,
+		GP_3_20_FN, FN_IP8_27_26,
+		GP_3_19_FN, FN_IP8_25_24,
+		GP_3_18_FN, FN_IP8_23_21,
+		GP_3_17_FN, FN_IP8_20_18,
+		GP_3_16_FN, FN_IP8_17_15,
+		GP_3_15_FN, FN_IP8_14_12,
+		GP_3_14_FN, FN_IP8_11_9,
+		GP_3_13_FN, FN_IP8_8_6,
+		GP_3_12_FN, FN_IP8_5_3,
+		GP_3_11_FN, FN_IP8_2_0,
+		GP_3_10_FN, FN_IP7_29_27,
+		GP_3_9_FN, FN_IP7_26_24,
+		GP_3_8_FN, FN_IP7_23_21,
+		GP_3_7_FN, FN_IP7_20_19,
+		GP_3_6_FN, FN_IP7_18_17,
+		GP_3_5_FN, FN_IP7_16_15,
+		GP_3_4_FN, FN_IP7_14_13,
+		GP_3_3_FN, FN_IP7_12_11,
+		GP_3_2_FN, FN_IP7_10_9,
+		GP_3_1_FN, FN_IP7_8_6,
+		GP_3_0_FN, FN_IP7_5_3 }
+	},
+	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1) {
+		GP_4_31_FN, FN_IP15_5_4,
+		GP_4_30_FN, FN_IP15_3_2,
+		GP_4_29_FN, FN_IP15_1_0,
+		GP_4_28_FN, FN_IP11_8_6,
+		GP_4_27_FN, FN_IP11_5_3,
+		GP_4_26_FN, FN_IP11_2_0,
+		GP_4_25_FN, FN_IP10_31_29,
+		GP_4_24_FN, FN_IP10_28_27,
+		GP_4_23_FN, FN_IP10_26_25,
+		GP_4_22_FN, FN_IP10_24_22,
+		GP_4_21_FN, FN_IP10_21_19,
+		GP_4_20_FN, FN_IP10_18_17,
+		GP_4_19_FN, FN_IP10_16_15,
+		GP_4_18_FN, FN_IP10_14_12,
+		GP_4_17_FN, FN_IP10_11_9,
+		GP_4_16_FN, FN_IP10_8_6,
+		GP_4_15_FN, FN_IP10_5_3,
+		GP_4_14_FN, FN_IP10_2_0,
+		GP_4_13_FN, FN_IP9_31_29,
+		GP_4_12_FN, FN_VI0_DATA7_VI0_B7,
+		GP_4_11_FN, FN_VI0_DATA6_VI0_B6,
+		GP_4_10_FN, FN_VI0_DATA5_VI0_B5,
+		GP_4_9_FN, FN_VI0_DATA4_VI0_B4,
+		GP_4_8_FN, FN_IP9_28_27,
+		GP_4_7_FN, FN_VI0_DATA2_VI0_B2,
+		GP_4_6_FN, FN_VI0_DATA1_VI0_B1,
+		GP_4_5_FN, FN_VI0_DATA0_VI0_B0,
+		GP_4_4_FN, FN_IP9_26_25,
+		GP_4_3_FN, FN_IP9_24_23,
+		GP_4_2_FN, FN_IP9_22_21,
+		GP_4_1_FN, FN_IP9_20_19,
+		GP_4_0_FN, FN_VI0_CLK }
+	},
+	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1) {
+		GP_5_31_FN, FN_IP3_24_22,
+		GP_5_30_FN, FN_IP13_9_7,
+		GP_5_29_FN, FN_IP13_6_5,
+		GP_5_28_FN, FN_IP13_4_3,
+		GP_5_27_FN, FN_IP13_2_0,
+		GP_5_26_FN, FN_IP12_29_27,
+		GP_5_25_FN, FN_IP12_26_24,
+		GP_5_24_FN, FN_IP12_23_22,
+		GP_5_23_FN, FN_IP12_21_20,
+		GP_5_22_FN, FN_IP12_19_18,
+		GP_5_21_FN, FN_IP12_17_16,
+		GP_5_20_FN, FN_IP12_15_13,
+		GP_5_19_FN, FN_IP12_12_10,
+		GP_5_18_FN, FN_IP12_9_7,
+		GP_5_17_FN, FN_IP12_6_4,
+		GP_5_16_FN, FN_IP12_3_2,
+		GP_5_15_FN, FN_IP12_1_0,
+		GP_5_14_FN, FN_IP11_31_30,
+		GP_5_13_FN, FN_IP11_29_28,
+		GP_5_12_FN, FN_IP11_27,
+		GP_5_11_FN, FN_IP11_26,
+		GP_5_10_FN, FN_IP11_25,
+		GP_5_9_FN, FN_IP11_24,
+		GP_5_8_FN, FN_IP11_23,
+		GP_5_7_FN, FN_IP11_22,
+		GP_5_6_FN, FN_IP11_21,
+		GP_5_5_FN, FN_IP11_20,
+		GP_5_4_FN, FN_IP11_19,
+		GP_5_3_FN, FN_IP11_18_17,
+		GP_5_2_FN, FN_IP11_16_15,
+		GP_5_1_FN, FN_IP11_14_12,
+		GP_5_0_FN, FN_IP11_11_9 }
+	},
+	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1) {
+		GP_6_31_FN, FN_DU0_DOTCLKIN,
+		GP_6_30_FN, FN_USB1_OVC,
+		GP_6_29_FN, FN_IP14_31_29,
+		GP_6_28_FN, FN_IP14_28_26,
+		GP_6_27_FN, FN_IP14_25_23,
+		GP_6_26_FN, FN_IP14_22_20,
+		GP_6_25_FN, FN_IP14_19_17,
+		GP_6_24_FN, FN_IP14_16_14,
+		GP_6_23_FN, FN_IP14_13_11,
+		GP_6_22_FN, FN_IP14_10_8,
+		GP_6_21_FN, FN_IP14_7,
+		GP_6_20_FN, FN_IP14_6,
+		GP_6_19_FN, FN_IP14_5,
+		GP_6_18_FN, FN_IP14_4,
+		GP_6_17_FN, FN_IP14_3,
+		GP_6_16_FN, FN_IP14_2,
+		GP_6_15_FN, FN_IP14_1_0,
+		GP_6_14_FN, FN_IP13_30_28,
+		GP_6_13_FN, FN_IP13_27,
+		GP_6_12_FN, FN_IP13_26,
+		GP_6_11_FN, FN_IP13_25,
+		GP_6_10_FN, FN_IP13_24_23,
+		GP_6_9_FN, FN_IP13_22,
+		GP_6_8_FN, FN_SD1_CLK,
+		GP_6_7_FN, FN_IP13_21_19,
+		GP_6_6_FN, FN_IP13_18_16,
+		GP_6_5_FN, FN_IP13_15,
+		GP_6_4_FN, FN_IP13_14,
+		GP_6_3_FN, FN_IP13_13,
+		GP_6_2_FN, FN_IP13_12,
+		GP_6_1_FN, FN_IP13_11,
+		GP_6_0_FN, FN_IP13_10 }
+	},
+	{ PINMUX_CFG_REG("GPSR7", 0xE6060074, 32, 1) {
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		GP_7_25_FN, FN_USB1_PWEN,
+		GP_7_24_FN, FN_USB0_OVC,
+		GP_7_23_FN, FN_USB0_PWEN,
+		GP_7_22_FN, FN_IP15_14_12,
+		GP_7_21_FN, FN_IP15_11_9,
+		GP_7_20_FN, FN_IP15_8_6,
+		GP_7_19_FN, FN_IP7_2_0,
+		GP_7_18_FN, FN_IP6_29_27,
+		GP_7_17_FN, FN_IP6_26_24,
+		GP_7_16_FN, FN_IP6_23_21,
+		GP_7_15_FN, FN_IP6_20_19,
+		GP_7_14_FN, FN_IP6_18_16,
+		GP_7_13_FN, FN_IP6_15_14,
+		GP_7_12_FN, FN_IP6_13_12,
+		GP_7_11_FN, FN_IP6_11_10,
+		GP_7_10_FN, FN_IP6_9_8,
+		GP_7_9_FN, FN_IP16_11_10,
+		GP_7_8_FN, FN_IP16_9_8,
+		GP_7_7_FN, FN_IP16_7_6,
+		GP_7_6_FN, FN_IP16_5_3,
+		GP_7_5_FN, FN_IP16_2_0,
+		GP_7_4_FN, FN_IP15_29_27,
+		GP_7_3_FN, FN_IP15_26_24,
+		GP_7_2_FN, FN_IP15_23_21,
+		GP_7_1_FN, FN_IP15_20_18,
+		GP_7_0_FN, FN_IP15_17_15 }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
+			     1, 2, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1,
+			     1, 1, 1, 1, 1, 1, 1, 1) {
+		/* IP0_31 [1] */
+		0, 0,
+		/* IP0_30_29 [2] */
+		FN_A6, FN_MSIOF1_SCK,
+		0, 0,
+		/* IP0_28_27 [2] */
+		FN_A5, FN_MSIOF0_RXD_B,
+		0, 0,
+		/* IP0_26_25 [2] */
+		FN_A4, FN_MSIOF0_TXD_B,
+		0, 0,
+		/* IP0_24_23 [2] */
+		FN_A3, FN_MSIOF0_SS2_B,
+		0, 0,
+		/* IP0_22_21 [2] */
+		FN_A2, FN_MSIOF0_SS1_B,
+		0, 0,
+		/* IP0_20_19 [2] */
+		FN_A1, FN_MSIOF0_SYNC_B,
+		0, 0,
+		/* IP0_18_16 [3] */
+		FN_A0, FN_ATAWR0_N_C, FN_MSIOF0_SCK_B, FN_SCL0_C, FN_PWM2_B,
+		0, 0, 0,
+		/* IP0_15 [1] */
+		FN_D15, 0,
+		/* IP0_14 [1] */
+		FN_D14, 0,
+		/* IP0_13 [1] */
+		FN_D13, 0,
+		/* IP0_12 [1] */
+		FN_D12, 0,
+		/* IP0_11 [1] */
+		FN_D11, 0,
+		/* IP0_10 [1] */
+		FN_D10, 0,
+		/* IP0_9 [1] */
+		FN_D9, 0,
+		/* IP0_8 [1] */
+		FN_D8, 0,
+		/* IP0_7 [1] */
+		FN_D7, 0,
+		/* IP0_6 [1] */
+		FN_D6, 0,
+		/* IP0_5 [1] */
+		FN_D5, 0,
+		/* IP0_4 [1] */
+		FN_D4, 0,
+		/* IP0_3 [1] */
+		FN_D3, 0,
+		/* IP0_2 [1] */
+		FN_D2, 0,
+		/* IP0_1 [1] */
+		FN_D1, 0,
+		/* IP0_0 [1] */
+		FN_D0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR1", 0xE6060024, 32,
+			     3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2) {
+		/* IP1_31_29 [3] */
+		FN_A18, FN_DREQ1, FN_SCIFA1_RXD_C, 0, FN_SCIFB1_RXD_C,
+		0, 0, 0,
+		/* IP1_28_26 [3] */
+		FN_A17, FN_DACK2_B, 0, FN_SDA0_C,
+		0, 0, 0, 0,
+		/* IP1_25_23 [3] */
+		FN_A16, FN_DREQ2_B, FN_FMCLK_C, 0, FN_SCIFA1_SCK_B,
+		0, 0, 0,
+		/* IP1_22_20 [3] */
+		FN_A15, FN_BPFCLK_C,
+		0, 0, 0, 0, 0, 0,
+		/* IP1_19_17 [3] */
+		FN_A14, FN_ATADIR0_N_C, FN_FMIN, FN_FMIN_C, FN_MSIOF1_SYNC_D,
+		0, 0, 0,
+		/* IP1_16_14 [3] */
+		FN_A13, FN_ATAG0_N_C, FN_BPFCLK, FN_MSIOF1_SS1_D,
+		0, 0, 0, 0,
+		/* IP1_13_11 [3] */
+		FN_A12, FN_FMCLK, FN_SDA3_D, FN_MSIOF1_SCK_D,
+		0, 0, 0, 0,
+		/* IP1_10_8 [3] */
+		FN_A11, FN_MSIOF1_RXD, FN_SCL3_D, FN_MSIOF1_RXD_D,
+		0, 0, 0, 0,
+		/* IP1_7_6 [2] */
+		FN_A10, FN_MSIOF1_TXD, 0, FN_MSIOF1_TXD_D,
+		/* IP1_5_4 [2] */
+		FN_A9, FN_MSIOF1_SS2, FN_SDA0, 0,
+		/* IP1_3_2 [2] */
+		FN_A8, FN_MSIOF1_SS1, FN_SCL0, 0,
+		/* IP1_1_0 [2] */
+		FN_A7, FN_MSIOF1_SYNC,
+		0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR2", 0xE6060028, 32,
+			     2, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 3) {
+		/* IP2_31_20 [2] */
+		0, 0, 0, 0,
+		/* IP2_29_27 [3] */
+		FN_EX_CS3_N, FN_ATADIR0_N, FN_MSIOF2_TXD,
+		FN_ATAG0_N, 0, FN_EX_WAIT1,
+		0, 0,
+		/* IP2_26_25 [2] */
+		FN_EX_CS2_N, FN_ATAWR0_N, FN_MSIOF2_SYNC, 0,
+		/* IP2_24_23 [2] */
+		FN_EX_CS1_N, FN_MSIOF2_SCK, 0, 0,
+		/* IP2_22_21 [2] */
+		FN_CS1_N_A26, FN_ATADIR0_N_B, FN_SDA1, 0,
+		/* IP2_20_19 [2] */
+		FN_CS0_N, FN_ATAG0_N_B, FN_SCL1, 0,
+		/* IP2_18_16 [3] */
+		FN_A25, FN_DACK2, FN_SSL, FN_DREQ1_C, FN_RX1, FN_SCIFA1_RXD,
+		0, 0,
+		/* IP2_15_13 [3] */
+		FN_A24, FN_DREQ2, FN_IO3, FN_TX1, FN_SCIFA1_TXD,
+		0, 0, 0,
+		/* IP2_12_0 [3] */
+		FN_A23, FN_IO2, FN_BPFCLK_B, FN_RX0, FN_SCIFA0_RXD,
+		0, 0, 0,
+		/* IP2_9_7 [3] */
+		FN_A22, FN_MISO_IO1, FN_FMCLK_B, FN_TX0, FN_SCIFA0_TXD,
+		0, 0, 0,
+		/* IP2_6_5 [2] */
+		FN_A21, FN_ATAWR0_N_B, FN_MOSI_IO0, 0,
+		/* IP2_4_3 [2] */
+		FN_A20, FN_SPCLK, 0, 0,
+		/* IP2_2_0 [3] */
+		FN_A19, FN_DACK1, FN_SCIFA1_TXD_C, 0,
+		FN_SCIFB1_TXD_C, 0, FN_SCIFB1_SCK_B, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR3", 0xE606002C, 32,
+			     1, 3, 3, 3, 2, 2, 2, 2, 2, 3, 3, 3, 3) {
+		/* IP3_31 [1] */
+		0, 0,
+		/* IP3_30_28 [3] */
+		FN_SSI_WS0129, FN_HTX0_C, FN_HTX2_C,
+		FN_SCIFB0_TXD_C, FN_SCIFB2_TXD_C,
+		0, 0, 0,
+		/* IP3_27_25 [3] */
+		FN_SSI_SCK0129, FN_HRX0_C, FN_HRX2_C,
+		FN_SCIFB0_RXD_C, FN_SCIFB2_RXD_C,
+		0, 0, 0,
+		/* IP3_24_22 [3] */
+		FN_SPEEDIN, 0, FN_HSCK0_C, FN_HSCK2_C, FN_SCIFB0_SCK_B,
+		FN_SCIFB2_SCK_B, FN_DREQ2_C, FN_HTX2_D,
+		/* IP3_21_20 [2] */
+		FN_DACK0, FN_DRACK0, FN_REMOCON, 0,
+		/* IP3_19_18 [2] */
+		FN_DREQ0, FN_PWM3, FN_TPU_TO3, 0,
+		/* IP3_17_16 [2] */
+		FN_EX_WAIT0, FN_HRTS2_N_B, FN_SCIFB0_CTS_N_B, 0,
+		/* IP3_15_14 [2] */
+		FN_WE1_N, FN_ATARD0_N_B, FN_HTX2_B, FN_SCIFB0_RTS_N_B,
+		/* IP3_13_12 [2] */
+		FN_WE0_N, FN_HCTS2_N_B, FN_SCIFB0_TXD_B, 0,
+		/* IP3_11_9 [3] */
+		FN_RD_WR_N, FN_HRX2_B, FN_FMIN_B, FN_SCIFB0_RXD_B, FN_DREQ1_D,
+		0, 0, 0,
+		/* IP3_8_6 [3] */
+		FN_BS_N, FN_ATACS10_N, FN_MSIOF2_SS2, FN_HTX1_B,
+		FN_SCIFB1_TXD_B, FN_PWM2, FN_TPU_TO2, 0,
+		/* IP3_5_3 [3] */
+		FN_EX_CS5_N, FN_ATACS00_N, FN_MSIOF2_SS1, FN_HRX1_B,
+		FN_SCIFB1_RXD_B, FN_PWM1, FN_TPU_TO1, 0,
+		/* IP3_2_0 [3] */
+		FN_EX_CS4_N, FN_ATARD0_N, FN_MSIOF2_RXD, 0, FN_EX_WAIT2,
+		0, 0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR4", 0xE6060030, 32,
+			     1, 3, 2, 2, 2, 1, 1, 1, 3, 3, 3, 2, 3, 3, 2) {
+		/* IP4_31 [1] */
+		0, 0,
+		/* IP4_30_28 [3] */
+		FN_SSI_SCK5, FN_MSIOF1_SCK_C, FN_TS_SDATA0, FN_GLO_I0,
+		FN_MSIOF2_SYNC_D, FN_VI1_R2_B,
+		0, 0,
+		/* IP4_27_26 [2] */
+		FN_SSI_SDATA4, FN_MSIOF2_SCK_D, 0, 0,
+		/* IP4_25_24 [2] */
+		FN_SSI_WS4, FN_GLO_RFON_D, 0, 0,
+		/* IP4_23_22 [2] */
+		FN_SSI_SCK4, FN_GLO_SS_D, 0, 0,
+		/* IP4_21 [1] */
+		FN_SSI_SDATA3, 0,
+		/* IP4_20 [1] */
+		FN_SSI_WS34, 0,
+		/* IP4_19 [1] */
+		FN_SSI_SCK34, 0,
+		/* IP4_18_16 [3] */
+		FN_SSI_SDATA2, FN_GPS_MAG_B, FN_TX2_E, FN_HRTS1_N_E,
+		0, 0, 0, 0,
+		/* IP4_15_13 [3] */
+		FN_SSI_WS2, FN_SDA2, FN_GPS_SIGN_B, FN_RX2_E,
+		FN_GLO_Q1_D, FN_HCTS1_N_E,
+		0, 0,
+		/* IP4_12_10 [3] */
+		FN_SSI_SCK2, FN_SCL2, FN_GPS_CLK_B, FN_GLO_Q0_D, FN_HSCK1_E,
+		0, 0, 0,
+		/* IP4_9_8 [2] */
+		FN_SSI_SDATA1, FN_SDA1_B, FN_SDA8_B, FN_MSIOF2_RXD_C,
+		/* IP4_7_5 [3] */
+		FN_SSI_WS1, FN_SCL1_B, FN_SCL8_B, FN_MSIOF2_TXD_C, FN_GLO_I1_D,
+		0, 0, 0,
+		/* IP4_4_2 [3] */
+		FN_SSI_SCK1, FN_SDA0_B, FN_SDA7_B,
+		FN_MSIOF2_SYNC_C, FN_GLO_I0_D,
+		0, 0, 0,
+		/* IP4_1_0 [2] */
+		FN_SSI_SDATA0, FN_SCL0_B, FN_SCL7_B, FN_MSIOF2_SCK_C, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR5", 0xE6060034, 32,
+			     3, 3, 2, 2, 2, 3, 2, 3, 3, 3, 3, 3) {
+		/* IP5_31_29 [3] */
+		FN_SSI_SDATA9, FN_RX3_D, FN_CAN0_RX_D,
+		0, 0, 0, 0, 0,
+		/* IP5_28_26 [3] */
+		FN_SSI_WS9, FN_TX3_D, FN_CAN0_TX_D, FN_GLO_SDATA_D,
+		0, 0, 0, 0,
+		/* IP5_25_24 [2] */
+		FN_SSI_SCK9, FN_RX1_D, FN_GLO_SCLK_D, 0,
+		/* IP5_23_22 [2] */
+		FN_SSI_SDATA8, FN_TX1_D, FN_STP_ISSYNC_0_B, 0,
+		/* IP5_21_20 [2] */
+		FN_SSI_SDATA7, FN_RX0_D, FN_STP_ISEN_0_B, 0,
+		/* IP5_19_17 [3] */
+		FN_SSI_WS78, FN_TX0_D, FN_STP_ISD_0_B, FN_GLO_RFON,
+		0, 0, 0, 0,
+		/* IP5_16_15 [2] */
+		FN_SSI_SCK78, FN_STP_ISCLK_0_B, FN_GLO_SS, 0,
+		/* IP5_14_12 [3] */
+		FN_SSI_SDATA6, FN_STP_IVCXO27_0_B, FN_GLO_SDATA, FN_VI1_R7_B,
+		0, 0, 0, 0,
+		/* IP5_11_9 [3] */
+		FN_SSI_WS6, FN_GLO_SCLK, FN_MSIOF2_SS2_D, FN_VI1_R6_B,
+		0, 0, 0, 0,
+		/* IP5_8_6 [3] */
+		FN_SSI_SCK6, FN_MSIOF1_RXD_C, FN_TS_SPSYNC0, FN_GLO_Q1,
+		FN_MSIOF2_RXD_D, FN_VI1_R5_B,
+		0, 0,
+		/* IP5_5_3 [3] */
+		FN_SSI_SDATA5, FN_MSIOF1_TXD_C, FN_TS_SDEN0, FN_GLO_Q0,
+		FN_MSIOF2_SS1_D, FN_VI1_R4_B,
+		0, 0,
+		/* IP5_2_0 [3] */
+		FN_SSI_WS5, FN_MSIOF1_SYNC_C, FN_TS_SCK0, FN_GLO_I1,
+		FN_MSIOF2_TXD_D, FN_VI1_R3_B,
+		0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR6", 0xE6060038, 32,
+			     2, 3, 3, 3, 2, 3, 2, 2, 2, 2, 2, 3, 3) {
+		/* IP6_31_30 [2] */
+		0, 0, 0, 0,
+		/* IP6_29_27 [3] */
+		FN_IRQ8, FN_HRTS1_N_C, FN_MSIOF1_RXD_B,
+		FN_GPS_SIGN_C, FN_GPS_SIGN_D,
+		0, 0, 0,
+		/* IP6_26_24 [3] */
+		FN_IRQ7, FN_HCTS1_N_C, FN_MSIOF1_TXD_B,
+		FN_GPS_CLK_C, FN_GPS_CLK_D,
+		0, 0, 0,
+		/* IP6_23_21 [3] */
+		FN_IRQ6, FN_HSCK1_C, FN_MSIOF1_SS2_B,
+		FN_SDA1_E, FN_MSIOF2_SYNC_E,
+		0, 0, 0,
+		/* IP6_20_19 [2] */
+		FN_IRQ5, FN_HTX1_C, FN_SCL1_E, FN_MSIOF2_SCK_E,
+		/* IP6_18_16 [3] */
+		FN_IRQ4, FN_HRX1_C, FN_SDA4_C, FN_MSIOF2_RXD_E, FN_INTC_IRQ4_N,
+		0, 0, 0,
+		/* IP6_15_14 [2] */
+		FN_IRQ3, FN_SCL4_C, FN_MSIOF2_TXD_E, FN_INTC_IRQ3_N,
+		/* IP6_13_12 [2] */
+		FN_IRQ2, FN_SCIFB1_TXD_D, FN_INTC_IRQ2_N, 0,
+		/* IP6_11_10 [2] */
+		FN_IRQ1, FN_SCIFB1_SCK_C, FN_INTC_IRQ1_N, 0,
+		/* IP6_9_8 [2] */
+		FN_IRQ0, FN_SCIFB1_RXD_D, FN_INTC_IRQ0_N, 0,
+		/* IP6_7_6 [2] */
+		FN_AUDIO_CLKOUT, FN_MSIOF1_SS1_B, FN_TX2, FN_SCIFA2_TXD,
+		/* IP6_5_3 [3] */
+		FN_AUDIO_CLKC, FN_SCIFB0_SCK_C, FN_MSIOF1_SYNC_B, FN_RX2,
+		FN_SCIFA2_RXD, FN_FMIN_E,
+		0, 0,
+		/* IP6_2_0 [3] */
+		FN_AUDIO_CLKB, FN_STP_OPWM_0_B, FN_MSIOF1_SCK_B,
+		FN_SCIF_CLK, 0, FN_BPFCLK_E,
+		0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR7", 0xE606003C, 32,
+			     2, 3, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 3) {
+		/* IP7_31_30 [2] */
+		0, 0, 0, 0,
+		/* IP7_29_27 [3] */
+		FN_DU1_DG2, FN_LCDOUT10, FN_VI1_DATA4_B, FN_SCIF1_SCK_B,
+		FN_SCIFA1_SCK, FN_SSI_SCK78_B,
+		0, 0,
+		/* IP7_26_24 [3] */
+		FN_DU1_DG1, FN_LCDOUT9, FN_VI1_DATA3_B, FN_RX1_B,
+		FN_SCIFA1_RXD_B, FN_MSIOF2_SS2_B,
+		0, 0,
+		/* IP7_23_21 [3] */
+		FN_DU1_DG0, FN_LCDOUT8, FN_VI1_DATA2_B, FN_TX1_B,
+		FN_SCIFA1_TXD_B, FN_MSIOF2_SS1_B,
+		0, 0,
+		/* IP7_20_19 [2] */
+		FN_DU1_DR7, FN_LCDOUT7, FN_SSI_SDATA1_B, 0,
+		/* IP7_18_17 [2] */
+		FN_DU1_DR6, FN_LCDOUT6, FN_SSI_WS1_B, 0,
+		/* IP7_16_15 [2] */
+		FN_DU1_DR5, FN_LCDOUT5, FN_SSI_SCK1_B, 0,
+		/* IP7_14_13 [2] */
+		FN_DU1_DR4, FN_LCDOUT4, FN_SSI_SDATA0_B, 0,
+		/* IP7_12_11 [2] */
+		FN_DU1_DR3, FN_LCDOUT3, FN_SSI_WS0129_B, 0,
+		/* IP7_10_9 [2] */
+		FN_DU1_DR2, FN_LCDOUT2, FN_SSI_SCK0129_B, 0,
+		/* IP7_8_6 [3] */
+		FN_DU1_DR1, FN_LCDOUT1, FN_VI1_DATA1_B, FN_RX0_B,
+		FN_SCIFA0_RXD_B, FN_MSIOF2_SYNC_B,
+		0, 0,
+		/* IP7_5_3 [3] */
+		FN_DU1_DR0, FN_LCDOUT0, FN_VI1_DATA0_B, FN_TX0_B,
+		FN_SCIFA0_TXD_B, FN_MSIOF2_SCK_B,
+		0, 0,
+		/* IP7_2_0 [3] */
+		FN_IRQ9, FN_DU1_DOTCLKIN_B, FN_CAN_CLK_D, FN_GPS_MAG_C,
+		FN_SCIF_CLK_B, FN_GPS_MAG_D,
+		0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR8", 0xE6060040, 32,
+			     1, 3, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3) {
+		/* IP8_31 [1] */
+		0, 0,
+		/* IP8_30_28 [3] */
+		FN_DU1_DB5, FN_LCDOUT21, FN_TX3, FN_SCIFA3_TXD, FN_CAN1_TX,
+		0, 0, 0,
+		/* IP8_27_26 [2] */
+		FN_DU1_DB4, FN_LCDOUT20, FN_VI1_FIELD_B, FN_CAN1_RX,
+		/* IP8_25_24 [2] */
+		FN_DU1_DB3, FN_LCDOUT19, FN_VI1_CLKENB_B, 0,
+		/* IP8_23_21 [3] */
+		FN_DU1_DB2, FN_LCDOUT18, FN_VI1_VSYNC_N_B, FN_SCIF2_SCK_B,
+		FN_SCIFA2_SCK, FN_SSI_SDATA9_B,
+		0, 0,
+		/* IP8_20_18 [3] */
+		FN_DU1_DB1, FN_LCDOUT17, FN_VI1_HSYNC_N_B, FN_RX2_B,
+		FN_SCIFA2_RXD_B, FN_MSIOF2_RXD_B,
+		0, 0,
+		/* IP8_17_15 [3] */
+		FN_DU1_DB0, FN_LCDOUT16, FN_VI1_CLK_B, FN_TX2_B,
+		FN_SCIFA2_TXD_B, FN_MSIOF2_TXD_B,
+		0, 0,
+		/* IP8_14_12 [3] */
+		FN_DU1_DG7, FN_LCDOUT15, FN_HTX0_B,
+		FN_SCIFB2_RTS_N_B, FN_SSI_WS9_B,
+		0, 0, 0,
+		/* IP8_11_9 [3] */
+		FN_DU1_DG6, FN_LCDOUT14, FN_HRTS0_N_B,
+		FN_SCIFB2_CTS_N_B, FN_SSI_SCK9_B,
+		0, 0, 0,
+		/* IP8_8_6 [3] */
+		FN_DU1_DG5, FN_LCDOUT13, FN_VI1_DATA7_B, FN_HCTS0_N_B,
+		FN_SCIFB2_TXD_B, FN_SSI_SDATA8_B,
+		0, 0,
+		/* IP8_5_3 [3] */
+		FN_DU1_DG4, FN_LCDOUT12, FN_VI1_DATA6_B, FN_HRX0_B,
+		FN_SCIFB2_RXD_B, FN_SSI_SDATA7_B,
+		0, 0,
+		/* IP8_2_0 [3] */
+		FN_DU1_DG3, FN_LCDOUT11, FN_VI1_DATA5_B, 0, FN_SSI_WS78_B,
+		0, 0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR9", 0xE6060044, 32,
+			     3, 2, 2, 2, 2, 2, 2, 1, 3, 1, 1, 3, 1, 1, 3, 3) {
+		/* IP9_31_29 [3] */
+		FN_VI0_G0, FN_SCL8, FN_STP_IVCXO27_0_C, FN_SCL4,
+		FN_HCTS2_N, FN_SCIFB2_CTS_N, FN_ATAWR1_N, 0,
+		/* IP9_28_27 [2] */
+		FN_VI0_DATA3_VI0_B3, FN_SCIF3_SCK_B, FN_SCIFA3_SCK_B, 0,
+		/* IP9_26_25 [2] */
+		FN_VI0_VSYNC_N, FN_RX5, FN_SCIFA5_RXD, FN_TS_SPSYNC0_D,
+		/* IP9_24_23 [2] */
+		FN_VI0_HSYNC_N, FN_TX5, FN_SCIFA5_TXD, FN_TS_SDEN0_D,
+		/* IP9_22_21 [2] */
+		FN_VI0_FIELD, FN_RX4, FN_SCIFA4_RXD, FN_TS_SCK0_D,
+		/* IP9_20_19 [2] */
+		FN_VI0_CLKENB, FN_TX4, FN_SCIFA4_TXD, FN_TS_SDATA0_D,
+		/* IP9_18_17 [2] */
+		FN_DU1_CDE, FN_QPOLB, FN_PWM4_B, 0,
+		/* IP9_16 [1] */
+		FN_DU1_DISP, FN_QPOLA,
+		/* IP9_15_13 [3] */
+		FN_DU1_EXODDF_DU1_ODDF_DISP_CDE, FN_QCPV_QDE,
+		FN_CAN0_RX, FN_RX3_B, FN_SDA2_B,
+		0, 0, 0,
+		/* IP9_12 [1] */
+		FN_DU1_EXVSYNC_DU1_VSYNC, FN_QSTB_QHE,
+		/* IP9_11 [1] */
+		FN_DU1_EXHSYNC_DU1_HSYNC, FN_QSTH_QHS,
+		/* IP9_10_8 [3] */
+		FN_DU1_DOTCLKOUT1, FN_QSTVB_QVE, FN_CAN0_TX,
+		FN_TX3_B, FN_SCL2_B, FN_PWM4,
+		0, 0,
+		/* IP9_7 [1] */
+		FN_DU1_DOTCLKOUT0, FN_QCLK,
+		/* IP9_6 [1] */
+		FN_DU1_DOTCLKIN, FN_QSTVA_QVS,
+		/* IP9_5_3 [3] */
+		FN_DU1_DB7, FN_LCDOUT23, FN_SDA3_C,
+		FN_SCIF3_SCK, FN_SCIFA3_SCK,
+		0, 0, 0,
+		/* IP9_2_0 [3] */
+		FN_DU1_DB6, FN_LCDOUT22, FN_SCL3_C, FN_RX3, FN_SCIFA3_RXD,
+		0, 0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR10", 0xE6060048, 32,
+			     3, 2, 2, 3, 3, 2, 2, 3, 3, 3, 3, 3) {
+		/* IP10_31_29 [3] */
+		FN_VI0_R4, FN_VI2_DATA5, FN_GLO_SCLK_B, FN_TX0_C, FN_SCL1_D,
+		0, 0, 0,
+		/* IP10_28_27 [2] */
+		FN_VI0_R3, FN_VI2_DATA4, FN_GLO_Q1_B, FN_TS_SPSYNC0_C,
+		/* IP10_26_25 [2] */
+		FN_VI0_R2, FN_VI2_DATA3, FN_GLO_Q0_B, FN_TS_SDEN0_C,
+		/* IP10_24_22 [3] */
+		FN_VI0_R1, FN_VI2_DATA2, FN_GLO_I1_B, FN_TS_SCK0_C, FN_ATAG1_N,
+		0, 0, 0,
+		/* IP10_21_29 [3] */
+		FN_VI0_R0, FN_VI2_DATA1, FN_GLO_I0_B,
+		FN_TS_SDATA0_C, FN_ATACS11_N,
+		0, 0, 0,
+		/* IP10_18_17 [2] */
+		FN_VI0_G7, FN_VI2_DATA0, FN_FMIN_D, 0,
+		/* IP10_16_15 [2] */
+		FN_VI0_G6, FN_VI2_CLK, FN_BPFCLK_D, 0,
+		/* IP10_14_12 [3] */
+		FN_VI0_G5, FN_VI2_FIELD, FN_STP_OPWM_0_C, FN_FMCLK_D,
+		FN_CAN0_TX_E, FN_HTX1_D, FN_SCIFB0_TXD_D, 0,
+		/* IP10_11_9 [3] */
+		FN_VI0_G4, FN_VI2_CLKENB, FN_STP_ISSYNC_0_C,
+		FN_HTX2, FN_SCIFB2_TXD, FN_SCIFB0_SCK_D,
+		0, 0,
+		/* IP10_8_6 [3] */
+		FN_VI0_G3, FN_VI2_VSYNC_N, FN_STP_ISEN_0_C, FN_SDA3_B,
+		FN_HRX2, FN_SCIFB2_RXD, FN_ATACS01_N, 0,
+		/* IP10_5_3 [3] */
+		FN_VI0_G2, FN_VI2_HSYNC_N, FN_STP_ISD_0_C, FN_SCL3_B,
+		FN_HSCK2, FN_SCIFB2_SCK, FN_ATARD1_N, 0,
+		/* IP10_2_0 [3] */
+		FN_VI0_G1, FN_SDA8, FN_STP_ISCLK_0_C, FN_SDA4,
+		FN_HRTS2_N, FN_SCIFB2_RTS_N, FN_ATADIR1_N, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR11", 0xE606004C, 32,
+			     2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2,
+			     3, 3, 3, 3, 3) {
+		/* IP11_31_30 [2] */
+		FN_ETH_CRS_DV, FN_AVB_LINK, FN_SDA2_C, 0,
+		/* IP11_29_28 [2] */
+		FN_ETH_MDIO, FN_AVB_RX_CLK, FN_SCL2_C, 0,
+		/* IP11_27 [1] */
+		FN_VI1_DATA7, FN_AVB_MDC,
+		/* IP11_26 [1] */
+		FN_VI1_DATA6, FN_AVB_MAGIC,
+		/* IP11_25 [1] */
+		FN_VI1_DATA5, FN_AVB_RX_DV,
+		/* IP11_24 [1] */
+		FN_VI1_DATA4, FN_AVB_MDIO,
+		/* IP11_23 [1] */
+		FN_VI1_DATA3, FN_AVB_RX_ER,
+		/* IP11_22 [1] */
+		FN_VI1_DATA2, FN_AVB_RXD7,
+		/* IP11_21 [1] */
+		FN_VI1_DATA1, FN_AVB_RXD6,
+		/* IP11_20 [1] */
+		FN_VI1_DATA0, FN_AVB_RXD5,
+		/* IP11_19 [1] */
+		FN_VI1_CLK, FN_AVB_RXD4,
+		/* IP11_18_17 [2] */
+		FN_VI1_FIELD, FN_AVB_RXD3, FN_TS_SPSYNC0_B, 0,
+		/* IP11_16_15 [2] */
+		FN_VI1_CLKENB, FN_AVB_RXD2, FN_TS_SDEN0_B, 0,
+		/* IP11_14_12 [3] */
+		FN_VI1_VSYNC_N, FN_AVB_RXD1, FN_TS_SCK0_B,
+		FN_RX4_B, FN_SCIFA4_RXD_B,
+		0, 0, 0,
+		/* IP11_11_9 [3] */
+		FN_VI1_HSYNC_N, FN_AVB_RXD0, FN_TS_SDATA0_B,
+		FN_TX4_B, FN_SCIFA4_TXD_B,
+		0, 0, 0,
+		/* IP11_8_6 [3] */
+		FN_VI0_R7, FN_GLO_RFON_B, FN_RX1_C, FN_CAN0_RX_E,
+		FN_SDA4_B, FN_HRX1_D, FN_SCIFB0_RXD_D, 0,
+		/* IP11_5_3 [3] */
+		FN_VI0_R6, FN_VI2_DATA7, FN_GLO_SS_B, FN_TX1_C, FN_SCL4_B,
+		0, 0, 0,
+		/* IP11_2_0 [3] */
+		FN_VI0_R5, FN_VI2_DATA6, FN_GLO_SDATA_B, FN_RX0_C, FN_SDA1_D,
+		0, 0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR12", 0xE6060050, 32,
+			     2, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2) {
+		/* IP12_31_30 [2] */
+		0, 0, 0, 0,
+		/* IP12_29_27 [3] */
+		FN_STP_ISCLK_0, FN_AVB_TX_EN, FN_SCIFB2_RXD_D,
+		FN_ADICS_SAMP_B, FN_MSIOF0_SCK_C,
+		0, 0, 0,
+		/* IP12_26_24 [3] */
+		FN_STP_IVCXO27_0, FN_AVB_TXD7, FN_SCIFB2_TXD_D,
+		FN_ADIDATA_B, FN_MSIOF0_SYNC_C,
+		0, 0, 0,
+		/* IP12_23_22 [2] */
+		FN_ETH_MDC, FN_AVB_TXD6, FN_IERX_C, 0,
+		/* IP12_21_20 [2] */
+		FN_ETH_TXD0, FN_AVB_TXD5, FN_IECLK_C, 0,
+		/* IP12_19_18 [2] */
+		FN_ETH_MAGIC, FN_AVB_TXD4, FN_IETX_C, 0,
+		/* IP12_17_16 [2] */
+		FN_ETH_TX_EN, FN_AVB_TXD3, FN_TCLK1_B, FN_CAN_CLK_B,
+		/* IP12_15_13 [3] */
+		FN_ETH_TXD1, FN_AVB_TXD2, FN_SCIFA3_TXD_B,
+		FN_CAN1_TX_C, FN_MSIOF1_TXD_E,
+		0, 0, 0,
+		/* IP12_12_10 [3] */
+		FN_ETH_REFCLK, FN_AVB_TXD1, FN_SCIFA3_RXD_B,
+		FN_CAN1_RX_C, FN_MSIOF1_SYNC_E,
+		0, 0, 0,
+		/* IP12_9_7 [3] */
+		FN_ETH_LINK, FN_AVB_TXD0, FN_CAN0_RX_C,
+		FN_SDA2_D, FN_MSIOF1_SCK_E,
+		0, 0, 0,
+		/* IP12_6_4 [3] */
+		FN_ETH_RXD1, FN_AVB_GTXREFCLK, FN_CAN0_TX_C,
+		FN_SCL2_D, FN_MSIOF1_RXD_E,
+		0, 0, 0,
+		/* IP12_3_2 [2] */
+		FN_ETH_RXD0, FN_AVB_PHY_INT, FN_SDA3, FN_SDA7,
+		/* IP12_1_0 [2] */
+		FN_ETH_RX_ER, FN_AVB_CRS, FN_SCL3, FN_SCL7, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR13", 0xE6060054, 32,
+			     1, 3, 1, 1, 1, 2, 1, 3, 3, 1, 1, 1, 1, 1, 1,
+			     3, 2, 2, 3) {
+		/* IP13_31 [1] */
+		0, 0,
+		/* IP13_30_28 [3] */
+		FN_SD1_CD, FN_PWM0, FN_TPU_TO0, FN_SCL1_C,
+		0, 0, 0, 0,
+		/* IP13_27 [1] */
+		FN_SD1_DATA3, FN_IERX_B,
+		/* IP13_26 [1] */
+		FN_SD1_DATA2, FN_IECLK_B,
+		/* IP13_25 [1] */
+		FN_SD1_DATA1, FN_IETX_B,
+		/* IP13_24_23 [2] */
+		FN_SD1_DATA0, FN_SPEEDIN_B, 0, 0,
+		/* IP13_22 [1] */
+		FN_SD1_CMD, FN_REMOCON_B,
+		/* IP13_21_19 [3] */
+		FN_SD0_WP, FN_MMC_D7_B, FN_SIM0_D_B, FN_CAN0_TX_F,
+		FN_SCIFA5_RXD_B, FN_RX3_C,
+		0, 0,
+		/* IP13_18_16 [3] */
+		FN_SD0_CD, FN_MMC_D6_B, FN_SIM0_RST_B, FN_CAN0_RX_F,
+		FN_SCIFA5_TXD_B, FN_TX3_C,
+		0, 0,
+		/* IP13_15 [1] */
+		FN_SD0_DATA3, FN_SSL_B,
+		/* IP13_14 [1] */
+		FN_SD0_DATA2, FN_IO3_B,
+		/* IP13_13 [1] */
+		FN_SD0_DATA1, FN_IO2_B,
+		/* IP13_12 [1] */
+		FN_SD0_DATA0, FN_MISO_IO1_B,
+		/* IP13_11 [1] */
+		FN_SD0_CMD, FN_MOSI_IO0_B,
+		/* IP13_10 [1] */
+		FN_SD0_CLK, FN_SPCLK_B,
+		/* IP13_9_7 [3] */
+		FN_STP_OPWM_0, FN_AVB_GTX_CLK, FN_PWM0_B,
+		FN_ADICHS2_B, FN_MSIOF0_TXD_C,
+		0, 0, 0,
+		/* IP13_6_5 [2] */
+		FN_STP_ISSYNC_0, FN_AVB_COL, FN_ADICHS1_B, FN_MSIOF0_RXD_C,
+		/* IP13_4_3 [2] */
+		FN_STP_ISEN_0, FN_AVB_TX_CLK, FN_ADICHS0_B, FN_MSIOF0_SS2_C,
+		/* IP13_2_0 [3] */
+		FN_STP_ISD_0, FN_AVB_TX_ER, FN_SCIFB2_SCK_C,
+		FN_ADICLK_B, FN_MSIOF0_SS1_C,
+		0, 0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR14", 0xE6060058, 32,
+			     3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 2) {
+		/* IP14_31_29 [3] */
+		FN_MSIOF0_SS2, FN_MMC_D7, FN_ADICHS2, FN_RX0_E,
+		FN_VI1_VSYNC_N_C, FN_SDA7_C, FN_VI1_G5_B, 0,
+		/* IP14_28_26 [3] */
+		FN_MSIOF0_SS1, FN_MMC_D6, FN_ADICHS1, FN_TX0_E,
+		FN_VI1_HSYNC_N_C, FN_SCL7_C, FN_VI1_G4_B, 0,
+		/* IP14_25_23 [3] */
+		FN_MSIOF0_RXD, FN_ADICHS0, 0, FN_VI1_DATA0_C, FN_VI1_G3_B,
+		0, 0, 0,
+		/* IP14_22_20 [3] */
+		FN_MSIOF0_TXD, FN_ADICLK, 0, FN_VI1_FIELD_C, FN_VI1_G2_B,
+		0, 0, 0,
+		/* IP14_19_17 [3] */
+		FN_MSIOF0_SYNC, FN_TX2_C, FN_ADICS_SAMP, 0,
+		FN_VI1_CLKENB_C, FN_VI1_G1_B,
+		0, 0,
+		/* IP14_16_14 [3] */
+		FN_MSIOF0_SCK, FN_RX2_C, FN_ADIDATA, 0,
+		FN_VI1_CLK_C, FN_VI1_G0_B,
+		0, 0,
+		/* IP14_13_11 [3] */
+		FN_SD2_WP, FN_MMC_D5, FN_SDA8_C, FN_RX5_B, FN_SCIFA5_RXD_C,
+		0, 0, 0,
+		/* IP14_10_8 [3] */
+		FN_SD2_CD, FN_MMC_D4, FN_SCL8_C, FN_TX5_B, FN_SCIFA5_TXD_C,
+		0, 0, 0,
+		/* IP14_7 [1] */
+		FN_SD2_DATA3, FN_MMC_D3,
+		/* IP14_6 [1] */
+		FN_SD2_DATA2, FN_MMC_D2,
+		/* IP14_5 [1] */
+		FN_SD2_DATA1, FN_MMC_D1,
+		/* IP14_4 [1] */
+		FN_SD2_DATA0, FN_MMC_D0,
+		/* IP14_3 [1] */
+		FN_SD2_CMD, FN_MMC_CMD,
+		/* IP14_2 [1] */
+		FN_SD2_CLK, FN_MMC_CLK,
+		/* IP14_1_0 [2] */
+		FN_SD1_WP, FN_PWM1_B, FN_SDA1_C, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR15", 0xE606005C, 32,
+			     2, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2) {
+		/* IP15_31_30 [2] */
+		0, 0, 0, 0,
+		/* IP15_29_27 [3] */
+		FN_HTX0, FN_SCIFB0_TXD, 0, FN_GLO_SCLK_C,
+		FN_CAN0_TX_B, FN_VI1_DATA5_C,
+		0, 0,
+		/* IP15_26_24 [3] */
+		FN_HRX0, FN_SCIFB0_RXD, 0, FN_GLO_Q1_C,
+		FN_CAN0_RX_B, FN_VI1_DATA4_C,
+		0, 0,
+		/* IP15_23_21 [3] */
+		FN_HSCK0, FN_SCIFB0_SCK, 0, FN_GLO_Q0_C, FN_CAN_CLK,
+		FN_TCLK2, FN_VI1_DATA3_C, 0,
+		/* IP15_20_18 [3] */
+		FN_HRTS0_N, FN_SCIFB0_RTS_N, 0, FN_GLO_I1_C, FN_VI1_DATA2_C,
+		0, 0, 0,
+		/* IP15_17_15 [3] */
+		FN_HCTS0_N, FN_SCIFB0_CTS_N, 0, FN_GLO_I0_C,
+		FN_TCLK1, FN_VI1_DATA1_C,
+		0, 0,
+		/* IP15_14_12 [3] */
+		FN_GPS_MAG, FN_RX4_C, FN_SCIFA4_RXD_C, FN_PWM6,
+		FN_VI1_G7_B, FN_SCIFA3_SCK_C,
+		0, 0,
+		/* IP15_11_9 [3] */
+		FN_GPS_SIGN, FN_TX4_C, FN_SCIFA4_TXD_C, FN_PWM5,
+		FN_VI1_G6_B, FN_SCIFA3_RXD_C,
+		0, 0,
+		/* IP15_8_6 [3] */
+		FN_GPS_CLK, FN_DU1_DOTCLKIN_C, FN_AUDIO_CLKB_B,
+		FN_PWM5_B, FN_SCIFA3_TXD_C,
+		0, 0, 0,
+		/* IP15_5_4 [2] */
+		FN_SIM0_D, FN_IERX, FN_CAN1_RX_D, 0,
+		/* IP15_3_2 [2] */
+		FN_SIM0_CLK, FN_IECLK, FN_CAN_CLK_C, 0,
+		/* IP15_1_0 [2] */
+		FN_SIM0_RST, FN_IETX, FN_CAN1_TX_D, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("IPSR16", 0xE6060160, 32,
+			     4, 4, 4, 4, 4, 2, 2, 2, 3, 3) {
+		/* IP16_31_28 [4] */
+		0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+		/* IP16_27_24 [4] */
+		0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+		/* IP16_23_20 [4] */
+		0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+		/* IP16_19_16 [4] */
+		0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+		/* IP16_15_12 [4] */
+		0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+		/* IP16_11_10 [2] */
+		FN_HRTS1_N, FN_SCIFB1_RTS_N, FN_MLB_DAT, FN_CAN1_RX_B,
+		/* IP16_9_8 [2] */
+		FN_HCTS1_N, FN_SCIFB1_CTS_N, FN_MLB_SIG, FN_CAN1_TX_B,
+		/* IP16_7_6 [2] */
+		FN_HSCK1, FN_SCIFB1_SCK, FN_MLB_CK, FN_GLO_RFON_C,
+		/* IP16_5_3 [3] */
+		FN_HTX1, FN_SCIFB1_TXD, FN_VI1_R1_B,
+		FN_GLO_SS_C, FN_VI1_DATA7_C,
+		0, 0, 0,
+		/* IP16_2_0 [3] */
+		FN_HRX1, FN_SCIFB1_RXD, FN_VI1_R0_B,
+		FN_GLO_SDATA_C, FN_VI1_DATA6_C,
+		0, 0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("MOD_SEL", 0xE6060090, 32,
+			     1, 2, 2, 2, 3, 2, 1, 1, 1, 1,
+			     3, 2, 2, 2, 1, 2, 2, 2) {
+		/* RESERVED [1] */
+		0, 0,
+		/* SEL_SCIF1 [2] */
+		FN_SEL_SCIF1_0, FN_SEL_SCIF1_1, FN_SEL_SCIF1_2, FN_SEL_SCIF1_3,
+		/* SEL_SCIFB [2] */
+		FN_SEL_SCIFB_0, FN_SEL_SCIFB_1, FN_SEL_SCIFB_2, FN_SEL_SCIFB_3,
+		/* SEL_SCIFB2 [2] */
+		FN_SEL_SCIFB2_0, FN_SEL_SCIFB2_1,
+		FN_SEL_SCIFB2_2, FN_SEL_SCIFB2_3,
+		/* SEL_SCIFB1 [3] */
+		FN_SEL_SCIFB1_0, FN_SEL_SCIFB1_1,
+		FN_SEL_SCIFB1_2, FN_SEL_SCIFB1_3,
+		0, 0, 0, 0,
+		/* SEL_SCIFA1 [2] */
+		FN_SEL_SCIFA1_0, FN_SEL_SCIFA1_1, FN_SEL_SCIFA1_2, 0,
+		/* SEL_SSI9 [1] */
+		FN_SEL_SSI9_0, FN_SEL_SSI9_1,
+		/* SEL_SCFA [1] */
+		FN_SEL_SCFA_0, FN_SEL_SCFA_1,
+		/* SEL_QSP [1] */
+		FN_SEL_QSP_0, FN_SEL_QSP_1,
+		/* SEL_SSI7 [1] */
+		FN_SEL_SSI7_0, FN_SEL_SSI7_1,
+		/* SEL_HSCIF1 [3] */
+		FN_SEL_HSCIF1_0, FN_SEL_HSCIF1_1, FN_SEL_HSCIF1_2,
+		FN_SEL_HSCIF1_3, FN_SEL_HSCIF1_4,
+		0, 0, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* SEL_VI1 [2] */
+		FN_SEL_VI1_0, FN_SEL_VI1_1, FN_SEL_VI1_2, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* SEL_TMU [1] */
+		FN_SEL_TMU1_0, FN_SEL_TMU1_1,
+		/* SEL_LBS [2] */
+		FN_SEL_LBS_0, FN_SEL_LBS_1, FN_SEL_LBS_2, FN_SEL_LBS_3,
+		/* SEL_TSIF0 [2] */
+		FN_SEL_TSIF0_0, FN_SEL_TSIF0_1, FN_SEL_TSIF0_2, FN_SEL_TSIF0_3,
+		/* SEL_SOF0 [2] */
+		FN_SEL_SOF0_0, FN_SEL_SOF0_1, FN_SEL_SOF0_2, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
+			     3, 1, 1, 3, 2, 1, 1, 2, 2,
+			     1, 3, 2, 1, 2, 2, 2, 1, 1, 1) {
+		/* SEL_SCIF0 [3] */
+		FN_SEL_SCIF0_0, FN_SEL_SCIF0_1, FN_SEL_SCIF0_2,
+		FN_SEL_SCIF0_3, FN_SEL_SCIF0_4,
+		0, 0, 0,
+		/* RESERVED [1] */
+		0, 0,
+		/* SEL_SCIF [1] */
+		FN_SEL_SCIF_0, FN_SEL_SCIF_1,
+		/* SEL_CAN0 [3] */
+		FN_SEL_CAN0_0, FN_SEL_CAN0_1, FN_SEL_CAN0_2, FN_SEL_CAN0_3,
+		FN_SEL_CAN0_4, FN_SEL_CAN0_5,
+		0, 0,
+		/* SEL_CAN1 [2] */
+		FN_SEL_CAN1_0, FN_SEL_CAN1_1, FN_SEL_CAN1_2, FN_SEL_CAN1_3,
+		/* RESERVED [1] */
+		0, 0,
+		/* SEL_SCIFA2 [1] */
+		FN_SEL_SCIFA2_0, FN_SEL_SCIFA2_1,
+		/* SEL_SCIF4 [2] */
+		FN_SEL_SCIF4_0, FN_SEL_SCIF4_1, FN_SEL_SCIF4_2, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* SEL_ADG [1] */
+		FN_SEL_ADG_0, FN_SEL_ADG_1,
+		/* SEL_FM [3] */
+		FN_SEL_FM_0, FN_SEL_FM_1, FN_SEL_FM_2,
+		FN_SEL_FM_3, FN_SEL_FM_4,
+		0, 0, 0,
+		/* SEL_SCIFA5 [2] */
+		FN_SEL_SCIFA5_0, FN_SEL_SCIFA5_1, FN_SEL_SCIFA5_2, 0,
+		/* RESERVED [1] */
+		0, 0,
+		/* SEL_GPS [2] */
+		FN_SEL_GPS_0, FN_SEL_GPS_1, FN_SEL_GPS_2, FN_SEL_GPS_3,
+		/* SEL_SCIFA4 [2] */
+		FN_SEL_SCIFA4_0, FN_SEL_SCIFA4_1, FN_SEL_SCIFA4_2, 0,
+		/* SEL_SCIFA3 [2] */
+		FN_SEL_SCIFA3_0, FN_SEL_SCIFA3_1, FN_SEL_SCIFA3_2, 0,
+		/* SEL_SIM [1] */
+		FN_SEL_SIM_0, FN_SEL_SIM_1,
+		/* RESERVED [1] */
+		0, 0,
+		/* SEL_SSI8 [1] */
+		FN_SEL_SSI8_0, FN_SEL_SSI8_1, }
+	},
+	{ PINMUX_CFG_REG_VAR("MOD_SEL3", 0xE6060098, 32,
+			     2, 2, 2, 2, 2, 2, 2, 2,
+			     1, 1, 2, 2, 3, 2, 2, 2, 1) {
+		/* SEL_HSCIF2 [2] */
+		FN_SEL_HSCIF2_0, FN_SEL_HSCIF2_1,
+		FN_SEL_HSCIF2_2, FN_SEL_HSCIF2_3,
+		/* SEL_CANCLK [2] */
+		FN_SEL_CANCLK_0, FN_SEL_CANCLK_1,
+		FN_SEL_CANCLK_2, FN_SEL_CANCLK_3,
+		/* SEL_IIC8 [2] */
+		FN_SEL_IIC8_0, FN_SEL_IIC8_1, FN_SEL_IIC8_2, 0,
+		/* SEL_IIC7 [2] */
+		FN_SEL_IIC7_0, FN_SEL_IIC7_1, FN_SEL_IIC7_2, 0,
+		/* SEL_IIC4 [2] */
+		FN_SEL_IIC4_0, FN_SEL_IIC4_1, FN_SEL_IIC4_2, 0,
+		/* SEL_IIC3 [2] */
+		FN_SEL_IIC3_0, FN_SEL_IIC3_1, FN_SEL_IIC3_2, FN_SEL_IIC3_3,
+		/* SEL_SCIF3 [2] */
+		FN_SEL_SCIF3_0, FN_SEL_SCIF3_1, FN_SEL_SCIF3_2, FN_SEL_SCIF3_3,
+		/* SEL_IEB [2] */
+		FN_SEL_IEB_0, FN_SEL_IEB_1, FN_SEL_IEB_2, 0,
+		/* SEL_MMC [1] */
+		FN_SEL_MMC_0, FN_SEL_MMC_1,
+		/* SEL_SCIF5 [1] */
+		FN_SEL_SCIF5_0, FN_SEL_SCIF5_1,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* SEL_IIC2 [2] */
+		FN_SEL_IIC2_0, FN_SEL_IIC2_1, FN_SEL_IIC2_2, FN_SEL_IIC2_3,
+		/* SEL_IIC1 [3] */
+		FN_SEL_IIC1_0, FN_SEL_IIC1_1, FN_SEL_IIC1_2, FN_SEL_IIC1_3,
+		FN_SEL_IIC1_4,
+		0, 0, 0,
+		/* SEL_IIC0 [2] */
+		FN_SEL_IIC0_0, FN_SEL_IIC0_1, FN_SEL_IIC0_2, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* RESERVED [1] */
+		0, 0, }
+	},
+	{ PINMUX_CFG_REG_VAR("MOD_SEL4", 0xE606009C, 32,
+			     3, 2, 2, 1, 1, 1, 1, 3, 2,
+			     2, 3, 1, 1, 1, 2, 2, 2, 2) {
+		/* SEL_SOF1 [3] */
+		FN_SEL_SOF1_0, FN_SEL_SOF1_1, FN_SEL_SOF1_2, FN_SEL_SOF1_3,
+		FN_SEL_SOF1_4,
+		0, 0, 0,
+		/* SEL_HSCIF0 [2] */
+		FN_SEL_HSCIF0_0, FN_SEL_HSCIF0_1, FN_SEL_HSCIF0_2, 0,
+		/* SEL_DIS [2] */
+		FN_SEL_DIS_0, FN_SEL_DIS_1, FN_SEL_DIS_2, 0,
+		/* RESERVED [1] */
+		0, 0,
+		/* SEL_RAD [1] */
+		FN_SEL_RAD_0, FN_SEL_RAD_1,
+		/* SEL_RCN [1] */
+		FN_SEL_RCN_0, FN_SEL_RCN_1,
+		/* SEL_RSP [1] */
+		FN_SEL_RSP_0, FN_SEL_RSP_1,
+		/* SEL_SCIF2 [3] */
+		FN_SEL_SCIF2_0, FN_SEL_SCIF2_1, FN_SEL_SCIF2_2,
+		FN_SEL_SCIF2_3, FN_SEL_SCIF2_4,
+		0, 0, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* SEL_SOF2 [3] */
+		FN_SEL_SOF2_0, FN_SEL_SOF2_1, FN_SEL_SOF2_2,
+		FN_SEL_SOF2_3, FN_SEL_SOF2_4,
+		0, 0, 0,
+		/* RESERVED [1] */
+		0, 0,
+		/* SEL_SSI1 [1] */
+		FN_SEL_SSI1_0, FN_SEL_SSI1_1,
+		/* SEL_SSI0 [1] */
+		FN_SEL_SSI0_0, FN_SEL_SSI0_1,
+		/* SEL_SSP [2] */
+		FN_SEL_SSP_0, FN_SEL_SSP_1, FN_SEL_SSP_2, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0,
+		/* RESERVED [2] */
+		0, 0, 0, 0, }
+	},
+	{ },
+};
-- 
2.3.5

