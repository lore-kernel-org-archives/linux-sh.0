From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 11 Dec 2015 13:48:57 +0000
Subject: [PATCH 2/3] pinctrl: sh-pfc: r8a7790: Add SCIF_CLK support
Message-Id: <1449841738-17490-3-git-send-email-geert+renesas@glider.be>
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
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index d99a5bcd90d9c5d3..a8b629bc7a557b2f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3219,6 +3219,21 @@ static const unsigned int scifb2_data_c_pins[] = {
 static const unsigned int scifb2_data_c_mux[] = {
 	SCIFB2_RXD_C_MARK, SCIFB2_TXD_C_MARK,
 };
+/* - SCIF Clock ------------------------------------------------------------- */
+static const unsigned int scif_clk_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(4, 26),
+};
+static const unsigned int scif_clk_mux[] = {
+	SCIF_CLK_MARK,
+};
+static const unsigned int scif_clk_b_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(5, 4),
+};
+static const unsigned int scif_clk_b_mux[] = {
+	SCIF_CLK_B_MARK,
+};
 /* - SDHI0 ------------------------------------------------------------------ */
 static const unsigned int sdhi0_data1_pins[] = {
 	/* D0 */
@@ -4122,6 +4137,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb2_clk_b),
 	SH_PFC_PIN_GROUP(scifb2_ctrl_b),
 	SH_PFC_PIN_GROUP(scifb2_data_c),
+	SH_PFC_PIN_GROUP(scif_clk),
+	SH_PFC_PIN_GROUP(scif_clk_b),
 	SH_PFC_PIN_GROUP(sdhi0_data1),
 	SH_PFC_PIN_GROUP(sdhi0_data4),
 	SH_PFC_PIN_GROUP(sdhi0_ctrl),
@@ -4538,6 +4555,11 @@ static const char * const scifb2_groups[] = {
 	"scifb2_data_c",
 };
 
+static const char * const scif_clk_groups[] = {
+	"scif_clk",
+	"scif_clk_b",
+};
+
 static const char * const sdhi0_groups[] = {
 	"sdhi0_data1",
 	"sdhi0_data4",
@@ -4712,6 +4734,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scifb0),
 	SH_PFC_FUNCTION(scifb1),
 	SH_PFC_FUNCTION(scifb2),
+	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
-- 
1.9.1

