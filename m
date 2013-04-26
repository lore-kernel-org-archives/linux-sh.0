From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Apr 2013 22:48:22 +0000
Subject: [PATCH v3 3/3] sh-pfc: r8a7779: add Ether pin groups
Message-Id: <201304270248.22740.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add Ether RMII/LINK/MAGIC pin groups to R8A7779 PFC driver.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes from the original posting:
- moved all pin groups to stay in the alphabetical order with the others.

 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
=================================--- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -1640,6 +1640,38 @@ static const unsigned int du1_cde_pins[]
 static const unsigned int du1_cde_mux[] = {
 	DU1_CDE_MARK
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
 /* - HSPI0 ------------------------------------------------------------------ */
 static const unsigned int hspi0_pins[] = {
 	/* CLK, CS, RX, TX */
@@ -2537,6 +2569,9 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(du1_sync_1),
 	SH_PFC_PIN_GROUP(du1_oddf),
 	SH_PFC_PIN_GROUP(du1_cde),
+	SH_PFC_PIN_GROUP(ether_rmii),
+	SH_PFC_PIN_GROUP(ether_link),
+	SH_PFC_PIN_GROUP(ether_magic),
 	SH_PFC_PIN_GROUP(hspi0),
 	SH_PFC_PIN_GROUP(hspi1),
 	SH_PFC_PIN_GROUP(hspi1_b),
@@ -2679,6 +2714,12 @@ static const char * const du1_groups[]  	"du1_cde",
 };
 
+static const char * const ether_groups[] = {
+	"ether_rmii",
+	"ether_link",
+	"ether_magic",
+};
+
 static const char * const hspi0_groups[] = {
 	"hspi0",
 };
@@ -2871,6 +2912,7 @@ static const char * const vin3_groups[] 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
+	SH_PFC_FUNCTION(ether),
 	SH_PFC_FUNCTION(hspi0),
 	SH_PFC_FUNCTION(hspi1),
 	SH_PFC_FUNCTION(hspi2),

