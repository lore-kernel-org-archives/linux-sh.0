From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Apr 2013 05:16:30 +0000
Subject: [PATCH 1/6] sh-pfc: r8a7778: add SDHI support
Message-Id: <87ehe9enys.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   79 ++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index ddbd27b..7c22d33 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1417,6 +1417,63 @@ SCIF_PFC_DAT(scif5_data_a,	TX5_A,			RX5_A);
 SCIF_PFC_PIN(scif5_data_b,	RCAR_GP_PIN(1, 15),	RCAR_GP_PIN(1, 14));
 SCIF_PFC_DAT(scif5_data_b,	TX5_B,			RX5_B);
 
+/* - SDHI macro ------------------------------------------------------------- */
+#define SDHI_PFC(name, pclk, pcmd, pdat0, pdat1, pdat2, pdat3, pcd, pwp,\
+		       mclk, mcmd, mdat0, mdat1, mdat2, mdat3, mcd, mwp)\
+	static const unsigned int name ##_pins[] =			\
+	{ pclk, pcmd, pdat0, pdat1, pdat2, pdat3, pcd, pwp };		\
+	static const unsigned int name ##_mux[] =			\
+	{ mclk##_MARK,  mcmd##_MARK,  mdat0##_MARK, mdat1##_MARK,	\
+	  mdat2##_MARK, mdat3##_MARK, mcd##_MARK,   mwp##_MARK }
+
+/* - SDHI0 ------------------------------------------------------------------ */
+SDHI_PFC(sdhi0,		RCAR_GP_PIN(3, 11),	RCAR_GP_PIN(3, 12),
+			RCAR_GP_PIN(3, 13),	RCAR_GP_PIN(3, 14),
+			RCAR_GP_PIN(3, 15),	RCAR_GP_PIN(3, 16),
+			RCAR_GP_PIN(3, 17),	RCAR_GP_PIN(3, 18),
+			SD0_CLK,		SD0_CMD,
+			SD0_DAT0,		SD0_DAT1,
+			SD0_DAT2,		SD0_DAT3,
+			SD0_CD,			SD0_WP);
+
+/* - SDHI1 ------------------------------------------------------------------ */
+SDHI_PFC(sdhi1_a,	RCAR_GP_PIN(1, 5),	RCAR_GP_PIN(1, 6),
+			RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(1, 8),
+			RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6),
+			RCAR_GP_PIN(0, 30),	RCAR_GP_PIN(0, 31),
+			SD1_CLK_A,		SD1_CMD_A,
+			SD1_DAT0_A,		SD1_DAT1_A,
+			SD1_DAT2_A,		SD1_DAT3_A,
+			SD1_CD_A,		SD1_WP_A);
+
+SDHI_PFC(sdhi1_b,	RCAR_GP_PIN(1, 17),	RCAR_GP_PIN(1, 16),
+			RCAR_GP_PIN(1, 18),	RCAR_GP_PIN(1, 19),
+			RCAR_GP_PIN(1, 20),	RCAR_GP_PIN(1, 21),
+			RCAR_GP_PIN(2, 24),	RCAR_GP_PIN(2, 25),
+			SD1_CLK_B,		SD1_CMD_B,
+			SD1_DAT0_B,		SD1_DAT1_B,
+			SD1_DAT2_B,		SD1_DAT3_B,
+			SD1_CD_B,		SD1_WP_B);
+
+/* - SDH2 ------------------------------------------------------------------- */
+SDHI_PFC(sdhi2_a,	RCAR_GP_PIN(4, 17),	RCAR_GP_PIN(4, 18),
+			RCAR_GP_PIN(4, 19),	RCAR_GP_PIN(4, 20),
+			RCAR_GP_PIN(4, 21),	RCAR_GP_PIN(4, 22),
+			RCAR_GP_PIN(4, 23),	RCAR_GP_PIN(4, 24),
+			SD2_CLK_A,		SD2_CMD_A,
+			SD2_DAT0_A,		SD2_DAT1_A,
+			SD2_DAT2_A,		SD2_DAT3_A,
+			SD2_CD_A,		SD2_WP_A);
+
+SDHI_PFC(sdhi2_b,	RCAR_GP_PIN(4, 5),	RCAR_GP_PIN(4, 6),
+			RCAR_GP_PIN(4, 7),	RCAR_GP_PIN(4, 8),
+			RCAR_GP_PIN(3, 25),	RCAR_GP_PIN(3, 26),
+			RCAR_GP_PIN(3, 27),	RCAR_GP_PIN(3, 28),
+			SD2_CLK_B,		SD2_CMD_B,
+			SD2_DAT0_B,		SD2_DAT1_B,
+			SD2_DAT2_B,		SD2_DAT3_B,
+			SD2_CD_B,		SD2_WP_B);
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(hscif0_data_a),
 	SH_PFC_PIN_GROUP(hscif0_data_b),
@@ -1461,6 +1518,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif4_data_c),
 	SH_PFC_PIN_GROUP(scif5_data_a),
 	SH_PFC_PIN_GROUP(scif5_data_b),
+	SH_PFC_PIN_GROUP(sdhi0),
+	SH_PFC_PIN_GROUP(sdhi1_a),
+	SH_PFC_PIN_GROUP(sdhi1_b),
+	SH_PFC_PIN_GROUP(sdhi2_a),
+	SH_PFC_PIN_GROUP(sdhi2_b),
 };
 
 static const char * const hscif0_groups[] = {
@@ -1533,6 +1595,20 @@ static const char * const scif5_groups[] = {
 	"scif5_data_b",
 };
 
+static const char * const sdhi0_groups[] = {
+	"sdhi0",
+};
+
+static const char * const sdhi1_groups[] = {
+	"sdhi1_a",
+	"sdhi1_b",
+};
+
+static const char * const sdhi2_groups[] = {
+	"sdhi2_a",
+	"sdhi2_b",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
@@ -1543,6 +1619,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif5),
+	SH_PFC_FUNCTION(sdhi0),
+	SH_PFC_FUNCTION(sdhi1),
+	SH_PFC_FUNCTION(sdhi2),
 };
 
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
1.7.9.5

