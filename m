From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:48 +0000
Subject: [PATCH 07/37] sh-pfc: r8a7740: Add HDMI pin groups and functions
Message-Id: <1366671618-8796-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 49da76a..5a77d39 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2039,6 +2039,14 @@ static const unsigned int gether_wol_pins[] = {
 static const unsigned int gether_wol_mux[] = {
 	ET_WOL_MARK,
 };
+/* - HDMI ------------------------------------------------------------------- */
+static const unsigned int hdmi_pins[] = {
+	/* HPD, CEC */
+	210, 211,
+};
+static const unsigned int hdmi_mux[] = {
+	HDMI_HPD_MARK, HDMI_CEC_MARK,
+};
 /* - INTC ------------------------------------------------------------------- */
 IRQC_PINS_MUX(0, 0, 2);
 IRQC_PINS_MUX(0, 1, 13);
@@ -2787,6 +2795,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(gether_int),
 	SH_PFC_PIN_GROUP(gether_link),
 	SH_PFC_PIN_GROUP(gether_wol),
+	SH_PFC_PIN_GROUP(hdmi),
 	SH_PFC_PIN_GROUP(intc_irq0_0),
 	SH_PFC_PIN_GROUP(intc_irq0_1),
 	SH_PFC_PIN_GROUP(intc_irq1),
@@ -2985,6 +2994,10 @@ static const char * const gether_groups[] = {
 	"gether_wol",
 };
 
+static const char * const hdmi_groups[] = {
+	"hdmi",
+};
+
 static const char * const intc_groups[] = {
 	"intc_irq0_0",
 	"intc_irq0_1",
@@ -3173,6 +3186,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(fsia),
 	SH_PFC_FUNCTION(fsib),
 	SH_PFC_FUNCTION(gether),
+	SH_PFC_FUNCTION(hdmi),
 	SH_PFC_FUNCTION(intc),
 	SH_PFC_FUNCTION(lcd0),
 	SH_PFC_FUNCTION(lcd1),
-- 
1.8.1.5

