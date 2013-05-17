From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 May 2013 14:55:13 +0000
Subject: [PATCH 2/9] pinctrl: r8a73a4: add pinmux data for MMCIF and SDHI interfaces
Message-Id: <1368802520-16378-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds pinmux groups and functions for the two MMCIF and three
SDHI interfaces on r8a73a4 (APE6).

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  200 ++++++++++++++++++++++++++++++++++
 1 files changed, 200 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index bbff559..1fc7410 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -1684,6 +1684,148 @@ static const unsigned int scifb3_ctrl_b_mux[] = {
 	SCIFB3_RTS_38_MARK, SCIFB3_CTS_39_MARK,
 };
 
+/* - SDHI0 ------------------------------------------------------------------ */
+static const unsigned int sdhi0_data1_pins[] = {
+	/* D0 */
+	302,
+};
+static const unsigned int sdhi0_data1_mux[] = {
+	SDHID0_0_MARK,
+};
+static const unsigned int sdhi0_data4_pins[] = {
+	/* D[0:3] */
+	302, 303, 304, 305,
+};
+static const unsigned int sdhi0_data4_mux[] = {
+	SDHID0_0_MARK, SDHID0_1_MARK, SDHID0_2_MARK, SDHID0_3_MARK,
+};
+static const unsigned int sdhi0_ctrl_pins[] = {
+	/* CLK, CMD */
+	308, 306,
+};
+static const unsigned int sdhi0_ctrl_mux[] = {
+	SDHICLK0_MARK, SDHICMD0_MARK,
+};
+static const unsigned int sdhi0_cd_pins[] = {
+	/* CD */
+	301,
+};
+static const unsigned int sdhi0_cd_mux[] = {
+	SDHICD0_MARK,
+};
+static const unsigned int sdhi0_wp_pins[] = {
+	/* WP */
+	307,
+};
+static const unsigned int sdhi0_wp_mux[] = {
+	SDHIWP0_MARK,
+};
+/* - SDHI1 ------------------------------------------------------------------ */
+static const unsigned int sdhi1_data1_pins[] = {
+	/* D0 */
+	289,
+};
+static const unsigned int sdhi1_data1_mux[] = {
+	SDHID1_0_MARK,
+};
+static const unsigned int sdhi1_data4_pins[] = {
+	/* D[0:3] */
+	289, 290, 291, 292,
+};
+static const unsigned int sdhi1_data4_mux[] = {
+	SDHID1_0_MARK, SDHID1_1_MARK, SDHID1_2_MARK, SDHID1_3_MARK,
+};
+static const unsigned int sdhi1_ctrl_pins[] = {
+	/* CLK, CMD */
+	293, 294,
+};
+static const unsigned int sdhi1_ctrl_mux[] = {
+	SDHICLK1_MARK, SDHICMD1_MARK,
+};
+/* - SDHI2 ------------------------------------------------------------------ */
+static const unsigned int sdhi2_data1_pins[] = {
+	/* D0 */
+	295,
+};
+static const unsigned int sdhi2_data1_mux[] = {
+	SDHID2_0_MARK,
+};
+static const unsigned int sdhi2_data4_pins[] = {
+	/* D[0:3] */
+	295, 296, 297, 298,
+};
+static const unsigned int sdhi2_data4_mux[] = {
+	SDHID2_0_MARK, SDHID2_1_MARK, SDHID2_2_MARK, SDHID2_3_MARK,
+};
+static const unsigned int sdhi2_ctrl_pins[] = {
+	/* CLK, CMD */
+	299, 300,
+};
+static const unsigned int sdhi2_ctrl_mux[] = {
+	SDHICLK2_MARK, SDHICMD2_MARK,
+};
+
+/* - MMCIF0 ----------------------------------------------------------------- */
+static const unsigned int mmc0_data1_pins[] = {
+	/* D[0] */
+	164,
+};
+static const unsigned int mmc0_data1_mux[] = {
+	MMCD0_0_MARK,
+};
+static const unsigned int mmc0_data4_pins[] = {
+	/* D[0:3] */
+	164, 165, 166, 167,
+};
+static const unsigned int mmc0_data4_mux[] = {
+	MMCD0_0_MARK, MMCD0_1_MARK, MMCD0_2_MARK, MMCD0_3_MARK,
+};
+static const unsigned int mmc0_data8_pins[] = {
+	/* D[0:7] */
+	164, 165, 166, 167, 168, 169, 170, 171,
+};
+static const unsigned int mmc0_data8_mux[] = {
+	MMCD0_0_MARK, MMCD0_1_MARK, MMCD0_2_MARK, MMCD0_3_MARK,
+	MMCD0_4_MARK, MMCD0_5_MARK, MMCD0_6_MARK, MMCD0_7_MARK,
+};
+static const unsigned int mmc0_ctrl_pins[] = {
+	/* CMD, CLK */
+	172, 173,
+};
+static const unsigned int mmc0_ctrl_mux[] = {
+	MMCCMD0_MARK, MMCCLK0_MARK,
+};
+/* - MMCIF1 ----------------------------------------------------------------- */
+static const unsigned int mmc1_data1_pins[] = {
+	/* D[0] */
+	199,
+};
+static const unsigned int mmc1_data1_mux[] = {
+	MMCD1_0_MARK,
+};
+static const unsigned int mmc1_data4_pins[] = {
+	/* D[0:3] */
+	199, 198, 197, 196,
+};
+static const unsigned int mmc1_data4_mux[] = {
+	MMCD1_0_MARK, MMCD1_1_MARK, MMCD1_2_MARK, MMCD1_3_MARK,
+};
+static const unsigned int mmc1_data8_pins[] = {
+	/* D[0:7] */
+	199, 198, 197, 196, 195, 194, 193, 192,
+};
+static const unsigned int mmc1_data8_mux[] = {
+	MMCD1_0_MARK, MMCD1_1_MARK, MMCD1_2_MARK, MMCD1_3_MARK,
+	MMCD1_4_MARK, MMCD1_5_MARK, MMCD1_6_MARK, MMCD1_7_MARK,
+};
+static const unsigned int mmc1_ctrl_pins[] = {
+	/* CMD, CLK */
+	200, 203,
+};
+static const unsigned int mmc1_ctrl_mux[] = {
+	MMCCMD1_MARK, MMCCLK1_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(irqc_irq0),
 	SH_PFC_PIN_GROUP(irqc_irq1),
@@ -1770,6 +1912,25 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb3_data_b),
 	SH_PFC_PIN_GROUP(scifb3_clk_b),
 	SH_PFC_PIN_GROUP(scifb3_ctrl_b),
