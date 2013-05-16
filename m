From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 May 2013 07:14:46 +0000
Subject: [PATCH 01/12] sh-pfc: r8a7778: add I2C pin groups
Message-Id: <87hai3wg4d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add I2C SDA/SCL pin groups to R8A7778 PFC driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index bc20083..ed78f74 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1339,6 +1339,32 @@ SH_PFC_MUX1(ether_link,		ETH_LINK);
 SH_PFC_PINS(ether_magic,	RCAR_GP_PIN(4, 20));
 SH_PFC_MUX1(ether_magic,	ETH_MAGIC);
 
+/* - I2C macro ------------------------------------------------------------- */
+#define I2C_PFC_PIN(name, args...)	SH_PFC_PINS(name, args)
+#define I2C_PFC_DAT(name, sda, scl)	SH_PFC_MUX2(name, sda, scl)
+
+/* - I2C1 ------------------------------------------------------------------ */
+I2C_PFC_PIN(i2c1_a,	RCAR_GP_PIN(3, 8),	RCAR_GP_PIN(3, 9));
+I2C_PFC_DAT(i2c1_a,	SDA1_A,			SCL1_A);
+I2C_PFC_PIN(i2c1_b,	RCAR_GP_PIN(4, 17),	RCAR_GP_PIN(4, 18));
+I2C_PFC_DAT(i2c1_b,	SDA1_B,			SCL1_B);
+
+/* - I2C2 ------------------------------------------------------------------ */
+I2C_PFC_PIN(i2c2_a,	PIN_NUMBER(3, 20),	RCAR_GP_PIN(1, 3));
+I2C_PFC_DAT(i2c2_a,	SDA2_A,			SCL2_A);
+I2C_PFC_PIN(i2c2_b,	RCAR_GP_PIN(0, 3),	RCAR_GP_PIN(0, 4));
+I2C_PFC_DAT(i2c2_b,	SDA2_B,			SCL2_B);
+I2C_PFC_PIN(i2c2_c,	RCAR_GP_PIN(4, 15),	RCAR_GP_PIN(4, 16));
+I2C_PFC_DAT(i2c2_c,	SDA2_C,			SCL2_C);
+
+/* - I2C3 ------------------------------------------------------------------ */
+I2C_PFC_PIN(i2c3_a,	RCAR_GP_PIN(1, 14),	RCAR_GP_PIN(1, 15));
+I2C_PFC_DAT(i2c3_a,	SDA3_A,			SCL3_A);
+I2C_PFC_PIN(i2c3_b,	RCAR_GP_PIN(1, 16),	RCAR_GP_PIN(1, 19));
+I2C_PFC_DAT(i2c3_b,	SDA3_B,			SCL3_B);
+I2C_PFC_PIN(i2c3_c,	RCAR_GP_PIN(1, 22),	RCAR_GP_PIN(1, 23));
+I2C_PFC_DAT(i2c3_c,	SDA3_C,			SCL3_C);
+
 /* - SCIF macro ------------------------------------------------------------- */
 #define SCIF_PFC_PIN(name, args...)	SH_PFC_PINS(name, args)
 #define SCIF_PFC_DAT(name, tx, rx)	SH_PFC_MUX2(name, tx, rx)
@@ -1573,6 +1599,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(ether_rmii),
 	SH_PFC_PIN_GROUP(ether_link),
 	SH_PFC_PIN_GROUP(ether_magic),
+	SH_PFC_PIN_GROUP(i2c1_a),
+	SH_PFC_PIN_GROUP(i2c1_b),
+	SH_PFC_PIN_GROUP(i2c2_a),
+	SH_PFC_PIN_GROUP(i2c2_b),
+	SH_PFC_PIN_GROUP(i2c2_c),
+	SH_PFC_PIN_GROUP(i2c3_a),
+	SH_PFC_PIN_GROUP(i2c3_b),
+	SH_PFC_PIN_GROUP(i2c3_c),
 	SH_PFC_PIN_GROUP(hscif0_data_a),
 	SH_PFC_PIN_GROUP(hscif0_data_b),
 	SH_PFC_PIN_GROUP(hscif0_ctrl_a),
@@ -1659,6 +1693,23 @@ static const char * const ether_groups[] = {
 	"ether_magic",
 };
 
+static const char * const i2c1_groups[] = {
+	"i2c1_a",
+	"i2c1_b",
+};
+
+static const char * const i2c2_groups[] = {
+	"i2c2_a",
+	"i2c2_b",
+	"i2c2_c",
+};
+
+static const char * const i2c3_groups[] = {
+	"i2c3_a",
+	"i2c3_b",
+	"i2c3_c",
+};
+
 static const char * const hscif0_groups[] = {
 	"hscif0_data_a",
 	"hscif0_data_b",
@@ -1788,6 +1839,9 @@ static const char * const vin1_groups[] = {
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(ether),
+	SH_PFC_FUNCTION(i2c1),
+	SH_PFC_FUNCTION(i2c2),
+	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
 	SH_PFC_FUNCTION(scif_clk),
-- 
1.7.9.5

