From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 04:10:39 +0000
Subject: [PATCH 2/3] pinctrl: sh-pfc: r8a7795: add Audio clock pin support
Message-Id: <87y4g57kqn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mvx4qkzo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mvx4qkzo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Laurent <laurent.pinchart@ideasonboard.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 151 +++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index f6afe71..183178d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -1426,6 +1426,121 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
+/* - AUDIO CLOCK ------------------------------------------------------------ */
+static const unsigned int audio_clk_a_a_pins[] = {
+	/* CLK A */
+	RCAR_GP_PIN(6, 22),
+};
+static const unsigned int audio_clk_a_a_mux[] = {
+	AUDIO_CLKA_A_MARK,
+};
+static const unsigned int audio_clk_a_b_pins[] = {
+	/* CLK A */
+	RCAR_GP_PIN(5, 4),
+};
+static const unsigned int audio_clk_a_b_mux[] = {
+	AUDIO_CLKA_B_MARK,
+};
+static const unsigned int audio_clk_a_c_pins[] = {
+	/* CLK A */
+	RCAR_GP_PIN(5, 19),
+};
+static const unsigned int audio_clk_a_c_mux[] = {
+	AUDIO_CLKA_C_MARK,
+};
+static const unsigned int audio_clk_b_a_pins[] = {
+	/* CLK B */
+	RCAR_GP_PIN(5, 12),
+};
+static const unsigned int audio_clk_b_a_mux[] = {
+	AUDIO_CLKB_A_MARK,
+};
+static const unsigned int audio_clk_b_b_pins[] = {
+	/* CLK B */
+	RCAR_GP_PIN(6, 23),
+};
+static const unsigned int audio_clk_b_b_mux[] = {
+	AUDIO_CLKB_B_MARK,
+};
+static const unsigned int audio_clk_c_a_pins[] = {
+	/* CLK C */
+	RCAR_GP_PIN(5, 21),
+};
+static const unsigned int audio_clk_c_a_mux[] = {
+	AUDIO_CLKC_A_MARK,
+};
+static const unsigned int audio_clk_c_b_pins[] = {
+	/* CLK C */
+	RCAR_GP_PIN(5, 0),
+};
+static const unsigned int audio_clk_c_b_mux[] = {
+	AUDIO_CLKC_B_MARK,
+};
+static const unsigned int audio_clkout_a_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(5, 18),
+};
+static const unsigned int audio_clkout_a_mux[] = {
+	AUDIO_CLKOUT_A_MARK,
+};
+static const unsigned int audio_clkout_b_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(6, 28),
+};
+static const unsigned int audio_clkout_b_mux[] = {
+	AUDIO_CLKOUT_B_MARK,
+};
+static const unsigned int audio_clkout_c_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(5, 3),
+};
+static const unsigned int audio_clkout_c_mux[] = {
+	AUDIO_CLKOUT_C_MARK,
+};
+static const unsigned int audio_clkout1_a_pins[] = {
+	/* CLKOUT1 */
+	RCAR_GP_PIN(5, 15),
+};
+static const unsigned int audio_clkout1_a_mux[] = {
+	AUDIO_CLKOUT1_A_MARK,
+};
+static const unsigned int audio_clkout1_b_pins[] = {
+	/* CLKOUT1 */
+	RCAR_GP_PIN(6, 29),
+};
+static const unsigned int audio_clkout1_b_mux[] = {
+	AUDIO_CLKOUT1_B_MARK,
+};
+static const unsigned int audio_clkout2_a_pins[] = {
+	/* CLKOUT2 */
+	RCAR_GP_PIN(5, 16),
+};
+static const unsigned int audio_clkout2_a_mux[] = {
+	AUDIO_CLKOUT2_A_MARK,
+};
+static const unsigned int audio_clkout2_b_pins[] = {
+	/* CLKOUT2 */
+	RCAR_GP_PIN(6, 30),
+};
+static const unsigned int audio_clkout2_b_mux[] = {
+	AUDIO_CLKOUT2_B_MARK,
+};
+
+static const unsigned int audio_clkout3_a_pins[] = {
+	/* CLKOUT3 */
+	RCAR_GP_PIN(5, 19),
+};
+static const unsigned int audio_clkout3_a_mux[] = {
+	AUDIO_CLKOUT3_A_MARK,
+};
+static const unsigned int audio_clkout3_b_pins[] = {
+	/* CLKOUT3 */
+	RCAR_GP_PIN(6, 31),
+};
+static const unsigned int audio_clkout3_b_mux[] = {
+	AUDIO_CLKOUT3_B_MARK,
+};
+
 /* - I2C -------------------------------------------------------------------- */
 static const unsigned int i2c1_a_pins[] = {
 	/* SDA, SCL */
@@ -1661,6 +1776,22 @@ static const unsigned int scif5_clk_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(audio_clk_a_a),
+	SH_PFC_PIN_GROUP(audio_clk_a_b),
+	SH_PFC_PIN_GROUP(audio_clk_a_c),
+	SH_PFC_PIN_GROUP(audio_clk_b_a),
+	SH_PFC_PIN_GROUP(audio_clk_b_b),
+	SH_PFC_PIN_GROUP(audio_clk_c_a),
+	SH_PFC_PIN_GROUP(audio_clk_c_b),
+	SH_PFC_PIN_GROUP(audio_clkout_a),
+	SH_PFC_PIN_GROUP(audio_clkout_b),
+	SH_PFC_PIN_GROUP(audio_clkout_c),
+	SH_PFC_PIN_GROUP(audio_clkout1_a),
+	SH_PFC_PIN_GROUP(audio_clkout1_b),
+	SH_PFC_PIN_GROUP(audio_clkout2_a),
+	SH_PFC_PIN_GROUP(audio_clkout2_b),
+	SH_PFC_PIN_GROUP(audio_clkout3_a),
+	SH_PFC_PIN_GROUP(audio_clkout3_b),
 	SH_PFC_PIN_GROUP(i2c1_a),
 	SH_PFC_PIN_GROUP(i2c1_b),
 	SH_PFC_PIN_GROUP(i2c2_a),
@@ -1695,6 +1826,25 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif5_clk),
 };
 
+static const char * const audio_clk_groups[] = {
+	"audio_clk_a_a",
+	"audio_clk_a_b",
+	"audio_clk_a_c",
+	"audio_clk_b_a",
+	"audio_clk_b_b",
+	"audio_clk_c_a",
+	"audio_clk_c_b",
+	"audio_clkout_a",
+	"audio_clkout_b",
+	"audio_clkout_c",
+	"audio_clkout1_a",
+	"audio_clkout1_b",
+	"audio_clkout2_a",
+	"audio_clkout2_b",
+	"audio_clkout3_a",
+	"audio_clkout3_b",
+};
+
 static const char * const i2c1_groups[] = {
 	"i2c1_a",
 	"i2c1_b",
@@ -1755,6 +1905,7 @@ static const char * const scif5_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(i2c1),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c6),
-- 
1.9.1

