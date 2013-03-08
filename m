From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:34 +0000
Subject: [PATCH v3 14/64] sh-pfc: r8a7779: Add USB pin groups and functions
Message-Id: <1362740544-19164-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 4ab7b11..150bdf0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2221,6 +2221,30 @@ static const unsigned int sdhi3_wp_mux[] = {
 	SD3_WP_MARK,
 };
 
+static const unsigned int usb0_pins[] = {
+	/* OVC */
+	150, 154,
+};
+static const unsigned int usb0_mux[] = {
+	USB_OVC0_MARK, USB_PENC0_MARK,
+};
+
+static const unsigned int usb1_pins[] = {
+	/* OVC */
+	152, 155,
+};
+static const unsigned int usb1_mux[] = {
+	USB_OVC1_MARK, USB_PENC1_MARK,
+};
+
+static const unsigned int usb2_pins[] = {
+	/* OVC, PENC */
+	125, 156,
+};
+static const unsigned int usb2_mux[] = {
+	USB_OVC2_MARK, USB_PENC2_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du0_rgb666),
 	SH_PFC_PIN_GROUP(du0_rgb888),
@@ -2323,6 +2347,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi3_ctrl),
 	SH_PFC_PIN_GROUP(sdhi3_cd),
 	SH_PFC_PIN_GROUP(sdhi3_wp),
+	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb1),
+	SH_PFC_PIN_GROUP(usb2),
 };
 
 static const char * const du0_groups[] = {
@@ -2477,6 +2504,18 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_wp",
 };
 
+static const char * const usb0_groups[] = {
+	"usb0",
+};
+
+static const char * const usb1_groups[] = {
+	"usb1",
+};
+
+static const char * const usb2_groups[] = {
+	"usb2",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
@@ -2495,6 +2534,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif5),
+	SH_PFC_FUNCTION(usb0),
+	SH_PFC_FUNCTION(usb1),
+	SH_PFC_FUNCTION(usb2),
 };
 
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
-- 
1.8.1.5

