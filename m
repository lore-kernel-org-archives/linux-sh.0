From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 15:50:10 +0000
Subject: [PATCH 1/2] pinctrl: sh-pfc: pfc-r8a7790: Add full VIN1/2/3 support
Message-Id: <1386690611-2014-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds missing VIN1/2/3 pin configuration to pfc-r8a7790.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 202 ++++++++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 72786fc..d6c446f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3076,22 +3076,168 @@ static const unsigned int vin0_clk_mux[] = {
 	VI0_CLK_MARK,
 };
 /* - VIN1 ------------------------------------------------------------------- */
-static const unsigned int vin1_data_pins[] = {
+static const unsigned int vin1_data_g_pins[] = {
+	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 17),
+	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 12),
+	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 7),
+};
+static const unsigned int vin1_data_g_mux[] = {
+	VI1_G0_MARK, VI1_G1_MARK, VI1_G2_MARK,
+	VI1_G3_MARK, VI1_G4_MARK, VI1_G5_MARK,
+	VI1_G6_MARK, VI1_G7_MARK,
+};
+static const unsigned int vin1_data_r_pins[] = {
+	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28), RCAR_GP_PIN(0, 29),
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 8),
+};
+static const unsigned int vin1_data_r_mux[] = {
+	VI1_R0_MARK, VI1_R1_MARK, VI1_R2_MARK,
+	VI1_R3_MARK, VI1_R4_MARK, VI1_R5_MARK,
+	VI1_R6_MARK, VI1_R7_MARK,
+};
+static const unsigned int vin1_data_b_pins[] = {
 	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 12),
 	RCAR_GP_PIN(2, 13), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 15),
 	RCAR_GP_PIN(2, 16), RCAR_GP_PIN(2, 17),
 };
-static const unsigned int vin1_data_mux[] = {
+static const unsigned int vin1_data_b_mux[] = {
 	VI1_DATA0_VI1_B0_MARK, VI1_DATA1_VI1_B1_MARK, VI1_DATA2_VI1_B2_MARK,
 	VI1_DATA3_VI1_B3_MARK, VI1_DATA4_VI1_B4_MARK, VI1_DATA5_VI1_B5_MARK,
 	VI1_DATA6_VI1_B6_MARK, VI1_DATA7_VI1_B7_MARK,
 };
+static const unsigned int vin1_hsync_signal_pins[] = {
+	RCAR_GP_PIN(1, 24),
+};
+static const unsigned int vin1_hsync_signal_mux[] = {
+	VI1_HSYNC_N_MARK,
+};
+static const unsigned int vin1_vsync_signal_pins[] = {
+	RCAR_GP_PIN(1, 25),
+};
+static const unsigned int vin1_vsync_signal_mux[] = {
+	VI1_VSYNC_N_MARK,
+};
+static const unsigned int vin1_field_signal_pins[] = {
+	RCAR_GP_PIN(1, 13),
+};
+static const unsigned int vin1_field_signal_mux[] = {
+	VI1_FIELD_MARK,
+};
+static const unsigned int vin1_data_enable_pins[] = {
+	RCAR_GP_PIN(1, 26),
+};
+static const unsigned int vin1_data_enable_mux[] = {
+	VI1_CLKENB_MARK,
+};
 static const unsigned int vin1_clk_pins[] = {
 	RCAR_GP_PIN(2, 9),
 };
 static const unsigned int vin1_clk_mux[] = {
 	VI1_CLK_MARK,
 };
+/* - VIN2 ----------------------------------------------------------------- */
+static const unsigned int vin2_data_g_pins[] = {
+	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28), RCAR_GP_PIN(0, 29),
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+};
+static const unsigned int vin2_data_g_mux[] = {
+	VI2_G0_MARK, VI2_G1_MARK, VI2_G2_MARK,
+	VI2_G3_MARK, VI2_G4_MARK, VI2_G5_MARK,
+	VI2_G6_MARK, VI2_G7_MARK,
+};
+static const unsigned int vin2_data_r_pins[] = {
+	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13), RCAR_GP_PIN(1, 14),
+	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 20),
+	RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 24),
+};
+static const unsigned int vin2_data_r_mux[] = {
+	VI2_R0_MARK, VI2_R1_MARK, VI2_R2_MARK,
+	VI2_R3_MARK, VI2_R4_MARK, VI2_R5_MARK,
+	VI2_R6_MARK, VI2_R7_MARK,
+};
+static const unsigned int vin2_data_b_pins[] = {
+	RCAR_GP_PIN(0, 8), RCAR_GP_PIN(0, 9), RCAR_GP_PIN(0, 10),
+	RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+	RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 15),
+};
+static const unsigned int vin2_data_b_mux[] = {
+	VI2_DATA0_VI2_B0_MARK, VI2_DATA1_VI2_B1_MARK, VI2_DATA2_VI2_B2_MARK,
+	VI2_DATA3_VI2_B3_MARK, VI2_DATA4_VI2_B4_MARK, VI2_DATA5_VI2_B5_MARK,
+	VI2_DATA6_VI2_B6_MARK, VI2_DATA7_VI2_B7_MARK,
+};
+static const unsigned int vin2_hsync_signal_pins[] = {
+	RCAR_GP_PIN(1, 16),
+};
+static const unsigned int vin2_hsync_signal_mux[] = {
+	VI2_HSYNC_N_MARK,
+};
+static const unsigned int vin2_vsync_signal_pins[] = {
+	RCAR_GP_PIN(1, 21),
+};
+static const unsigned int vin2_vsync_signal_mux[] = {
+	VI2_VSYNC_N_MARK,
+};
+static const unsigned int vin2_field_signal_pins[] = {
+	RCAR_GP_PIN(1, 9),
+};
+static const unsigned int vin2_field_signal_mux[] = {
+	VI2_FIELD_MARK,
+};
+static const unsigned int vin2_data_enable_pins[] = {
+	RCAR_GP_PIN(1, 8),
+};
+static const unsigned int vin2_data_enable_mux[] = {
+	VI2_CLKENB_MARK,
+};
+static const unsigned int vin2_clk_pins[] = {
+	RCAR_GP_PIN(1, 11),
+};
+static const unsigned int vin2_clk_mux[] = {
+	VI2_CLK_MARK,
+};
+/* - VIN3 ----------------------------------------------------------------- */
+static const unsigned int vin3_data_pins[] = {
+	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1), RCAR_GP_PIN(0, 2),
+	RCAR_GP_PIN(0, 3), RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+};
+static const unsigned int vin3_data_mux[] = {
+	VI3_DATA0_MARK, VI3_DATA1_MARK, VI3_DATA2_MARK,
+	VI3_DATA3_MARK, VI3_DATA4_MARK, VI3_DATA5_MARK,
+	VI3_DATA6_MARK, VI3_DATA7_MARK,
+};
+static const unsigned int vin3_hsync_signal_pins[] = {
+	RCAR_GP_PIN(1, 16),
+};
+static const unsigned int vin3_hsync_signal_mux[] = {
+	VI3_HSYNC_N_MARK,
+};
+static const unsigned int vin3_vsync_signal_pins[] = {
+	RCAR_GP_PIN(1, 17),
+};
+static const unsigned int vin3_vsync_signal_mux[] = {
+	VI2_VSYNC_N_MARK,
+};
+static const unsigned int vin3_field_signal_pins[] = {
+	RCAR_GP_PIN(1, 15),
+};
+static const unsigned int vin3_field_signal_mux[] = {
+	VI3_FIELD_MARK,
+};
+static const unsigned int vin3_data_enable_pins[] = {
+	RCAR_GP_PIN(1, 14),
+};
+static const unsigned int vin3_data_enable_mux[] = {
+	VI3_CLKENB_MARK,
+};
+static const unsigned int vin3_clk_pins[] = {
+	RCAR_GP_PIN(1, 23),
+};
+static const unsigned int vin3_clk_mux[] = {
+	VI3_CLK_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_rgb666),
@@ -3274,8 +3420,28 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin0_field_signal),
 	SH_PFC_PIN_GROUP(vin0_data_enable),
 	SH_PFC_PIN_GROUP(vin0_clk),
