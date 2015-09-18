From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Sep 2015 06:00:01 +0000
Subject: [PATCH/RFC v2] sh-pfc: r8a7795: add EtherAVB support
Message-Id: <1442556001-7041-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds EthernetAVB

Based on a much lager patch by Takeshi Kihara which was
originally posted by Kuninori Morimoto.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms: extracted from a larger patch;
        corrected swapped {MATCH,CAPTURE_A} pins]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v2
* Added Reviewed-by
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 86 ++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
---
Base:
* "[PATCH 0/9 v2] sh-pfc: modify PINMUX_IPSR_MSEL() and r8a7795 support"
  aka the topic/r8a7795-pfc-v2 branch of Geert's renesas-drivers tree.

Availability:

To aid review of this and other EtherAVB patches the following branches are
available in my renesas tree on kernel.org.

* me/r8a7795-ravb-pfc-v2: this patch
* me/r8a7795-ravb-driver-v3: phylib and EthernetAVB driver update for r8a7795
* me/r8a7795-ravb-integration-v3: enable EthernetAVB on r8a7795
* me/r8a7795-ravb-driver-and-integration-v3.runtime:
      the above three branches with their runtime dependencies

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index aff3895d9955..fcb9fed77d9e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -1426,6 +1426,70 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
+/* - EtherAVB --------------------------------------------------------------- */
+static const unsigned int avb_link_pins[] = {
+	/* AVB_LINK */
+	RCAR_GP_PIN(2, 12),
+};
+static const unsigned int avb_link_mux[] = {
+	AVB_LINK_MARK,
+};
+static const unsigned int avb_magic_pins[] = {
+	/* AVB_MAGIC_ */
+	RCAR_GP_PIN(2, 10),
+};
+static const unsigned int avb_magic_mux[] = {
+	AVB_MAGIC_MARK,
+};
+static const unsigned int avb_phy_int_pins[] = {
+	/* AVB_PHY_INT */
+	RCAR_GP_PIN(2, 11),
+};
+static const unsigned int avb_phy_int_mux[] = {
+	AVB_PHY_INT_MARK,
+};
+static const unsigned int avb_mdc_pins[] = {
+	/* AVB_MDC */
+	RCAR_GP_PIN(2, 9),
+};
+static const unsigned int avb_mdc_mux[] = {
+	AVB_MDC_MARK,
+};
+static const unsigned int avb_avtp_pps_pins[] = {
+	/* AVB_AVTP_PPS */
+	RCAR_GP_PIN(2, 6),
+};
+static const unsigned int avb_avtp_pps_mux[] = {
+	AVB_AVTP_PPS_MARK,
+};
+static const unsigned int avb_avtp_match_a_pins[] = {
+	/* AVB_AVTP_MATCH_A */
+	RCAR_GP_PIN(2, 13),
+};
+static const unsigned int avb_avtp_match_a_mux[] = {
+	AVB_AVTP_MATCH_A_MARK,
+};
+static const unsigned int avb_avtp_capture_a_pins[] = {
+	/* AVB_AVTP_CAPTURE_A */
+	RCAR_GP_PIN(2, 14),
+};
+static const unsigned int avb_avtp_capture_a_mux[] = {
+	AVB_AVTP_CAPTURE_A_MARK,
+};
+static const unsigned int avb_avtp_match_b_pins[] = {
+	/*  AVB_AVTP_MATCH_B */
+	RCAR_GP_PIN(1, 8),
+};
+static const unsigned int avb_avtp_match_b_mux[] = {
+	AVB_AVTP_MATCH_B_MARK,
+};
+static const unsigned int avb_avtp_capture_b_pins[] = {
+	/* AVB_AVTP_CAPTURE_B */
+	RCAR_GP_PIN(1, 11),
+};
+static const unsigned int avb_avtp_capture_b_mux[] = {
+	AVB_AVTP_CAPTURE_B_MARK,
+};
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
 	/* RX, TX */
@@ -1610,6 +1674,15 @@ static const unsigned int scif5_clk_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(avb_link),
+	SH_PFC_PIN_GROUP(avb_magic),
+	SH_PFC_PIN_GROUP(avb_phy_int),
+	SH_PFC_PIN_GROUP(avb_mdc),
+	SH_PFC_PIN_GROUP(avb_avtp_pps),
+	SH_PFC_PIN_GROUP(avb_avtp_match_a),
+	SH_PFC_PIN_GROUP(avb_avtp_capture_a),
+	SH_PFC_PIN_GROUP(avb_avtp_match_b),
+	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_clk),
 	SH_PFC_PIN_GROUP(scif0_ctrl),
@@ -1637,6 +1710,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif5_clk),
 };
 
+static const char * const avb_groups[] = {
+	"avb_link",
+	"avb_magic",
+	"avb_phy_int",
+	"avb_mdc",
+	"avb_avtp_pps",
+	"avb_avtp_match_a",
+	"avb_avtp_capture_a",
+	"avb_avtp_match_b",
+	"avb_avtp_capture_b",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data",
 	"scif0_clk",
@@ -1681,6 +1766,7 @@ static const char * const scif5_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
2.1.4

