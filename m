From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 18:20:25 +0000
Subject: [PATCH 4/5] pinctrl: sh-pfc: pfc-r8a7790: Add missing VIN1 pins
Message-Id: <1386699626-15803-5-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Both VIN0 and VIN1 channels support identical input interfaces.
Add missing VIN1 pins here and organize them in the same pin
groups as VIN0.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 112 ++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 8206cdf..64ce10d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3127,15 +3127,91 @@ static const unsigned int vin0_clk_mux[] = {
 	VI0_CLK_MARK,
 };
 /* - VIN1 ------------------------------------------------------------------- */
-static const unsigned int vin1_data_pins[] = {
-	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 12),
-	RCAR_GP_PIN(2, 13), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 15),
+static const union vin_data vin1_data_pins = {
+	.data24 = {
+		/* B */
+		RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 11),
+		RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 13),
+		RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 15),
+		RCAR_GP_PIN(2, 16), RCAR_GP_PIN(2, 17),
+		/* G */
+		RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
+		RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 20),
+		RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 12),
+		RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 7),
+		/* R */
+		RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28),
+		RCAR_GP_PIN(0, 29), RCAR_GP_PIN(1, 4),
+		RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
+		RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 8),
+	},
+};
+static const union vin_data vin1_data_mux = {
+	.data24 = {
+		/* B */
+		VI1_DATA0_VI1_B0_MARK, VI1_DATA1_VI1_B1_MARK,
+		VI1_DATA2_VI1_B2_MARK, VI1_DATA3_VI1_B3_MARK,
+		VI1_DATA4_VI1_B4_MARK, VI1_DATA5_VI1_B5_MARK,
+		VI1_DATA6_VI1_B6_MARK, VI1_DATA7_VI1_B7_MARK,
+		/* G */
+		VI1_G0_MARK, VI1_G1_MARK,
+		VI1_G2_MARK, VI1_G3_MARK,
+		VI1_G4_MARK, VI1_G5_MARK,
+		VI1_G6_MARK, VI1_G7_MARK,
+		/* R */
+		VI1_R0_MARK, VI1_R1_MARK,
+		VI1_R2_MARK, VI1_R3_MARK,
+		VI1_R4_MARK, VI1_R5_MARK,
+		VI1_R6_MARK, VI1_R7_MARK,
+	},
+};
+static const unsigned int vin1_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 13),
+	RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 15),
 	RCAR_GP_PIN(2, 16), RCAR_GP_PIN(2, 17),
+	/* G */
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 20),
+	RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 12),
+	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 7),
+	/* R */
+	RCAR_GP_PIN(0, 29), RCAR_GP_PIN(1, 4),
+	RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 8),
 };
-static const unsigned int vin1_data_mux[] = {
-	VI1_DATA0_VI1_B0_MARK, VI1_DATA1_VI1_B1_MARK, VI1_DATA2_VI1_B2_MARK,
-	VI1_DATA3_VI1_B3_MARK, VI1_DATA4_VI1_B4_MARK, VI1_DATA5_VI1_B5_MARK,
+static const unsigned int vin1_data18_mux[] = {
+	/* B */
+	VI1_DATA2_VI1_B2_MARK, VI1_DATA3_VI1_B3_MARK,
+	VI1_DATA4_VI1_B4_MARK, VI1_DATA5_VI1_B5_MARK,
 	VI1_DATA6_VI1_B6_MARK, VI1_DATA7_VI1_B7_MARK,
+	/* G */
+	VI1_G2_MARK, VI1_G3_MARK,
+	VI1_G4_MARK, VI1_G5_MARK,
+	VI1_G6_MARK, VI1_G7_MARK,
+	/* R */
+	VI1_R2_MARK, VI1_R3_MARK,
+	VI1_R4_MARK, VI1_R5_MARK,
+	VI1_R6_MARK, VI1_R7_MARK,
+};
+static const unsigned int vin1_sync_pins[] = {
+	RCAR_GP_PIN(1, 24), /* HSYNC */
+	RCAR_GP_PIN(1, 25), /* VSYNC */
+};
+static const unsigned int vin1_sync_mux[] = {
+	VI1_HSYNC_N_MARK,
+	VI1_VSYNC_N_MARK,
+};
+static const unsigned int vin1_field_pins[] = {
+	RCAR_GP_PIN(1, 13),
+};
+static const unsigned int vin1_field_mux[] = {
+	VI1_FIELD_MARK,
+};
+static const unsigned int vin1_clkenb_pins[] = {
+	RCAR_GP_PIN(1, 26),
+};
+static const unsigned int vin1_clkenb_mux[] = {
+	VI1_CLKENB_MARK,
 };
 static const unsigned int vin1_clk_pins[] = {
 	RCAR_GP_PIN(2, 9),
@@ -3329,7 +3405,17 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin0_field),
 	SH_PFC_PIN_GROUP(vin0_clkenb),
 	SH_PFC_PIN_GROUP(vin0_clk),
-	SH_PFC_PIN_GROUP(vin1_data),
+	VIN_DATA_PIN_GROUP(vin1_data, 24),
+	VIN_DATA_PIN_GROUP(vin1_data, 20),
+	SH_PFC_PIN_GROUP(vin1_data18),
+	VIN_DATA_PIN_GROUP(vin1_data, 16),
+	VIN_DATA_PIN_GROUP(vin1_data, 12),
+	VIN_DATA_PIN_GROUP(vin1_data, 10),
+	VIN_DATA_PIN_GROUP(vin1_data, 8),
+	VIN_DATA_PIN_GROUP(vin1_data, 4),
+	SH_PFC_PIN_GROUP(vin1_sync),
+	SH_PFC_PIN_GROUP(vin1_field),
+	SH_PFC_PIN_GROUP(vin1_clkenb),
 	SH_PFC_PIN_GROUP(vin1_clk),
 };
 
@@ -3623,7 +3709,17 @@ static const char * const vin0_groups[] = {
 };
 
 static const char * const vin1_groups[] = {
-	"vin1_data",
+	"vin1_data24",
+	"vin1_data20",
+	"vin1_data18",
+	"vin1_data16",
+	"vin1_data12",
+	"vin1_data10",
+	"vin1_data8",
+	"vin1_data4",
+	"vin1_sync",
+	"vin1_field",
+	"vin1_clkenb",
 	"vin1_clk",
 };
 
-- 
1.8.3.1

