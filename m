From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 29 Nov 2013 03:01:27 +0000
Subject: [PATCH 1/4] sh-pfc: r8a7790: Add SSI pin support
Message-Id: <87ob5352t7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  240 ++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 72786fc..a7fa443 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -2961,6 +2961,190 @@ static const unsigned int sdhi3_wp_pins[] = {
 static const unsigned int sdhi3_wp_mux[] = {
 	SD3_WP_MARK,
 };
+
+/* - SSI -------------------------------------------------------------------- */
+static const unsigned int ssi0_data_pins[] = {
+	/* SDATA0 */
+	RCAR_GP_PIN(4, 5),
+};
+static const unsigned int ssi0_data_mux[] = {
+	SSI_SDATA0_MARK,
+};
+static const unsigned int ssi0129_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(4, 3), RCAR_GP_PIN(4, 4),
+};
+static const unsigned int ssi0129_ctrl_mux[] = {
+	SSI_SCK0129_MARK, SSI_WS0129_MARK,
+};
+static const unsigned int ssi1_data_pins[] = {
+	/* SDATA1 */
+	RCAR_GP_PIN(4, 6),
+};
+static const unsigned int ssi1_data_mux[] = {
+	SSI_SDATA1_MARK,
+};
+static const unsigned int ssi1_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(4, 7), RCAR_GP_PIN(4, 24),
+};
+static const unsigned int ssi1_ctrl_mux[] = {
+	SSI_SCK1_MARK, SSI_WS1_MARK,
+};
+static const unsigned int ssi2_data_pins[] = {
+	/* SDATA2 */
+	RCAR_GP_PIN(4, 7),
+};
+static const unsigned int ssi2_data_mux[] = {
+	SSI_SDATA2_MARK,
+};
+static const unsigned int ssi2_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 17),
+};
+static const unsigned int ssi2_ctrl_mux[] = {
+	SSI_SCK2_MARK, SSI_WS2_MARK,
+};
+static const unsigned int ssi3_data_pins[] = {
+	/* SDATA3 */
+	RCAR_GP_PIN(4, 10),
+};
+static const unsigned int ssi3_data_mux[] = {
+	SSI_SDATA3_MARK
+};
+static const unsigned int ssi34_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(4, 8), RCAR_GP_PIN(4, 9),
+};
+static const unsigned int ssi34_ctrl_mux[] = {
+	SSI_SCK34_MARK, SSI_WS34_MARK,
+};
+static const unsigned int ssi4_data_pins[] = {
+	/* SDATA4 */
+	RCAR_GP_PIN(4, 13),
+};
+static const unsigned int ssi4_data_mux[] = {
+	SSI_SDATA4_MARK,
+};
+static const unsigned int ssi4_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
+};
+static const unsigned int ssi4_ctrl_mux[] = {
+	SSI_SCK4_MARK, SSI_WS4_MARK,
+};
+static const unsigned int ssi5_pins[] = {
+	/* SDATA5, SCK, WS */
+	RCAR_GP_PIN(4, 16), RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 15),
+};
+static const unsigned int ssi5_mux[] = {
+	SSI_SDATA5_MARK, SSI_SCK5_MARK, SSI_WS5_MARK,
+};
+static const unsigned int ssi5_b_pins[] = {
+	/* SDATA5, SCK, WS */
+	RCAR_GP_PIN(0, 26), RCAR_GP_PIN(0, 24), RCAR_GP_PIN(0, 25),
+};
+static const unsigned int ssi5_b_mux[] = {
+	SSI_SDATA5_B_MARK, SSI_SCK5_B_MARK, SSI_WS5_B_MARK
+};
+static const unsigned int ssi5_c_pins[] = {
+	/* SDATA5, SCK, WS */
+	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
+};
+static const unsigned int ssi5_c_mux[] = {
+	SSI_SDATA5_C_MARK, SSI_SCK5_C_MARK, SSI_WS5_C_MARK,
+};
+static const unsigned int ssi6_pins[] = {
+	/* SDATA6, SCK, WS */
+	RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 18),
+};
+static const unsigned int ssi6_mux[] = {
+	SSI_SDATA6_MARK, SSI_SCK6_MARK, SSI_WS6_MARK,
+};
+static const unsigned int ssi6_b_pins[] = {
+	/* SDATA6, SCK, WS */
+	RCAR_GP_PIN(1, 29), RCAR_GP_PIN(1, 25), RCAR_GP_PIN(1, 27),
+};
+static const unsigned int ssi6_b_mux[] = {
+	SSI_SDATA6_B_MARK, SSI_SCK6_B_MARK, SSI_WS6_B_MARK,
+};
+static const unsigned int ssi7_data_pins[] = {
+	/* SDATA7 */
+	RCAR_GP_PIN(4, 22),
+};
+static const unsigned int ssi7_data_mux[] = {
+	SSI_SDATA7_MARK,
+};
+static const unsigned int ssi7_b_data_pins[] = {
+	/* SDATA7 */
+	RCAR_GP_PIN(4, 22),
+};
+static const unsigned int ssi7_b_data_mux[] = {
+	SSI_SDATA7_B_MARK,
+};
+static const unsigned int ssi7_c_data_pins[] = {
+	/* SDATA7 */
+	RCAR_GP_PIN(1, 26),
+};
+static const unsigned int ssi7_c_data_mux[] = {
+	SSI_SDATA7_C_MARK,
+};
+static const unsigned int ssi78_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(4, 20), RCAR_GP_PIN(4, 21),
+};
+static const unsigned int ssi78_ctrl_mux[] = {
+	SSI_SCK78_MARK, SSI_WS78_MARK,
+};
+static const unsigned int ssi78_b_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(1, 26), RCAR_GP_PIN(1, 24),
+};
+static const unsigned int ssi78_b_ctrl_mux[] = {
+	SSI_SCK78_B_MARK, SSI_WS78_B_MARK,
+};
+static const unsigned int ssi78_c_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(1, 24), RCAR_GP_PIN(1, 25),
+};
+static const unsigned int ssi78_c_ctrl_mux[] = {
+	SSI_SCK78_C_MARK, SSI_WS78_C_MARK,
+};
+static const unsigned int ssi8_data_pins[] = {
+	/* SDATA8 */
+	RCAR_GP_PIN(4, 23),
+};
+static const unsigned int ssi8_data_mux[] = {
+	SSI_SDATA8_MARK,
+};
+static const unsigned int ssi8_b_data_pins[] = {
+	/* SDATA8 */
+	RCAR_GP_PIN(4, 23),
+};
+static const unsigned int ssi8_b_data_mux[] = {
+	SSI_SDATA8_B_MARK,
+};
+static const unsigned int ssi8_c_data_pins[] = {
+	/* SDATA8 */
+	RCAR_GP_PIN(1, 27),
+};
+static const unsigned int ssi8_c_data_mux[] = {
+	SSI_SDATA8_C_MARK,
+};
+static const unsigned int ssi9_data_pins[] = {
+	/* SDATA9 */
+	RCAR_GP_PIN(4, 24),
+};
+static const unsigned int ssi9_data_mux[] = {
+	SSI_SDATA9_MARK,
+};
+static const unsigned int ssi9_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(5, 10), RCAR_GP_PIN(5, 11),
+};
+static const unsigned int ssi9_ctrl_mux[] = {
+	SSI_SCK9_MARK, SSI_WS9_MARK,
+};
 /* - TPU0 ------------------------------------------------------------------- */
 static const unsigned int tpu0_to0_pins[] = {
 	/* TO */
@@ -3259,6 +3443,32 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi3_ctrl),
 	SH_PFC_PIN_GROUP(sdhi3_cd),
 	SH_PFC_PIN_GROUP(sdhi3_wp),
