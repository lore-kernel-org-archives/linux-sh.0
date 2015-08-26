From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:02:21 +0000
Subject: [PATCH 2/5] pinctrl: sh-pfc: r8a7795: Extend SCIF2 pin data
Message-Id: <1440612144-16877-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1440612144-16877-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440612144-16877-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add missing alternative data pins.

Note that this renames "scif2_data" to "scif2_data_a", and thus requires
a DTS update.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 459929d215f9b8aa..83cce48da9f928b7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -2288,11 +2288,11 @@ static const unsigned int scif1_data_b_mux[] = {
 	RX1_B_MARK, TX1_B_MARK,
 };
 /* - SCIF2 ------------------------------------------------------------------ */
-static const unsigned int scif2_data_pins[] = {
+static const unsigned int scif2_data_a_pins[] = {
 	/* RX, TX */
 	RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 10),
 };
-static const unsigned int scif2_data_mux[] = {
+static const unsigned int scif2_data_a_mux[] = {
 	RX2_A_MARK, TX2_A_MARK,
 };
 static const unsigned int scif2_clk_pins[] = {
@@ -2302,6 +2302,13 @@ static const unsigned int scif2_clk_pins[] = {
 static const unsigned int scif2_clk_mux[] = {
 	SCK2_MARK,
 };
+static const unsigned int scif2_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 16),
+};
+static const unsigned int scif2_data_b_mux[] = {
+	RX2_B_MARK, TX2_B_MARK,
+};
 /* - SCIF3 ------------------------------------------------------------------ */
 static const unsigned int scif3_data_a_pins[] = {
 	/* RX, TX */
@@ -2793,8 +2800,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif1_clk),
 	SH_PFC_PIN_GROUP(scif1_ctrl),
 	SH_PFC_PIN_GROUP(scif1_data_b),
-	SH_PFC_PIN_GROUP(scif2_data),
+	SH_PFC_PIN_GROUP(scif2_data_a),
 	SH_PFC_PIN_GROUP(scif2_clk),
+	SH_PFC_PIN_GROUP(scif2_data_b),
 	SH_PFC_PIN_GROUP(scif3_data_a),
 	SH_PFC_PIN_GROUP(scif3_clk),
 	SH_PFC_PIN_GROUP(scif3_ctrl),
@@ -2992,8 +3000,9 @@ static const char * const scif1_groups[] = {
 };
 
 static const char * const scif2_groups[] = {
-	"scif2_data",
+	"scif2_data_a",
 	"scif2_clk",
+	"scif2_data_b",
 };
 
 static const char * const scif3_groups[] = {
-- 
1.9.1

