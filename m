From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 11 Dec 2015 13:48:56 +0000
Subject: [PATCH 1/3] pinctrl: sh-pfc: r8a7779: Add SCIF_CLK support
Message-Id: <1449841738-17490-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1449841738-17490-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449841738-17490-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add pins, groups, and a function for SCIF_CLK, which is the external
clock source for the Baud Rate Generator for External Clock (BRG) on
SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index afc5d80353c568fd..bd17eccb6a8901a8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2282,6 +2282,35 @@ static const unsigned int scif5_clk_d_pins[] = {
 static const unsigned int scif5_clk_d_mux[] = {
 	SCK5_D_MARK,
 };
+/* - SCIF Clock ------------------------------------------------------------- */
+static const unsigned int scif_clk_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(4, 28),
+};
+static const unsigned int scif_clk_mux[] = {
+	SCIF_CLK_MARK,
+};
+static const unsigned int scif_clk_b_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(4, 5),
+};
+static const unsigned int scif_clk_b_mux[] = {
+	SCIF_CLK_B_MARK,
+};
+static const unsigned int scif_clk_c_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(4, 18),
+};
+static const unsigned int scif_clk_c_mux[] = {
+	SCIF_CLK_C_MARK,
+};
+static const unsigned int scif_clk_d_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(2, 29),
+};
+static const unsigned int scif_clk_d_mux[] = {
+	SCIF_CLK_D_MARK,
+};
 /* - SDHI0 ------------------------------------------------------------------ */
 static const unsigned int sdhi0_data1_pins[] = {
 	/* D0 */
@@ -2693,6 +2722,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif5_clk_c),
 	SH_PFC_PIN_GROUP(scif5_data_d),
 	SH_PFC_PIN_GROUP(scif5_clk_d),
+	SH_PFC_PIN_GROUP(scif_clk),
+	SH_PFC_PIN_GROUP(scif_clk_b),
+	SH_PFC_PIN_GROUP(scif_clk_c),
+	SH_PFC_PIN_GROUP(scif_clk_d),
 	SH_PFC_PIN_GROUP(sdhi0_data1),
 	SH_PFC_PIN_GROUP(sdhi0_data4),
 	SH_PFC_PIN_GROUP(sdhi0_ctrl),
@@ -2902,6 +2935,13 @@ static const char * const scif5_groups[] = {
 	"scif5_clk_d",
 };
 
+static const char * const scif_clk_groups[] = {
+	"scif_clk",
+	"scif_clk_b",
+	"scif_clk_c",
+	"scif_clk_d",
+};
+
 static const char * const sdhi0_groups[] = {
 	"sdhi0_data1",
 	"sdhi0_data4",
@@ -2997,6 +3037,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif5),
+	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
 	SH_PFC_FUNCTION(usb2),
-- 
1.9.1

