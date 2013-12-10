From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 18:20:22 +0000
Subject: [PATCH 1/5] pinctrl: sh-pfc: pfc-r8a7790: Rename VIN pin groups
Message-Id: <1386699626-15803-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This drops superfluous "signal" word from the pin group names
and renames data_enable group to clkenb as in the h/w manual.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 72786fc..21d41f8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3045,28 +3045,28 @@ static const unsigned int vin0_data_b_mux[] = {
 	VI0_DATA3_VI0_B3_MARK, VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
 	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
 };
-static const unsigned int vin0_hsync_signal_pins[] = {
+static const unsigned int vin0_hsync_pins[] = {
 	RCAR_GP_PIN(0, 12),
 };
-static const unsigned int vin0_hsync_signal_mux[] = {
+static const unsigned int vin0_hsync_mux[] = {
 	VI0_HSYNC_N_MARK,
 };
-static const unsigned int vin0_vsync_signal_pins[] = {
+static const unsigned int vin0_vsync_pins[] = {
 	RCAR_GP_PIN(0, 13),
 };
-static const unsigned int vin0_vsync_signal_mux[] = {
+static const unsigned int vin0_vsync_mux[] = {
 	VI0_VSYNC_N_MARK,
 };
-static const unsigned int vin0_field_signal_pins[] = {
+static const unsigned int vin0_field_pins[] = {
 	RCAR_GP_PIN(0, 15),
 };
-static const unsigned int vin0_field_signal_mux[] = {
+static const unsigned int vin0_field_mux[] = {
 	VI0_FIELD_MARK,
 };
-static const unsigned int vin0_data_enable_pins[] = {
+static const unsigned int vin0_clkenb_pins[] = {
 	RCAR_GP_PIN(0, 14),
 };
-static const unsigned int vin0_data_enable_mux[] = {
+static const unsigned int vin0_clkenb_mux[] = {
 	VI0_CLKENB_MARK,
 };
 static const unsigned int vin0_clk_pins[] = {
@@ -3269,10 +3269,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin0_data_g),
 	SH_PFC_PIN_GROUP(vin0_data_r),
 	SH_PFC_PIN_GROUP(vin0_data_b),
-	SH_PFC_PIN_GROUP(vin0_hsync_signal),
-	SH_PFC_PIN_GROUP(vin0_vsync_signal),
-	SH_PFC_PIN_GROUP(vin0_field_signal),
-	SH_PFC_PIN_GROUP(vin0_data_enable),
+	SH_PFC_PIN_GROUP(vin0_hsync),
+	SH_PFC_PIN_GROUP(vin0_vsync),
+	SH_PFC_PIN_GROUP(vin0_field),
+	SH_PFC_PIN_GROUP(vin0_clkenb),
 	SH_PFC_PIN_GROUP(vin0_clk),
 	SH_PFC_PIN_GROUP(vin1_data),
 	SH_PFC_PIN_GROUP(vin1_clk),
@@ -3556,10 +3556,10 @@ static const char * const vin0_groups[] = {
 	"vin0_data_g",
 	"vin0_data_r",
 	"vin0_data_b",
-	"vin0_hsync_signal",
-	"vin0_vsync_signal",
-	"vin0_field_signal",
-	"vin0_data_enable",
+	"vin0_hsync",
+	"vin0_vsync",
+	"vin0_field",
+	"vin0_clkenb",
 	"vin0_clk",
 };
 
-- 
1.8.3.1

