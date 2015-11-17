From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Nov 2015 03:19:02 +0000
Subject: [PATCH 03/04] pinctrl: sh-pfc: r8a7794: Add missing dot clock signals
Message-Id: <20151117031902.24924.4588.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117031832.24924.60685.sendpatchset@little-apple>
In-Reply-To: <20151117031832.24924.60685.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org, koji.matsuoka.xm@renesas.com, linux-gpio@vger.kernel.org, horms@verge.net.au, geert@glider.be, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Add missing r8a7794 DU dot clock output signals and in
particular the DU1_DOTCLKOUT0 signal on GP4_25 which is
needed by DU1 on the r8a7794 ALT board.

The groups "du0_clk_out" and "du1_clk_out" are replaced by
"du0_dotclkout0", "du0_dotclkout1", "du1_dotclkout0" and
"du1_dotclkout1".

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- 0014/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a7794.c	2015-11-16 22:08:28.230513000 +0900
@@ -1586,18 +1586,32 @@ static const unsigned int du1_rgb888_mux
 	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
 	DU1_DB3_MARK, DU1_DB2_MARK, DU1_DB1_MARK, DU1_DB0_MARK,
 };
-static const unsigned int du0_clk_out_pins[] = {
+static const unsigned int du0_clk0_out_pins[] = {
 	/* CLKOUT */
 	RCAR_GP_PIN(2, 25),
 };
-static const unsigned int du0_clk_out_mux[] = {
+static const unsigned int du0_clk0_out_mux[] = {
 	DU0_DOTCLKOUT0_MARK
 };
-static const unsigned int du1_clk_out_pins[] = {
+static const unsigned int du0_clk1_out_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(2, 26),
+};
+static const unsigned int du0_clk1_out_mux[] = {
+	DU0_DOTCLKOUT1_MARK
+};
+static const unsigned int du1_clk0_out_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(4, 25),
+};
+static const unsigned int du1_clk0_out_mux[] = {
+	DU1_DOTCLKOUT0_MARK
+};
+static const unsigned int du1_clk1_out_pins[] = {
 	/* CLKOUT */
 	RCAR_GP_PIN(4, 26),
 };
-static const unsigned int du1_clk_out_mux[] = {
+static const unsigned int du1_clk1_out_mux[] = {
 	DU1_DOTCLKOUT1_MARK
 };
 static const unsigned int du0_sync_pins[] = {
@@ -2942,8 +2956,10 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(du0_rgb888),
 	SH_PFC_PIN_GROUP(du1_rgb666),
 	SH_PFC_PIN_GROUP(du1_rgb888),
-	SH_PFC_PIN_GROUP(du0_clk_out),
-	SH_PFC_PIN_GROUP(du1_clk_out),
+	SH_PFC_PIN_GROUP(du0_clk0_out),
+	SH_PFC_PIN_GROUP(du0_clk1_out),
+	SH_PFC_PIN_GROUP(du1_clk0_out),
+	SH_PFC_PIN_GROUP(du1_clk1_out),
 	SH_PFC_PIN_GROUP(du0_sync),
 	SH_PFC_PIN_GROUP(du1_sync),
 	SH_PFC_PIN_GROUP(du0_cde),
@@ -3134,8 +3150,10 @@ static const char * const du_groups[]  	"du0_rgb888",
 	"du1_rgb666",
 	"du1_rgb888",
-	"du0_clk_out",
-	"du1_clk_out",
+	"du0_dotclkout0",
+	"du0_dotclkout1",
+	"du1_dotclkout0",
+	"du1_dotclkout1",
 	"du0_sync",
 	"du1_sync",
 	"du0_cde",
