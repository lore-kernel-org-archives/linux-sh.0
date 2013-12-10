From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 18:20:24 +0000
Subject: [PATCH 3/5] pinctrl: sh-pfc: pfc-r8a7790: Reorganize VIN0 data pins
Message-Id: <1386699626-15803-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This reorganizes and renames VIN0 data pin groups to cover
all possible configurations. There's total of eight data
pin groups, one per each configuration. Most of the groups
share the same pin/mux array. Only the 18-bit configuration
needs a separate pin/mux array since in combines interleaved
data pins.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 125 ++++++++++++++++++++++++++---------
 1 file changed, 95 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index fa4d7093..8206cdf 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3014,36 +3014,91 @@ static const unsigned int usb2_pins[] = {
 static const unsigned int usb2_mux[] = {
 	USB2_PWEN_MARK, USB2_OVC_MARK,
 };
-/* - VIN0 ------------------------------------------------------------------- */
-static const unsigned int vin0_data_g_pins[] = {
-	RCAR_GP_PIN(0, 8), RCAR_GP_PIN(0, 9), RCAR_GP_PIN(0, 10),
-	RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-};
-static const unsigned int vin0_data_g_mux[] = {
-	VI0_G0_MARK, VI0_G1_MARK, VI0_G2_MARK,
-	VI0_G3_MARK, VI0_G4_MARK, VI0_G5_MARK,
-	VI0_G6_MARK, VI0_G7_MARK,
+
+union vin_data {
+	unsigned int data24[24];
+	unsigned int data20[20];
+	unsigned int data16[16];
+	unsigned int data12[12];
+	unsigned int data10[10];
+	unsigned int data8[8];
+	unsigned int data4[4];
 };
-static const unsigned int vin0_data_r_pins[] = {
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5), RCAR_GP_PIN(0, 6),
-	RCAR_GP_PIN(0, 7), RCAR_GP_PIN(0, 24), RCAR_GP_PIN(0, 25),
-	RCAR_GP_PIN(0, 26), RCAR_GP_PIN(1, 11),
+
+#define VIN_DATA_PIN_GROUP(n, s)				\
+	{							\
+		.name = #n#s,					\
+		.pins = n##_pins.data##s,			\
+		.mux = n##_mux.data##s,				\
+		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
+	}
+
+/* - VIN0 ------------------------------------------------------------------- */
+static const union vin_data vin0_data_pins = {
+	.data24 = {
+		/* B */
+		RCAR_GP_PIN(2, 1), RCAR_GP_PIN(2, 2),
+		RCAR_GP_PIN(2, 3), RCAR_GP_PIN(2, 4),
+		RCAR_GP_PIN(2, 5), RCAR_GP_PIN(2, 6),
+		RCAR_GP_PIN(2, 7), RCAR_GP_PIN(2, 8),
+		/* G */
+		RCAR_GP_PIN(0, 8), RCAR_GP_PIN(0, 9),
+		RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
+		RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
+		RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+		/* R */
+		RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+		RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+		RCAR_GP_PIN(0, 24), RCAR_GP_PIN(0, 25),
+		RCAR_GP_PIN(0, 26), RCAR_GP_PIN(1, 11),
+	},
 };
-static const unsigned int vin0_data_r_mux[] = {
-	VI0_R0_MARK, VI0_R1_MARK, VI0_R2_MARK,
-	VI0_R3_MARK, VI0_R4_MARK, VI0_R5_MARK,
-	VI0_R6_MARK, VI0_R7_MARK,
+static const union vin_data vin0_data_mux = {
+	.data24 = {
+		/* B */
+		VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK,
+		VI0_DATA2_VI0_B2_MARK, VI0_DATA3_VI0_B3_MARK,
+		VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+		VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
+		/* G */
+		VI0_G0_MARK, VI0_G1_MARK,
+		VI0_G2_MARK, VI0_G3_MARK,
+		VI0_G4_MARK, VI0_G5_MARK,
+		VI0_G6_MARK, VI0_G7_MARK,
+		/* R */
+		VI0_R0_MARK, VI0_R1_MARK,
+		VI0_R2_MARK, VI0_R3_MARK,
+		VI0_R4_MARK, VI0_R5_MARK,
+		VI0_R6_MARK, VI0_R7_MARK,
+	},
 };
-static const unsigned int vin0_data_b_pins[] = {
-	RCAR_GP_PIN(2, 1), RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 3),
-	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 5), RCAR_GP_PIN(2, 6),
+static const unsigned int vin0_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(2, 3), RCAR_GP_PIN(2, 4),
+	RCAR_GP_PIN(2, 5), RCAR_GP_PIN(2, 6),
 	RCAR_GP_PIN(2, 7), RCAR_GP_PIN(2, 8),
+	/* G */
+	RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
+	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
+	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+	/* R */
+	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+	RCAR_GP_PIN(0, 24), RCAR_GP_PIN(0, 25),
+	RCAR_GP_PIN(0, 26), RCAR_GP_PIN(1, 11),
 };
-static const unsigned int vin0_data_b_mux[] = {
-	VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK, VI0_DATA2_VI0_B2_MARK,
-	VI0_DATA3_VI0_B3_MARK, VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+static const unsigned int vin0_data18_mux[] = {
+	/* B */
+	VI0_DATA2_VI0_B2_MARK, VI0_DATA3_VI0_B3_MARK,
+	VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
 	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
+	/* G */
+	VI0_G2_MARK, VI0_G3_MARK,
+	VI0_G4_MARK, VI0_G5_MARK,
+	VI0_G6_MARK, VI0_G7_MARK,
+	/* R */
+	VI0_R2_MARK, VI0_R3_MARK,
+	VI0_R4_MARK, VI0_R5_MARK,
+	VI0_R6_MARK, VI0_R7_MARK,
 };
 static const unsigned int vin0_sync_pins[] = {
 	RCAR_GP_PIN(0, 12), /* HSYNC */
@@ -3262,9 +3317,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
 	SH_PFC_PIN_GROUP(usb2),
-	SH_PFC_PIN_GROUP(vin0_data_g),
-	SH_PFC_PIN_GROUP(vin0_data_r),
-	SH_PFC_PIN_GROUP(vin0_data_b),
+	VIN_DATA_PIN_GROUP(vin0_data, 24),
+	VIN_DATA_PIN_GROUP(vin0_data, 20),
+	SH_PFC_PIN_GROUP(vin0_data18),
+	VIN_DATA_PIN_GROUP(vin0_data, 16),
+	VIN_DATA_PIN_GROUP(vin0_data, 12),
+	VIN_DATA_PIN_GROUP(vin0_data, 10),
+	VIN_DATA_PIN_GROUP(vin0_data, 8),
+	VIN_DATA_PIN_GROUP(vin0_data, 4),
 	SH_PFC_PIN_GROUP(vin0_sync),
 	SH_PFC_PIN_GROUP(vin0_field),
 	SH_PFC_PIN_GROUP(vin0_clkenb),
@@ -3548,9 +3608,14 @@ static const char * const usb2_groups[] = {
 };
 
 static const char * const vin0_groups[] = {
-	"vin0_data_g",
-	"vin0_data_r",
-	"vin0_data_b",
+	"vin0_data24",
+	"vin0_data20",
+	"vin0_data18",
+	"vin0_data16",
+	"vin0_data12",
+	"vin0_data10",
+	"vin0_data8",
+	"vin0_data4",
 	"vin0_sync",
 	"vin0_field",
 	"vin0_clkenb",
-- 
1.8.3.1

