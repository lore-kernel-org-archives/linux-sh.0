From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 23 Apr 2013 19:36:37 +0000
Subject: [PATCH 2/2] sh-pfc: r8a7779: add Ether pin groups
Message-Id: <201304232336.37563.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add Ether RMII/LINK/MAGIC pin groups to R8A7779 PFC driver.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
=================================--- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2518,6 +2518,38 @@ static const unsigned int vin3_sync_pins
 static const unsigned int vin3_sync_mux[] = {
 	VI3_HSYNC_MARK, VI3_VSYNC_MARK,
 };
+/* - Ether ------------------------------------------------------------------ */
+static const unsigned int ether_rmii_pins[] = {
+	/*
+	 * ETH_TXD0, ETH_TXD1, ETH_TX_EN,  ETH_REFCLK,
+	 * ETH_RXD0, ETH_RXD1, ETH_CRS_DV, ETH_RX_ER,
+	 * ETH_MDIO, ETH_MDC
+	 */
+	RCAR_GP_PIN(2, 27), RCAR_GP_PIN(2, 16), RCAR_GP_PIN(2, 18),
+	RCAR_GP_PIN(2, 26),
+	RCAR_GP_PIN(2, 20), RCAR_GP_PIN(2, 21), RCAR_GP_PIN(2, 17),
+	RCAR_GP_PIN(2, 19),
+	RCAR_GP_PIN(2, 29), RCAR_GP_PIN(2, 28),
+};
+static const unsigned int ether_rmii_mux[] = {
+	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK,  ETH_REFCLK_MARK,
+	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_CRS_DV_MARK, ETH_RX_ER_MARK,
+	ETH_MDIO_MARK, ETH_MDC_MARK,
+};
+static const unsigned int ether_link_pins[] = {
+	/* ETH_LINK */
+	RCAR_GP_PIN(2, 24),
+};
+static const unsigned int ether_link_mux[] = {
+	ETH_LINK_MARK,
+};
+static const unsigned int ether_magic_pins[] = {
+	/* ETH_MAGIC */
+	RCAR_GP_PIN(2, 25),
+};
+static const unsigned int ether_magic_mux[] = {
+	ETH_MAGIC_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du0_rgb666),
@@ -2654,6 +2686,9 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(vin3_data8),
 	SH_PFC_PIN_GROUP(vin3_clk),
 	SH_PFC_PIN_GROUP(vin3_sync),
+	SH_PFC_PIN_GROUP(ether_rmii),
+	SH_PFC_PIN_GROUP(ether_link),
+	SH_PFC_PIN_GROUP(ether_magic),
 };
 
 static const char * const du0_groups[] = {
@@ -2868,6 +2903,12 @@ static const char * const vin3_groups[] 
 	"vin3_sync",
 };
 
+static const char * const ether_groups[] = {
+	"ether_rmii",
+	"ether_link",
+	"ether_magic",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
@@ -2895,6 +2936,7 @@ static const struct sh_pfc_function pinm
 	SH_PFC_FUNCTION(vin1),
 	SH_PFC_FUNCTION(vin2),
 	SH_PFC_FUNCTION(vin3),
+	SH_PFC_FUNCTION(ether),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