+	SH_PFC_PIN_GROUP(ssi0_data),
+	SH_PFC_PIN_GROUP(ssi0129_ctrl),
+	SH_PFC_PIN_GROUP(ssi1_data),
+	SH_PFC_PIN_GROUP(ssi1_ctrl),
+	SH_PFC_PIN_GROUP(ssi2_data),
+	SH_PFC_PIN_GROUP(ssi2_ctrl),
+	SH_PFC_PIN_GROUP(ssi3_data),
+	SH_PFC_PIN_GROUP(ssi34_ctrl),
+	SH_PFC_PIN_GROUP(ssi4_data),
+	SH_PFC_PIN_GROUP(ssi4_ctrl),
+	SH_PFC_PIN_GROUP(ssi5),
+	SH_PFC_PIN_GROUP(ssi5_b),
+	SH_PFC_PIN_GROUP(ssi5_c),
+	SH_PFC_PIN_GROUP(ssi6),
+	SH_PFC_PIN_GROUP(ssi6_b),
+	SH_PFC_PIN_GROUP(ssi7_data),
+	SH_PFC_PIN_GROUP(ssi7_b_data),
+	SH_PFC_PIN_GROUP(ssi7_c_data),
+	SH_PFC_PIN_GROUP(ssi78_ctrl),
+	SH_PFC_PIN_GROUP(ssi78_b_ctrl),
+	SH_PFC_PIN_GROUP(ssi78_c_ctrl),
+	SH_PFC_PIN_GROUP(ssi8_data),
+	SH_PFC_PIN_GROUP(ssi8_b_data),
+	SH_PFC_PIN_GROUP(ssi8_c_data),
+	SH_PFC_PIN_GROUP(ssi9_data),
+	SH_PFC_PIN_GROUP(ssi9_ctrl),
 	SH_PFC_PIN_GROUP(tpu0_to0),
 	SH_PFC_PIN_GROUP(tpu0_to1),
 	SH_PFC_PIN_GROUP(tpu0_to2),
@@ -3533,6 +3743,35 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_wp",
 };
 
+static const char * const ssi_groups[] = {
+	"ssi0_data",
+	"ssi0129_ctrl",
+	"ssi1_data",
+	"ssi1_ctrl",
+	"ssi2_data",
+	"ssi2_ctrl",
+	"ssi3_data",
+	"ssi34_ctrl",
+	"ssi4_data",
+	"ssi4_ctrl",
+	"ssi5",
+	"ssi5_b",
+	"ssi5_c",
+	"ssi6",
+	"ssi6_b",
+	"ssi7_data",
+	"ssi7_b_data",
+	"ssi7_c_data",
+	"ssi78_ctrl",
+	"ssi78_b_ctrl",
+	"ssi78_c_ctrl",
+	"ssi8_data",
+	"ssi8_b_data",
+	"ssi8_c_data",
+	"ssi9_data",
+	"ssi9_ctrl",
+};
+
 static const char * const tpu0_groups[] = {
 	"tpu0_to0",
 	"tpu0_to1",
@@ -3599,6 +3838,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
 	SH_PFC_FUNCTION(sdhi3),
+	SH_PFC_FUNCTION(ssi),
 	SH_PFC_FUNCTION(tpu0),
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
-- 
1.7.9.5

