From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:24 +0000
Subject: [PATCH v3 04/64] sh-pfc: sh73a0: Add I2C2 and I2C3 pin groups and functions
Message-Id: <1362740544-19164-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 09c2501..2dc58e2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1550,6 +1550,50 @@ static struct pinmux_range pinmux_ranges[] = {
 	{.begin = 288, .end = 309,},
 };
 
+static const unsigned int i2c2_0_pins[] = {
+	/* SCL, SDA */
+	237, 236,
+};
+static const unsigned int i2c2_0_mux[] = {
+	PORT237_I2C_SCL2_MARK, PORT236_I2C_SDA2_MARK,
+};
+static const unsigned int i2c2_1_pins[] = {
+	/* SCL, SDA */
+	27, 28,
+};
+static const unsigned int i2c2_1_mux[] = {
+	PORT27_I2C_SCL2_MARK, PORT28_I2C_SDA2_MARK,
+};
+static const unsigned int i2c2_2_pins[] = {
+	/* SCL, SDA */
+	115, 116,
+};
+static const unsigned int i2c2_2_mux[] = {
+	PORT115_I2C_SCL2_MARK, PORT116_I2C_SDA2_MARK,
+};
+
+static const unsigned int i2c3_0_pins[] = {
+	/* SCL, SDA */
+	248, 249,
+};
+static const unsigned int i2c3_0_mux[] = {
+	PORT248_I2C_SCL3_MARK, PORT249_I2C_SDA3_MARK,
+};
+static const unsigned int i2c3_1_pins[] = {
+	/* SCL, SDA */
+	27, 28,
+};
+static const unsigned int i2c3_1_mux[] = {
+	PORT27_I2C_SCL3_MARK, PORT28_I2C_SDA3_MARK,
+};
+static const unsigned int i2c3_2_pins[] = {
+	/* SCL, SDA */
+	115, 116,
+};
+static const unsigned int i2c3_2_mux[] = {
+	PORT115_I2C_SCL3_MARK, PORT116_I2C_SDA3_MARK,
+};
+
 static const unsigned int lcd_data8_pins[] = {
 	/* D[0:7] */
 	192, 193, 194, 195, 196, 197, 198, 199,
@@ -1993,6 +2037,12 @@ static const unsigned int scifb_ctrl_1_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(i2c2_0),
+	SH_PFC_PIN_GROUP(i2c2_1),
+	SH_PFC_PIN_GROUP(i2c2_2),
+	SH_PFC_PIN_GROUP(i2c3_0),
+	SH_PFC_PIN_GROUP(i2c3_1),
+	SH_PFC_PIN_GROUP(i2c3_2),
 	SH_PFC_PIN_GROUP(lcd_data8),
 	SH_PFC_PIN_GROUP(lcd_data9),
 	SH_PFC_PIN_GROUP(lcd_data12),
@@ -2049,6 +2099,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb_ctrl_1),
 };
 
+static const char * const i2c2_groups[] = {
+	"i2c2_0",
+	"i2c2_1",
+	"i2c2_2",
+};
+
+static const char * const i2c3_groups[] = {
+	"i2c3_0",
+	"i2c3_1",
+	"i2c3_2",
+};
+
 static const char * const lcd_groups[] = {
 	"lcd_data8",
 	"lcd_data9",
@@ -2137,6 +2199,8 @@ static const char * const scifb_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(i2c2),
+	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(lcd),
 	SH_PFC_FUNCTION(lcd2),
 	SH_PFC_FUNCTION(scifa0),
-- 
1.8.1.5

