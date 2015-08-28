From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Aug 2015 09:33:26 +0000
Subject: [PATCH 2/2][RFC] pinctrl: sh-pfc: r8a7795: add SCIFx support
Message-Id: <87a8tbdamb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds SCIF0/1/2/3/4/5

This patch is including Geert's SCIF support patch

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 446 +++++++++++++++++++++++++++++++----
 1 file changed, 405 insertions(+), 41 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 23f2c4e..64f68ba 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -141,6 +141,24 @@ enum {
 	FN_SEL_VSP_0,		FN_SEL_VSP_1,		FN_SEL_VSP_2,		FN_SEL_VSP_3,
 	FN_SEL_VIN4_0,		FN_SEL_VIN4_1,
 
+	/* SCIF0 */
+	FN_RX0,		FN_TX0,		FN_SCK0,	FN_RTS0_N_TANS,		FN_CTS0_N,
+	/* SCIF1 */
+	FN_RX1_A,	FN_TX1_A,	FN_SCK1,	FN_RTS1_N_TANS,		FN_CTS1_N,
+	FN_RX1_B,	FN_TX1_B,
+	/* SCIF2 */
+	FN_RX2_A,	FN_TX2_A,	FN_SCK2,
+	FN_RX2_B,	FN_TX2_B,
+	/* SCIF3 */
+	FN_RX3_A,	FN_TX3_A,	FN_SCK3,	FN_RTS3_N_TANS,		FN_CTS3_N,
+	FN_RX3_B,	FN_TX3_B,
+	/* SCIF4 */
+	FN_RX4_A,	FN_TX4_A,	FN_SCK4_A,	FN_RTS4_N_TANS_A,	FN_CTS4_N_A,
+	FN_RX4_B,	FN_TX4_B,	FN_SCK4_B,	FN_RTS4_N_TANS_B,	FN_CTS4_N_B,
+	FN_RX4_C,	FN_TX4_C,	FN_SCK4_C,	FN_RTS4_N_TANS_C,	FN_CTS4_N_C,
+	/* SCIF5 */
+	FN_RX5,		FN_TX5,		FN_SCK5,
+
 	PINMUX_FUNCTION_END,
 
 	PINMUX_MARK_BEGIN,
@@ -252,6 +270,24 @@ enum {
 	SEL_VSP_0_MARK,		SEL_VSP_1_MARK,		SEL_VSP_2_MARK,		SEL_VSP_3_MARK,
 	SEL_VIN4_0_MARK,	SEL_VIN4_1_MARK,
 
+	/* SCIF0 */
+	RX0_MARK,	TX0_MARK,	SCK0_MARK,	RTS0_N_TANS_MARK,	CTS0_N_MARK,
+	/* SCIF1 */
+	RX1_A_MARK,	TX1_A_MARK,	SCK1_MARK,	RTS1_N_TANS_MARK,	CTS1_N_MARK,
+	RX1_B_MARK,	TX1_B_MARK,
+	/* SCIF2 */
+	RX2_A_MARK,	TX2_A_MARK,	SCK2_MARK,
+	RX2_B_MARK,	TX2_B_MARK,
+	/* SCIF3 */
+	RX3_A_MARK,	TX3_A_MARK,	SCK3_MARK,	RTS3_N_TANS_MARK,	CTS3_N_MARK,
+	RX3_B_MARK,	TX3_B_MARK,
+	/* SCIF4 */
+	RX4_A_MARK,	TX4_A_MARK,	SCK4_A_MARK,	RTS4_N_TANS_A_MARK,	CTS4_N_A_MARK,
+	RX4_B_MARK,	TX4_B_MARK,	SCK4_B_MARK,	RTS4_N_TANS_B_MARK,	CTS4_N_B_MARK,
+	RX4_C_MARK,	TX4_C_MARK,	SCK4_C_MARK,	RTS4_N_TANS_C_MARK,	CTS4_N_C_MARK,
+	/* SCIF5 */
+	RX5_MARK,	TX5_MARK,	SCK5_MARK,
+
 	PINMUX_MARK_END,
 };
 
@@ -259,36 +295,107 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(),
 
 	/* IPSR0 */
+	PINMUX_IPSR_MODS(IP0_7_4,	SCK4_A,		SEL_SCIF4_0),
+
+	PINMUX_IPSR_MODS(IP0_11_8,	RX4_A,		SEL_SCIF4_0),
+
+	PINMUX_IPSR_MODS(IP0_15_12,	TX4_A,		SEL_SCIF4_0),
+
+	PINMUX_IPSR_MODS(IP0_19_16,	CTS4_N_A,	SEL_SCIF4_0),
+
+	PINMUX_IPSR_MODS(IP0_23_20,	RTS4_N_TANS_A,	SEL_SCIF4_0),
 
 	/* IPSR1 */
 
 	/* IPSR2 */
+	PINMUX_IPSR_MODS(IP2_19_16,	SCK4_B,		SEL_SCIF4_1),
+
+	PINMUX_IPSR_MODS(IP2_23_20,	RX4_B,		SEL_SCIF4_1),
+
+	PINMUX_IPSR_MODS(IP2_27_24,	TX4_B,		SEL_SCIF4_1),
+
+	PINMUX_IPSR_MODS(IP2_31_28,	RX3_B,		SEL_SCIF3_1),
 
 	/* IPSR3 */
+	PINMUX_IPSR_MODS(IP3_3_0,	CTS4_N_B,	SEL_SCIF4_1),
+
+	PINMUX_IPSR_MODS(IP3_7_4,	RTS4_N_TANS_B,	SEL_SCIF4_1),
+
+	PINMUX_IPSR_MODS(IP3_11_8,	TX3_B,		SEL_SCIF3_1),
 
 	/* IPSR4 */
+	PINMUX_IPSR_DATA(IP4_23_20,	SCK3),
+
+	PINMUX_IPSR_MODS(IP4_27_24,	RX3_A,		SEL_SCIF3_0),
+
+	PINMUX_IPSR_MODS(IP4_31_28,	TX3_A,		SEL_SCIF3_0),
 
 	/* IPSR5 */
+	PINMUX_IPSR_DATA(IP5_3_0,	CTS3_N),
+
+	PINMUX_IPSR_DATA(IP5_7_4,	RTS3_N_TANS),
 
 	/* IPSR6 */
+	PINMUX_IPSR_MODS(IP6_15_12,	SCK4_C,		SEL_SCIF4_2),
+
+	PINMUX_IPSR_MODS(IP6_23_20,	CTS4_N_C,	SEL_SCIF4_2),
+
+	PINMUX_IPSR_MODS(IP6_27_24,	RTS4_N_TANS_C,	SEL_SCIF4_2),
+
+	PINMUX_IPSR_MODS(IP6_31_28,	RX4_C,		SEL_SCIF4_2),
 
 	/* IPSR7 */
+	PINMUX_IPSR_MODS(IP7_3_0,	TX4_C,		SEL_SCIF4_2),
 
 	/* IPSR8 */
 
 	/* IPSR9 */
 
 	/* IPSR10 */
+	PINMUX_IPSR_DATA(IP10_27_24,	SCK0),
+
+	PINMUX_IPSR_DATA(IP10_31_28,	RX0),
 
 	/* IPSR11 */
+	PINMUX_IPSR_DATA(IP11_3_0,	TX0),
+
+	PINMUX_IPSR_DATA(IP11_7_4,	CTS0_N),
+
+	PINMUX_IPSR_DATA(IP11_11_8,	RTS0_N_TANS),
+
+	PINMUX_IPSR_MODS(IP11_15_12,	RX1_A,		SEL_SCIF1_0),
+
+	PINMUX_IPSR_MODS(IP11_19_16,	TX1_A,		SEL_SCIF1_0),
+
+	PINMUX_IPSR_DATA(IP11_23_20,	CTS1_N),
+
+	PINMUX_IPSR_DATA(IP11_27_24,	RTS1_N_TANS),
+
+	PINMUX_IPSR_DATA(IP11_31_28,	SCK2),
 
 	/* IPSR12 */
+	PINMUX_IPSR_MODS(IP12_3_0,	TX2_A,		SEL_SCIF2_0),
+
+	PINMUX_IPSR_MODS(IP12_7_4,	RX2_A,		SEL_SCIF2_0),
+
+	PINMUX_IPSR_MODS(IP12_23_20,	RX2_B,		SEL_SCIF2_1),
+
+	PINMUX_IPSR_MODS(IP12_27_24,	TX2_B,		SEL_SCIF2_1),
 
 	/* IPSR13 */
+	PINMUX_IPSR_DATA(IP13_3_0,	RX5),
+
+	PINMUX_IPSR_DATA(IP13_7_4,	TX5),
+
+	PINMUX_IPSR_MODS(IP13_15_12,	RX1_B,		SEL_SCIF1_1),
+
+	PINMUX_IPSR_MODS(IP13_19_16,	TX1_B,		SEL_SCIF1_1),
 
 	/* IPSR14 */
 
 	/* IPSR15 */
+	PINMUX_IPSR_DATA(IP15_31_28,	SCK1),
+	PINMUX_IPSR_DATA(IP15_31_28,	SCK5),
 
 	/* IPSR16 */
 
@@ -299,10 +406,267 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
+/* - SCIF0 ------------------------------------------------------------------ */
+static const unsigned int scif0_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
+};
+static const unsigned int scif0_data_mux[] = {
+	RX0_MARK, TX0_MARK,
+};
+static const unsigned int scif0_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 0),
+};
+static const unsigned int scif0_clk_mux[] = {
+	SCK0_MARK,
+};
+static const unsigned int scif0_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 3),
+};
+static const unsigned int scif0_ctrl_mux[] = {
+	RTS0_N_TANS_MARK, CTS0_N_MARK,
+};
+/* - SCIF1 ------------------------------------------------------------------ */
+static const unsigned int scif1_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
+};
+static const unsigned int scif1_data_a_mux[] = {
+	RX1_A_MARK, TX1_A_MARK,
+};
+static const unsigned int scif1_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(6, 21),
+};
+static const unsigned int scif1_clk_mux[] = {
+	SCK1_MARK,
+};
+static const unsigned int scif1_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 7),
+};
+static const unsigned int scif1_ctrl_mux[] = {
+	RTS1_N_TANS_MARK, CTS1_N_MARK,
+};
+
+static const unsigned int scif1_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 24), RCAR_GP_PIN(5, 25),
+};
+static const unsigned int scif1_data_b_mux[] = {
+	RX1_B_MARK, TX1_B_MARK,
+};
+/* - SCIF2 ------------------------------------------------------------------ */
+static const unsigned int scif2_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 10),
+};
+static const unsigned int scif2_data_a_mux[] = {
+	RX2_A_MARK, TX2_A_MARK,
+};
+static const unsigned int scif2_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 9),
+};
+static const unsigned int scif2_clk_mux[] = {
+	SCK2_MARK,
+};
+static const unsigned int scif2_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 16),
+};
+static const unsigned int scif2_data_b_mux[] = {
+	RX2_B_MARK, TX2_B_MARK,
+};
+/* - SCIF3 ------------------------------------------------------------------ */
+static const unsigned int scif3_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 23), RCAR_GP_PIN(1, 24),
+};
+static const unsigned int scif3_data_a_mux[] = {
+	RX3_A_MARK, TX3_A_MARK,
+};
+static const unsigned int scif3_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 22),
+};
+static const unsigned int scif3_clk_mux[] = {
+	SCK3_MARK,
+};
+static const unsigned int scif3_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(1, 26), RCAR_GP_PIN(1, 25),
+};
+static const unsigned int scif3_ctrl_mux[] = {
+	RTS3_N_TANS_MARK, CTS3_N_MARK,
+};
+static const unsigned int scif3_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 11),
+};
+static const unsigned int scif3_data_b_mux[] = {
+	RX3_B_MARK, TX3_B_MARK,
+};
+/* - SCIF4 ------------------------------------------------------------------ */
+static const unsigned int scif4_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 12),
+};
+static const unsigned int scif4_data_a_mux[] = {
+	RX4_A_MARK, TX4_A_MARK,
+};
+static const unsigned int scif4_clk_a_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 10),
+};
+static const unsigned int scif4_clk_a_mux[] = {
+	SCK4_A_MARK,
+};
+static const unsigned int scif4_ctrl_a_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
+};
+static const unsigned int scif4_ctrl_a_mux[] = {
+	RTS4_N_TANS_A_MARK, CTS4_N_A_MARK,
+};
+static const unsigned int scif4_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+};
+static const unsigned int scif4_data_b_mux[] = {
+	RX4_B_MARK, TX4_B_MARK,
+};
+static const unsigned int scif4_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 5),
+};
+static const unsigned int scif4_clk_b_mux[] = {
+	SCK4_B_MARK,
+};
+static const unsigned int scif4_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 9),
+};
+static const unsigned int scif4_ctrl_b_mux[] = {
+	RTS4_N_TANS_B_MARK, CTS4_N_B_MARK,
+};
+static const unsigned int scif4_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+};
+static const unsigned int scif4_data_c_mux[] = {
+	RX4_C_MARK, TX4_C_MARK,
+};
+static const unsigned int scif4_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(0, 8),
+};
+static const unsigned int scif4_clk_c_mux[] = {
+	SCK4_C_MARK,
+};
+static const unsigned int scif4_ctrl_c_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 10),
+};
+static const unsigned int scif4_ctrl_c_mux[] = {
+	RTS4_N_TANS_C_MARK, CTS4_N_C_MARK,
+};
+/* - SCIF5 ------------------------------------------------------------------ */
+static const unsigned int scif5_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 21),
+};
+static const unsigned int scif5_data_mux[] = {
+	RX5_MARK, TX5_MARK,
+};
+static const unsigned int scif5_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(6, 21),
+};
+static const unsigned int scif5_clk_mux[] = {
+	SCK5_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(scif0_data),
+	SH_PFC_PIN_GROUP(scif0_clk),
+	SH_PFC_PIN_GROUP(scif0_ctrl),
+	SH_PFC_PIN_GROUP(scif1_data_a),
+	SH_PFC_PIN_GROUP(scif1_clk),
+	SH_PFC_PIN_GROUP(scif1_ctrl),
+	SH_PFC_PIN_GROUP(scif1_data_b),
+	SH_PFC_PIN_GROUP(scif2_data_a),
+	SH_PFC_PIN_GROUP(scif2_clk),
+	SH_PFC_PIN_GROUP(scif2_data_b),
+	SH_PFC_PIN_GROUP(scif3_data_a),
+	SH_PFC_PIN_GROUP(scif3_clk),
+	SH_PFC_PIN_GROUP(scif3_ctrl),
+	SH_PFC_PIN_GROUP(scif3_data_b),
+	SH_PFC_PIN_GROUP(scif4_data_a),
+	SH_PFC_PIN_GROUP(scif4_clk_a),
+	SH_PFC_PIN_GROUP(scif4_ctrl_a),
+	SH_PFC_PIN_GROUP(scif4_data_b),
+	SH_PFC_PIN_GROUP(scif4_clk_b),
+	SH_PFC_PIN_GROUP(scif4_ctrl_b),
+	SH_PFC_PIN_GROUP(scif4_data_c),
+	SH_PFC_PIN_GROUP(scif4_clk_c),
+	SH_PFC_PIN_GROUP(scif4_ctrl_c),
+	SH_PFC_PIN_GROUP(scif5_data),
+	SH_PFC_PIN_GROUP(scif5_clk),
+};
+
+static const char * const scif0_groups[] = {
+	"scif0_data",
+	"scif0_clk",
+	"scif0_ctrl",
+};
+
+static const char * const scif1_groups[] = {
+	"scif1_data_a",
+	"scif1_clk",
+	"scif1_ctrl",
+	"scif1_data_b",
+};
+
+static const char * const scif2_groups[] = {
+	"scif2_data_a",
+	"scif2_clk",
+	"scif2_data_b",
+};
+
+static const char * const scif3_groups[] = {
+	"scif3_data_a",
+	"scif3_clk",
+	"scif3_ctrl",
+	"scif3_data_b",
+};
+
+static const char * const scif4_groups[] = {
+	"scif4_data_a",
+	"scif4_clk_a",
+	"scif4_ctrl_a",
+	"scif4_data_b",
+	"scif4_clk_b",
+	"scif4_ctrl_b",
+	"scif4_data_c",
+	"scif4_clk_c",
+	"scif4_ctrl_c",
+};
+
+static const char * const scif5_groups[] = {
+	"scif5_data",
+	"scif5_clk",
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(scif0),
+	SH_PFC_FUNCTION(scif1),
+	SH_PFC_FUNCTION(scif2),
+	SH_PFC_FUNCTION(scif3),
+	SH_PFC_FUNCTION(scif4),
+	SH_PFC_FUNCTION(scif5),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
@@ -590,27 +954,27 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP0_23_20 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_RTS4_N_TANS_A,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP0_19_16 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_CTS4_N_A,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP0_15_12 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_TX4_A,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP0_11_8 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_RX4_A,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP0_7_4 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_SCK4_A,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -664,22 +1028,22 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
 		/* IP2_31_28 [4] */
-		0, 0, 0, 0,
+		0, FN_RX3_B, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP2_27_24 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_TX4_B,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP2_23_20 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_RX4_B,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP2_19_16 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_SCK4_B,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -731,34 +1095,34 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP3_11_8 [4] */
-		0, 0, 0, 0,
+		0, FN_TX3_B, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP3_7_4 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_RTS4_N_TANS_B,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP3_3_0 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_CTS4_N_B,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0, }
 	},
 	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
 		/* IP4_31_28 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_TX3_A,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP4_27_24 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_RX3_A,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP4_23_20 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_SCK3,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -820,30 +1184,30 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP5_7_4 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_RTS3_N_TANS,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP5_3_0 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_CTS3_N,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0, }
 	},
 	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
 		/* IP6_31_28 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_RX4_C,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP6_27_24 [4] */
 		0, 0, 0, 0,
