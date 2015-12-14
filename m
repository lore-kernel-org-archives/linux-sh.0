From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 14 Dec 2015 22:06:55 +0000
Subject: [PATCH v2] pinctrl: sh-pfc: r8a7791: add EtherAVB pin groups
Message-Id: <4277494.6KPmCjaGvB@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
In-Reply-To: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org, geert@linux-m68k.org

Add the EtherAVB pin groups to the R8A7791 PFC driver.

Also add the copyright for all the Cogent Embedded's past work on this file.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.

Changes in version 2:
- added AVB_TX_ER pin to the AVB MII group;
- added Cogent Embedded's copyright;
- refreshed the patch.

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   93 +++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -2,6 +2,7 @@
  * r8a7791 processor support - PFC hardware block.
  *
  * Copyright (C) 2013 Renesas Electronics Corporation
+ * Copyright (C) 2014-2015 Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2
@@ -1725,6 +1726,82 @@ static const unsigned int audio_clkout_m
 	AUDIO_CLKOUT_MARK,
 };
 
+/* - AVB -------------------------------------------------------------------- */
+static const unsigned int avb_link_pins[] = {
+	RCAR_GP_PIN(5, 14),
+};
+static const unsigned int avb_link_mux[] = {
+	AVB_LINK_MARK,
+};
+static const unsigned int avb_magic_pins[] = {
+	RCAR_GP_PIN(5, 11),
+};
+static const unsigned int avb_magic_mux[] = {
+	AVB_MAGIC_MARK,
+};
+static const unsigned int avb_phy_int_pins[] = {
+	RCAR_GP_PIN(5, 16),
+};
+static const unsigned int avb_phy_int_mux[] = {
+	AVB_PHY_INT_MARK,
+};
+static const unsigned int avb_mdio_pins[] = {
+	RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 9),
+};
+static const unsigned int avb_mdio_mux[] = {
+	AVB_MDC_MARK, AVB_MDIO_MARK,
+};
+static const unsigned int avb_mii_pins[] = {
+	RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 20),
+	RCAR_GP_PIN(5, 21),
+
+	RCAR_GP_PIN(5, 0), RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
+	RCAR_GP_PIN(5, 3),
+
+	RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 10),
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 27),
+	RCAR_GP_PIN(5, 28), RCAR_GP_PIN(5, 29),
+};
+static const unsigned int avb_mii_mux[] = {
+	AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
+	AVB_TXD3_MARK,
+
+	AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
+	AVB_RXD3_MARK,
+
+	AVB_RX_ER_MARK, AVB_RX_CLK_MARK, AVB_RX_DV_MARK,
+	AVB_CRS_MARK, AVB_TX_EN_MARK, AVB_TX_ER_MARK,
+	AVB_TX_CLK_MARK, AVB_COL_MARK,
+};
+static const unsigned int avb_gmii_pins[] = {
+	RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 20),
+	RCAR_GP_PIN(5, 21), RCAR_GP_PIN(5, 22), RCAR_GP_PIN(5, 23),
+	RCAR_GP_PIN(5, 24), RCAR_GP_PIN(5, 25),
+
+	RCAR_GP_PIN(5, 0), RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
+	RCAR_GP_PIN(5, 3), RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 5),
+	RCAR_GP_PIN(5, 6), RCAR_GP_PIN(5, 7),
+
+	RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 10),
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 30), RCAR_GP_PIN(5, 17),
+	RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 27), RCAR_GP_PIN(5, 28),
+	RCAR_GP_PIN(5, 29),
+};
+static const unsigned int avb_gmii_mux[] = {
+	AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
+	AVB_TXD3_MARK, AVB_TXD4_MARK, AVB_TXD5_MARK,
+	AVB_TXD6_MARK, AVB_TXD7_MARK,
+
+	AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
+	AVB_RXD3_MARK, AVB_RXD4_MARK, AVB_RXD5_MARK,
+	AVB_RXD6_MARK, AVB_RXD7_MARK,
+
+	AVB_RX_ER_MARK, AVB_RX_CLK_MARK, AVB_RX_DV_MARK,
+	AVB_CRS_MARK, AVB_GTX_CLK_MARK, AVB_GTXREFCLK_MARK,
+	AVB_TX_EN_MARK, AVB_TX_ER_MARK, AVB_TX_CLK_MARK,
+	AVB_COL_MARK,
+};
+
 /* - CAN -------------------------------------------------------------------- */
 
 static const unsigned int can0_data_pins[] = {
@@ -4260,6 +4337,12 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(audio_clk_b_b),
 	SH_PFC_PIN_GROUP(audio_clk_c),
 	SH_PFC_PIN_GROUP(audio_clkout),
+	SH_PFC_PIN_GROUP(avb_link),
+	SH_PFC_PIN_GROUP(avb_magic),
+	SH_PFC_PIN_GROUP(avb_phy_int),
+	SH_PFC_PIN_GROUP(avb_mdio),
+	SH_PFC_PIN_GROUP(avb_mii),
+	SH_PFC_PIN_GROUP(avb_gmii),
 	SH_PFC_PIN_GROUP(can0_data),
 	SH_PFC_PIN_GROUP(can0_data_b),
 	SH_PFC_PIN_GROUP(can0_data_c),
@@ -4601,6 +4684,15 @@ static const char * const audio_clk_grou
 	"audio_clkout",
 };
 
+static const char * const avb_groups[] = {
+	"avb_link",
+	"avb_magic",
+	"avb_phy_int",
+	"avb_mdio",
+	"avb_mii",
+	"avb_gmii",
+};
+
 static const char * const can0_groups[] = {
 	"can0_data",
 	"can0_data_b",
@@ -5090,6 +5182,7 @@ static const char * const vin2_groups[]
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
+	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(can0),
 	SH_PFC_FUNCTION(can1),
 	SH_PFC_FUNCTION(du),

