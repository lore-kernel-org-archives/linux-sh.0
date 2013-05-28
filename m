From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 28 May 2013 12:22:06 +0000
Subject: [PATCH 3/5] sh-pfc: r8a7790: add HSCIF pin groups
Message-Id: <1369743728-26084-4-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds HSCIF data/clk/ctrl groups to R8A7790 PFC driver.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  181 ++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 85d77a4..4067cd7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -1979,6 +1979,141 @@ static const unsigned int scif1_clk_e_pins[] = {
 static const unsigned int scif1_clk_e_mux[] = {
 	SCK1_E_MARK,
 };
+/* - HSCIF0 ----------------------------------------------------------------- */
+static const unsigned int hscif0_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 9),
+};
+static const unsigned int hscif0_data_mux[] = {
+	HRX0_MARK, HTX0_MARK,
+};
+static const unsigned int hscif0_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 7),
+};
+static const unsigned int hscif0_clk_mux[] = {
+	HSCK0_MARK,
+};
+static const unsigned int hscif0_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 10),
+};
+static const unsigned int hscif0_ctrl_mux[] = {
+	HRTS0_N_MARK, HCTS0_N_MARK,
+};
+static const unsigned int hscif0_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 23), RCAR_GP_PIN(1, 12),
+};
+static const unsigned int hscif0_data_b_mux[] = {
+	HRX0_B_MARK, HTX0_B_MARK,
+};
+static const unsigned int hscif0_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(1, 29), RCAR_GP_PIN(1, 28),
+};
+static const unsigned int hscif0_ctrl_b_mux[] = {
+	HRTS0_N_B_MARK, HCTS0_N_B_MARK,
+};
+static const unsigned int hscif0_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 16),
+};
+static const unsigned int hscif0_data_c_mux[] = {
+	HRX0_C_MARK, HTX0_C_MARK,
+};
+static const unsigned int hscif0_ctrl_c_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(5, 3), RCAR_GP_PIN(5, 7),
+};
+static const unsigned int hscif0_ctrl_c_mux[] = {
+	HRTS0_N_C_MARK, HCTS0_N_C_MARK,
+};
+static const unsigned int hscif0_data_d_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(3, 20), RCAR_GP_PIN(3, 21),
+};
+static const unsigned int hscif0_data_d_mux[] = {
+	HRX0_D_MARK, HTX0_D_MARK,
+};
+static const unsigned int hscif0_ctrl_d_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(3, 23), RCAR_GP_PIN(3, 22),
+};
+static const unsigned int hscif0_ctrl_d_mux[] = {
+	HRTS0_N_D_MARK, HCTS0_N_D_MARK,
+};
+static const unsigned int hscif0_data_e_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 21), RCAR_GP_PIN(2, 22),
+};
+static const unsigned int hscif0_data_e_mux[] = {
+	HRX0_E_MARK, HTX0_E_MARK,
+};
+static const unsigned int hscif0_ctrl_e_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(2, 24), RCAR_GP_PIN(2, 23),
+};
+static const unsigned int hscif0_ctrl_e_mux[] = {
+	HRTS0_N_E_MARK, HCTS0_N_E_MARK,
+};
+static const unsigned int hscif0_data_f_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(2, 25),
+};
+static const unsigned int hscif0_data_f_mux[] = {
+	HRX0_F_MARK, HTX0_F_MARK,
+};
+static const unsigned int hscif0_ctrl_f_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(2, 26), RCAR_GP_PIN(2, 24),
+};
+static const unsigned int hscif0_ctrl_f_mux[] = {
+	HRTS0_N_F_MARK, HCTS0_N_F_MARK,
+};
+/* - HSCIF1 ----------------------------------------------------------------- */
+static const unsigned int hscif1_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 29),
+};
+static const unsigned int hscif1_data_mux[] = {
+	HRX1_MARK, HTX1_MARK,
+};
+static const unsigned int hscif1_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(4, 27),
+};
+static const unsigned int hscif1_clk_mux[] = {
+	HSCK1_MARK,
+};
+static const unsigned int hscif1_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(4, 31), RCAR_GP_PIN(4, 30),
+};
+static const unsigned int hscif1_ctrl_mux[] = {
+	HRTS1_N_MARK, HCTS1_N_MARK,
+};
+static const unsigned int hscif1_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 18),
+};
+static const unsigned int hscif1_data_b_mux[] = {
+	HRX1_B_MARK, HTX1_B_MARK,
+};
+static const unsigned int hscif1_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 28),
+};
+static const unsigned int hscif1_clk_b_mux[] = {
+	HSCK1_B_MARK,
+};
+static const unsigned int hscif1_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 13),
+};
+static const unsigned int hscif1_ctrl_b_mux[] = {
+	HRTS1_N_B_MARK, HCTS1_N_B_MARK,
+};
 /* - SCIFA0 ----------------------------------------------------------------- */
 static const unsigned int scifa0_data_pins[] = {
 	/* RXD, TXD */
@@ -2608,6 +2743,25 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif1_clk_d),
 	SH_PFC_PIN_GROUP(scif1_data_e),
 	SH_PFC_PIN_GROUP(scif1_clk_e),
+	SH_PFC_PIN_GROUP(hscif0_data),
+	SH_PFC_PIN_GROUP(hscif0_clk),
+	SH_PFC_PIN_GROUP(hscif0_ctrl),
+	SH_PFC_PIN_GROUP(hscif0_data_b),
+	SH_PFC_PIN_GROUP(hscif0_ctrl_b),
+	SH_PFC_PIN_GROUP(hscif0_data_c),
+	SH_PFC_PIN_GROUP(hscif0_ctrl_c),
+	SH_PFC_PIN_GROUP(hscif0_data_d),
+	SH_PFC_PIN_GROUP(hscif0_ctrl_d),
+	SH_PFC_PIN_GROUP(hscif0_data_e),
+	SH_PFC_PIN_GROUP(hscif0_ctrl_e),
+	SH_PFC_PIN_GROUP(hscif0_data_f),
+	SH_PFC_PIN_GROUP(hscif0_ctrl_f),
+	SH_PFC_PIN_GROUP(hscif1_data),
+	SH_PFC_PIN_GROUP(hscif1_clk),
+	SH_PFC_PIN_GROUP(hscif1_ctrl),
+	SH_PFC_PIN_GROUP(hscif1_data_b),
+	SH_PFC_PIN_GROUP(hscif1_clk_b),
+	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
 	SH_PFC_PIN_GROUP(scifa0_data),
 	SH_PFC_PIN_GROUP(scifa0_clk),
 	SH_PFC_PIN_GROUP(scifa0_ctrl),
@@ -2726,6 +2880,31 @@ static const char * const scif1_groups[] = {
 	"scif1_clk_e",
 };
 
+static const char * const hscif0_groups[] = {
+	"hscif0_data",
+	"hscif0_clk",
+	"hscif0_ctrl",
+	"hscif0_data_b",
+	"hscif0_ctrl_b",
+	"hscif0_data_c",
+	"hscif0_ctrl_c",
+	"hscif0_data_d",
+	"hscif0_ctrl_d",
+	"hscif0_data_e",
+	"hscif0_ctrl_e",
+	"hscif0_data_f",
+	"hscif0_ctrl_f",
+};
+
+static const char * const hscif1_groups[] = {
+	"hscif1_data",
+	"hscif1_clk",
+	"hscif1_ctrl",
+	"hscif1_data_b",
+	"hscif1_clk_b",
+	"hscif1_ctrl_b",
+};
+
 static const char * const scifa0_groups[] = {
 	"scifa0_data",
 	"scifa0_clk",
@@ -2853,6 +3032,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(intc),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
+	SH_PFC_FUNCTION(hscif0),
+	SH_PFC_FUNCTION(hscif1),
 	SH_PFC_FUNCTION(scifa0),
 	SH_PFC_FUNCTION(scifa1),
 	SH_PFC_FUNCTION(scifa2),
-- 
1.7.10.4

