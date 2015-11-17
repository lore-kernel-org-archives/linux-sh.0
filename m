From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Nov 2015 03:18:41 +0000
Subject: [PATCH 01/04] pinctrl: sh-pfc: r8a7794: Add DU pin groups
Message-Id: <20151117031841.24924.27388.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117031832.24924.60685.sendpatchset@little-apple>
In-Reply-To: <20151117031832.24924.60685.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org, koji.matsuoka.xm@renesas.com, linux-gpio@vger.kernel.org, horms@verge.net.au, geert@glider.be, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

r8a7794 PFC DU support from the R-Car Gen2 v1.9.4 BSP

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 170 +++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index b25851c..0af7c12 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -1306,6 +1306,140 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
+/* - DU --------------------------------------------------------------------- */
+static const unsigned int du0_rgb666_pins[] = {
+	/* R[7:2], G[7:2], B[7:2] */
+	RCAR_GP_PIN(2, 7),  RCAR_GP_PIN(2, 6),  RCAR_GP_PIN(2, 5),
+	RCAR_GP_PIN(2, 4),  RCAR_GP_PIN(2, 3),  RCAR_GP_PIN(2, 2),
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 10),
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(2, 22), RCAR_GP_PIN(2, 21),
+	RCAR_GP_PIN(2, 20), RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 18),
+};
+static const unsigned int du0_rgb666_mux[] = {
+	DU0_DR7_MARK, DU0_DR6_MARK, DU0_DR5_MARK, DU0_DR4_MARK,
+	DU0_DR3_MARK, DU0_DR2_MARK,
+	DU0_DG7_MARK, DU0_DG6_MARK, DU0_DG5_MARK, DU0_DG4_MARK,
+	DU0_DG3_MARK, DU0_DG2_MARK,
+	DU0_DB7_MARK, DU0_DB6_MARK, DU0_DB5_MARK, DU0_DB4_MARK,
+	DU0_DB3_MARK, DU0_DB2_MARK,
+};
+static const unsigned int du0_rgb888_pins[] = {
+	/* R[7:0], G[7:0], B[7:0] */
+	RCAR_GP_PIN(2, 7),  RCAR_GP_PIN(2, 6),  RCAR_GP_PIN(2, 5),
+	RCAR_GP_PIN(2, 4),  RCAR_GP_PIN(2, 3),  RCAR_GP_PIN(2, 2),
+	RCAR_GP_PIN(2, 1),  RCAR_GP_PIN(2, 0),
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 10),
+	RCAR_GP_PIN(2, 9),  RCAR_GP_PIN(2, 8),
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(2, 22), RCAR_GP_PIN(2, 21),
+	RCAR_GP_PIN(2, 20), RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 18),
+	RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 16),
+};
+static const unsigned int du0_rgb888_mux[] = {
+	DU0_DR7_MARK, DU0_DR6_MARK, DU0_DR5_MARK, DU0_DR4_MARK,
+	DU0_DR3_MARK, DU0_DR2_MARK, DU0_DR1_MARK, DU0_DR0_MARK,
+	DU0_DG7_MARK, DU0_DG6_MARK, DU0_DG5_MARK, DU0_DG4_MARK,
+	DU0_DG3_MARK, DU0_DG2_MARK, DU0_DG1_MARK, DU0_DG0_MARK,
+	DU0_DB7_MARK, DU0_DB6_MARK, DU0_DB5_MARK, DU0_DB4_MARK,
+	DU0_DB3_MARK, DU0_DB2_MARK, DU0_DB1_MARK, DU0_DB0_MARK,
+};
+static const unsigned int du1_rgb666_pins[] = {
+	/* R[7:2], G[7:2], B[7:2] */
+	RCAR_GP_PIN(4, 7),  RCAR_GP_PIN(4, 6),  RCAR_GP_PIN(4, 5),
+	RCAR_GP_PIN(4, 4),  RCAR_GP_PIN(4, 3),  RCAR_GP_PIN(4, 2),
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 13),
+	RCAR_GP_PIN(4, 12), RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 23), RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 21),
+	RCAR_GP_PIN(4, 20), RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 18),
+};
+static const unsigned int du1_rgb666_mux[] = {
+	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
+	DU1_DR3_MARK, DU1_DR2_MARK,
+	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
+	DU1_DG3_MARK, DU1_DG2_MARK,
+	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
+	DU1_DB3_MARK, DU1_DB2_MARK,
+};
+static const unsigned int du1_rgb888_pins[] = {
+	/* R[7:0], G[7:0], B[7:0] */
+	RCAR_GP_PIN(4, 7),  RCAR_GP_PIN(4, 6),  RCAR_GP_PIN(4, 5),
+	RCAR_GP_PIN(4, 4),  RCAR_GP_PIN(4, 3),  RCAR_GP_PIN(4, 2),
+	RCAR_GP_PIN(4, 1),  RCAR_GP_PIN(4, 0),
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 13),
+	RCAR_GP_PIN(4, 12), RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 9),  RCAR_GP_PIN(4, 8),
+	RCAR_GP_PIN(4, 23), RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 21),
+	RCAR_GP_PIN(4, 20), RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 18),
+	RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 16),
+};
+static const unsigned int du1_rgb888_mux[] = {
+	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
+	DU1_DR3_MARK, DU1_DR2_MARK, DU1_DR1_MARK, DU1_DR0_MARK,
+	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
+	DU1_DG3_MARK, DU1_DG2_MARK, DU1_DG1_MARK, DU1_DG0_MARK,
+	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
+	DU1_DB3_MARK, DU1_DB2_MARK, DU1_DB1_MARK, DU1_DB0_MARK,
+};
+static const unsigned int du0_clk_out_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(2, 25),
+};
+static const unsigned int du0_clk_out_mux[] = {
+	DU0_DOTCLKOUT0_MARK
+};
+static const unsigned int du1_clk_out_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(4, 26),
+};
+static const unsigned int du1_clk_out_mux[] = {
+	DU1_DOTCLKOUT1_MARK
+};
+static const unsigned int du0_sync_pins[] = {
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC, EXDISP/EXODDF/EXCDE */
+	RCAR_GP_PIN(2, 29), RCAR_GP_PIN(2, 28), RCAR_GP_PIN(2, 27),
+};
+static const unsigned int du0_sync_mux[] = {
+	DU0_EXODDF_DU0_ODDF_DISP_CDE_MARK,
+	DU0_EXVSYNC_DU0_VSYNC_MARK, DU0_EXHSYNC_DU0_HSYNC_MARK
+};
+static const unsigned int du1_sync_pins[] = {
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC, EXDISP/EXODDF/EXCDE */
+	RCAR_GP_PIN(4, 29), RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 27),
+};
+static const unsigned int du1_sync_mux[] = {
+	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
+	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK
+};
+static const unsigned int du0_cde_disp_pins[] = {
+	/* CDE DISP */
+	RCAR_GP_PIN(2, 31), RCAR_GP_PIN(2, 30),
+};
+static const unsigned int du0_cde_disp_mux[] = {
+	DU0_CDE_MARK, DU0_DISP_MARK
+};
+static const unsigned int du1_cde_disp_pins[] = {
+	/* CDE DISP */
+	RCAR_GP_PIN(4, 31), RCAR_GP_PIN(4, 30),
+};
+static const unsigned int du1_cde_disp_mux[] = {
+	DU1_CDE_MARK, DU1_DISP_MARK
+};
+static const unsigned int du0_clk_in_pins[] = {
+	/* CLKIN */
+	RCAR_GP_PIN(2, 24),
+};
+static const unsigned int du0_clk_in_mux[] = {
+	DU0_DOTCLKIN_MARK
+};
+static const unsigned int du1_clk_in_pins[] = {
+	/* CLKIN */
+	RCAR_GP_PIN(4, 24),
+};
+static const unsigned int du1_clk_in_mux[] = {
+	DU1_DOTCLKIN_MARK
+};
+
 /* - ETH -------------------------------------------------------------------- */
 static const unsigned int eth_link_pins[] = {
 	/* LINK */
@@ -2543,6 +2677,18 @@ static const unsigned int usb1_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(du0_rgb666),
+	SH_PFC_PIN_GROUP(du0_rgb888),
+	SH_PFC_PIN_GROUP(du1_rgb666),
+	SH_PFC_PIN_GROUP(du1_rgb888),
+	SH_PFC_PIN_GROUP(du0_clk_out),
+	SH_PFC_PIN_GROUP(du1_clk_out),
+	SH_PFC_PIN_GROUP(du0_sync),
+	SH_PFC_PIN_GROUP(du1_sync),
+	SH_PFC_PIN_GROUP(du0_cde_disp),
+	SH_PFC_PIN_GROUP(du1_cde_disp),
+	SH_PFC_PIN_GROUP(du0_clk_in),
+	SH_PFC_PIN_GROUP(du1_clk_in),
 	SH_PFC_PIN_GROUP(eth_link),
 	SH_PFC_PIN_GROUP(eth_magic),
 	SH_PFC_PIN_GROUP(eth_mdio),
@@ -2714,6 +2860,27 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(usb1),
 };
 
+static const char * const du_groups[] = {
+	"du0_rgb666",
+	"du0_rgb888",
+	"du1_rgb666",
+	"du1_rgb888",
+	"du0_clk_out",
+	"du1_clk_out",
+	"du0_sync",
+	"du1_sync",
+	"du0_cde_disp",
+	"du1_cde_disp",
+};
+
+static const char * const du0_groups[] = {
+	"du0_clk_in",
+};
+
+static const char * const du1_groups[] = {
+	"du1_clk_in",
+};
+
 static const char * const eth_groups[] = {
 	"eth_link",
 	"eth_magic",
@@ -2985,6 +3152,9 @@ static const char * const usb1_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(du),
+	SH_PFC_FUNCTION(du0),
+	SH_PFC_FUNCTION(du1),
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),