-		0, 0, 0, 0,
+		0, FN_RTS4_N_TANS_C, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP6_23_20 [4] */
 		0, 0, 0, 0,
-		0, 0, 0, 0,
+		0, FN_CTS4_N_C, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP6_19_16 [4] */
@@ -852,7 +1216,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP6_15_12 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_SCK4_C,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -909,7 +1273,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP7_3_0 [4] */
-		0, 0, 0, 0,
+		0, 0, 0, FN_TX4_C,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0, }
@@ -1000,12 +1364,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4) {
 		/* IP10_31_28 [4] */
-		0, 0, 0, 0,
+		FN_RX0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP10_27_24 [4] */
-		0, 0, 0, 0,
+		FN_SCK0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1042,42 +1406,42 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4) {
 		/* IP11_31_28 [4] */
-		0, 0, 0, 0,
+		FN_SCK2, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP11_27_24 [4] */
-		0, 0, 0, 0,
+		FN_RTS1_N_TANS, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP11_23_20 [4] */
-		0, 0, 0, 0,
+		FN_CTS1_N, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP11_19_16 [4] */
-		0, 0, 0, 0,
+		FN_TX1_A, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP11_15_12 [4] */
-		0, 0, 0, 0,
+		FN_RX1_A, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP11_11_8 [4] */
-		0, 0, 0, 0,
+		FN_RTS0_N_TANS, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP11_7_4 [4] */
-		0, 0, 0, 0,
+		FN_CTS0_N, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP11_3_0 [4] */
-		0, 0, 0, 0,
+		FN_TX0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0, }
@@ -1089,12 +1453,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP12_27_24 [4] */
-		0, 0, 0, 0,
+		0, FN_TX2_B, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP12_23_20 [4] */
-		0, 0, 0, 0,
+		0, FN_RX2_B, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1114,12 +1478,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP12_7_4 [4] */
-		0, 0, 0, 0,
+		FN_RX2_A, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP12_3_0 [4] */
-		0, 0, 0, 0,
+		FN_TX2_A, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0, }
@@ -1141,12 +1505,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP13_19_16 [4] */
-		0, 0, 0, 0,
+		0, FN_TX1_B, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP13_15_12 [4] */
-		0, 0, 0, 0,
+		0, FN_RX1_B, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1156,12 +1520,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP13_7_4 [4] */
-		0, 0, 0, 0,
+		0, FN_TX5, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP13_3_0 [4] */
-		0, 0, 0, 0,
+		0, FN_RX5, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0, }
@@ -1211,7 +1575,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4) {
 		/* IP15_31_28 [4] */
 		0, 0, 0, 0,
-		0, 0, 0, 0,
+		0, FN_SCK1, 0, FN_SCK5,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		/* IP15_27_24 [4] */
-- 
1.9.1

