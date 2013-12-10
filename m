From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 15:50:11 +0000
Subject: [PATCH 2/2] pinctrl: sh-pfc: pfc-r8a7790: Reorganize and rename VIN pin groups
Message-Id: <1386690611-2014-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Regroup VIN data pins to cover all possible data
configurations with one group per each configuration.
Most of the groups share the same pin/mux array.
Only the 18-bit one needs a separate pin/mux array
since it combines interleaved data pins.

Also group hsync and vsync pins together since
one cannot be used without another.
While at it, drop the superfluous "signal" word
from the group names and rename "data_enable"
to "clkenb" as in the hardware manual.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 485 ++++++++++++++++++++++-------------
 1 file changed, 307 insertions(+), 178 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index d6c446f..74abab6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3014,59 +3014,110 @@ static const unsigned int usb2_pins[] = {
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
-static const unsigned int vin0_hsync_signal_pins[] = {
-	RCAR_GP_PIN(0, 12),
+static const unsigned int vin0_sync_pins[] = {
+	RCAR_GP_PIN(0, 12), /* HSYNC */
+	RCAR_GP_PIN(0, 13), /* VSYNC */
 };
-static const unsigned int vin0_hsync_signal_mux[] = {
+static const unsigned int vin0_sync_mux[] = {
 	VI0_HSYNC_N_MARK,
-};
-static const unsigned int vin0_vsync_signal_pins[] = {
-	RCAR_GP_PIN(0, 13),
-};
-static const unsigned int vin0_vsync_signal_mux[] = {
 	VI0_VSYNC_N_MARK,
 };
-static const unsigned int vin0_field_signal_pins[] = {
+static const unsigned int vin0_field_pins[] = {
 	RCAR_GP_PIN(0, 15),
 };
-static const unsigned int vin0_field_signal_mux[] = {
+static const unsigned int vin0_field_mux[] = {
 	VI0_FIELD_MARK,
 };
-static const unsigned int vin0_data_enable_pins[] = {
+static const unsigned int vin0_clkenb_pins[] = {
 	RCAR_GP_PIN(0, 14),
 };
-static const unsigned int vin0_data_enable_mux[] = {
+static const unsigned int vin0_clkenb_mux[] = {
 	VI0_CLKENB_MARK,
 };
 static const unsigned int vin0_clk_pins[] = {
@@ -3076,58 +3127,90 @@ static const unsigned int vin0_clk_mux[] = {
 	VI0_CLK_MARK,
 };
 /* - VIN1 ------------------------------------------------------------------- */
-static const unsigned int vin1_data_g_pins[] = {
-	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 17),
-	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 12),
-	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 7),
-};
-static const unsigned int vin1_data_g_mux[] = {
-	VI1_G0_MARK, VI1_G1_MARK, VI1_G2_MARK,
-	VI1_G3_MARK, VI1_G4_MARK, VI1_G5_MARK,
-	VI1_G6_MARK, VI1_G7_MARK,
-};
-static const unsigned int vin1_data_r_pins[] = {
-	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28), RCAR_GP_PIN(0, 29),
-	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
-	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 8),
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
 };
-static const unsigned int vin1_data_r_mux[] = {
-	VI1_R0_MARK, VI1_R1_MARK, VI1_R2_MARK,
-	VI1_R3_MARK, VI1_R4_MARK, VI1_R5_MARK,
-	VI1_R6_MARK, VI1_R7_MARK,
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
 };
-static const unsigned int vin1_data_b_pins[] = {
-	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 12),
-	RCAR_GP_PIN(2, 13), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 15),
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
-static const unsigned int vin1_data_b_mux[] = {
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
 };
-static const unsigned int vin1_hsync_signal_pins[] = {
-	RCAR_GP_PIN(1, 24),
+static const unsigned int vin1_sync_pins[] = {
+	RCAR_GP_PIN(1, 24), /* HSYNC */
+	RCAR_GP_PIN(1, 25), /* VSYNC */
 };
-static const unsigned int vin1_hsync_signal_mux[] = {
+static const unsigned int vin1_sync_mux[] = {
 	VI1_HSYNC_N_MARK,
-};
-static const unsigned int vin1_vsync_signal_pins[] = {
-	RCAR_GP_PIN(1, 25),
-};
-static const unsigned int vin1_vsync_signal_mux[] = {
 	VI1_VSYNC_N_MARK,
 };
-static const unsigned int vin1_field_signal_pins[] = {
+static const unsigned int vin1_field_pins[] = {
 	RCAR_GP_PIN(1, 13),
 };
-static const unsigned int vin1_field_signal_mux[] = {
+static const unsigned int vin1_field_mux[] = {
 	VI1_FIELD_MARK,
 };
-static const unsigned int vin1_data_enable_pins[] = {
+static const unsigned int vin1_clkenb_pins[] = {
 	RCAR_GP_PIN(1, 26),
 };
-static const unsigned int vin1_data_enable_mux[] = {
+static const unsigned int vin1_clkenb_mux[] = {
 	VI1_CLKENB_MARK,
 };
 static const unsigned int vin1_clk_pins[] = {
@@ -3137,58 +3220,90 @@ static const unsigned int vin1_clk_mux[] = {
 	VI1_CLK_MARK,
 };
 /* - VIN2 ----------------------------------------------------------------- */
-static const unsigned int vin2_data_g_pins[] = {
-	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28), RCAR_GP_PIN(0, 29),
-	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
-	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
-};
-static const unsigned int vin2_data_g_mux[] = {
-	VI2_G0_MARK, VI2_G1_MARK, VI2_G2_MARK,
-	VI2_G3_MARK, VI2_G4_MARK, VI2_G5_MARK,
-	VI2_G6_MARK, VI2_G7_MARK,
-};
-static const unsigned int vin2_data_r_pins[] = {
-	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13), RCAR_GP_PIN(1, 14),
-	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 20),
-	RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 24),
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
 };
-static const unsigned int vin2_data_r_mux[] = {
-	VI2_R0_MARK, VI2_R1_MARK, VI2_R2_MARK,
-	VI2_R3_MARK, VI2_R4_MARK, VI2_R5_MARK,
-	VI2_R6_MARK, VI2_R7_MARK,
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
 };
-static const unsigned int vin2_data_b_pins[] = {
-	RCAR_GP_PIN(0, 8), RCAR_GP_PIN(0, 9), RCAR_GP_PIN(0, 10),
-	RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+static const unsigned int vin2_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
 	RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 15),
+	/* G */
+	RCAR_GP_PIN(0, 29), RCAR_GP_PIN(1, 10),
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+	/* R */
+	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 20),
+	RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 24),
 };
-static const unsigned int vin2_data_b_mux[] = {
-	VI2_DATA0_VI2_B0_MARK, VI2_DATA1_VI2_B1_MARK, VI2_DATA2_VI2_B2_MARK,
-	VI2_DATA3_VI2_B3_MARK, VI2_DATA4_VI2_B4_MARK, VI2_DATA5_VI2_B5_MARK,
+static const unsigned int vin2_data18_mux[] = {
+	/* B */
+	VI2_DATA2_VI2_B2_MARK, VI2_DATA3_VI2_B3_MARK,
+	VI2_DATA4_VI2_B4_MARK, VI2_DATA5_VI2_B5_MARK,
 	VI2_DATA6_VI2_B6_MARK, VI2_DATA7_VI2_B7_MARK,
+	/* G */
+	VI2_G2_MARK, VI2_G3_MARK,
+	VI2_G4_MARK, VI2_G5_MARK,
+	VI2_G6_MARK, VI2_G7_MARK,
+	/* R */
+	VI2_R2_MARK, VI2_R3_MARK,
+	VI2_R4_MARK, VI2_R5_MARK,
+	VI2_R6_MARK, VI2_R7_MARK,
 };
-static const unsigned int vin2_hsync_signal_pins[] = {
-	RCAR_GP_PIN(1, 16),
+static const unsigned int vin2_sync_pins[] = {
+	RCAR_GP_PIN(1, 16), /* HSYNC */
+	RCAR_GP_PIN(1, 21), /* VSYNC */
 };
-static const unsigned int vin2_hsync_signal_mux[] = {
+static const unsigned int vin2_sync_mux[] = {
 	VI2_HSYNC_N_MARK,
-};
-static const unsigned int vin2_vsync_signal_pins[] = {
-	RCAR_GP_PIN(1, 21),
-};
-static const unsigned int vin2_vsync_signal_mux[] = {
 	VI2_VSYNC_N_MARK,
 };
-static const unsigned int vin2_field_signal_pins[] = {
+static const unsigned int vin2_field_pins[] = {
 	RCAR_GP_PIN(1, 9),
 };
-static const unsigned int vin2_field_signal_mux[] = {
+static const unsigned int vin2_field_mux[] = {
 	VI2_FIELD_MARK,
 };
-static const unsigned int vin2_data_enable_pins[] = {
+static const unsigned int vin2_clkenb_pins[] = {
 	RCAR_GP_PIN(1, 8),
 };
-static const unsigned int vin2_data_enable_mux[] = {
+static const unsigned int vin2_clkenb_mux[] = {
 	VI2_CLKENB_MARK,
 };
 static const unsigned int vin2_clk_pins[] = {
@@ -3198,38 +3313,36 @@ static const unsigned int vin2_clk_mux[] = {
 	VI2_CLK_MARK,
 };
 /* - VIN3 ----------------------------------------------------------------- */
-static const unsigned int vin3_data_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1), RCAR_GP_PIN(0, 2),
-	RCAR_GP_PIN(0, 3), RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+static const unsigned int vin3_data8_pins[] = {
+	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
+	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
 	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
 };
-static const unsigned int vin3_data_mux[] = {
-	VI3_DATA0_MARK, VI3_DATA1_MARK, VI3_DATA2_MARK,
-	VI3_DATA3_MARK, VI3_DATA4_MARK, VI3_DATA5_MARK,
+static const unsigned int vin3_data8_mux[] = {
+	VI3_DATA0_MARK, VI3_DATA1_MARK,
+	VI3_DATA2_MARK, VI3_DATA3_MARK,
+	VI3_DATA4_MARK, VI3_DATA5_MARK,
 	VI3_DATA6_MARK, VI3_DATA7_MARK,
 };
-static const unsigned int vin3_hsync_signal_pins[] = {
-	RCAR_GP_PIN(1, 16),
+static const unsigned int vin3_sync_pins[] = {
+	RCAR_GP_PIN(1, 16), /* HSYNC */
+	RCAR_GP_PIN(1, 17), /* VSYNC */
 };
-static const unsigned int vin3_hsync_signal_mux[] = {
+static const unsigned int vin3_sync_mux[] = {
 	VI3_HSYNC_N_MARK,
-};
-static const unsigned int vin3_vsync_signal_pins[] = {
-	RCAR_GP_PIN(1, 17),
-};
-static const unsigned int vin3_vsync_signal_mux[] = {
 	VI2_VSYNC_N_MARK,
 };
-static const unsigned int vin3_field_signal_pins[] = {
+static const unsigned int vin3_field_pins[] = {
 	RCAR_GP_PIN(1, 15),
 };
-static const unsigned int vin3_field_signal_mux[] = {
+static const unsigned int vin3_field_mux[] = {
 	VI3_FIELD_MARK,
 };
-static const unsigned int vin3_data_enable_pins[] = {
+static const unsigned int vin3_clkenb_pins[] = {
 	RCAR_GP_PIN(1, 14),
 };
-static const unsigned int vin3_data_enable_mux[] = {
+static const unsigned int vin3_clkenb_mux[] = {
 	VI3_CLKENB_MARK,
 };
 static const unsigned int vin3_clk_pins[] = {
@@ -3412,35 +3525,43 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
 	SH_PFC_PIN_GROUP(usb2),
-	SH_PFC_PIN_GROUP(vin0_data_g),
-	SH_PFC_PIN_GROUP(vin0_data_r),
-	SH_PFC_PIN_GROUP(vin0_data_b),
-	SH_PFC_PIN_GROUP(vin0_hsync_signal),
-	SH_PFC_PIN_GROUP(vin0_vsync_signal),
-	SH_PFC_PIN_GROUP(vin0_field_signal),
-	SH_PFC_PIN_GROUP(vin0_data_enable),
+	VIN_DATA_PIN_GROUP(vin0_data, 24),
+	VIN_DATA_PIN_GROUP(vin0_data, 20),
+	SH_PFC_PIN_GROUP(vin0_data18),
+	VIN_DATA_PIN_GROUP(vin0_data, 16),
+	VIN_DATA_PIN_GROUP(vin0_data, 12),
+	VIN_DATA_PIN_GROUP(vin0_data, 10),
+	VIN_DATA_PIN_GROUP(vin0_data, 8),
+	VIN_DATA_PIN_GROUP(vin0_data, 4),
+	SH_PFC_PIN_GROUP(vin0_sync),
+	SH_PFC_PIN_GROUP(vin0_field),
+	SH_PFC_PIN_GROUP(vin0_clkenb),
 	SH_PFC_PIN_GROUP(vin0_clk),
-	SH_PFC_PIN_GROUP(vin1_data_g),
-	SH_PFC_PIN_GROUP(vin1_data_r),
-	SH_PFC_PIN_GROUP(vin1_data_b),
-	SH_PFC_PIN_GROUP(vin1_hsync_signal),
-	SH_PFC_PIN_GROUP(vin1_vsync_signal),
-	SH_PFC_PIN_GROUP(vin1_field_signal),
-	SH_PFC_PIN_GROUP(vin1_data_enable),
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
-	SH_PFC_PIN_GROUP(vin2_data_g),
-	SH_PFC_PIN_GROUP(vin2_data_r),
-	SH_PFC_PIN_GROUP(vin2_data_b),
-	SH_PFC_PIN_GROUP(vin2_hsync_signal),
-	SH_PFC_PIN_GROUP(vin2_vsync_signal),
-	SH_PFC_PIN_GROUP(vin2_field_signal),
-	SH_PFC_PIN_GROUP(vin2_data_enable),
+	VIN_DATA_PIN_GROUP(vin2_data, 24),
+	SH_PFC_PIN_GROUP(vin2_data18),
+	VIN_DATA_PIN_GROUP(vin2_data, 16),
+	VIN_DATA_PIN_GROUP(vin2_data, 8),
+	VIN_DATA_PIN_GROUP(vin2_data, 4),
+	SH_PFC_PIN_GROUP(vin2_sync),
+	SH_PFC_PIN_GROUP(vin2_field),
+	SH_PFC_PIN_GROUP(vin2_clkenb),
 	SH_PFC_PIN_GROUP(vin2_clk),
-	SH_PFC_PIN_GROUP(vin3_data),
-	SH_PFC_PIN_GROUP(vin3_hsync_signal),
-	SH_PFC_PIN_GROUP(vin3_vsync_signal),
-	SH_PFC_PIN_GROUP(vin3_field_signal),
-	SH_PFC_PIN_GROUP(vin3_data_enable),
+	SH_PFC_PIN_GROUP(vin3_data8),
+	SH_PFC_PIN_GROUP(vin3_sync),
+	SH_PFC_PIN_GROUP(vin3_field),
+	SH_PFC_PIN_GROUP(vin3_clkenb),
 	SH_PFC_PIN_GROUP(vin3_clk),
 };
 
@@ -3719,44 +3840,52 @@ static const char * const usb2_groups[] = {
 };
 
 static const char * const vin0_groups[] = {
-	"vin0_data_g",
-	"vin0_data_r",
-	"vin0_data_b",
-	"vin0_hsync_signal",
-	"vin0_vsync_signal",
-	"vin0_field_signal",
-	"vin0_data_enable",
+	"vin0_data24",
+	"vin0_data20",
+	"vin0_data18",
+	"vin0_data16",
+	"vin0_data12",
+	"vin0_data10",
+	"vin0_data8",
+	"vin0_data4",
+	"vin0_sync",
+	"vin0_field",
+	"vin0_clkenb",
 	"vin0_clk",
 };
 
 static const char * const vin1_groups[] = {
-	"vin1_data_g",
-	"vin1_data_r",
-	"vin1_data_b",
-	"vin1_hsync_signal",
-	"vin1_vsync_signal",
-	"vin1_field_signal",
-	"vin1_data_enable",
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
 
 static const char * const vin2_groups[] = {
-	"vin2_data_g",
-	"vin2_data_r",
-	"vin2_data_b",
-	"vin2_hsync_signal",
-	"vin2_vsync_signal",
-	"vin2_field_signal",
-	"vin2_data_enable",
+	"vin2_data24",
+	"vin2_data18",
+	"vin2_data16",
+	"vin2_data8",
+	"vin2_data4",
+	"vin2_sync",
+	"vin2_field",
+	"vin2_clkenb",
 	"vin2_clk",
 };
 
 static const char * const vin3_groups[] = {
-	"vin3_data",
-	"vin3_hsync_signal",
-	"vin3_vsync_signal",
-	"vin3_field_signal",
-	"vin3_data_enable",
+	"vin3_data8",
+	"vin3_sync",
+	"vin3_field",
+	"vin3_clkenb",
 	"vin3_clk",
 };
 
-- 
1.8.3.1

