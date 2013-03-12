From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 12 Mar 2013 15:48:29 +0000
Subject: [PATCH v3.1 3/4] sh-pfc: sh73a0: Add USB pin groups and functions
Message-Id: <1363103310-16260-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index ba8efa8..f5fa2be 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2615,6 +2615,14 @@ static const unsigned int sdhi2_ctrl_mux[] = {
 	SDHICMD2_MARK, SDHICLK2_MARK,
 };
 
+static const unsigned int usb_vbus_pins[] = {
+	/* VBUS */
+	0,
+};
+static const unsigned int usb_vbus_mux[] = {
+	VBUS_0_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(bsc_data_0_7),
 	SH_PFC_PIN_GROUP(bsc_data_8_15),
@@ -2755,6 +2763,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi2_data1),
 	SH_PFC_PIN_GROUP(sdhi2_data4),
 	SH_PFC_PIN_GROUP(sdhi2_ctrl),
+	SH_PFC_PIN_GROUP(usb_vbus),
 };
 
 static const char * const bsc_groups[] = {
@@ -2964,6 +2973,10 @@ static const char * const sdhi2_groups[] = {
 	"sdhi2_ctrl",
 };
 
+static const char * const usb_groups[] = {
+	"usb_vbus",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(bsc),
 	SH_PFC_FUNCTION(fsia),
@@ -2988,6 +3001,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(usb),
 };
 
 #define PINMUX_FN_BASE	GPIO_FN_VBUS_0
-- 
1.8.1.5

