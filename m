From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 May 2013 23:15:50 +0000
Subject: [PATCH v4 3/4] sh-pfc: r8a7778: add Ether pin groups
Message-Id: <201305090315.50774.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add Ether RMII/LINK/MAGIC pin groups to R8A7778 PFC driver.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes from version 3:
- refreshed the patch.

Changes from version 2:
- fixed whitespace errors/warnings reported by scripts/checkpatch.pl.

Changes from the original posting:
- resolved reject, refreshed the patch;
- moved all pin groups to stay in the alphabetical order with the others;
- made use of SH_PFC_*() macros where possible. 

 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
=================================--- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1323,6 +1323,22 @@ static struct sh_pfc_pin pinmux_pins[]  						     arg5##_MARK, arg6##_MARK, \
 						     arg7##_MARK, arg8##_MARK, }
 
+/* - Ether ------------------------------------------------------------------ */
+SH_PFC_PINS(ether_rmii,		RCAR_GP_PIN(4, 10),	RCAR_GP_PIN(4, 11),
+				RCAR_GP_PIN(4, 13),	RCAR_GP_PIN(4, 9),
+				RCAR_GP_PIN(4, 15),	RCAR_GP_PIN(4, 16),
+				RCAR_GP_PIN(4, 12),	RCAR_GP_PIN(4, 14),
+				RCAR_GP_PIN(4, 18),	RCAR_GP_PIN(4, 17));
+static const unsigned int ether_rmii_mux[] = {
+	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK,  ETH_REF_CLK_MARK,
+	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_CRS_DV_MARK, ETH_RX_ER_MARK,
+	ETH_MDIO_MARK, ETH_MDC_MARK,
+};
+SH_PFC_PINS(ether_link,		RCAR_GP_PIN(4, 19));
+SH_PFC_MUX1(ether_link,		ETH_LINK);
+SH_PFC_PINS(ether_magic,	RCAR_GP_PIN(4, 20));
+SH_PFC_MUX1(ether_magic,	ETH_MAGIC);
+
 /* - SCIF macro ------------------------------------------------------------- */
 #define SCIF_PFC_PIN(name, args...)	SH_PFC_PINS(name, args)
 #define SCIF_PFC_DAT(name, tx, rx)	SH_PFC_MUX2(name, tx, rx)
@@ -1554,6 +1570,9 @@ VIN_PFC_PINS(vin1_sync,		RCAR_GP_PIN(3, 
 VIN_PFC_SYNC(vin1_sync,		VI1_HSYNC,		VI1_VSYNC);
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(ether_rmii),
+	SH_PFC_PIN_GROUP(ether_link),
+	SH_PFC_PIN_GROUP(ether_magic),
 	SH_PFC_PIN_GROUP(hscif0_data_a),
 	SH_PFC_PIN_GROUP(hscif0_data_b),
 	SH_PFC_PIN_GROUP(hscif0_ctrl_a),
@@ -1634,6 +1653,12 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(vin1_sync),
 };
 
+static const char * const ether_groups[] = {
+	"ether_rmii",
+	"ether_link",
+	"ether_magic",
+};
+
 static const char * const hscif0_groups[] = {
 	"hscif0_data_a",
 	"hscif0_data_b",
@@ -1762,6 +1787,7 @@ static const char * const vin1_groups[] 
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(ether),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
 	SH_PFC_FUNCTION(scif_clk),
