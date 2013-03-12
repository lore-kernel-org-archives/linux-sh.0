From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 12 Mar 2013 15:48:30 +0000
Subject: [PATCH v3.1 4/4] sh-pfc: sh73a0: Add IrDA pin groups and functions
Message-Id: <1363103310-16260-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index f5fa2be..e2a37d3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1874,6 +1874,21 @@ static const unsigned int i2c3_2_mux[] = {
 	PORT115_I2C_SCL3_MARK, PORT116_I2C_SDA3_MARK,
 };
 
+static const unsigned int irda_0_pins[] = {
+	/* OUT, IN, FIRSEL */
+	241, 242, 243,
+};
+static const unsigned int irda_0_mux[] = {
+	PORT241_IRDA_OUT_MARK, PORT242_IRDA_IN_MARK, PORT243_IRDA_FIRSEL_MARK,
+};
+static const unsigned int irda_1_pins[] = {
+	/* OUT, IN, FIRSEL */
+	49, 53, 54,
+};
+static const unsigned int irda_1_mux[] = {
+	PORT49_IRDA_OUT_MARK, PORT53_IRDA_IN_MARK, PORT54_IRDA_FIRSEL_MARK,
+};
+
 static const unsigned int keysc_in5_pins[] = {
 	/* KEYIN[0:4] */
 	66, 67, 68, 69, 70,
@@ -2668,6 +2683,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c3_0),
 	SH_PFC_PIN_GROUP(i2c3_1),
 	SH_PFC_PIN_GROUP(i2c3_2),
+	SH_PFC_PIN_GROUP(irda_0),
+	SH_PFC_PIN_GROUP(irda_1),
 	SH_PFC_PIN_GROUP(keysc_in5),
 	SH_PFC_PIN_GROUP(keysc_in6),
 	SH_PFC_PIN_GROUP(keysc_in7),
@@ -2830,6 +2847,11 @@ static const char * const i2c3_groups[] = {
 	"i2c3_2",
 };
 
+static const char * const irda_groups[] = {
+	"irda_0",
+	"irda_1",
+};
+
 static const char * const keysc_groups[] = {
 	"keysc_in5",
 	"keysc_in6",
@@ -2985,6 +3007,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(fsid),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
+	SH_PFC_FUNCTION(irda),
 	SH_PFC_FUNCTION(keysc),
 	SH_PFC_FUNCTION(lcd),
 	SH_PFC_FUNCTION(lcd2),
-- 
1.8.1.5

