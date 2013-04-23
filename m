From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 23 Apr 2013 17:24:05 +0000
Subject: [PATCH v3 2/5] sh-pfc: r8a7778: add VIN pin groups
Message-Id: <201304232124.05793.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add VIN DATA[0:8]/CLK/HSYNC/VSYNC pin groups to R8A7778 PFC driver.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
[Sergei: updated the copyrights.]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>

---
Changes from version 2:
- resolved rejects, refreshed the patch;
- added ACKs from Laurent Pinchart and Linus Walleij.

 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   74 +++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
=================================--- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2013  Renesas Solutions Corp.
  * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ * Copyright (C) 2013  Cogent Embedded, Inc.
  *
  * based on
  * Copyright (C) 2011  Renesas Solutions Corp.
@@ -1505,6 +1506,59 @@ SDHI_PFC_PINS(sdhi2_b_wp,	RCAR_GP_PIN(3,
 SDHI_PFC_WPPN(sdhi2_b_wp,	SD2_WP_B);
 
 
+/* - VIN0 ------------------------------------------------------------------- */
+static const unsigned int vin0_data8_pins[] = {
+	/* D[0:7] */
+	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(3, 30), RCAR_GP_PIN(3, 31),
+	RCAR_GP_PIN(4, 0),  RCAR_GP_PIN(4, 1),  RCAR_GP_PIN(4, 2),
+	RCAR_GP_PIN(4, 3),  RCAR_GP_PIN(4, 4),
+};
+static const unsigned int vin0_data8_mux[] = {
+	VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK, VI0_DATA2_VI0_B2_MARK,
+	VI0_DATA3_VI0_B3_MARK, VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+	VI0_DATA6_VI0_G0_MARK, VI0_DATA7_VI0_G1_MARK,
+};
+static const unsigned int vin0_clk_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(3, 24),
+};
+static const unsigned int vin0_clk_mux[] = {
+	VI0_CLK_MARK,
+};
+static const unsigned int vin0_sync_pins[] = {
+	/* HSYNC, VSYNC */
+	RCAR_GP_PIN(3, 27), RCAR_GP_PIN(3, 28),
+};
+static const unsigned int vin0_sync_mux[] = {
+	VI0_HSYNC_MARK, VI0_VSYNC_MARK,
+};
+/* - VIN1 ------------------------------------------------------------------- */
+static const unsigned int vin1_data8_pins[] = {
+	/* D[0:7] */
+	RCAR_GP_PIN(3, 25), RCAR_GP_PIN(3, 26), RCAR_GP_PIN(3, 27),
+	RCAR_GP_PIN(3, 28), RCAR_GP_PIN(4, 5),  RCAR_GP_PIN(4, 6),
+	RCAR_GP_PIN(4, 7),  RCAR_GP_PIN(4, 8),
+};
+static const unsigned int vin1_data8_mux[] = {
+	VI1_DATA0_MARK, VI1_DATA1_MARK, VI1_DATA2_MARK,
+	VI1_DATA3_MARK, VI1_DATA4_MARK, VI1_DATA5_MARK,
+	VI1_DATA6_MARK, VI1_DATA7_MARK,
+};
+static const unsigned int vin1_clk_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(4, 9),
+};
+static const unsigned int vin1_clk_mux[] = {
+	VI1_CLK_MARK,
+};
+static const unsigned int vin1_sync_pins[] = {
+	/* HSYNC, VSYNC */
+	RCAR_GP_PIN(3, 21), RCAR_GP_PIN(3, 22),
+};
+static const unsigned int vin1_sync_mux[] = {
+	VI1_HSYNC_MARK, VI1_VSYNC_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(hscif0_data_a),
 	SH_PFC_PIN_GROUP(hscif0_data_b),
@@ -1574,6 +1628,12 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(sdhi2_b_data1),
 	SH_PFC_PIN_GROUP(sdhi2_b_data4),
 	SH_PFC_PIN_GROUP(sdhi2_b_wp),
+	SH_PFC_PIN_GROUP(vin0_data8),
+	SH_PFC_PIN_GROUP(vin0_clk),
+	SH_PFC_PIN_GROUP(vin0_sync),
+	SH_PFC_PIN_GROUP(vin1_data8),
+	SH_PFC_PIN_GROUP(vin1_clk),
+	SH_PFC_PIN_GROUP(vin1_sync),
 };
 
 static const char * const hscif0_groups[] = {
@@ -1681,6 +1741,18 @@ static const char * const sdhi2_groups[]
 	"sdhi2_b_wp",
 };
 
+static const char * const vin0_groups[] = {
+	"vin0_data8",
+	"vin0_clk",
+	"vin0_sync",
+};
+
+static const char * const vin1_groups[] = {
+	"vin1_data8",
+	"vin1_clk",
+	"vin1_sync",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
@@ -1694,6 +1766,8 @@ static const struct sh_pfc_function pinm
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(vin0),
+	SH_PFC_FUNCTION(vin1),
 };
 
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
