From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 01 Apr 2014 10:59:09 +0000
Subject: [PATCH] pinctrl: sh-pfc: r8a7791: Split the DU sync and cde/disp groups
Message-Id: <1396349949-26712-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The DU parallel interface ODDF signal is optional, move it out of the
HSYNC/VSYNC group into a group of its down. The CDE and DISP signals are
independent, split them to two different groups.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 567d691..ee9c6a6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1733,19 +1733,32 @@ static const unsigned int du_clk_out_1_mux[] = {
 	DU1_DOTCLKOUT1_MARK
 };
 static const unsigned int du_sync_pins[] = {
-	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC, EXDISP/EXODDF/EXCDE */
-	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(3, 28), RCAR_GP_PIN(3, 27),
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(3, 28), RCAR_GP_PIN(3, 27),
 };
 static const unsigned int du_sync_mux[] = {
-	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
 	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK
 };
-static const unsigned int du_cde_disp_pins[] = {
-	/* CDE DISP */
-	RCAR_GP_PIN(3, 31), RCAR_GP_PIN(3, 30),
+static const unsigned int du_oddf_pins[] = {
+	/* EXDISP/EXODDF/EXCDE */
+	RCAR_GP_PIN(3, 29),
+};
+static const unsigned int du_oddf_mux[] = {
+	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
+};
+static const unsigned int du_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(3, 31),
+};
+static const unsigned int du_cde_mux[] = {
+	DU1_CDE_MARK,
+};
+static const unsigned int du_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(3, 30),
 };
-static const unsigned int du_cde_disp_mux[] = {
-	DU1_CDE_MARK, DU1_DISP_MARK
+static const unsigned int du_disp_mux[] = {
+	DU1_DISP_MARK,
 };
 static const unsigned int du0_clk_in_pins[] = {
 	/* CLKIN */
@@ -3097,7 +3110,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_clk_out_0),
 	SH_PFC_PIN_GROUP(du_clk_out_1),
 	SH_PFC_PIN_GROUP(du_sync),
-	SH_PFC_PIN_GROUP(du_cde_disp),
+	SH_PFC_PIN_GROUP(du_oddf),
+	SH_PFC_PIN_GROUP(du_cde),
+	SH_PFC_PIN_GROUP(du_disp),
 	SH_PFC_PIN_GROUP(du0_clk_in),
 	SH_PFC_PIN_GROUP(du1_clk_in),
 	SH_PFC_PIN_GROUP(du1_clk_in_b),
@@ -3283,7 +3298,9 @@ static const char * const du_groups[] = {
 	"du_clk_out_0",
 	"du_clk_out_1",
 	"du_sync",
-	"du_cde_disp",
+	"du_oddf",
+	"du_cde",
+	"du_disp",
 };
 
 static const char * const du0_groups[] = {
-- 
Regards,

Laurent Pinchart

