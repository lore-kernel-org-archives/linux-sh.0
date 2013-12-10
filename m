From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 18:20:23 +0000
Subject: [PATCH 2/5] pinctrl: sh-pfc: pfc-r8a7790: Group VIN0 HSYNC and VSYNC together
Message-Id: <1386699626-15803-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This groups VIN0 HSYNC and VSYNC pins together
since one cannot be used without another.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 21d41f8..fa4d7093 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3045,16 +3045,12 @@ static const unsigned int vin0_data_b_mux[] = {
 	VI0_DATA3_VI0_B3_MARK, VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
 	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
 };
-static const unsigned int vin0_hsync_pins[] = {
-	RCAR_GP_PIN(0, 12),
+static const unsigned int vin0_sync_pins[] = {
+	RCAR_GP_PIN(0, 12), /* HSYNC */
+	RCAR_GP_PIN(0, 13), /* VSYNC */
 };
-static const unsigned int vin0_hsync_mux[] = {
+static const unsigned int vin0_sync_mux[] = {
 	VI0_HSYNC_N_MARK,
-};
-static const unsigned int vin0_vsync_pins[] = {
-	RCAR_GP_PIN(0, 13),
-};
-static const unsigned int vin0_vsync_mux[] = {
 	VI0_VSYNC_N_MARK,
 };
 static const unsigned int vin0_field_pins[] = {
@@ -3269,8 +3265,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin0_data_g),
 	SH_PFC_PIN_GROUP(vin0_data_r),
 	SH_PFC_PIN_GROUP(vin0_data_b),
-	SH_PFC_PIN_GROUP(vin0_hsync),
-	SH_PFC_PIN_GROUP(vin0_vsync),
+	SH_PFC_PIN_GROUP(vin0_sync),
 	SH_PFC_PIN_GROUP(vin0_field),
 	SH_PFC_PIN_GROUP(vin0_clkenb),
 	SH_PFC_PIN_GROUP(vin0_clk),
@@ -3556,8 +3551,7 @@ static const char * const vin0_groups[] = {
 	"vin0_data_g",
 	"vin0_data_r",
 	"vin0_data_b",
-	"vin0_hsync",
-	"vin0_vsync",
+	"vin0_sync",
 	"vin0_field",
 	"vin0_clkenb",
 	"vin0_clk",
-- 
1.8.3.1

