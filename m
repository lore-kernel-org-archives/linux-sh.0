From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 30 Jun 2014 22:11:22 +0000
Subject: [PATCH] sh-pfc: r8a7791: add CAN pin groups
Message-Id: <201407010211.23665.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add CAN0/1 data/clock pin groups to R8A7791 PFC driver.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  153 +++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1726,6 +1726,119 @@ static const unsigned int audio_clkout_m
 	AUDIO_CLKOUT_MARK,
 };
 
+/* - CAN -------------------------------------------------------------------- */
+
+static const unsigned int can0_data_a_pins[] = {
+	RCAR_GP_PIN(3, 26), RCAR_GP_PIN(3, 29),
+};
+
+static const unsigned int can0_data_a_mux[] = {
+	CAN0_TX_MARK, CAN0_RX_MARK,
+};
+
+static const unsigned int can0_data_b_pins[] = {
+	RCAR_GP_PIN(7, 4), RCAR_GP_PIN(7, 3),
+};
+
+static const unsigned int can0_data_b_mux[] = {
+	CAN0_TX_B_MARK, CAN0_RX_B_MARK,
+};
+
+static const unsigned int can0_data_c_pins[] = {
+	RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 18),
+};
+
+static const unsigned int can0_data_c_mux[] = {
+	CAN0_TX_C_MARK,	CAN0_RX_C_MARK,
+};
+
+static const unsigned int can0_data_d_pins[] = {
+	RCAR_GP_PIN(2, 26), RCAR_GP_PIN(2, 27),
+};
+
+static const unsigned int can0_data_d_mux[] = {
+	CAN0_TX_D_MARK, CAN0_RX_D_MARK,
+};
+
+static const unsigned int can0_data_e_pins[] = {
+	RCAR_GP_PIN(4, 18), RCAR_GP_PIN(4, 28),
+};
+
+static const unsigned int can0_data_e_mux[] = {
+	CAN0_TX_E_MARK, CAN0_RX_E_MARK,
+};
+
+static const unsigned int can0_data_f_pins[] = {
+	RCAR_GP_PIN(6, 7), RCAR_GP_PIN(6, 6),
+};
+
+static const unsigned int can0_data_f_mux[] = {
+	CAN0_TX_F_MARK, CAN0_RX_F_MARK,
+};
+
+static const unsigned int can1_data_a_pins[] = {
+	 RCAR_GP_PIN(3, 21), RCAR_GP_PIN(3, 20),
+};
+
+static const unsigned int can1_data_a_mux[] = {
+	CAN1_TX_MARK, CAN1_RX_MARK,
+};
+
+static const unsigned int can1_data_b_pins[] = {
+	RCAR_GP_PIN(7, 8), RCAR_GP_PIN(7, 9),
+};
+
+static const unsigned int can1_data_b_mux[] = {
+	CAN1_TX_B_MARK, CAN1_RX_B_MARK,
+};
+
+static const unsigned int can1_data_c_pins[] = {
+	RCAR_GP_PIN(5, 20), RCAR_GP_PIN(5, 19),
+};
+
+static const unsigned int can1_data_c_mux[] = {
+	CAN1_TX_C_MARK, CAN1_RX_C_MARK,
+};
+
+static const unsigned int can1_data_d_pins[] = {
+	 RCAR_GP_PIN(4, 29), RCAR_GP_PIN(4, 31),
+};
+
+static const unsigned int can1_data_d_mux[] = {
+	CAN1_TX_D_MARK, CAN1_RX_D_MARK,
+};
+
+static const unsigned int can_clk_a_pins[] = {
+	RCAR_GP_PIN(7, 2),
+};
+
+static const unsigned int can_clk_a_mux[] = {
+	CAN_CLK_MARK,
+};
+
+static const unsigned int can_clk_b_pins[] = {
+	RCAR_GP_PIN(5, 21),
+};
+
+static const unsigned int can_clk_b_mux[] = {
+	CAN_CLK_B_MARK,
+};
+
+static const unsigned int can_clk_c_pins[] = {
+	RCAR_GP_PIN(4, 31),
+};
+
+static const unsigned int can_clk_c_mux[] = {
+	CAN_CLK_C_MARK,
+};
+
+static const unsigned int can_clk_d_pins[] = {
+	RCAR_GP_PIN(7, 19),
+};
+
+static const unsigned int can_clk_d_mux[] = {
+	CAN_CLK_D_MARK,
+};
 
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
@@ -4055,6 +4168,20 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(audio_clk_b_b),
 	SH_PFC_PIN_GROUP(audio_clk_c),
 	SH_PFC_PIN_GROUP(audio_clkout),
+	SH_PFC_PIN_GROUP(can0_data_a),
+	SH_PFC_PIN_GROUP(can0_data_b),
+	SH_PFC_PIN_GROUP(can0_data_c),
+	SH_PFC_PIN_GROUP(can0_data_d),
+	SH_PFC_PIN_GROUP(can0_data_e),
+	SH_PFC_PIN_GROUP(can0_data_f),
+	SH_PFC_PIN_GROUP(can1_data_a),
+	SH_PFC_PIN_GROUP(can1_data_b),
+	SH_PFC_PIN_GROUP(can1_data_c),
+	SH_PFC_PIN_GROUP(can1_data_d),
+	SH_PFC_PIN_GROUP(can_clk_a),
+	SH_PFC_PIN_GROUP(can_clk_b),
+	SH_PFC_PIN_GROUP(can_clk_c),
+	SH_PFC_PIN_GROUP(can_clk_d),
 	SH_PFC_PIN_GROUP(du_rgb666),
 	SH_PFC_PIN_GROUP(du_rgb888),
 	SH_PFC_PIN_GROUP(du_clk_out_0),
@@ -4367,6 +4494,30 @@ static const char * const audio_clk_grou
 	"audio_clkout",
 };
 
+static const char * const can0_groups[] = {
+	"can0_data_a",
+	"can0_data_b",
+	"can0_data_c",
+	"can0_data_d",
+	"can0_data_e",
+	"can0_data_f",
+	"can_clk_a",
+	"can_clk_b",
+	"can_clk_c",
+	"can_clk_d",
+};
+
+static const char * const can1_groups[] = {
+	"can1_data_a",
+	"can1_data_b",
+	"can1_data_c",
+	"can1_data_d",
+	"can_clk_a",
+	"can_clk_b",
+	"can_clk_c",
+	"can_clk_d",
+};
+
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4790,6 +4941,8 @@ static const char * const vin2_groups[] 
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
+	SH_PFC_FUNCTION(can0),
+	SH_PFC_FUNCTION(can1),
 	SH_PFC_FUNCTION(du),
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
