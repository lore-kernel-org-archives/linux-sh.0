From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 18 Aug 2015 22:26:55 +0000
Subject: [PATCH 1/2] pinctrl: sh-pfc: r8a7794: add USB pin groups
Message-Id: <6436990.f6AZfhkFnG@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
In-Reply-To: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Add USB0/1 pin groups to R8A7794 PFC driver.

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
[Sergei: rebased, renamed, added changelog.]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
=================================--- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -2770,6 +2770,24 @@ static const unsigned int sdhi2_wp_pins[
 static const unsigned int sdhi2_wp_mux[] = {
 	SD2_WP_MARK,
 };
+/* - USB0 ------------------------------------------------------------------- */
+static const unsigned int usb0_pins[] = {
+	RCAR_GP_PIN(5, 24), /* PWEN */
+	RCAR_GP_PIN(5, 25), /* OVC */
+};
+static const unsigned int usb0_mux[] = {
+	USB0_PWEN_MARK,
+	USB0_OVC_MARK,
+};
+/* - USB1 ------------------------------------------------------------------- */
+static const unsigned int usb1_pins[] = {
+	RCAR_GP_PIN(5, 26), /* PWEN */
+	RCAR_GP_PIN(5, 27), /* OVC */
+};
+static const unsigned int usb1_mux[] = {
+	USB1_PWEN_MARK,
+	USB1_OVC_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(eth_link),
@@ -2945,6 +2963,8 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(sdhi2_ctrl),
 	SH_PFC_PIN_GROUP(sdhi2_cd),
 	SH_PFC_PIN_GROUP(sdhi2_wp),
+	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb1),
 };
 
 static const char * const eth_groups[] = {
@@ -3219,6 +3239,14 @@ static const char * const sdhi2_groups[]
 	"sdhi2_wp",
 };
 
+static const char * const usb0_groups[] = {
+	"usb0",
+};
+
+static const char * const usb1_groups[] = {
+	"usb1",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(hscif0),
@@ -3253,6 +3281,8 @@ static const struct sh_pfc_function pinm
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(usb0),
+	SH_PFC_FUNCTION(usb1),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {

