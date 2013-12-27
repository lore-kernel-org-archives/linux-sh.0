From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 27 Dec 2013 11:27:37 +0000
Subject: [PATCH 1/3 V2] pinctrl: sh-pfc: r8a7791: Add I2C pins
Message-Id: <1388143659-8739-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds I2C[0-4] pinmux support to R8A7791 SoC.

Changes in V2:
* None.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 196 +++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index ea02d37..654bef3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1805,6 +1805,144 @@ static const unsigned int eth_rmii_mux[] = {
 	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_RX_ER_MARK, ETH_CRS_DV_MARK,
 	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK, ETH_REFCLK_MARK,
 };
+/* - I2C0 ------------------------------------------------------------------- */
+static const unsigned int i2c0_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(0, 24), RCAR_GP_PIN(0, 25),
+};
+static const unsigned int i2c0_mux[] = {
+	SCL0_MARK, SDA0_MARK,
+};
+static const unsigned int i2c0_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 3),
+};
+static const unsigned int i2c0_b_mux[] = {
+	SCL0_B_MARK, SDA0_B_MARK,
+};
+static const unsigned int i2c0_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(0, 16), RCAR_GP_PIN(1, 1),
+};
+static const unsigned int i2c0_c_mux[] = {
+	SCL0_C_MARK, SDA0_C_MARK,
+};
+/* - I2C1 ------------------------------------------------------------------- */
+static const unsigned int i2c1_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 11),
+};
+static const unsigned int i2c1_mux[] = {
+	SCL1_MARK, SDA1_MARK,
+};
+static const unsigned int i2c1_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 5),
+};
+static const unsigned int i2c1_b_mux[] = {
+	SCL1_B_MARK, SDA1_B_MARK,
+};
+static const unsigned int i2c1_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(6, 14), RCAR_GP_PIN(6, 15),
+};
+static const unsigned int i2c1_c_mux[] = {
+	SCL1_C_MARK, SDA1_C_MARK,
+};
+static const unsigned int i2c1_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 26),
+};
+static const unsigned int i2c1_d_mux[] = {
+	SCL1_D_MARK, SDA1_D_MARK,
+};
+static const unsigned int i2c1_e_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(7, 15), RCAR_GP_PIN(7, 16),
+};
+static const unsigned int i2c1_e_mux[] = {
+	SCL1_E_MARK, SDA1_E_MARK,
+};
+/* - I2C2 ------------------------------------------------------------------- */
+static const unsigned int i2c2_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 6), RCAR_GP_PIN(2, 7),
+};
+static const unsigned int i2c2_mux[] = {
+	SCL2_MARK, SDA2_MARK,
+};
+static const unsigned int i2c2_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 26), RCAR_GP_PIN(3, 29),
+};
+static const unsigned int i2c2_b_mux[] = {
+	SCL2_B_MARK, SDA2_B_MARK,
+};
+static const unsigned int i2c2_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 14),
+};
+static const unsigned int i2c2_c_mux[] = {
+	SCL2_C_MARK, SDA2_C_MARK,
+};
+static const unsigned int i2c2_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 18),
+};
+static const unsigned int i2c2_d_mux[] = {
+	SCL2_D_MARK, SDA2_D_MARK,
+};
+/* - I2C3 ------------------------------------------------------------------- */
+static const unsigned int i2c3_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 16),
+};
+static const unsigned int i2c3_mux[] = {
+	SCL3_MARK, SDA3_MARK,
+};
+static const unsigned int i2c3_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 16),
+};
+static const unsigned int i2c3_b_mux[] = {
+	SCL3_B_MARK, SDA3_B_MARK,
+};
+static const unsigned int i2c3_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 23),
+};
+static const unsigned int i2c3_c_mux[] = {
+	SCL3_C_MARK, SDA3_C_MARK,
+};
+static const unsigned int i2c3_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28),
+};
+static const unsigned int i2c3_d_mux[] = {
+	SCL3_D_MARK, SDA3_D_MARK,
+};
+/* - I2C4 ------------------------------------------------------------------- */
+static const unsigned int i2c4_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 14),
+};
+static const unsigned int i2c4_mux[] = {
+	SCL4_MARK, SDA4_MARK,
+};
+static const unsigned int i2c4_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
+};
+static const unsigned int i2c4_b_mux[] = {
+	SCL4_B_MARK, SDA4_B_MARK,
+};
+static const unsigned int i2c4_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(7, 13), RCAR_GP_PIN(7, 14),
+};
+static const unsigned int i2c4_c_mux[] = {
+	SCL4_C_MARK, SDA4_C_MARK,
+};
 /* - INTC ------------------------------------------------------------------- */
 static const unsigned int intc_irq0_pins[] = {
 	/* IRQ */
@@ -2694,6 +2832,25 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(eth_magic),
 	SH_PFC_PIN_GROUP(eth_mdio),
 	SH_PFC_PIN_GROUP(eth_rmii),
+	SH_PFC_PIN_GROUP(i2c0),
+	SH_PFC_PIN_GROUP(i2c0_b),
+	SH_PFC_PIN_GROUP(i2c0_c),
+	SH_PFC_PIN_GROUP(i2c1),
+	SH_PFC_PIN_GROUP(i2c1_b),
+	SH_PFC_PIN_GROUP(i2c1_c),
+	SH_PFC_PIN_GROUP(i2c1_d),
+	SH_PFC_PIN_GROUP(i2c1_e),
+	SH_PFC_PIN_GROUP(i2c2),
+	SH_PFC_PIN_GROUP(i2c2_b),
+	SH_PFC_PIN_GROUP(i2c2_c),
+	SH_PFC_PIN_GROUP(i2c2_d),
+	SH_PFC_PIN_GROUP(i2c3),
+	SH_PFC_PIN_GROUP(i2c3_b),
+	SH_PFC_PIN_GROUP(i2c3_c),
+	SH_PFC_PIN_GROUP(i2c3_d),
+	SH_PFC_PIN_GROUP(i2c4),
+	SH_PFC_PIN_GROUP(i2c4_b),
+	SH_PFC_PIN_GROUP(i2c4_c),
 	SH_PFC_PIN_GROUP(intc_irq0),
 	SH_PFC_PIN_GROUP(intc_irq1),
 	SH_PFC_PIN_GROUP(intc_irq2),
@@ -2842,6 +2999,40 @@ static const char * const eth_groups[] = {
 	"eth_rmii",
 };
 
+static const char * const i2c0_groups[] = {
+	"i2c0",
+	"i2c0_b",
+	"i2c0_c",
+};
+
+static const char * const i2c1_groups[] = {
+	"i2c1",
+	"i2c1_b",
+	"i2c1_c",
+	"i2c1_d",
+	"i2c1_e",
+};
+
+static const char * const i2c2_groups[] = {
+	"i2c2",
+	"i2c2_b",
+	"i2c2_c",
+	"i2c2_d",
+};
+
+static const char * const i2c3_groups[] = {
+	"i2c3",
+	"i2c3_b",
+	"i2c3_c",
+	"i2c3_d",
+};
+
+static const char * const i2c4_groups[] = {
+	"i2c4",
+	"i2c4_b",
+	"i2c4_c",
+};
+
 static const char * const intc_groups[] = {
 	"intc_irq0",
 	"intc_irq1",
@@ -3029,6 +3220,11 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
 	SH_PFC_FUNCTION(eth),
+	SH_PFC_FUNCTION(i2c0),
+	SH_PFC_FUNCTION(i2c1),
+	SH_PFC_FUNCTION(i2c2),
+	SH_PFC_FUNCTION(i2c3),
+	SH_PFC_FUNCTION(i2c4),
 	SH_PFC_FUNCTION(intc),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(msiof0),
-- 
1.8.3.1

