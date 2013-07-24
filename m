From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Jul 2013 13:15:18 +0000
Subject: [PATCH 12/14] sh-pfc: r8a7790: Add SCIF2 pin groups and functions
Message-Id: <1374671720-8794-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 9acb0e5..2fd904f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -2311,6 +2311,28 @@ static const unsigned int scif1_clk_e_pins[] = {
 static const unsigned int scif1_clk_e_mux[] = {
 	SCK1_E_MARK,
 };
+/* - SCIF2 ------------------------------------------------------------------ */
+static const unsigned int scif2_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 6), RCAR_GP_PIN(5, 5),
+};
+static const unsigned int scif2_data_mux[] = {
+	RX2_MARK, TX2_MARK,
+};
+static const unsigned int scif2_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 4),
+};
+static const unsigned int scif2_clk_mux[] = {
+	SCK2_MARK,
+};
+static const unsigned int scif2_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(0, 24), RCAR_GP_PIN(0, 25),
+};
+static const unsigned int scif2_data_b_mux[] = {
+	RX2_B_MARK, TX2_B_MARK,
+};
 /* - SCIFA0 ----------------------------------------------------------------- */
 static const unsigned int scifa0_data_pins[] = {
 	/* RXD, TXD */
@@ -2921,6 +2943,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif1_clk_d),
 	SH_PFC_PIN_GROUP(scif1_data_e),
 	SH_PFC_PIN_GROUP(scif1_clk_e),
+	SH_PFC_PIN_GROUP(scif2_data),
+	SH_PFC_PIN_GROUP(scif2_clk),
+	SH_PFC_PIN_GROUP(scif2_data_b),
 	SH_PFC_PIN_GROUP(scifa0_data),
 	SH_PFC_PIN_GROUP(scifa0_clk),
 	SH_PFC_PIN_GROUP(scifa0_ctrl),
@@ -3106,6 +3131,12 @@ static const char * const scif1_groups[] = {
 	"scif1_clk_e",
 };
 
+static const char * const scif2_groups[] = {
+	"scif2_data",
+	"scif2_clk",
+	"scif2_data_b",
+};
+
 static const char * const scifa0_groups[] = {
 	"scifa0_data",
 	"scifa0_clk",
@@ -3227,6 +3258,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(msiof3),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
+	SH_PFC_FUNCTION(scif2),
 	SH_PFC_FUNCTION(scifa0),
 	SH_PFC_FUNCTION(scifa1),
 	SH_PFC_FUNCTION(scifa2),
-- 
1.8.1.5

