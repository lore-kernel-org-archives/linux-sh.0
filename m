From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Mar 2013 19:07:31 +0000
Subject: [PATCH 1/3] sh-pfc: r8a7779: Replace hardcoded pin numbers with GP_PIN macro
Message-Id: <1364411253-12170-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pins are numbered in the r8a7779 documentation using a bank number and a
pin number in the bank. As the pinctrl pin number space is linear, this
is flattened by multiplying the bank number by 32 and adding the pin
number. The resulting pin number has no direct relationship with the
documentation, making it error-prone.

Add and use a GP_PIN macro to convert from the documentation pin number
space to the linear pinctrl space.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 270 ++++++++++++++++++-----------------
 1 file changed, 142 insertions(+), 128 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index e448ff1..29d4b21 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -1469,12 +1469,16 @@ static struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
+#define GP_PIN(bank, pin)	(((bank) * 32) + (pin))
+
 /* - DU0 -------------------------------------------------------------------- */
 static const unsigned int du0_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
-	188, 187, 186, 185, 184, 183,
-	194, 193, 192, 191, 190, 189,
-	200, 199, 198, 197, 196, 195,
+	GP_PIN(5, 28), GP_PIN(5, 27), GP_PIN(5, 26), GP_PIN(5, 25),
+	GP_PIN(5, 24), GP_PIN(5, 23), GP_PIN(6, 2),  GP_PIN(6, 1),
+	GP_PIN(6, 0),  GP_PIN(5, 31), GP_PIN(5, 30), GP_PIN(5, 29),
+	GP_PIN(6, 8),  GP_PIN(6, 7),  GP_PIN(6, 6),  GP_PIN(6, 5),
+	GP_PIN(6, 4),  GP_PIN(6, 3),
 };
 static const unsigned int du0_rgb666_mux[] = {
 	DU0_DR7_MARK, DU0_DR6_MARK, DU0_DR5_MARK, DU0_DR4_MARK,
@@ -1486,9 +1490,12 @@ static const unsigned int du0_rgb666_mux[] = {
 };
 static const unsigned int du0_rgb888_pins[] = {
 	/* R[7:0], G[7:0], B[7:0] */
-	188, 187, 186, 185, 184, 183, 24, 23,
-	194, 193, 192, 191, 190, 189, 26, 25,
-	200, 199, 198, 197, 196, 195, 28, 27,
+	GP_PIN(5, 28), GP_PIN(5, 27), GP_PIN(5, 26), GP_PIN(5, 25),
+	GP_PIN(5, 24), GP_PIN(5, 23), GP_PIN(0, 24), GP_PIN(0, 23),
+	GP_PIN(6, 2),  GP_PIN(6, 1),  GP_PIN(6, 0),  GP_PIN(5, 31),
+	GP_PIN(5, 30), GP_PIN(5, 29), GP_PIN(0, 26), GP_PIN(0, 25),
+	GP_PIN(6, 8),  GP_PIN(6, 7),  GP_PIN(6, 6),  GP_PIN(6, 5),
+	GP_PIN(6, 4),  GP_PIN(6, 3),  GP_PIN(0, 28), GP_PIN(0, 27),
 };
 static const unsigned int du0_rgb888_mux[] = {
 	DU0_DR7_MARK, DU0_DR6_MARK, DU0_DR5_MARK, DU0_DR4_MARK,
@@ -1500,21 +1507,21 @@ static const unsigned int du0_rgb888_mux[] = {
 };
 static const unsigned int du0_clk_0_pins[] = {
 	/* CLKIN, CLKOUT */
-	29, 180,
+	GP_PIN(0, 29), GP_PIN(5, 20),
 };
 static const unsigned int du0_clk_0_mux[] = {
 	DU0_DOTCLKIN_MARK, DU0_DOTCLKOUT0_MARK,
 };
 static const unsigned int du0_clk_1_pins[] = {
 	/* CLKIN, CLKOUT */
-	29, 30,
+	GP_PIN(0, 29), GP_PIN(0, 30),
 };
 static const unsigned int du0_clk_1_mux[] = {
 	DU0_DOTCLKIN_MARK, DU0_DOTCLKOUT1_MARK,
 };
 static const unsigned int du0_sync_0_pins[] = {
 	/* VSYNC, HSYNC, DISP */
-	182, 181, 31,
+	GP_PIN(5, 22), GP_PIN(5, 21), GP_PIN(0, 31),
 };
 static const unsigned int du0_sync_0_mux[] = {
 	DU0_EXHSYNC_DU0_HSYNC_MARK, DU0_EXVSYNC_DU0_VSYNC_MARK,
@@ -1522,7 +1529,7 @@ static const unsigned int du0_sync_0_mux[] = {
 };
 static const unsigned int du0_sync_1_pins[] = {
 	/* VSYNC, HSYNC, DISP */
-	182, 181, 32,
+	GP_PIN(5, 22), GP_PIN(5, 21), GP_PIN(1, 0),
 };
 static const unsigned int du0_sync_1_mux[] = {
 	DU0_EXHSYNC_DU0_HSYNC_MARK, DU0_EXVSYNC_DU0_VSYNC_MARK,
@@ -1530,14 +1537,14 @@ static const unsigned int du0_sync_1_mux[] = {
 };
 static const unsigned int du0_oddf_pins[] = {
 	/* ODDF */
-	31,
+	GP_PIN(0, 31),
 };
 static const unsigned int du0_oddf_mux[] = {
 	DU0_EXODDF_DU0_ODDF_DISP_CDE_MARK
 };
 static const unsigned int du0_cde_pins[] = {
 	/* CDE */
-	33,
+	GP_PIN(1, 1),
 };
 static const unsigned int du0_cde_mux[] = {
 	DU0_CDE_MARK
@@ -1545,9 +1552,11 @@ static const unsigned int du0_cde_mux[] = {
 /* - DU1 -------------------------------------------------------------------- */
 static const unsigned int du1_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
-	41, 40, 39, 38, 37, 36,
-	49, 48, 47, 46, 45, 44,
-	57, 56, 55, 54, 53, 52,
+	GP_PIN(1, 9),  GP_PIN(1, 8),  GP_PIN(1, 7),  GP_PIN(1, 6),
+	GP_PIN(1, 5),  GP_PIN(1, 4),  GP_PIN(1, 17), GP_PIN(1, 16),
+	GP_PIN(1, 15), GP_PIN(1, 14), GP_PIN(1, 13), GP_PIN(1, 12),
+	GP_PIN(1, 25), GP_PIN(1, 24), GP_PIN(1, 23), GP_PIN(1, 22),
+	GP_PIN(1, 21), GP_PIN(1, 20),
 };
 static const unsigned int du1_rgb666_mux[] = {
 	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
@@ -1559,9 +1568,12 @@ static const unsigned int du1_rgb666_mux[] = {
 };
 static const unsigned int du1_rgb888_pins[] = {
 	/* R[7:0], G[7:0], B[7:0] */
-	41, 40, 39, 38, 37, 36, 35, 34,
-	49, 48, 47, 46, 45, 44, 43, 32,
-	57, 56, 55, 54, 53, 52, 51, 50,
+	GP_PIN(1, 9),  GP_PIN(1, 8),  GP_PIN(1, 7),  GP_PIN(1, 6),
+	GP_PIN(1, 5),  GP_PIN(1, 4),  GP_PIN(1, 3),  GP_PIN(1, 2),
+	GP_PIN(1, 17), GP_PIN(1, 16), GP_PIN(1, 15), GP_PIN(1, 14),
+	GP_PIN(1, 13), GP_PIN(1, 12), GP_PIN(1, 11), GP_PIN(1, 0),
+	GP_PIN(1, 25), GP_PIN(1, 24), GP_PIN(1, 23), GP_PIN(1, 22),
+	GP_PIN(1, 21), GP_PIN(1, 20), GP_PIN(1, 19), GP_PIN(1, 18),
 };
 static const unsigned int du1_rgb888_mux[] = {
 	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
@@ -1573,14 +1585,14 @@ static const unsigned int du1_rgb888_mux[] = {
 };
 static const unsigned int du1_clk_pins[] = {
 	/* CLKIN, CLKOUT */
-	58, 59,
+	GP_PIN(1, 26), GP_PIN(1, 27),
 };
 static const unsigned int du1_clk_mux[] = {
 	DU1_DOTCLKIN_MARK, DU1_DOTCLKOUT_MARK,
 };
 static const unsigned int du1_sync_0_pins[] = {
 	/* VSYNC, HSYNC, DISP */
-	61, 60, 62,
+	GP_PIN(1, 29), GP_PIN(1, 28), GP_PIN(1, 30),
 };
 static const unsigned int du1_sync_0_mux[] = {
 	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK,
@@ -1588,7 +1600,7 @@ static const unsigned int du1_sync_0_mux[] = {
 };
 static const unsigned int du1_sync_1_pins[] = {
 	/* VSYNC, HSYNC, DISP */
-	61, 60, 63,
+	GP_PIN(1, 29), GP_PIN(1, 28), GP_PIN(1, 31),
 };
 static const unsigned int du1_sync_1_mux[] = {
 	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK,
@@ -1596,14 +1608,14 @@ static const unsigned int du1_sync_1_mux[] = {
 };
 static const unsigned int du1_oddf_pins[] = {
 	/* ODDF */
-	62,
+	GP_PIN(1, 30),
 };
 static const unsigned int du1_oddf_mux[] = {
 	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK
 };
 static const unsigned int du1_cde_pins[] = {
 	/* CDE */
-	64,
+	GP_PIN(2, 0),
 };
 static const unsigned int du1_cde_mux[] = {
 	DU1_CDE_MARK
@@ -1611,7 +1623,7 @@ static const unsigned int du1_cde_mux[] = {
 /* - HSPI0 ------------------------------------------------------------------ */
 static const unsigned int hspi0_pins[] = {
 	/* CLK, CS, RX, TX */
-	150, 151, 153, 152,
+	GP_PIN(4, 22), GP_PIN(4, 23), GP_PIN(4, 25), GP_PIN(4, 24),
 };
 static const unsigned int hspi0_mux[] = {
 	HSPI_CLK0_MARK, HSPI_CS0_MARK, HSPI_RX0_MARK, HSPI_TX0_MARK,
@@ -1619,28 +1631,28 @@ static const unsigned int hspi0_mux[] = {
 /* - HSPI1 ------------------------------------------------------------------ */
 static const unsigned int hspi1_pins[] = {
 	/* CLK, CS, RX, TX */
-	63, 58, 64, 62,
+	GP_PIN(1, 31), GP_PIN(1, 26), GP_PIN(2, 0), GP_PIN(1, 30),
 };
 static const unsigned int hspi1_mux[] = {
 	HSPI_CLK1_MARK, HSPI_CS1_MARK, HSPI_RX1_MARK, HSPI_TX1_MARK,
 };
 static const unsigned int hspi1_b_pins[] = {
 	/* CLK, CS, RX, TX */
-	90, 91, 93, 92,
+	GP_PIN(2, 26), GP_PIN(2, 27), GP_PIN(2, 29), GP_PIN(2, 28),
 };
 static const unsigned int hspi1_b_mux[] = {
 	HSPI_CLK1_B_MARK, HSPI_CS1_B_MARK, HSPI_RX1_B_MARK, HSPI_TX1_B_MARK,
 };
 static const unsigned int hspi1_c_pins[] = {
 	/* CLK, CS, RX, TX */
-	141, 142, 144, 143,
+	GP_PIN(4, 13), GP_PIN(4, 14), GP_PIN(4, 16), GP_PIN(4, 15),
 };
 static const unsigned int hspi1_c_mux[] = {
 	HSPI_CLK1_C_MARK, HSPI_CS1_C_MARK, HSPI_RX1_C_MARK, HSPI_TX1_C_MARK,
 };
 static const unsigned int hspi1_d_pins[] = {
 	/* CLK, CS, RX, TX */
-	101, 102, 104, 103,
+	GP_PIN(3, 5), GP_PIN(3, 6), GP_PIN(3, 8), GP_PIN(3, 7),
 };
 static const unsigned int hspi1_d_mux[] = {
 	HSPI_CLK1_D_MARK, HSPI_CS1_D_MARK, HSPI_RX1_D_MARK, HSPI_TX1_D_MARK,
@@ -1648,14 +1660,14 @@ static const unsigned int hspi1_d_mux[] = {
 /* - HSPI2 ------------------------------------------------------------------ */
 static const unsigned int hspi2_pins[] = {
 	/* CLK, CS, RX, TX */
-	9, 10, 11, 14,
+	GP_PIN(0, 9), GP_PIN(0, 10), GP_PIN(0, 11), GP_PIN(0, 14),
 };
 static const unsigned int hspi2_mux[] = {
 	HSPI_CLK2_MARK, HSPI_CS2_MARK, HSPI_RX2_MARK, HSPI_TX2_MARK,
 };
 static const unsigned int hspi2_b_pins[] = {
 	/* CLK, CS, RX, TX */
-	7, 13, 8, 6,
+	GP_PIN(0, 7), GP_PIN(0, 13), GP_PIN(0, 8), GP_PIN(0, 6),
 };
 static const unsigned int hspi2_b_mux[] = {
 	HSPI_CLK2_B_MARK, HSPI_CS2_B_MARK, HSPI_RX2_B_MARK, HSPI_TX2_B_MARK,
@@ -1663,56 +1675,56 @@ static const unsigned int hspi2_b_mux[] = {
 /* - INTC ------------------------------------------------------------------- */
 static const unsigned int intc_irq0_pins[] = {
 	/* IRQ */
-	78,
+	GP_PIN(2, 14),
 };
 static const unsigned int intc_irq0_mux[] = {
 	IRQ0_MARK,
 };
 static const unsigned int intc_irq0_b_pins[] = {
 	/* IRQ */
-	141,
+	GP_PIN(4, 13),
 };
 static const unsigned int intc_irq0_b_mux[] = {
 	IRQ0_B_MARK,
 };
 static const unsigned int intc_irq1_pins[] = {
 	/* IRQ */
-	79,
+	GP_PIN(2, 15),
 };
 static const unsigned int intc_irq1_mux[] = {
 	IRQ1_MARK,
 };
 static const unsigned int intc_irq1_b_pins[] = {
 	/* IRQ */
-	142,
+	GP_PIN(4, 14),
 };
 static const unsigned int intc_irq1_b_mux[] = {
 	IRQ1_B_MARK,
 };
 static const unsigned int intc_irq2_pins[] = {
 	/* IRQ */
-	88,
+	GP_PIN(2, 24),
 };
 static const unsigned int intc_irq2_mux[] = {
 	IRQ2_MARK,
 };
 static const unsigned int intc_irq2_b_pins[] = {
 	/* IRQ */
-	143,
+	GP_PIN(4, 15),
 };
 static const unsigned int intc_irq2_b_mux[] = {
 	IRQ2_B_MARK,
 };
 static const unsigned int intc_irq3_pins[] = {
 	/* IRQ */
-	89,
+	GP_PIN(2, 25),
 };
 static const unsigned int intc_irq3_mux[] = {
 	IRQ3_MARK,
 };
 static const unsigned int intc_irq3_b_pins[] = {
 	/* IRQ */
-	144,
+	GP_PIN(4, 16),
 };
 static const unsigned int intc_irq3_b_mux[] = {
 	IRQ3_B_MARK,
@@ -1720,56 +1732,56 @@ static const unsigned int intc_irq3_b_mux[] = {
 /* - LSBC ------------------------------------------------------------------- */
 static const unsigned int lbsc_cs0_pins[] = {
 	/* CS */
-	13,
+	GP_PIN(0, 13),
 };
 static const unsigned int lbsc_cs0_mux[] = {
 	CS0_MARK,
 };
 static const unsigned int lbsc_cs1_pins[] = {
 	/* CS */
-	14,
+	GP_PIN(0, 14),
 };
 static const unsigned int lbsc_cs1_mux[] = {
 	CS1_A26_MARK,
 };
 static const unsigned int lbsc_ex_cs0_pins[] = {
 	/* CS */
-	15,
+	GP_PIN(0, 15),
 };
 static const unsigned int lbsc_ex_cs0_mux[] = {
 	EX_CS0_MARK,
 };
 static const unsigned int lbsc_ex_cs1_pins[] = {
 	/* CS */
-	16,
+	GP_PIN(0, 16),
 };
 static const unsigned int lbsc_ex_cs1_mux[] = {
 	EX_CS1_MARK,
 };
 static const unsigned int lbsc_ex_cs2_pins[] = {
 	/* CS */
-	17,
+	GP_PIN(0, 17),
 };
 static const unsigned int lbsc_ex_cs2_mux[] = {
 	EX_CS2_MARK,
 };
 static const unsigned int lbsc_ex_cs3_pins[] = {
 	/* CS */
-	18,
+	GP_PIN(0, 18),
 };
 static const unsigned int lbsc_ex_cs3_mux[] = {
 	EX_CS3_MARK,
 };
 static const unsigned int lbsc_ex_cs4_pins[] = {
 	/* CS */
-	19,
+	GP_PIN(0, 19),
 };
 static const unsigned int lbsc_ex_cs4_mux[] = {
 	EX_CS4_MARK,
 };
 static const unsigned int lbsc_ex_cs5_pins[] = {
 	/* CS */
-	20,
+	GP_PIN(0, 20),
 };
 static const unsigned int lbsc_ex_cs5_mux[] = {
 	EX_CS5_MARK,
@@ -1777,21 +1789,22 @@ static const unsigned int lbsc_ex_cs5_mux[] = {
 /* - MMCIF ------------------------------------------------------------------ */
 static const unsigned int mmc0_data1_pins[] = {
 	/* D[0] */
-	19,
+	GP_PIN(0, 19),
 };
 static const unsigned int mmc0_data1_mux[] = {
 	MMC0_D0_MARK,
 };
 static const unsigned int mmc0_data4_pins[] = {
 	/* D[0:3] */
-	19, 20, 21, 2,
+	GP_PIN(0, 19), GP_PIN(0, 20), GP_PIN(0, 21), GP_PIN(0, 2),
 };
 static const unsigned int mmc0_data4_mux[] = {
 	MMC0_D0_MARK, MMC0_D1_MARK, MMC0_D2_MARK, MMC0_D3_MARK,
 };
 static const unsigned int mmc0_data8_pins[] = {
 	/* D[0:7] */
-	19, 20, 21, 2, 10, 11, 15, 16,
+	GP_PIN(0, 19), GP_PIN(0, 20), GP_PIN(0, 21), GP_PIN(0, 2),
+	GP_PIN(0, 10), GP_PIN(0, 11), GP_PIN(0, 15), GP_PIN(0, 16),
 };
 static const unsigned int mmc0_data8_mux[] = {
 	MMC0_D0_MARK, MMC0_D1_MARK, MMC0_D2_MARK, MMC0_D3_MARK,
@@ -1799,28 +1812,29 @@ static const unsigned int mmc0_data8_mux[] = {
 };
 static const unsigned int mmc0_ctrl_pins[] = {
 	/* CMD, CLK */
-	18, 17,
+	GP_PIN(0, 18), GP_PIN(0, 17),
 };
 static const unsigned int mmc0_ctrl_mux[] = {
 	MMC0_CMD_MARK, MMC0_CLK_MARK,
 };
 static const unsigned int mmc1_data1_pins[] = {
 	/* D[0] */
-	72,
+	GP_PIN(2, 8),
 };
 static const unsigned int mmc1_data1_mux[] = {
 	MMC1_D0_MARK,
 };
 static const unsigned int mmc1_data4_pins[] = {
 	/* D[0:3] */
-	72, 73, 74, 75,
+	GP_PIN(2, 8), GP_PIN(2, 9), GP_PIN(2, 10), GP_PIN(2, 11),
 };
 static const unsigned int mmc1_data4_mux[] = {
 	MMC1_D0_MARK, MMC1_D1_MARK, MMC1_D2_MARK, MMC1_D3_MARK,
 };
 static const unsigned int mmc1_data8_pins[] = {
 	/* D[0:7] */
-	72, 73, 74, 75, 76, 77, 80, 81,
+	GP_PIN(2, 8),  GP_PIN(2, 9),  GP_PIN(2, 10), GP_PIN(2, 11),
+	GP_PIN(2, 12), GP_PIN(2, 13), GP_PIN(2, 16), GP_PIN(2, 17),
 };
 static const unsigned int mmc1_data8_mux[] = {
 	MMC1_D0_MARK, MMC1_D1_MARK, MMC1_D2_MARK, MMC1_D3_MARK,
@@ -1828,7 +1842,7 @@ static const unsigned int mmc1_data8_mux[] = {
 };
 static const unsigned int mmc1_ctrl_pins[] = {
 	/* CMD, CLK */
-	68, 65,
+	GP_PIN(2, 4), GP_PIN(2, 1),
 };
 static const unsigned int mmc1_ctrl_mux[] = {
 	MMC1_CMD_MARK, MMC1_CLK_MARK,
@@ -1836,84 +1850,84 @@ static const unsigned int mmc1_ctrl_mux[] = {
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
 	/* RXD, TXD */
-	153, 152,
+	GP_PIN(4, 25), GP_PIN(4, 24),
 };
 static const unsigned int scif0_data_mux[] = {
 	RX0_MARK, TX0_MARK,
 };
 static const unsigned int scif0_clk_pins[] = {
 	/* SCK */
-	156,
+	GP_PIN(4, 28),
 };
 static const unsigned int scif0_clk_mux[] = {
 	SCK0_MARK,
 };
 static const unsigned int scif0_ctrl_pins[] = {
 	/* RTS, CTS */
-	151, 150,
+	GP_PIN(4, 23), GP_PIN(4, 22),
 };
 static const unsigned int scif0_ctrl_mux[] = {
 	RTS0_TANS_MARK, CTS0_MARK,
 };
 static const unsigned int scif0_data_b_pins[] = {
 	/* RXD, TXD */
-	20, 19,
+	GP_PIN(0, 20), GP_PIN(0, 19),
 };
 static const unsigned int scif0_data_b_mux[] = {
 	RX0_B_MARK, TX0_B_MARK,
 };
 static const unsigned int scif0_clk_b_pins[] = {
 	/* SCK */
-	33,
+	GP_PIN(1, 1),
 };
 static const unsigned int scif0_clk_b_mux[] = {
 	SCK0_B_MARK,
 };
 static const unsigned int scif0_ctrl_b_pins[] = {
 	/* RTS, CTS */
-	18, 11,
+	GP_PIN(0, 18), GP_PIN(0, 11),
 };
 static const unsigned int scif0_ctrl_b_mux[] = {
 	RTS0_B_TANS_B_MARK, CTS0_B_MARK,
 };
 static const unsigned int scif0_data_c_pins[] = {
 	/* RXD, TXD */
-	146, 147,
+	GP_PIN(4, 18), GP_PIN(4, 19),
 };
 static const unsigned int scif0_data_c_mux[] = {
 	RX0_C_MARK, TX0_C_MARK,
 };
 static const unsigned int scif0_clk_c_pins[] = {
 	/* SCK */
-	145,
+	GP_PIN(4, 17),
 };
 static const unsigned int scif0_clk_c_mux[] = {
 	SCK0_C_MARK,
 };
 static const unsigned int scif0_ctrl_c_pins[] = {
 	/* RTS, CTS */
-	149, 148,
+	GP_PIN(4, 21), GP_PIN(4, 20),
 };
 static const unsigned int scif0_ctrl_c_mux[] = {
 	RTS0_C_TANS_C_MARK, CTS0_C_MARK,
 };
 static const unsigned int scif0_data_d_pins[] = {
 	/* RXD, TXD */
-	43, 42,
+	GP_PIN(1, 11), GP_PIN(1, 10),
 };
 static const unsigned int scif0_data_d_mux[] = {
 	RX0_D_MARK, TX0_D_MARK,
 };
 static const unsigned int scif0_clk_d_pins[] = {
 	/* SCK */
-	50,
+	GP_PIN(1, 18),
 };
 static const unsigned int scif0_clk_d_mux[] = {
 	SCK0_D_MARK,
 };
 static const unsigned int scif0_ctrl_d_pins[] = {
 	/* RTS, CTS */
-	51, 35,
+	GP_PIN(1, 19), GP_PIN(1, 3),
 };
 static const unsigned int scif0_ctrl_d_mux[] = {
 	RTS0_D_TANS_D_MARK, CTS0_D_MARK,
@@ -1921,63 +1935,63 @@ static const unsigned int scif0_ctrl_d_mux[] = {
 /* - SCIF1 ------------------------------------------------------------------ */
 static const unsigned int scif1_data_pins[] = {
 	/* RXD, TXD */
-	149, 148,
+	GP_PIN(4, 21), GP_PIN(4, 20),
 };
 static const unsigned int scif1_data_mux[] = {
 	RX1_MARK, TX1_MARK,
 };
 static const unsigned int scif1_clk_pins[] = {
 	/* SCK */
-	145,
+	GP_PIN(4, 17),
 };
 static const unsigned int scif1_clk_mux[] = {
 	SCK1_MARK,
 };
 static const unsigned int scif1_ctrl_pins[] = {
 	/* RTS, CTS */
-	147, 146,
+	GP_PIN(4, 19), GP_PIN(4, 18),
 };
 static const unsigned int scif1_ctrl_mux[] = {
 	RTS1_TANS_MARK, CTS1_MARK,
 };
 static const unsigned int scif1_data_b_pins[] = {
 	/* RXD, TXD */
-	117, 114,
+	GP_PIN(3, 21), GP_PIN(3, 18),
 };
 static const unsigned int scif1_data_b_mux[] = {
 	RX1_B_MARK, TX1_B_MARK,
 };
 static const unsigned int scif1_clk_b_pins[] = {
 	/* SCK */
-	113,
+	GP_PIN(3, 17),
 };
 static const unsigned int scif1_clk_b_mux[] = {
 	SCK1_B_MARK,
 };
 static const unsigned int scif1_ctrl_b_pins[] = {
 	/* RTS, CTS */
-	115, 116,
+	GP_PIN(3, 19), GP_PIN(3, 20),
 };
 static const unsigned int scif1_ctrl_b_mux[] = {
 	RTS1_B_TANS_B_MARK, CTS1_B_MARK,
 };
 static const unsigned int scif1_data_c_pins[] = {
 	/* RXD, TXD */
-	67, 66,
+	GP_PIN(2, 3), GP_PIN(2, 2),
 };
 static const unsigned int scif1_data_c_mux[] = {
 	RX1_C_MARK, TX1_C_MARK,
 };
 static const unsigned int scif1_clk_c_pins[] = {
 	/* SCK */
-	86,
+	GP_PIN(2, 22),
 };
 static const unsigned int scif1_clk_c_mux[] = {
 	SCK1_C_MARK,
 };
 static const unsigned int scif1_ctrl_c_pins[] = {
 	/* RTS, CTS */
-	69, 68,
+	GP_PIN(2, 5), GP_PIN(2, 4),
 };
 static const unsigned int scif1_ctrl_c_mux[] = {
 	RTS1_C_TANS_C_MARK, CTS1_C_MARK,
@@ -1985,63 +1999,63 @@ static const unsigned int scif1_ctrl_c_mux[] = {
 /* - SCIF2 ------------------------------------------------------------------ */
 static const unsigned int scif2_data_pins[] = {
 	/* RXD, TXD */
-	106, 105,
+	GP_PIN(3, 10), GP_PIN(3, 9),
 };
 static const unsigned int scif2_data_mux[] = {
 	RX2_MARK, TX2_MARK,
 };
 static const unsigned int scif2_clk_pins[] = {
 	/* SCK */
-	107,
+	GP_PIN(3, 11),
 };
 static const unsigned int scif2_clk_mux[] = {
 	SCK2_MARK,
 };
 static const unsigned int scif2_data_b_pins[] = {
 	/* RXD, TXD */
-	120, 119,
+	GP_PIN(3, 24), GP_PIN(3, 23),
 };
 static const unsigned int scif2_data_b_mux[] = {
 	RX2_B_MARK, TX2_B_MARK,
 };
 static const unsigned int scif2_clk_b_pins[] = {
 	/* SCK */
-	118,
+	GP_PIN(3, 22),
 };
 static const unsigned int scif2_clk_b_mux[] = {
 	SCK2_B_MARK,
 };
 static const unsigned int scif2_data_c_pins[] = {
 	/* RXD, TXD */
-	33, 31,
+	GP_PIN(1, 1), GP_PIN(0, 31),
 };
 static const unsigned int scif2_data_c_mux[] = {
 	RX2_C_MARK, TX2_C_MARK,
 };
 static const unsigned int scif2_clk_c_pins[] = {
 	/* SCK */
-	32,
+	GP_PIN(1, 0),
 };
 static const unsigned int scif2_clk_c_mux[] = {
 	SCK2_C_MARK,
 };
 static const unsigned int scif2_data_d_pins[] = {
 	/* RXD, TXD */
-	64, 62,
+	GP_PIN(2, 0), GP_PIN(1, 30),
 };
 static const unsigned int scif2_data_d_mux[] = {
 	RX2_D_MARK, TX2_D_MARK,
 };
 static const unsigned int scif2_clk_d_pins[] = {
 	/* SCK */
-	63,
+	GP_PIN(1, 31),
 };
 static const unsigned int scif2_clk_d_mux[] = {
 	SCK2_D_MARK,
 };
 static const unsigned int scif2_data_e_pins[] = {
 	/* RXD, TXD */
-	20, 19,
+	GP_PIN(0, 20), GP_PIN(0, 19),
 };
 static const unsigned int scif2_data_e_mux[] = {
 	RX2_E_MARK, TX2_E_MARK,
@@ -2049,14 +2063,14 @@ static const unsigned int scif2_data_e_mux[] = {
 /* - SCIF3 ------------------------------------------------------------------ */
 static const unsigned int scif3_data_pins[] = {
 	/* RXD, TXD */
-	137, 136,
+	GP_PIN(4, 9), GP_PIN(4, 8),
 };
 static const unsigned int scif3_data_mux[] = {
 	RX3_IRDA_RX_MARK, TX3_IRDA_TX_MARK,
 };
 static const unsigned int scif3_clk_pins[] = {
 	/* SCK */
-	135,
+	GP_PIN(4, 7),
 };
 static const unsigned int scif3_clk_mux[] = {
 	SCK3_MARK,
@@ -2064,35 +2078,35 @@ static const unsigned int scif3_clk_mux[] = {
 
 static const unsigned int scif3_data_b_pins[] = {
 	/* RXD, TXD */
-	64, 62,
+	GP_PIN(2, 0), GP_PIN(1, 30),
 };
 static const unsigned int scif3_data_b_mux[] = {
 	RX3_B_IRDA_RX_B_MARK, TX3_B_IRDA_TX_B_MARK,
 };
 static const unsigned int scif3_data_c_pins[] = {
 	/* RXD, TXD */
-	15, 12,
+	GP_PIN(0, 15), GP_PIN(0, 12),
 };
 static const unsigned int scif3_data_c_mux[] = {
 	RX3_C_IRDA_RX_C_MARK, TX3C_IRDA_TX_C_MARK,
 };
 static const unsigned int scif3_data_d_pins[] = {
 	/* RXD, TXD */
-	30, 29,
+	GP_PIN(0, 30), GP_PIN(0, 29),
 };
 static const unsigned int scif3_data_d_mux[] = {
 	RX3_D_IRDA_RX_D_MARK, TX3_D_IRDA_TX_D_MARK,
 };
 static const unsigned int scif3_data_e_pins[] = {
 	/* RXD, TXD */
-	35, 34,
+	GP_PIN(1, 3), GP_PIN(1, 2),
 };
 static const unsigned int scif3_data_e_mux[] = {
 	RX3_E_IRDA_RX_E_MARK, TX3_E_IRDA_TX_E_MARK,
 };
 static const unsigned int scif3_clk_e_pins[] = {
 	/* SCK */
-	42,
+	GP_PIN(1, 10),
 };
 static const unsigned int scif3_clk_e_mux[] = {
 	SCK3_E_MARK,
@@ -2100,42 +2114,42 @@ static const unsigned int scif3_clk_e_mux[] = {
 /* - SCIF4 ------------------------------------------------------------------ */
 static const unsigned int scif4_data_pins[] = {
 	/* RXD, TXD */
-	123, 122,
+	GP_PIN(3, 27), GP_PIN(3, 26),
 };
 static const unsigned int scif4_data_mux[] = {
 	RX4_MARK, TX4_MARK,
 };
 static const unsigned int scif4_clk_pins[] = {
 	/* SCK */
-	121,
+	GP_PIN(3, 25),
 };
 static const unsigned int scif4_clk_mux[] = {
 	SCK4_MARK,
 };
 static const unsigned int scif4_data_b_pins[] = {
 	/* RXD, TXD */
-	111, 110,
+	GP_PIN(3, 15), GP_PIN(3, 14),
 };
 static const unsigned int scif4_data_b_mux[] = {
 	RX4_B_MARK, TX4_B_MARK,
 };
 static const unsigned int scif4_clk_b_pins[] = {
 	/* SCK */
-	112,
+	GP_PIN(3, 16),
 };
 static const unsigned int scif4_clk_b_mux[] = {
 	SCK4_B_MARK,
 };
 static const unsigned int scif4_data_c_pins[] = {
 	/* RXD, TXD */
-	22, 21,
+	GP_PIN(0, 22), GP_PIN(0, 21),
 };
 static const unsigned int scif4_data_c_mux[] = {
 	RX4_C_MARK, TX4_C_MARK,
 };
 static const unsigned int scif4_data_d_pins[] = {
 	/* RXD, TXD */
-	69, 68,
+	GP_PIN(2, 5), GP_PIN(2, 4),
 };
 static const unsigned int scif4_data_d_mux[] = {
 	RX4_D_MARK, TX4_D_MARK,
@@ -2143,56 +2157,56 @@ static const unsigned int scif4_data_d_mux[] = {
 /* - SCIF5 ------------------------------------------------------------------ */
 static const unsigned int scif5_data_pins[] = {
 	/* RXD, TXD */
-	51, 50,
+	GP_PIN(1, 19), GP_PIN(1, 18),
 };
 static const unsigned int scif5_data_mux[] = {
 	RX5_MARK, TX5_MARK,
 };
 static const unsigned int scif5_clk_pins[] = {
 	/* SCK */
-	43,
+	GP_PIN(1, 11),
 };
 static const unsigned int scif5_clk_mux[] = {
 	SCK5_MARK,
 };
 static const unsigned int scif5_data_b_pins[] = {
 	/* RXD, TXD */
-	18, 11,
+	GP_PIN(0, 18), GP_PIN(0, 11),
 };
 static const unsigned int scif5_data_b_mux[] = {
 	RX5_B_MARK, TX5_B_MARK,
 };
 static const unsigned int scif5_clk_b_pins[] = {
 	/* SCK */
-	19,
+	GP_PIN(0, 19),
 };
 static const unsigned int scif5_clk_b_mux[] = {
 	SCK5_B_MARK,
 };
 static const unsigned int scif5_data_c_pins[] = {
 	/* RXD, TXD */
-	24, 23,
+	GP_PIN(0, 24), GP_PIN(0, 23),
 };
 static const unsigned int scif5_data_c_mux[] = {
 	RX5_C_MARK, TX5_C_MARK,
 };
 static const unsigned int scif5_clk_c_pins[] = {
 	/* SCK */
-	28,
+	GP_PIN(0, 28),
 };
 static const unsigned int scif5_clk_c_mux[] = {
 	SCK5_C_MARK,
 };
 static const unsigned int scif5_data_d_pins[] = {
 	/* RXD, TXD */
-	8, 6,
+	GP_PIN(0, 8), GP_PIN(0, 6),
 };
 static const unsigned int scif5_data_d_mux[] = {
 	RX5_D_MARK, TX5_D_MARK,
 };
 static const unsigned int scif5_clk_d_pins[] = {
 	/* SCK */
-	7,
+	GP_PIN(0, 7),
 };
 static const unsigned int scif5_clk_d_mux[] = {
 	SCK5_D_MARK,
@@ -2200,35 +2214,35 @@ static const unsigned int scif5_clk_d_mux[] = {
 /* - SDHI0 ------------------------------------------------------------------ */
 static const unsigned int sdhi0_data1_pins[] = {
 	/* D0 */
-	117,
+	GP_PIN(3, 21),
 };
 static const unsigned int sdhi0_data1_mux[] = {
 	SD0_DAT0_MARK,
 };
 static const unsigned int sdhi0_data4_pins[] = {
 	/* D[0:3] */
-	117, 118, 119, 120,
+	GP_PIN(3, 21), GP_PIN(3, 22), GP_PIN(3, 23), GP_PIN(3, 24),
 };
 static const unsigned int sdhi0_data4_mux[] = {
 	SD0_DAT0_MARK, SD0_DAT1_MARK, SD0_DAT2_MARK, SD0_DAT3_MARK,
 };
 static const unsigned int sdhi0_ctrl_pins[] = {
 	/* CMD, CLK */
-	114, 113,
+	GP_PIN(3, 18), GP_PIN(3, 17),
 };
 static const unsigned int sdhi0_ctrl_mux[] = {
 	SD0_CMD_MARK, SD0_CLK_MARK,
 };
 static const unsigned int sdhi0_cd_pins[] = {
 	/* CD */
-	115,
+	GP_PIN(3, 19),
 };
 static const unsigned int sdhi0_cd_mux[] = {
 	SD0_CD_MARK,
 };
 static const unsigned int sdhi0_wp_pins[] = {
 	/* WP */
-	116,
+	GP_PIN(3, 20),
 };
 static const unsigned int sdhi0_wp_mux[] = {
 	SD0_WP_MARK,
@@ -2236,35 +2250,35 @@ static const unsigned int sdhi0_wp_mux[] = {
 /* - SDHI1 ------------------------------------------------------------------ */
 static const unsigned int sdhi1_data1_pins[] = {
 	/* D0 */
-	19,
+	GP_PIN(0, 19),
 };
 static const unsigned int sdhi1_data1_mux[] = {
 	SD1_DAT0_MARK,
 };
 static const unsigned int sdhi1_data4_pins[] = {
 	/* D[0:3] */
-	19, 20, 21, 2,
+	GP_PIN(0, 19), GP_PIN(0, 20), GP_PIN(0, 21), GP_PIN(0, 2),
 };
 static const unsigned int sdhi1_data4_mux[] = {
 	SD1_DAT0_MARK, SD1_DAT1_MARK, SD1_DAT2_MARK, SD1_DAT3_MARK,
 };
 static const unsigned int sdhi1_ctrl_pins[] = {
 	/* CMD, CLK */
-	18, 17,
+	GP_PIN(0, 18), GP_PIN(0, 17),
 };
 static const unsigned int sdhi1_ctrl_mux[] = {
 	SD1_CMD_MARK, SD1_CLK_MARK,
 };
 static const unsigned int sdhi1_cd_pins[] = {
 	/* CD */
-	10,
+	GP_PIN(0, 10),
 };
 static const unsigned int sdhi1_cd_mux[] = {
 	SD1_CD_MARK,
 };
 static const unsigned int sdhi1_wp_pins[] = {
 	/* WP */
-	11,
+	GP_PIN(0, 11),
 };
 static const unsigned int sdhi1_wp_mux[] = {
 	SD1_WP_MARK,
@@ -2272,35 +2286,35 @@ static const unsigned int sdhi1_wp_mux[] = {
 /* - SDHI2 ------------------------------------------------------------------ */
 static const unsigned int sdhi2_data1_pins[] = {
 	/* D0 */
-	97,
+	GP_PIN(3, 1),
 };
 static const unsigned int sdhi2_data1_mux[] = {
 	SD2_DAT0_MARK,
 };
 static const unsigned int sdhi2_data4_pins[] = {
 	/* D[0:3] */
-	97, 98, 99, 100,
+	GP_PIN(3, 1), GP_PIN(3, 2), GP_PIN(3, 3), GP_PIN(3, 4),
 };
 static const unsigned int sdhi2_data4_mux[] = {
 	SD2_DAT0_MARK, SD2_DAT1_MARK, SD2_DAT2_MARK, SD2_DAT3_MARK,
 };
 static const unsigned int sdhi2_ctrl_pins[] = {
 	/* CMD, CLK */
-	102, 101,
+	GP_PIN(3, 6), GP_PIN(3, 5),
 };
 static const unsigned int sdhi2_ctrl_mux[] = {
 	SD2_CMD_MARK, SD2_CLK_MARK,
 };
 static const unsigned int sdhi2_cd_pins[] = {
 	/* CD */
-	103,
+	GP_PIN(3, 7),
 };
 static const unsigned int sdhi2_cd_mux[] = {
 	SD2_CD_MARK,
 };
 static const unsigned int sdhi2_wp_pins[] = {
 	/* WP */
-	104,
+	GP_PIN(3, 8),
 };
 static const unsigned int sdhi2_wp_mux[] = {
 	SD2_WP_MARK,
@@ -2308,35 +2322,35 @@ static const unsigned int sdhi2_wp_mux[] = {
 /* - SDHI3 ------------------------------------------------------------------ */
 static const unsigned int sdhi3_data1_pins[] = {
 	/* D0 */
-	50,
+	GP_PIN(1, 18),
 };
 static const unsigned int sdhi3_data1_mux[] = {
 	SD3_DAT0_MARK,
 };
 static const unsigned int sdhi3_data4_pins[] = {
 	/* D[0:3] */
-	50, 51, 52, 53,
+	GP_PIN(1, 18), GP_PIN(1, 19), GP_PIN(1, 20), GP_PIN(1, 21),
 };
 static const unsigned int sdhi3_data4_mux[] = {
 	SD3_DAT0_MARK, SD3_DAT1_MARK, SD3_DAT2_MARK, SD3_DAT3_MARK,
 };
 static const unsigned int sdhi3_ctrl_pins[] = {
 	/* CMD, CLK */
-	35, 34,
+	GP_PIN(1, 3), GP_PIN(1, 2),
 };
 static const unsigned int sdhi3_ctrl_mux[] = {
 	SD3_CMD_MARK, SD3_CLK_MARK,
 };
 static const unsigned int sdhi3_cd_pins[] = {
 	/* CD */
-	62,
+	GP_PIN(1, 30),
 };
 static const unsigned int sdhi3_cd_mux[] = {
 	SD3_CD_MARK,
 };
 static const unsigned int sdhi3_wp_pins[] = {
 	/* WP */
-	64,
+	GP_PIN(2, 0),
 };
 static const unsigned int sdhi3_wp_mux[] = {
 	SD3_WP_MARK,
@@ -2344,7 +2358,7 @@ static const unsigned int sdhi3_wp_mux[] = {
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
 	/* OVC */
-	150, 154,
+	GP_PIN(4, 22), GP_PIN(4, 26),
 };
 static const unsigned int usb0_mux[] = {
 	USB_OVC0_MARK, USB_PENC0_MARK,
@@ -2352,7 +2366,7 @@ static const unsigned int usb0_mux[] = {
 /* - USB1 ------------------------------------------------------------------- */
 static const unsigned int usb1_pins[] = {
 	/* OVC */
-	152, 155,
+	GP_PIN(4, 24), GP_PIN(4, 27),
 };
 static const unsigned int usb1_mux[] = {
 	USB_OVC1_MARK, USB_PENC1_MARK,
@@ -2360,7 +2374,7 @@ static const unsigned int usb1_mux[] = {
 /* - USB2 ------------------------------------------------------------------- */
 static const unsigned int usb2_pins[] = {
 	/* OVC, PENC */
-	125, 156,
+	GP_PIN(3, 29), GP_PIN(4, 28),
 };
 static const unsigned int usb2_mux[] = {
 	USB_OVC2_MARK, USB_PENC2_MARK,
-- 
1.8.1.5

