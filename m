From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 07 May 2015 16:10:37 +0000
Subject: [PATCH 4/4] pinctrl: sh-pfc: r8a7791/3: Add SSP pin group
Message-Id: <1431015037-25254-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

"Stream and Security Processor", applicable to r8a7791 and r8a7793.
Based on patch by Hisashi Nakamura.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index cbf8ec3..849bd4e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4183,6 +4183,23 @@ static const unsigned int vin2_clk_mux[] = {
 	VI2_CLK_MARK,
 };
 
+/* - SSP ------------------------------------------------------------------- */
+static const unsigned int ssp_pins[] = {
+	RCAR_GP_PIN(5, 25),
+	RCAR_GP_PIN(5, 26),
+	RCAR_GP_PIN(5, 27),
+	RCAR_GP_PIN(5, 28),
+	RCAR_GP_PIN(5, 29),
+};
+
+static const unsigned int ssp_mux[] = {
+	STP_IVCXO27_0_MARK,
+	STP_ISCLK_0_MARK,
+	STP_ISD_0_MARK,
+	STP_ISEN_0_MARK,
+	STP_ISSYNC_0_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(audio_clk_a),
 	SH_PFC_PIN_GROUP(audio_clk_b),
@@ -4472,6 +4489,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(ssi9_data_b),
 	SH_PFC_PIN_GROUP(ssi9_ctrl),
 	SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+	SH_PFC_PIN_GROUP(ssp),
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
 	VIN_DATA_PIN_GROUP(vin0_data, 24),
-- 
2.3.5

