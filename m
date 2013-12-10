From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 18:20:26 +0000
Subject: [PATCH 5/5] pinctrl: sh-pfc: pfc-r8a7790: Add VIN2 and VIN3 pins
Message-Id: <1386699626-15803-6-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There are VIN2 and VIN3 channels available on the R8A7790 SoC.
VIN2 supports 4/8/16/18/24-bit data, while VIN3 supports 8-bit.
Add both here, covering all possible data pin configurations.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 168 +++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 64ce10d..74abab6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3219,6 +3219,138 @@ static const unsigned int vin1_clk_pins[] = {
 static const unsigned int vin1_clk_mux[] = {
 	VI1_CLK_MARK,
 };
+/* - VIN2 ----------------------------------------------------------------- */
+static const union vin_data vin2_data_pins = {
+	.data24 = {
+		/* B */
+		RCAR_GP_PIN(0, 8), RCAR_GP_PIN(0, 9),
+		RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
+		RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+		RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 15),
+		/* G */
+		RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28),
+		RCAR_GP_PIN(0, 29), RCAR_GP_PIN(1, 10),
+		RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+		RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+		/* R */
+		RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
+		RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
+		RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 20),
+		RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 24),
+	},
+};
+static const union vin_data vin2_data_mux = {
+	.data24 = {
+		/* B */
+		VI2_DATA0_VI2_B0_MARK, VI2_DATA1_VI2_B1_MARK,
+		VI2_DATA2_VI2_B2_MARK, VI2_DATA3_VI2_B3_MARK,
+		VI2_DATA4_VI2_B4_MARK, VI2_DATA5_VI2_B5_MARK,
+		VI2_DATA6_VI2_B6_MARK, VI2_DATA7_VI2_B7_MARK,
+		/* G */
+		VI2_G0_MARK, VI2_G1_MARK,
+		VI2_G2_MARK, VI2_G3_MARK,
+		VI2_G4_MARK, VI2_G5_MARK,
+		VI2_G6_MARK, VI2_G7_MARK,
+		/* R */
+		VI2_R0_MARK, VI2_R1_MARK,
+		VI2_R2_MARK, VI2_R3_MARK,
+		VI2_R4_MARK, VI2_R5_MARK,
+		VI2_R6_MARK, VI2_R7_MARK,
+	},
+};
+static const unsigned int vin2_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+	RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 15),
+	/* G */
+	RCAR_GP_PIN(0, 29), RCAR_GP_PIN(1, 10),
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+	/* R */
+	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 20),
+	RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 24),
+};
+static const unsigned int vin2_data18_mux[] = {
+	/* B */
+	VI2_DATA2_VI2_B2_MARK, VI2_DATA3_VI2_B3_MARK,
+	VI2_DATA4_VI2_B4_MARK, VI2_DATA5_VI2_B5_MARK,
+	VI2_DATA6_VI2_B6_MARK, VI2_DATA7_VI2_B7_MARK,
+	/* G */
+	VI2_G2_MARK, VI2_G3_MARK,
+	VI2_G4_MARK, VI2_G5_MARK,
+	VI2_G6_MARK, VI2_G7_MARK,
+	/* R */
+	VI2_R2_MARK, VI2_R3_MARK,
+	VI2_R4_MARK, VI2_R5_MARK,
+	VI2_R6_MARK, VI2_R7_MARK,
+};
+static const unsigned int vin2_sync_pins[] = {
+	RCAR_GP_PIN(1, 16), /* HSYNC */
+	RCAR_GP_PIN(1, 21), /* VSYNC */
+};
+static const unsigned int vin2_sync_mux[] = {
+	VI2_HSYNC_N_MARK,
+	VI2_VSYNC_N_MARK,
+};
+static const unsigned int vin2_field_pins[] = {
+	RCAR_GP_PIN(1, 9),
+};
+static const unsigned int vin2_field_mux[] = {
+	VI2_FIELD_MARK,
+};
+static const unsigned int vin2_clkenb_pins[] = {
+	RCAR_GP_PIN(1, 8),
+};
+static const unsigned int vin2_clkenb_mux[] = {
+	VI2_CLKENB_MARK,
+};
+static const unsigned int vin2_clk_pins[] = {
+	RCAR_GP_PIN(1, 11),
+};
+static const unsigned int vin2_clk_mux[] = {
+	VI2_CLK_MARK,
+};
+/* - VIN3 ----------------------------------------------------------------- */
+static const unsigned int vin3_data8_pins[] = {
+	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
+	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+};
+static const unsigned int vin3_data8_mux[] = {
+	VI3_DATA0_MARK, VI3_DATA1_MARK,
+	VI3_DATA2_MARK, VI3_DATA3_MARK,
+	VI3_DATA4_MARK, VI3_DATA5_MARK,
+	VI3_DATA6_MARK, VI3_DATA7_MARK,
+};
+static const unsigned int vin3_sync_pins[] = {
+	RCAR_GP_PIN(1, 16), /* HSYNC */
+	RCAR_GP_PIN(1, 17), /* VSYNC */
+};
+static const unsigned int vin3_sync_mux[] = {
+	VI3_HSYNC_N_MARK,
+	VI2_VSYNC_N_MARK,
+};
+static const unsigned int vin3_field_pins[] = {
+	RCAR_GP_PIN(1, 15),
+};
+static const unsigned int vin3_field_mux[] = {
+	VI3_FIELD_MARK,
+};
+static const unsigned int vin3_clkenb_pins[] = {
+	RCAR_GP_PIN(1, 14),
+};
+static const unsigned int vin3_clkenb_mux[] = {
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
@@ -3417,6 +3549,20 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin1_field),
 	SH_PFC_PIN_GROUP(vin1_clkenb),
 	SH_PFC_PIN_GROUP(vin1_clk),
