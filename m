From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 May 2013 06:36:03 +0000
Subject: [PATCH] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
Message-Id: <1367908563-20293-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

the USB OVC pins are optional alternate options for USB over-current
detection when using a 3.3V USB interface. As they're not mandatory,
don't group them with the USB PENC pins.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 45 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

Simon, this is a v3.10 fix, could you apply it upon Sergei's ack ?

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index d6056ed..ddc2b2e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2392,27 +2392,48 @@ static const unsigned int sdhi3_wp_mux[] = {
 };
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
-	/* OVC */
-	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 26),
+	/* PENC */
+	RCAR_GP_PIN(4, 26),
 };
 static const unsigned int usb0_mux[] = {
-	USB_OVC0_MARK, USB_PENC0_MARK,
+	USB_PENC0_MARK,
+};
+static const unsigned int usb0_ovc_pins[] = {
+	/* OVC */
+	RCAR_GP_PIN(4, 22),
+};
+static const unsigned int usb0_ovc_mux[] = {
+	USB_OVC0_MARK,
 };
 /* - USB1 ------------------------------------------------------------------- */
 static const unsigned int usb1_pins[] = {
-	/* OVC */
-	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 27),
+	/* PENC */
+	RCAR_GP_PIN(4, 27),
 };
 static const unsigned int usb1_mux[] = {
-	USB_OVC1_MARK, USB_PENC1_MARK,
+	USB_PENC1_MARK,
+};
+static const unsigned int usb1_ovc_pins[] = {
+	/* OVC */
+	RCAR_GP_PIN(4, 24),
+};
+static const unsigned int usb1_ovc_mux[] = {
+	USB_OVC1_MARK,
 };
 /* - USB2 ------------------------------------------------------------------- */
 static const unsigned int usb2_pins[] = {
-	/* OVC, PENC */
-	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(4, 28),
+	/* PENC */
+	RCAR_GP_PIN(4, 28),
 };
 static const unsigned int usb2_mux[] = {
-	USB_OVC2_MARK, USB_PENC2_MARK,
+	USB_PENC2_MARK,
+};
+static const unsigned int usb2_ovc_pins[] = {
+	/* OVC */
+	RCAR_GP_PIN(3, 29),
+};
+static const unsigned int usb2_ovc_mux[] = {
+	USB_OVC2_MARK,
 };
 /* - VIN0 ------------------------------------------------------------------- */
 static const unsigned int vin0_data8_pins[] = {
@@ -2640,8 +2661,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi3_cd),
 	SH_PFC_PIN_GROUP(sdhi3_wp),
 	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb0_ovc),
 	SH_PFC_PIN_GROUP(usb1),
+	SH_PFC_PIN_GROUP(usb1_ovc),
 	SH_PFC_PIN_GROUP(usb2),
+	SH_PFC_PIN_GROUP(usb2_ovc),
 	SH_PFC_PIN_GROUP(vin0_data8),
 	SH_PFC_PIN_GROUP(vin0_clk),
 	SH_PFC_PIN_GROUP(vin0_sync),
@@ -2834,14 +2858,17 @@ static const char * const sdhi3_groups[] = {
 
 static const char * const usb0_groups[] = {
 	"usb0",
+	"usb0_ovc",
 };
 
 static const char * const usb1_groups[] = {
 	"usb1",
+	"usb1_ovc",
 };
 
 static const char * const usb2_groups[] = {
 	"usb2",
+	"usb2_ovc",
 };
 
 static const char * const vin0_groups[] = {
-- 
Regards,

Laurent Pinchart

