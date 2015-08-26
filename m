From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:02:20 +0000
Subject: [PATCH 1/5] pinctrl: sh-pfc: r8a7795: Fix and extend SCIF0 pin data
Message-Id: <1440612144-16877-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1440612144-16877-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440612144-16877-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

  - Fix SCIF0 SCK pin and mux: "SCIF_CLK_B" is not an alternative SCK
    pin, but the alternative (H)SCIF baud rate generation clock pin,
    which is not yet supported,
  - Add missing SCIF0 ctrl pins.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 9437e87cc8065211..459929d215f9b8aa 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -2243,12 +2243,19 @@ static const unsigned int scif0_data_pins[] = {
 static const unsigned int scif0_data_mux[] = {
 	RX0_MARK, TX0_MARK,
 };
-static const unsigned int scif0_clk_b_pins[] = {
+static const unsigned int scif0_clk_pins[] = {
 	/* SCK */
-	RCAR_GP_PIN(5, 9),
+	RCAR_GP_PIN(5, 0),
+};
+static const unsigned int scif0_clk_mux[] = {
+	SCK0_MARK,
+};
+static const unsigned int scif0_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 3),
 };
-static const unsigned int scif0_clk_b_mux[] = {
-	SCIF_CLK_B_MARK,
+static const unsigned int scif0_ctrl_mux[] = {
+	RTS0_N_TANS_MARK, CTS0_N_MARK,
 };
 /* - SCIF1 ------------------------------------------------------------------ */
 static const unsigned int scif1_data_a_pins[] = {
@@ -2780,7 +2787,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof3_txd_d),
 	SH_PFC_PIN_GROUP(msiof3_rxd_d),
 	SH_PFC_PIN_GROUP(scif0_data),
-	SH_PFC_PIN_GROUP(scif0_clk_b),
+	SH_PFC_PIN_GROUP(scif0_clk),
+	SH_PFC_PIN_GROUP(scif0_ctrl),
 	SH_PFC_PIN_GROUP(scif1_data_a),
 	SH_PFC_PIN_GROUP(scif1_clk),
 	SH_PFC_PIN_GROUP(scif1_ctrl),
@@ -2972,7 +2980,8 @@ static const char * const msiof3_groups[] = {
 
 static const char * const scif0_groups[] = {
 	"scif0_data",
-	"scif0_clk_b",
+	"scif0_clk",
+	"scif0_ctrl",
 };
 
 static const char * const scif1_groups[] = {
-- 
1.9.1

