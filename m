From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 25 Dec 2013 19:36:01 +0000
Subject: [PATCH 1/3] pinctrl: sh-pfc: r8a7791: Add VIN pins
Message-Id: <1388000163-9932-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387998730-6012-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387998730-6012-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds VIN[0-2] pinmux support to r8a7791 SoC.
VIN1 B mirror is also added along with the primary
configuration since it's the only one that provides
access to all 24 data bits on VIN1.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 360 +++++++++++++++++++++++++++++++++++
 1 file changed, 360 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 654bef3..57ede6b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -2817,6 +2817,290 @@ static const unsigned int usb1_ovc_mux[] = {
 	USB1_OVC_MARK,
 };
 
+union vin_data {
+	unsigned int data24[24];
+	unsigned int data20[20];
+	unsigned int data16[16];
+	unsigned int data12[12];
+	unsigned int data10[10];
+	unsigned int data8[8];
+};
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
+		RCAR_GP_PIN(4, 5), RCAR_GP_PIN(4, 6),
+		RCAR_GP_PIN(4, 7), RCAR_GP_PIN(4, 8),
+		RCAR_GP_PIN(4, 9), RCAR_GP_PIN(4, 10),
+		RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
+		/* G */
+		RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 14),
+		RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 16),
+		RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 18),
+		RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 20),
+		/* R */
+		RCAR_GP_PIN(4, 21), RCAR_GP_PIN(4, 22),
+		RCAR_GP_PIN(4, 23), RCAR_GP_PIN(4, 24),
+		RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 26),
+		RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
+	},
+};
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
+};
+static const unsigned int vin0_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(4, 7), RCAR_GP_PIN(4, 8),
+	RCAR_GP_PIN(4, 9), RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
+	/* G */
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 16),
+	RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 18),
+	RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 20),
+	/* R */
+	RCAR_GP_PIN(4, 23), RCAR_GP_PIN(4, 24),
+	RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 26),
+	RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
+};
+static const unsigned int vin0_data18_mux[] = {
+	/* B */
+	VI0_DATA2_VI0_B2_MARK, VI0_DATA3_VI0_B3_MARK,
+	VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
+	/* G */
+	VI0_G2_MARK, VI0_G3_MARK,
+	VI0_G4_MARK, VI0_G5_MARK,
+	VI0_G6_MARK, VI0_G7_MARK,
+	/* R */
+	VI0_R2_MARK, VI0_R3_MARK,
+	VI0_R4_MARK, VI0_R5_MARK,
+	VI0_R6_MARK, VI0_R7_MARK,
+};
+static const unsigned int vin0_sync_pins[] = {
+	RCAR_GP_PIN(4, 3), /* HSYNC */
+	RCAR_GP_PIN(4, 4), /* VSYNC */
+};
+static const unsigned int vin0_sync_mux[] = {
+	VI0_HSYNC_N_MARK,
+	VI0_VSYNC_N_MARK,
+};
+static const unsigned int vin0_field_pins[] = {
+	RCAR_GP_PIN(4, 2),
+};
+static const unsigned int vin0_field_mux[] = {
+	VI0_FIELD_MARK,
+};
+static const unsigned int vin0_clkenb_pins[] = {
+	RCAR_GP_PIN(4, 1),
+};
+static const unsigned int vin0_clkenb_mux[] = {
+	VI0_CLKENB_MARK,
+};
+static const unsigned int vin0_clk_pins[] = {
+	RCAR_GP_PIN(4, 0),
+};
+static const unsigned int vin0_clk_mux[] = {
+	VI0_CLK_MARK,
+};
+/* - VIN1 ----------------------------------------------------------------- */
+static const unsigned int vin1_data8_pins[] = {
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
+	RCAR_GP_PIN(5, 7), RCAR_GP_PIN(5, 8),
+	RCAR_GP_PIN(5, 9), RCAR_GP_PIN(5, 10),
+	RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 12),
+};
+static const unsigned int vin1_data8_mux[] = {
+	VI1_DATA0_MARK, VI1_DATA1_MARK,
+	VI1_DATA2_MARK, VI1_DATA3_MARK,
+	VI1_DATA4_MARK, VI1_DATA5_MARK,
+	VI1_DATA6_MARK, VI1_DATA7_MARK,
+};
+static const unsigned int vin1_sync_pins[] = {
+	RCAR_GP_PIN(5, 0), /* HSYNC */
+	RCAR_GP_PIN(5, 1), /* VSYNC */
+};
+static const unsigned int vin1_sync_mux[] = {
+	VI1_HSYNC_N_MARK,
+	VI1_VSYNC_N_MARK,
+};
+static const unsigned int vin1_field_pins[] = {
+	RCAR_GP_PIN(5, 3),
+};
+static const unsigned int vin1_field_mux[] = {
+	VI1_FIELD_MARK,
+};
+static const unsigned int vin1_clkenb_pins[] = {
+	RCAR_GP_PIN(5, 2),
+};
+static const unsigned int vin1_clkenb_mux[] = {
+	VI1_CLKENB_MARK,
+};
+static const unsigned int vin1_clk_pins[] = {
+	RCAR_GP_PIN(5, 4),
+};
+static const unsigned int vin1_clk_mux[] = {
+	VI1_CLK_MARK,
+};
+static const union vin_data vin1_b_data_pins = {
+	.data24 = {
+		/* B */
+		RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 1),
+		RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 9),
+		RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
+		RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 13),
+		/* G */
+		RCAR_GP_PIN(6, 24), RCAR_GP_PIN(6, 25),
+		RCAR_GP_PIN(6, 26), RCAR_GP_PIN(6, 27),
+		RCAR_GP_PIN(6, 28), RCAR_GP_PIN(6, 29),
+		RCAR_GP_PIN(7, 21), RCAR_GP_PIN(7, 22),
+		/* R */
+		RCAR_GP_PIN(7, 5), RCAR_GP_PIN(7, 6),
+		RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 16),
+		RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 18),
+		RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 20),
+	},
+};
+static const union vin_data vin1_b_data_mux = {
+	.data24 = {
+		/* B */
+		VI1_DATA0_B_MARK, VI1_DATA1_B_MARK,
+		VI1_DATA2_B_MARK, VI1_DATA3_B_MARK,
+		VI1_DATA4_B_MARK, VI1_DATA5_B_MARK,
+		VI1_DATA6_B_MARK, VI1_DATA7_B_MARK,
+		/* G */
+		VI1_G0_B_MARK, VI1_G1_B_MARK,
+		VI1_G2_B_MARK, VI1_G3_B_MARK,
+		VI1_G4_B_MARK, VI1_G5_B_MARK,
+		VI1_G6_B_MARK, VI1_G7_B_MARK,
+		/* R */
+		VI1_R0_B_MARK, VI1_R1_B_MARK,
+		VI1_R2_B_MARK, VI1_R3_B_MARK,
+		VI1_R4_B_MARK, VI1_R5_B_MARK,
+		VI1_R6_B_MARK, VI1_R7_B_MARK,
+	},
+};
+static const unsigned int vin1_b_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 9),
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 13),
+	/* G */
+	RCAR_GP_PIN(6, 26), RCAR_GP_PIN(6, 27),
+	RCAR_GP_PIN(6, 28), RCAR_GP_PIN(6, 29),
+	RCAR_GP_PIN(7, 21), RCAR_GP_PIN(7, 22),
+	/* R */
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 16),
+	RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 18),
+	RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 20),
+};
+static const unsigned int vin1_b_data18_mux[] = {
+	/* B */
+	VI1_DATA0_B_MARK, VI1_DATA1_B_MARK,
+	VI1_DATA2_B_MARK, VI1_DATA3_B_MARK,
+	VI1_DATA4_B_MARK, VI1_DATA5_B_MARK,
+	VI1_DATA6_B_MARK, VI1_DATA7_B_MARK,
+	/* G */
+	VI1_G0_B_MARK, VI1_G1_B_MARK,
+	VI1_G2_B_MARK, VI1_G3_B_MARK,
+	VI1_G4_B_MARK, VI1_G5_B_MARK,
+	VI1_G6_B_MARK, VI1_G7_B_MARK,
+	/* R */
+	VI1_R0_B_MARK, VI1_R1_B_MARK,
+	VI1_R2_B_MARK, VI1_R3_B_MARK,
+	VI1_R4_B_MARK, VI1_R5_B_MARK,
+	VI1_R6_B_MARK, VI1_R7_B_MARK,
+};
+static const unsigned int vin1_b_sync_pins[] = {
+	RCAR_GP_PIN(3, 17), /* HSYNC */
+	RCAR_GP_PIN(3, 18), /* VSYNC */
+};
+static const unsigned int vin1_b_sync_mux[] = {
+	VI1_HSYNC_N_B_MARK,
+	VI1_VSYNC_N_B_MARK,
+};
+static const unsigned int vin1_b_field_pins[] = {
+	RCAR_GP_PIN(3, 20),
+};
+static const unsigned int vin1_b_field_mux[] = {
+	VI1_FIELD_B_MARK,
+};
+static const unsigned int vin1_b_clkenb_pins[] = {
+	RCAR_GP_PIN(3, 19),
+};
+static const unsigned int vin1_b_clkenb_mux[] = {
+	VI1_CLKENB_B_MARK,
+};
+static const unsigned int vin1_b_clk_pins[] = {
+	RCAR_GP_PIN(3, 16),
+};
+static const unsigned int vin1_b_clk_mux[] = {
+	VI1_CLK_B_MARK,
+};
+/* - VIN2 ----------------------------------------------------------------- */
+static const unsigned int vin2_data8_pins[] = {
+	RCAR_GP_PIN(4, 20), RCAR_GP_PIN(4, 21),
+	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 23),
+	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 25),
+	RCAR_GP_PIN(4, 26), RCAR_GP_PIN(4, 27),
+};
+static const unsigned int vin2_data8_mux[] = {
+	VI2_DATA0_MARK, VI2_DATA1_MARK,
+	VI2_DATA2_MARK, VI2_DATA3_MARK,
+	VI2_DATA4_MARK, VI2_DATA5_MARK,
+	VI2_DATA6_MARK, VI2_DATA7_MARK,
+};
+static const unsigned int vin2_sync_pins[] = {
+	RCAR_GP_PIN(4, 15), /* HSYNC */
+	RCAR_GP_PIN(4, 16), /* VSYNC */
+};
+static const unsigned int vin2_sync_mux[] = {
+	VI2_HSYNC_N_MARK,
+	VI2_VSYNC_N_MARK,
+};
+static const unsigned int vin2_field_pins[] = {
+	RCAR_GP_PIN(4, 18),
+};
+static const unsigned int vin2_field_mux[] = {
+	VI2_FIELD_MARK,
+};
+static const unsigned int vin2_clkenb_pins[] = {
+	RCAR_GP_PIN(4, 17),
+};
+static const unsigned int vin2_clkenb_mux[] = {
+	VI2_CLKENB_MARK,
+};
+static const unsigned int vin2_clk_pins[] = {
+	RCAR_GP_PIN(4, 19),
+};
+static const unsigned int vin2_clk_mux[] = {
+	VI2_CLK_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_rgb666),
 	SH_PFC_PIN_GROUP(du_rgb888),
