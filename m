From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Nov 2015 03:18:51 +0000
Subject: [PATCH 02/04] pinctrl: sh-pfc: r8a7794: Separate DU CDE and DISP
Message-Id: <20151117031851.24924.18884.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117031832.24924.60685.sendpatchset@little-apple>
In-Reply-To: <20151117031832.24924.60685.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org, koji.matsuoka.xm@renesas.com, linux-gpio@vger.kernel.org, horms@verge.net.au, geert@glider.be, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Separate DU CDE and DISP signals to let the r8a7794 ALT
board that lacks CDE handle the DISP signal by itself.

The groups "du0_cde_disp" and "du1_cde_disp" are replaced
by "du0_cde", "du1_cde", "du0_disp" and "du1_disp".

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |   50 +++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 16 deletions(-)

--- 0008/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a7794.c	2015-11-16 15:04:00.760513000 +0900
@@ -1616,19 +1616,33 @@ static const unsigned int du1_sync_mux[]
 	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
 	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK
 };
-static const unsigned int du0_cde_disp_pins[] = {
-	/* CDE DISP */
-	RCAR_GP_PIN(2, 31), RCAR_GP_PIN(2, 30),
-};
-static const unsigned int du0_cde_disp_mux[] = {
-	DU0_CDE_MARK, DU0_DISP_MARK
-};
-static const unsigned int du1_cde_disp_pins[] = {
-	/* CDE DISP */
-	RCAR_GP_PIN(4, 31), RCAR_GP_PIN(4, 30),
+static const unsigned int du0_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(2, 31),
 };
-static const unsigned int du1_cde_disp_mux[] = {
-	DU1_CDE_MARK, DU1_DISP_MARK
+static const unsigned int du0_cde_mux[] = {
+	DU0_CDE_MARK,
+};
+static const unsigned int du1_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(4, 31),
+};
+static const unsigned int du1_cde_mux[] = {
+	DU1_CDE_MARK
+};
+static const unsigned int du0_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(2, 30),
+};
+static const unsigned int du0_disp_mux[] = {
+	DU0_DISP_MARK
+};
+static const unsigned int du1_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(4, 30),
+};
+static const unsigned int du1_disp_mux[] = {
+	DU1_DISP_MARK
 };
 static const unsigned int du0_clk_in_pins[] = {
 	/* CLKIN */
@@ -2932,8 +2946,10 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(du1_clk_out),
 	SH_PFC_PIN_GROUP(du0_sync),
 	SH_PFC_PIN_GROUP(du1_sync),
-	SH_PFC_PIN_GROUP(du0_cde_disp),
-	SH_PFC_PIN_GROUP(du1_cde_disp),
+	SH_PFC_PIN_GROUP(du0_cde),
+	SH_PFC_PIN_GROUP(du1_cde),
+	SH_PFC_PIN_GROUP(du0_disp),
+	SH_PFC_PIN_GROUP(du1_disp),
 	SH_PFC_PIN_GROUP(du0_clk_in),
 	SH_PFC_PIN_GROUP(du1_clk_in),
 	SH_PFC_PIN_GROUP(eth_link),
@@ -3122,8 +3138,10 @@ static const char * const du_groups[]  	"du1_clk_out",
 	"du0_sync",
 	"du1_sync",
-	"du0_cde_disp",
-	"du1_cde_disp",
+	"du0_cde",
+	"du1_cde",
+	"du0_disp",
+	"du1_disp",
 };
 
 static const char * const du0_groups[] = {
