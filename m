From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 30 Aug 2013 12:37:41 +0000
Subject: [RFC 07/10] ARM: shmobile: r8a7790: i2c pinmux
Message-Id: <1377866264-21110-8-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds pinmux for i2c bus 1 and 2. (Pins for 0 and 3 are not multiplexed.)

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 90 ++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 95b38fa..aebbbd7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -1800,6 +1800,72 @@ static const unsigned int eth_rmii_mux[] = {
 	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_RX_ER_MARK, ETH_CRS_DV_MARK,
 	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK, ETH_REF_CLK_MARK,
 };
+
+/* - I2C -------------------------------------------------------------------- */
+static const unsigned int i2c1_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(1, 16), RCAR_GP_PIN(1, 17),
+};
+static const unsigned int i2c1_mux[] = {
+	SCL1_CIS_MARK, SDA1_CIS_MARK,
+};
+
+static const unsigned int i2c1_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 6), RCAR_GP_PIN(3, 7),
+};
+static const unsigned int i2c1_b_mux[] = {
+	SCL1_CIS_B_MARK, SDA1_CIS_B_MARK,
+};
+
+static const unsigned int i2c1_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 30), RCAR_GP_PIN(4, 27),
+};
+static const unsigned int i2c1_c_mux[] = {
+	SCL1_CIS_C_MARK, SDA1_CIS_C_MARK,
+};
+
+static const unsigned int i2c2_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
+};
+static const unsigned int i2c2_mux[] = {
+	SCL2_CIS_MARK, SDA2_CIS_MARK,
+};
+
+static const unsigned int i2c2_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(4, 1),
+};
+static const unsigned int i2c2_b_mux[] = {
+	SCL2_CIS_B_MARK, SDA2_CIS_B_MARK,
+};
+
+static const unsigned int i2c2_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+};
+static const unsigned int i2c2_c_mux[] = {
+	SCL2_CIS_C_MARK, SDA2_CIS_C_MARK,
+};
+
+static const unsigned int i2c2_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
+};
+static const unsigned int i2c2_d_mux[] = {
+	SCL2_CIS_D_MARK, SDA2_CIS_D_MARK,
+};
+
+static const unsigned int i2c2_e_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 18), RCAR_GP_PIN(2, 19),
+};
+static const unsigned int i2c2_e_mux[] = {
+	SCL2_CIS_E_MARK, SDA2_CIS_E_MARK,
+};
+
 /* - INTC ------------------------------------------------------------------- */
 static const unsigned int intc_irq0_pins[] = {
 	/* IRQ */
@@ -2686,6 +2752,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(hscif1_data_b),
 	SH_PFC_PIN_GROUP(hscif1_clk_b),
 	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
+	SH_PFC_PIN_GROUP(i2c1),
+	SH_PFC_PIN_GROUP(i2c1_b),
+	SH_PFC_PIN_GROUP(i2c1_c),
+	SH_PFC_PIN_GROUP(i2c2),
+	SH_PFC_PIN_GROUP(i2c2_b),
+	SH_PFC_PIN_GROUP(i2c2_c),
+	SH_PFC_PIN_GROUP(i2c2_d),
+	SH_PFC_PIN_GROUP(i2c2_e),
 	SH_PFC_PIN_GROUP(intc_irq0),
 	SH_PFC_PIN_GROUP(intc_irq1),
 	SH_PFC_PIN_GROUP(intc_irq2),
@@ -2795,6 +2869,20 @@ static const char * const eth_groups[] = {
 	"eth_rmii",
 };
 
+static const char * const i2c1_groups[] = {
+	"i2c1",
+	"i2c1_b",
+	"i2c1_c",
+};
+
+static const char * const i2c2_groups[] = {
+	"i2c2",
+	"i2c2_b",
+	"i2c2_c",
+	"i2c2_d",
+	"i2c2_e",
+};
+
 static const char * const intc_groups[] = {
 	"intc_irq0",
 	"intc_irq1",
@@ -2972,6 +3060,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
+	SH_PFC_FUNCTION(i2c1),
+	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(intc),
 	SH_PFC_FUNCTION(mmc0),
 	SH_PFC_FUNCTION(mmc1),
-- 
1.8.1.4