@@ -2971,6 +3255,38 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(usb0_ovc),
 	SH_PFC_PIN_GROUP(usb1_pwen),
 	SH_PFC_PIN_GROUP(usb1_ovc),
+	VIN_DATA_PIN_GROUP(vin0_data, 24),
+	VIN_DATA_PIN_GROUP(vin0_data, 20),
+	SH_PFC_PIN_GROUP(vin0_data18),
+	VIN_DATA_PIN_GROUP(vin0_data, 16),
+	VIN_DATA_PIN_GROUP(vin0_data, 12),
+	VIN_DATA_PIN_GROUP(vin0_data, 10),
+	VIN_DATA_PIN_GROUP(vin0_data, 8),
+	SH_PFC_PIN_GROUP(vin0_sync),
+	SH_PFC_PIN_GROUP(vin0_field),
+	SH_PFC_PIN_GROUP(vin0_clkenb),
+	SH_PFC_PIN_GROUP(vin0_clk),
+	SH_PFC_PIN_GROUP(vin1_data8),
+	SH_PFC_PIN_GROUP(vin1_sync),
+	SH_PFC_PIN_GROUP(vin1_field),
+	SH_PFC_PIN_GROUP(vin1_clkenb),
+	SH_PFC_PIN_GROUP(vin1_clk),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 24),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 20),
+	SH_PFC_PIN_GROUP(vin1_b_data18),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 16),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 12),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 10),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 8),
+	SH_PFC_PIN_GROUP(vin1_b_sync),
+	SH_PFC_PIN_GROUP(vin1_b_field),
+	SH_PFC_PIN_GROUP(vin1_b_clkenb),
+	SH_PFC_PIN_GROUP(vin1_b_clk),
+	SH_PFC_PIN_GROUP(vin2_data8),
+	SH_PFC_PIN_GROUP(vin2_sync),
+	SH_PFC_PIN_GROUP(vin2_field),
+	SH_PFC_PIN_GROUP(vin2_clkenb),
+	SH_PFC_PIN_GROUP(vin2_clk),
 };
 
 static const char * const du_groups[] = {
@@ -3215,6 +3531,47 @@ static const char * const usb1_groups[] = {
 	"usb1_ovc",
 };
 
+static const char * const vin0_groups[] = {
+	"vin0_data24",
+	"vin0_data20",
+	"vin0_data18",
+	"vin0_data16",
+	"vin0_data12",
+	"vin0_data10",
+	"vin0_data8",
+	"vin0_sync",
+	"vin0_field",
+	"vin0_clkenb",
+	"vin0_clk",
+};
+
+static const char * const vin1_groups[] = {
+	"vin1_data8",
+	"vin1_sync",
+	"vin1_field",
+	"vin1_clkenb",
+	"vin1_clk",
+	"vin1_b_data24",
+	"vin1_b_data20",
+	"vin1_b_data18",
+	"vin1_b_data16",
+	"vin1_b_data12",
+	"vin1_b_data10",
+	"vin1_b_data8",
+	"vin1_b_sync",
+	"vin1_b_field",
+	"vin1_b_clkenb",
+	"vin1_b_clk",
+};
+
+static const char * const vin2_groups[] = {
+	"vin2_data8",
+	"vin2_sync",
+	"vin2_field",
+	"vin2_clkenb",
+	"vin2_clk",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(du),
 	SH_PFC_FUNCTION(du0),
@@ -3250,6 +3607,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi2),
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
+	SH_PFC_FUNCTION(vin0),
+	SH_PFC_FUNCTION(vin1),
+	SH_PFC_FUNCTION(vin2),
 };
 
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
1.8.3.1

