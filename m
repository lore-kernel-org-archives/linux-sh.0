From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 11 Apr 2014 01:08:35 +0000
Subject: [PATCH 2/2] sh-pfc: r8a7791: Add Audio pin support
Message-Id: <87ppkooep1.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index aef5d7f..19571c1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1680,6 +1680,53 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
+/* - Audio Clock ------------------------------------------------------------ */
+static const unsigned int audio_clk_a_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(2, 28),
+};
+
+static const unsigned int audio_clk_a_mux[] = {
+	AUDIO_CLKA_MARK,
+};
+
+static const unsigned int audio_clk_b_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(2, 29),
+};
+
+static const unsigned int audio_clk_b_mux[] = {
+	AUDIO_CLKB_MARK,
+};
+
+static const unsigned int audio_clk_b_b_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(7, 20),
+};
+
+static const unsigned int audio_clk_b_b_mux[] = {
+	AUDIO_CLKB_B_MARK,
+};
+
+static const unsigned int audio_clk_c_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(2, 30),
+};
+
+static const unsigned int audio_clk_c_mux[] = {
+	AUDIO_CLKC_MARK,
+};
+
+static const unsigned int audio_clkout_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(2, 31),
+};
+
+static const unsigned int audio_clkout_mux[] = {
+	AUDIO_CLKOUT_MARK,
+};
+
+
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -3804,6 +3851,11 @@ static const unsigned int vin2_clk_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(audio_clk_a),
+	SH_PFC_PIN_GROUP(audio_clk_b),
+	SH_PFC_PIN_GROUP(audio_clk_b_b),
+	SH_PFC_PIN_GROUP(audio_clk_c),
+	SH_PFC_PIN_GROUP(audio_clkout),
 	SH_PFC_PIN_GROUP(du_rgb666),
 	SH_PFC_PIN_GROUP(du_rgb888),
 	SH_PFC_PIN_GROUP(du_clk_out_0),
@@ -4080,6 +4132,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin2_clk),
 };
 
+static const char * const audio_clk_groups[] = {
+	"audio_clk_a",
+	"audio_clk_b",
+	"audio_clk_b_b",
+	"audio_clk_c",
+	"audio_clkout",
+};
+
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4465,6 +4525,7 @@ static const char * const vin2_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(du),
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
-- 
1.7.9.5

