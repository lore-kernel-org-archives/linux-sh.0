From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 21 Sep 2015 21:59:42 +0000
Subject: [PATCH v3] pinctrl: sh-pfc: r8a7794: add VIN pin groups
Message-Id: <2210950.JhIO20W3xN@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
In-Reply-To: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Add VIN0/1 pin groups to R8A7794 PFC driver.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
[Sergei: rebased, renamed, added changelog, gathered 12 VIN1 data pins into a
single pin group, added "vin1_data10" pin group.]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- added "vin1_data10" pin group.

Changes in version 2:
- relied on the 'struct vin_data' and #define VIN_DATA_PIN_GROUP() moved to the
  common header file;
- added to the VI1_DATA8/9/10/11 pin group VI1_DATA[0-7] pins and renamed/moved
  this pin group.

 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  208 +++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
=================================--- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -2789,6 +2789,170 @@ static const unsigned int usb1_mux[] = {
 	USB1_OVC_MARK,
 };
 
+/* - VIN0 ------------------------------------------------------------------- */
+static const union vin_data vin0_data_pins = {
+	.data24 = {
+		/* B */
+		RCAR_GP_PIN(3, 1), RCAR_GP_PIN(3, 2),
+		RCAR_GP_PIN(3, 3), RCAR_GP_PIN(3, 4),
+		RCAR_GP_PIN(3, 5), RCAR_GP_PIN(3, 6),
+		RCAR_GP_PIN(3, 7), RCAR_GP_PIN(3, 8),
+		/* G */
+		RCAR_GP_PIN(3, 13), RCAR_GP_PIN(3, 14),
+		RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 16),
+		RCAR_GP_PIN(3, 17), RCAR_GP_PIN(3, 18),
+		RCAR_GP_PIN(3, 19), RCAR_GP_PIN(3, 20),
+		/* R */
+		RCAR_GP_PIN(3, 21), RCAR_GP_PIN(3, 22),
+		RCAR_GP_PIN(3, 23), RCAR_GP_PIN(3, 24),
+		RCAR_GP_PIN(3, 25), RCAR_GP_PIN(3, 26),
+		RCAR_GP_PIN(3, 27), RCAR_GP_PIN(3, 28),
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
+	RCAR_GP_PIN(3, 3), RCAR_GP_PIN(3, 4),
+	RCAR_GP_PIN(3, 5), RCAR_GP_PIN(3, 6),
+	RCAR_GP_PIN(3, 7), RCAR_GP_PIN(3, 8),
+	/* G */
+	RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 16),
+	RCAR_GP_PIN(3, 17), RCAR_GP_PIN(3, 18),
+	RCAR_GP_PIN(3, 19), RCAR_GP_PIN(3, 20),
+	/* R */
+	RCAR_GP_PIN(3, 23), RCAR_GP_PIN(3, 24),
+	RCAR_GP_PIN(3, 25), RCAR_GP_PIN(3, 26),
+	RCAR_GP_PIN(3, 27), RCAR_GP_PIN(3, 28),
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
+	RCAR_GP_PIN(3, 11), /* HSYNC */
+	RCAR_GP_PIN(3, 12), /* VSYNC */
+};
+static const unsigned int vin0_sync_mux[] = {
+	VI0_HSYNC_N_MARK,
+	VI0_VSYNC_N_MARK,
+};
+static const unsigned int vin0_field_pins[] = {
+	RCAR_GP_PIN(3, 10),
+};
+static const unsigned int vin0_field_mux[] = {
+	VI0_FIELD_MARK,
+};
+static const unsigned int vin0_clkenb_pins[] = {
+	RCAR_GP_PIN(3, 9),
+};
+static const unsigned int vin0_clkenb_mux[] = {
+	VI0_CLKENB_MARK,
+};
+static const unsigned int vin0_clk_pins[] = {
+	RCAR_GP_PIN(3, 0),
+};
+static const unsigned int vin0_clk_mux[] = {
+	VI0_CLK_MARK,
+};
+
+/* - VIN1 ----------------------------------------------------------------- */
+static const unsigned int vin1_data8_pins[] = {
+	RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
+	RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
+	RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17),
+	RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
+};
+static const unsigned int vin1_data8_mux[] = {
+	VI1_DATA0_MARK, VI1_DATA1_MARK,
+	VI1_DATA2_MARK, VI1_DATA3_MARK,
+	VI1_DATA4_MARK, VI1_DATA5_MARK,
+	VI1_DATA6_MARK, VI1_DATA7_MARK,
+};
+static const unsigned int vin1_data10_pins[] = {
+	RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
+	RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
+	RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17),
+	RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 11),
+};
+static const unsigned int vin1_data10_mux[] = {
+	VI1_DATA0_MARK, VI1_DATA1_MARK,
+	VI1_DATA2_MARK, VI1_DATA3_MARK,
+	VI1_DATA4_MARK, VI1_DATA5_MARK,
+	VI1_DATA6_MARK, VI1_DATA7_MARK,
+	VI1_DATA8_MARK, VI1_DATA9_MARK,
+};
+static const unsigned int vin1_data12_pins[] = {
+	RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
+	RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
+	RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17),
+	RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 11),
+	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
+};
+static const unsigned int vin1_data12_mux[] = {
+	VI1_DATA0_MARK, VI1_DATA1_MARK,
+	VI1_DATA2_MARK, VI1_DATA3_MARK,
+	VI1_DATA4_MARK, VI1_DATA5_MARK,
+	VI1_DATA6_MARK, VI1_DATA7_MARK,
+	VI1_DATA8_MARK, VI1_DATA9_MARK,
+	VI1_DATA10_MARK, VI1_DATA11_MARK,
+};
+static const unsigned int vin1_sync_pins[] = {
+	RCAR_GP_PIN(5, 22), /* HSYNC */
+	RCAR_GP_PIN(5, 23), /* VSYNC */
+};
+static const unsigned int vin1_sync_mux[] = {
+	VI1_HSYNC_N_MARK,
+	VI1_VSYNC_N_MARK,
+};
+static const unsigned int vin1_field_pins[] = {
+	RCAR_GP_PIN(5, 21),
+};
+static const unsigned int vin1_field_mux[] = {
+	VI1_FIELD_MARK,
+};
+static const unsigned int vin1_clkenb_pins[] = {
+	RCAR_GP_PIN(5, 20),
+};
+static const unsigned int vin1_clkenb_mux[] = {
+	VI1_CLKENB_MARK,
+};
+static const unsigned int vin1_clk_pins[] = {
+	RCAR_GP_PIN(5, 11),
+};
+static const unsigned int vin1_clk_mux[] = {
+	VI1_CLK_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(eth_link),
 	SH_PFC_PIN_GROUP(eth_magic),
@@ -2965,6 +3129,24 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(sdhi2_wp),
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
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
+	SH_PFC_PIN_GROUP(vin1_data10),
+	SH_PFC_PIN_GROUP(vin1_data12),
+	SH_PFC_PIN_GROUP(vin1_sync),
+	SH_PFC_PIN_GROUP(vin1_field),
+	SH_PFC_PIN_GROUP(vin1_clkenb),
+	SH_PFC_PIN_GROUP(vin1_clk),
 };
 
 static const char * const eth_groups[] = {
@@ -3247,6 +3429,30 @@ static const char * const usb1_groups[]
 	"usb1",
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
+	"vin1_data10",
+	"vin1_data12",
+	"vin1_sync",
+	"vin1_field",
+	"vin1_clkenb",
+	"vin1_clk",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(hscif0),
@@ -3283,6 +3489,8 @@ static const struct sh_pfc_function pinm
 	SH_PFC_FUNCTION(sdhi2),
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
+	SH_PFC_FUNCTION(vin0),
+	SH_PFC_FUNCTION(vin1),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {

