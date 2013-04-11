From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Apr 2013 22:51:38 +0000
Subject: [PATCH] sh-pfc: R8A7779: add VIN pin groups
Message-Id: <201304120251.38652.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add VIN DATAx/CLK/HSYNC/VSYNC pin groups in R8A7779 PFC.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
These pins will be needed by the upcoming R-Car VIN driver...
The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130411v2' tag.

 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  139 ++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
=================================--- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -1,8 +1,9 @@
 /*
  * r8a7779 processor support - PFC hardware block
  *
- * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011, 2013  Renesas Solutions Corp.
  * Copyright (C) 2011  Magnus Damm
+ * Copyright (C) 2013  Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -2413,6 +2414,102 @@ static const unsigned int usb2_pins[] = 
 static const unsigned int usb2_mux[] = {
 	USB_OVC2_MARK, USB_PENC2_MARK,
 };
+/* - VIN0 ------------------------------------------------------------------- */
+static const unsigned int vin0_data8_pins[] = {
+	/* D[0:7] */
+	70, 71, 72, 73, 74, 75, 76, 77,
+};
+static const unsigned int vin0_data8_mux[] = {
+	VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK, VI0_DATA2_VI0_B2_MARK,
+	VI0_DATA3_VI0_B3_MARK, VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
+};
+static const unsigned int vin0_clk_pins[] = {
+	/* CLK */
+	65,
+};
+static const unsigned int vin0_clk_mux[] = {
+	VI0_CLK_MARK,
+};
+static const unsigned int vin0_sync_pins[] = {
+	/* HSYNC, VSYNC */
+	68, 69,
+};
+static const unsigned int vin0_sync_mux[] = {
+	VI0_HSYNC_MARK, VI0_VSYNC_MARK,
+};
+/* - VIN1 ------------------------------------------------------------------- */
+static const unsigned int vin1_data8_pins[] = {
+	/* D[0:7] */
+	97, 98, 99, 100, 101, 102, 103, 104,
+};
+static const unsigned int vin1_data8_mux[] = {
+	VI1_DATA0_VI1_B0_MARK, VI1_DATA1_VI1_B1_MARK, VI1_DATA2_VI1_B2_MARK,
+	VI1_DATA3_VI1_B3_MARK, VI1_DATA4_VI1_B4_MARK, VI1_DATA5_VI1_B5_MARK,
+	VI1_DATA6_VI1_B6_MARK, VI1_DATA7_VI1_B7_MARK,
+};
+static const unsigned int vin1_clk_pins[] = {
+	/* CLK */
+	94,
+};
+static const unsigned int vin1_clk_mux[] = {
+	VI1_CLK_MARK,
+};
+static const unsigned int vin1_sync_pins[] = {
+	/* HSYNC, VSYNC */
+	95, 96,
+};
+static const unsigned int vin1_sync_mux[] = {
+	VI1_HSYNC_MARK, VI1_VSYNC_MARK,
+};
+/* - VIN2 ------------------------------------------------------------------- */
+static const unsigned int vin2_data8_pins[] = {
+	/* D[0:7] */
+	34, 35, 42, 43, 50, 51, 63, 64,
+};
+static const unsigned int vin2_data8_mux[] = {
+	VI2_DATA0_VI2_B0_MARK, VI2_DATA1_VI2_B1_MARK, VI2_DATA2_VI2_B2_MARK,
+	VI2_DATA3_VI2_B3_MARK, VI2_DATA4_VI2_B4_MARK, VI2_DATA5_VI2_B5_MARK,
+	VI2_DATA6_VI2_B6_MARK, VI2_DATA7_VI2_B7_MARK,
+};
+static const unsigned int vin2_clk_pins[] = {
+	/* CLK */
+	62,
+};
+static const unsigned int vin2_clk_mux[] = {
+	VI2_CLK_MARK,
+};
+static const unsigned int vin2_sync_pins[] = {
+	/* HSYNC, VSYNC */
+	60, 61,
+};
+static const unsigned int vin2_sync_mux[] = {
+	VI2_HSYNC_MARK, VI2_VSYNC_MARK,
+};
+/* - VIN3 ------------------------------------------------------------------- */
+static const unsigned int vin3_data8_pins[] = {
+	/* D[0:7] */
+	105, 106, 107, 108, 109, 110, 111, 112,
+};
+static const unsigned int vin3_data8_mux[] = {
+	VI3_DATA0_MARK, VI3_DATA1_MARK, VI3_DATA2_MARK,
+	VI3_DATA3_MARK, VI3_DATA4_MARK, VI3_DATA5_MARK,
+	VI3_DATA6_MARK, VI3_DATA7_MARK,
+};
+static const unsigned int vin3_clk_pins[] = {
+	/* CLK */
+	95,
+};
+static const unsigned int vin3_clk_mux[] = {
+	VI3_CLK_MARK,
+};
+static const unsigned int vin3_sync_pins[] = {
+	/* HSYNC, VSYNC */
+	60, 61,
+};
+static const unsigned int vin3_sync_mux[] = {
+	VI3_HSYNC_MARK, VI3_VSYNC_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du0_rgb666),
@@ -2537,6 +2634,18 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
 	SH_PFC_PIN_GROUP(usb2),
+	SH_PFC_PIN_GROUP(vin0_data8),
+	SH_PFC_PIN_GROUP(vin0_clk),
+	SH_PFC_PIN_GROUP(vin0_sync),
+	SH_PFC_PIN_GROUP(vin1_data8),
+	SH_PFC_PIN_GROUP(vin1_clk),
+	SH_PFC_PIN_GROUP(vin1_sync),
+	SH_PFC_PIN_GROUP(vin2_data8),
+	SH_PFC_PIN_GROUP(vin2_clk),
+	SH_PFC_PIN_GROUP(vin2_sync),
+	SH_PFC_PIN_GROUP(vin3_data8),
+	SH_PFC_PIN_GROUP(vin3_clk),
+	SH_PFC_PIN_GROUP(vin3_sync),
 };
 
 static const char * const du0_groups[] = {
@@ -2727,6 +2836,30 @@ static const char * const usb2_groups[] 
 	"usb2",
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
+static const char * const vin2_groups[] = {
+	"vin2_data8",
+	"vin2_clk",
+	"vin2_sync",
+};
+
+static const char * const vin3_groups[] = {
+	"vin3_data8",
+	"vin3_clk",
+	"vin3_sync",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
@@ -2750,6 +2883,10 @@ static const struct sh_pfc_function pinm
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
 	SH_PFC_FUNCTION(usb2),
+	SH_PFC_FUNCTION(vin0),
+	SH_PFC_FUNCTION(vin1),
+	SH_PFC_FUNCTION(vin2),
+	SH_PFC_FUNCTION(vin3),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