+	VIN_DATA_PIN_GROUP(vin2_data, 24),
+	SH_PFC_PIN_GROUP(vin2_data18),
+	VIN_DATA_PIN_GROUP(vin2_data, 16),
+	VIN_DATA_PIN_GROUP(vin2_data, 8),
+	VIN_DATA_PIN_GROUP(vin2_data, 4),
+	SH_PFC_PIN_GROUP(vin2_sync),
+	SH_PFC_PIN_GROUP(vin2_field),
+	SH_PFC_PIN_GROUP(vin2_clkenb),
+	SH_PFC_PIN_GROUP(vin2_clk),
+	SH_PFC_PIN_GROUP(vin3_data8),
+	SH_PFC_PIN_GROUP(vin3_sync),
+	SH_PFC_PIN_GROUP(vin3_field),
+	SH_PFC_PIN_GROUP(vin3_clkenb),
+	SH_PFC_PIN_GROUP(vin3_clk),
 };
 
 static const char * const du_groups[] = {
@@ -3723,6 +3869,26 @@ static const char * const vin1_groups[] = {
 	"vin1_clk",
 };
 
+static const char * const vin2_groups[] = {
+	"vin2_data24",
+	"vin2_data18",
+	"vin2_data16",
+	"vin2_data8",
+	"vin2_data4",
+	"vin2_sync",
+	"vin2_field",
+	"vin2_clkenb",
+	"vin2_clk",
+};
+
+static const char * const vin3_groups[] = {
+	"vin3_data8",
+	"vin3_sync",
+	"vin3_field",
+	"vin3_clkenb",
+	"vin3_clk",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(du),
 	SH_PFC_FUNCTION(du0),
@@ -3760,6 +3926,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(usb2),
 	SH_PFC_FUNCTION(vin0),
 	SH_PFC_FUNCTION(vin1),
+	SH_PFC_FUNCTION(vin2),
+	SH_PFC_FUNCTION(vin3),
 };
 
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
1.8.3.1

