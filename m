From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 19 Nov 2015 18:30:27 +0000
Subject: [PATCH 2/2] pinctrl: sh-pfc: r8a7795: Add SCIF_CLK support
Message-Id: <1447957827-32637-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1447957827-32637-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447957827-32637-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add pins, groups, and a function for SCIF_CLK, which is the external
clock source for the Baud Rate Generator for External Clock (BRG) on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 2538ea4d6a81..44c5fa511ed5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -2031,6 +2031,22 @@ static const unsigned int scif5_clk_mux[] = {
 	SCK5_MARK,
 };
 
+/* - SCIF Clock ------------------------------------------------------------- */
+static const unsigned int scif_clk_a_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(6, 23),
+};
+static const unsigned int scif_clk_a_mux[] = {
+	SCIF_CLK_A_MARK,
+};
+static const unsigned int scif_clk_b_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(5, 9),
+};
+static const unsigned int scif_clk_b_mux[] = {
+	SCIF_CLK_B_MARK,
+};
+
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA */
@@ -2292,6 +2308,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif4_ctrl_c),
 	SH_PFC_PIN_GROUP(scif5_data),
 	SH_PFC_PIN_GROUP(scif5_clk),
+	SH_PFC_PIN_GROUP(scif_clk_a),
+	SH_PFC_PIN_GROUP(scif_clk_b),
 	SH_PFC_PIN_GROUP(ssi0_data),
 	SH_PFC_PIN_GROUP(ssi01239_ctrl),
 	SH_PFC_PIN_GROUP(ssi1_data_a),
@@ -2450,6 +2468,11 @@ static const char * const scif5_groups[] = {
 	"scif5_clk",
 };
 
+static const char * const scif_clk_groups[] = {
+	"scif_clk_a",
+	"scif_clk_b",
+};
+
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi01239_ctrl",
@@ -2495,6 +2518,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif5),
+	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(ssi),
 };
 
-- 
1.9.1

