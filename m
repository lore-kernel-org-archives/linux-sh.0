From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 17:53:58 +0000
Subject: [PATCH] pinctrl: sh-pfc: r8a7794: Remove bogus SCIF0 SCK pin data
Message-Id: <1440611638-16256-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

SCIF0 on R-Car E2 does not have an SCK pin.

"SCIF_CLK" is the (H)SCIF baud rate generation clock pin, which is not
yet supported.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index bfdcac4b3bc4a4a0..2f169d5bc230bdcc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -2197,13 +2197,6 @@ static const unsigned int scif0_data_pins[] = {
 static const unsigned int scif0_data_mux[] = {
 	SCIF0_RXD_MARK, SCIF0_TXD_MARK,
 };
-static const unsigned int scif0_clk_pins[] = {
-	/* SCK */
-	RCAR_GP_PIN(1, 23),
-};
-static const unsigned int scif0_clk_mux[] = {
-	SCIF_CLK_MARK,
-};
 static const unsigned int scif0_data_b_pins[] = {
 	/* RX, TX */
 	RCAR_GP_PIN(3, 11), RCAR_GP_PIN(3, 12),
@@ -2211,13 +2204,6 @@ static const unsigned int scif0_data_b_pins[] = {
 static const unsigned int scif0_data_b_mux[] = {
 	SCIF0_RXD_B_MARK, SCIF0_TXD_B_MARK,
 };
-static const unsigned int scif0_clk_b_pins[] = {
-	/* SCK */
-	RCAR_GP_PIN(3, 29),
-};
-static const unsigned int scif0_clk_b_mux[] = {
-	SCIF_CLK_B_MARK,
-};
 static const unsigned int scif0_data_c_pins[] = {
 	/* RX, TX */
 	RCAR_GP_PIN(3, 30), RCAR_GP_PIN(3, 31),
@@ -2866,9 +2852,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(qspi_data2),
 	SH_PFC_PIN_GROUP(qspi_data4),
 	SH_PFC_PIN_GROUP(scif0_data),
-	SH_PFC_PIN_GROUP(scif0_clk),
 	SH_PFC_PIN_GROUP(scif0_data_b),
-	SH_PFC_PIN_GROUP(scif0_clk_b),
 	SH_PFC_PIN_GROUP(scif0_data_c),
 	SH_PFC_PIN_GROUP(scif0_data_d),
 	SH_PFC_PIN_GROUP(scif1_data),
@@ -3087,9 +3071,7 @@ static const char * const qspi_groups[] = {
 
 static const char * const scif0_groups[] = {
 	"scif0_data",
-	"scif0_clk",
 	"scif0_data_b",
-	"scif0_clk_b",
 	"scif0_data_c",
 	"scif0_data_d",
 };
-- 
1.9.1