-	SH_PFC_PIN_GROUP(vin1_data),
+	SH_PFC_PIN_GROUP(vin1_data_g),
+	SH_PFC_PIN_GROUP(vin1_data_r),
+	SH_PFC_PIN_GROUP(vin1_data_b),
+	SH_PFC_PIN_GROUP(vin1_hsync_signal),
+	SH_PFC_PIN_GROUP(vin1_vsync_signal),
+	SH_PFC_PIN_GROUP(vin1_field_signal),
+	SH_PFC_PIN_GROUP(vin1_data_enable),
 	SH_PFC_PIN_GROUP(vin1_clk),
+	SH_PFC_PIN_GROUP(vin2_data_g),
+	SH_PFC_PIN_GROUP(vin2_data_r),
+	SH_PFC_PIN_GROUP(vin2_data_b),
+	SH_PFC_PIN_GROUP(vin2_hsync_signal),
+	SH_PFC_PIN_GROUP(vin2_vsync_signal),
+	SH_PFC_PIN_GROUP(vin2_field_signal),
+	SH_PFC_PIN_GROUP(vin2_data_enable),
+	SH_PFC_PIN_GROUP(vin2_clk),
+	SH_PFC_PIN_GROUP(vin3_data),
+	SH_PFC_PIN_GROUP(vin3_hsync_signal),
+	SH_PFC_PIN_GROUP(vin3_vsync_signal),
+	SH_PFC_PIN_GROUP(vin3_field_signal),
+	SH_PFC_PIN_GROUP(vin3_data_enable),
+	SH_PFC_PIN_GROUP(vin3_clk),
 };
 
 static const char * const du_groups[] = {
@@ -3564,10 +3730,36 @@ static const char * const vin0_groups[] = {
 };
 
 static const char * const vin1_groups[] = {
-	"vin1_data",
+	"vin1_data_g",
+	"vin1_data_r",
+	"vin1_data_b",
+	"vin1_hsync_signal",
+	"vin1_vsync_signal",
+	"vin1_field_signal",
+	"vin1_data_enable",
 	"vin1_clk",
 };
 
+static const char * const vin2_groups[] = {
+	"vin2_data_g",
+	"vin2_data_r",
+	"vin2_data_b",
+	"vin2_hsync_signal",
+	"vin2_vsync_signal",
+	"vin2_field_signal",
+	"vin2_data_enable",
+	"vin2_clk",
+};
+
+static const char * const vin3_groups[] = {
+	"vin3_data",
+	"vin3_hsync_signal",
+	"vin3_vsync_signal",
+	"vin3_field_signal",
+	"vin3_data_enable",
+	"vin3_clk",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(du),
 	SH_PFC_FUNCTION(du0),
@@ -3605,6 +3797,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(usb2),
 	SH_PFC_FUNCTION(vin0),
 	SH_PFC_FUNCTION(vin1),
+	SH_PFC_FUNCTION(vin2),
+	SH_PFC_FUNCTION(vin3),
 };
 
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
1.8.3.1