+	SH_PFC_PIN_GROUP(sdhi0_data1),
+	SH_PFC_PIN_GROUP(sdhi0_data4),
+	SH_PFC_PIN_GROUP(sdhi0_ctrl),
+	SH_PFC_PIN_GROUP(sdhi0_cd),
+	SH_PFC_PIN_GROUP(sdhi0_wp),
+	SH_PFC_PIN_GROUP(sdhi1_data1),
+	SH_PFC_PIN_GROUP(sdhi1_data4),
+	SH_PFC_PIN_GROUP(sdhi1_ctrl),
+	SH_PFC_PIN_GROUP(sdhi2_data1),
+	SH_PFC_PIN_GROUP(sdhi2_data4),
+	SH_PFC_PIN_GROUP(sdhi2_ctrl),
+	SH_PFC_PIN_GROUP(mmc0_data1),
+	SH_PFC_PIN_GROUP(mmc0_data4),
+	SH_PFC_PIN_GROUP(mmc0_data8),
+	SH_PFC_PIN_GROUP(mmc0_ctrl),
+	SH_PFC_PIN_GROUP(mmc1_data1),
+	SH_PFC_PIN_GROUP(mmc1_data4),
+	SH_PFC_PIN_GROUP(mmc1_data8),
+	SH_PFC_PIN_GROUP(mmc1_ctrl),
 };
 
 static const char * const irqc_groups[] = {
@@ -1878,6 +2039,40 @@ static const char * const scifb3_groups[] = {
 	"scifb3_ctrl_b",
 };
 
+static const char * const sdhi0_groups[] = {
+	"sdhi0_data1",
+	"sdhi0_data4",
+	"sdhi0_ctrl",
+	"sdhi0_cd",
+	"sdhi0_wp",
+};
+
+static const char * const sdhi1_groups[] = {
+	"sdhi1_data1",
+	"sdhi1_data4",
+	"sdhi1_ctrl",
+};
+
+static const char * const sdhi2_groups[] = {
+	"sdhi2_data1",
+	"sdhi2_data4",
+	"sdhi2_ctrl",
+};
+
+static const char * const mmc0_groups[] = {
+	"mmc0_data1",
+	"mmc0_data4",
+	"mmc0_data8",
+	"mmc0_ctrl",
+};
+
+static const char * const mmc1_groups[] = {
+	"mmc1_data1",
+	"mmc1_data4",
+	"mmc1_data8",
+	"mmc1_ctrl",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(irqc),
 	SH_PFC_FUNCTION(scifa0),
@@ -1886,6 +2081,11 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scifb1),
 	SH_PFC_FUNCTION(scifb2),
 	SH_PFC_FUNCTION(scifb3),
+	SH_PFC_FUNCTION(sdhi0),
+	SH_PFC_FUNCTION(sdhi1),
+	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(mmc0),
+	SH_PFC_FUNCTION(mmc1),
 };
 
 #undef PORTCR
-- 
1.7.2.5

