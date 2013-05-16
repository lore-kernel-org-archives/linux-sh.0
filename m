From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 May 2013 07:14:56 +0000
Subject: [PATCH 02/12] sh-pfc: r8a7778: add HSPI pin groups
Message-Id: <87fvxnwg43.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add HSPI CLK/CS/RX/TX pin groups to R8A7778 PFC driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index ed78f74..137dd59 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1365,6 +1365,43 @@ I2C_PFC_DAT(i2c3_b,	SDA3_B,			SCL3_B);
 I2C_PFC_PIN(i2c3_c,	RCAR_GP_PIN(1, 22),	RCAR_GP_PIN(1, 23));
 I2C_PFC_DAT(i2c3_c,	SDA3_C,			SCL3_C);
 
+/* - HSPI macro --------------------------------------------------------------*/
+#define HSPI_PFC_PIN(name, args...)		SH_PFC_PINS(name, args)
+#define HSPI_PFC_DAT(name, clk, cs, rx, tx)	SH_PFC_MUX4(name, clk, cs, rx, tx)
+
+/* - HSPI0 -------------------------------------------------------------------*/
+HSPI_PFC_PIN(hspi0_a,	RCAR_GP_PIN(3, 19),	RCAR_GP_PIN(3, 20),
+			RCAR_GP_PIN(3, 21),	RCAR_GP_PIN(3, 22));
+HSPI_PFC_DAT(hspi0_a,	HSPI_CLK0_A,		HSPI_CS0_A,
+			HSPI_RX0_A,		HSPI_TX0);
+
+HSPI_PFC_PIN(hspi0_b,	RCAR_GP_PIN(2, 25),	RCAR_GP_PIN(2, 26),
+			RCAR_GP_PIN(2, 24),	RCAR_GP_PIN(2, 27));
+HSPI_PFC_DAT(hspi0_b,	HSPI_CLK0_B,		HSPI_CS0_B,
+			HSPI_RX0_B,		HSPI_TX0_B);
+
+/* - HSPI1 -------------------------------------------------------------------*/
+HSPI_PFC_PIN(hspi1_a,	RCAR_GP_PIN(3, 26),	RCAR_GP_PIN(3, 27),
+			RCAR_GP_PIN(3, 25),	RCAR_GP_PIN(3, 28));
+HSPI_PFC_DAT(hspi1_a,	HSPI_CLK1_A,		HSPI_CS1_A,
+			HSPI_RX1_A,		HSPI_TX1_A);
+
+HSPI_PFC_PIN(hspi1_b,	RCAR_GP_PIN(0, 27),	RCAR_GP_PIN(0, 26),
+			PIN_NUMBER(20, 1),	PIN_NUMBER(25, 2));
+HSPI_PFC_DAT(hspi1_b,	HSPI_CLK1_B,		HSPI_CS1_B,
+			HSPI_RX1_B,		HSPI_TX1_B);
+
+/* - HSPI2 -------------------------------------------------------------------*/
+HSPI_PFC_PIN(hspi2_a,	RCAR_GP_PIN(2, 29),	RCAR_GP_PIN(3, 8),
+			RCAR_GP_PIN(2, 28),	RCAR_GP_PIN(2, 30));
+HSPI_PFC_DAT(hspi2_a,	HSPI_CLK2_A,		HSPI_CS2_A,
+			HSPI_RX2_A,		HSPI_TX2_A);
+
+HSPI_PFC_PIN(hspi2_b,	RCAR_GP_PIN(4, 21),	RCAR_GP_PIN(4, 22),
+			RCAR_GP_PIN(4, 23),	RCAR_GP_PIN(4, 24));
+HSPI_PFC_DAT(hspi2_b,	HSPI_CLK2_B,		HSPI_CS2_B,
+			HSPI_RX2_B,		HSPI_TX2_B);
+
 /* - SCIF macro ------------------------------------------------------------- */
 #define SCIF_PFC_PIN(name, args...)	SH_PFC_PINS(name, args)
 #define SCIF_PFC_DAT(name, tx, rx)	SH_PFC_MUX2(name, tx, rx)
@@ -1607,6 +1644,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c3_a),
 	SH_PFC_PIN_GROUP(i2c3_b),
 	SH_PFC_PIN_GROUP(i2c3_c),
+	SH_PFC_PIN_GROUP(hspi0_a),
+	SH_PFC_PIN_GROUP(hspi0_b),
+	SH_PFC_PIN_GROUP(hspi1_a),
+	SH_PFC_PIN_GROUP(hspi1_b),
+	SH_PFC_PIN_GROUP(hspi2_a),
+	SH_PFC_PIN_GROUP(hspi2_b),
 	SH_PFC_PIN_GROUP(hscif0_data_a),
 	SH_PFC_PIN_GROUP(hscif0_data_b),
 	SH_PFC_PIN_GROUP(hscif0_ctrl_a),
@@ -1710,6 +1753,21 @@ static const char * const i2c3_groups[] = {
 	"i2c3_c",
 };
 
+static const char * const hspi0_groups[] = {
+	"hspi0_a",
+	"hspi0_b",
+};
+
+static const char * const hspi1_groups[] = {
+	"hspi1_a",
+	"hspi1_b",
+};
+
+static const char * const hspi2_groups[] = {
+	"hspi2_a",
+	"hspi2_b",
+};
+
 static const char * const hscif0_groups[] = {
 	"hscif0_data_a",
 	"hscif0_data_b",
@@ -1842,6 +1900,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c1),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
+	SH_PFC_FUNCTION(hspi0),
+	SH_PFC_FUNCTION(hspi1),
+	SH_PFC_FUNCTION(hspi2),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
 	SH_PFC_FUNCTION(scif_clk),
-- 
1.7.9.5

