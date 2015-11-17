From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Nov 2015 03:19:12 +0000
Subject: [PATCH 04/04] pinctrl: sh-pfc: r8a7794: Break out ODDF from sync
Message-Id: <20151117031912.24924.37315.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117031832.24924.60685.sendpatchset@little-apple>
In-Reply-To: <20151117031832.24924.60685.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org, koji.matsuoka.xm@renesas.com, linux-gpio@vger.kernel.org, horms@verge.net.au, geert@glider.be, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Break out the r8a7794 DU ODDF (EXDISP/EXODDF/EXDE) signal
from the sync group into a separate unit. This makes the
sync group fit with the r8a7794 ALT board that only uses
HSYNC and VSYNC signals.

This makes the r8a7794 PFC similar to the existing r8a7791
PFC DU implementation that also groups together HSYNC and
VSYNC without ODDF.

The groups "du0_oddf" and "du1_oddf" are added and the
"du0_sync" and "du1_sync" groups are modified.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

--- 0016/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a7794.c	2015-11-16 22:27:10.190513000 +0900
@@ -1615,21 +1615,33 @@ static const unsigned int du1_clk1_out_m
 	DU1_DOTCLKOUT1_MARK
 };
 static const unsigned int du0_sync_pins[] = {
-	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC, EXDISP/EXODDF/EXCDE */
-	RCAR_GP_PIN(2, 29), RCAR_GP_PIN(2, 28), RCAR_GP_PIN(2, 27),
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(2, 28), RCAR_GP_PIN(2, 27),
 };
 static const unsigned int du0_sync_mux[] = {
-	DU0_EXODDF_DU0_ODDF_DISP_CDE_MARK,
 	DU0_EXVSYNC_DU0_VSYNC_MARK, DU0_EXHSYNC_DU0_HSYNC_MARK
 };
 static const unsigned int du1_sync_pins[] = {
-	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC, EXDISP/EXODDF/EXCDE */
-	RCAR_GP_PIN(4, 29), RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 27),
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 27),
 };
 static const unsigned int du1_sync_mux[] = {
-	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
 	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK
 };
+static const unsigned int du0_oddf_pins[] = {
+	/* EXDISP/EXODDF/EXCDE */
+	RCAR_GP_PIN(2, 29),
+};
+static const unsigned int du0_oddf_mux[] = {
+	DU0_EXODDF_DU0_ODDF_DISP_CDE_MARK,
+};
+static const unsigned int du1_oddf_pins[] = {
+	/* EXDISP/EXODDF/EXCDE */
+	RCAR_GP_PIN(4, 29),
+};
+static const unsigned int du1_oddf_mux[] = {
+	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
+};
 static const unsigned int du0_cde_pins[] = {
 	/* CDE */
 	RCAR_GP_PIN(2, 31),
@@ -2962,6 +2974,8 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(du1_clk1_out),
 	SH_PFC_PIN_GROUP(du0_sync),
 	SH_PFC_PIN_GROUP(du1_sync),
+	SH_PFC_PIN_GROUP(du0_oddf),
+	SH_PFC_PIN_GROUP(du1_oddf),
 	SH_PFC_PIN_GROUP(du0_cde),
 	SH_PFC_PIN_GROUP(du1_cde),
 	SH_PFC_PIN_GROUP(du0_disp),
@@ -3156,6 +3170,8 @@ static const char * const du_groups[]  	"du1_dotclkout1",
 	"du0_sync",
 	"du1_sync",
+	"du0_oddf",
+	"du1_oddf",
 	"du0_cde",
 	"du1_cde",
 	"du0_disp",
