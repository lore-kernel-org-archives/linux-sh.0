From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 May 2013 07:15:07 +0000
Subject: [PATCH 03/12] sh-pfc: r8a7778: add MMCIF pin groups
Message-Id: <87ehd7wg3s.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add MMCIF CLK/CMD/DATA groups to R8A7778 PFC driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 137dd59..8a8060c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1434,6 +1434,33 @@ SCIF_PFC_CLK(hscif1_clk_a,	HSCK1_A);
 SCIF_PFC_PIN(hscif1_clk_b,	RCAR_GP_PIN(4, 2));
 SCIF_PFC_CLK(hscif1_clk_b,	HSCK1_B);
 
+/* - MMC macro -------------------------------------------------------------- */
+#define MMC_PFC_PINS(name, args...)		SH_PFC_PINS(name, args)
+#define MMC_PFC_CTRL(name, clk, cmd)		SH_PFC_MUX2(name, clk, cmd)
+#define MMC_PFC_DAT1(name, d0)			SH_PFC_MUX1(name, d0)
+#define MMC_PFC_DAT4(name, d0, d1, d2, d3)	SH_PFC_MUX4(name, d0, d1, d2, d3)
+#define MMC_PFC_DAT8(name, d0, d1, d2, d3, d4, d5, d6, d7)\
+						SH_PFC_MUX8(name, d0, d1, d2, d3, \
+								  d4, d5, d6, d7)
+
+/* - MMC -------------------------------------------------------------------- */
+MMC_PFC_PINS(mmc_ctrl,		RCAR_GP_PIN(1, 5),	RCAR_GP_PIN(1, 6));
+MMC_PFC_CTRL(mmc_ctrl,		MMC_CLK,		MMC_CMD);
+MMC_PFC_PINS(mmc_data1,		RCAR_GP_PIN(1, 7));
+MMC_PFC_DAT1(mmc_data1,		MMC_D0);
+MMC_PFC_PINS(mmc_data4,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
+				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6));
+MMC_PFC_DAT4(mmc_data4,		MMC_D0,			MMC_D1,
+				MMC_D2,			MMC_D3);
+MMC_PFC_PINS(mmc_data8,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
+				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6),
+				RCAR_GP_PIN(1, 4),	RCAR_GP_PIN(1, 0),
+				RCAR_GP_PIN(0, 30),	RCAR_GP_PIN(0, 31));
+MMC_PFC_DAT8(mmc_data8,		MMC_D0,			MMC_D1,
+				MMC_D2,			MMC_D3,
+				MMC_D4,			MMC_D5,
+				MMC_D6,			MMC_D7);
+
 /* - SCIF CLOCK ------------------------------------------------------------- */
 SCIF_PFC_PIN(scif_clk,		RCAR_GP_PIN(1, 16));
 SCIF_PFC_CLK(scif_clk,		SCIF_CLK);
@@ -1661,6 +1688,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
 	SH_PFC_PIN_GROUP(hscif1_clk_a),
 	SH_PFC_PIN_GROUP(hscif1_clk_b),
+	SH_PFC_PIN_GROUP(mmc_ctrl),
+	SH_PFC_PIN_GROUP(mmc_data1),
+	SH_PFC_PIN_GROUP(mmc_data4),
+	SH_PFC_PIN_GROUP(mmc_data8),
 	SH_PFC_PIN_GROUP(scif_clk),
 	SH_PFC_PIN_GROUP(scif0_data_a),
 	SH_PFC_PIN_GROUP(scif0_data_b),
@@ -1785,6 +1816,13 @@ static const char * const hscif1_groups[] = {
 	"hscif1_clk_b",
 };
 
+static const char * const mmc_groups[] = {
+	"mmc_ctrl",
+	"mmc_data1",
+	"mmc_data4",
+	"mmc_data8",
+};
+
 static const char * const scif_clk_groups[] = {
 	"scif_clk",
 };
@@ -1905,6 +1943,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(hspi2),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
+	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
-- 
1.7.9.5

