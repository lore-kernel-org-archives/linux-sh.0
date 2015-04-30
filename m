From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:51 +0000
Subject: [PATCH v2 02/15] pinctrl: sh-pfc: Add r8a7793 PFC support part 2: pin groups
Message-Id: <1430403544-26742-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Part of PFC support for R-Car M2-N (r8a7793) that defines the device
pin groups.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[uli: minor reformat to fit mainline, fixed typos, split]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7793.c | 3168 ++++++++++++++++++++++++++++++++++
 1 file changed, 3168 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7793.c b/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
index 55cacc9..2de729a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7793.c
@@ -1679,3 +1679,3171 @@ static const u16 pinmux_data[] = {
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
+
+/* - Audio Clock ------------------------------------------------------------ */
+static const unsigned int audio_clk_a_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(2, 28),
+};
+
+static const unsigned int audio_clk_a_mux[] = {
+	AUDIO_CLKA_MARK,
+};
+
+static const unsigned int audio_clk_b_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(2, 29),
+};
+
+static const unsigned int audio_clk_b_mux[] = {
+	AUDIO_CLKB_MARK,
+};
+
+static const unsigned int audio_clk_b_b_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(7, 20),
+};
+
+static const unsigned int audio_clk_b_b_mux[] = {
+	AUDIO_CLKB_B_MARK,
+};
+
+static const unsigned int audio_clk_c_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(2, 30),
+};
+
+static const unsigned int audio_clk_c_mux[] = {
+	AUDIO_CLKC_MARK,
+};
+
+static const unsigned int audio_clkout_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(2, 31),
+};
+
+static const unsigned int audio_clkout_mux[] = {
+	AUDIO_CLKOUT_MARK,
+};
+
+
+/* - DU --------------------------------------------------------------------- */
+static const unsigned int du_rgb666_pins[] = {
+	/* R[7:2], G[7:2], B[7:2] */
+	RCAR_GP_PIN(3, 7),  RCAR_GP_PIN(3, 6),  RCAR_GP_PIN(3, 5),
+	RCAR_GP_PIN(3, 4),  RCAR_GP_PIN(3, 3),  RCAR_GP_PIN(3, 2),
+	RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 13),
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 11), RCAR_GP_PIN(3, 10),
+	RCAR_GP_PIN(3, 23), RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 21),
+	RCAR_GP_PIN(3, 20), RCAR_GP_PIN(3, 19), RCAR_GP_PIN(3, 18),
+};
+static const unsigned int du_rgb666_mux[] = {
+	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
+	DU1_DR3_MARK, DU1_DR2_MARK,
+	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
+	DU1_DG3_MARK, DU1_DG2_MARK,
+	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
+	DU1_DB3_MARK, DU1_DB2_MARK,
+};
+static const unsigned int du_rgb888_pins[] = {
+	/* R[7:0], G[7:0], B[7:0] */
+	RCAR_GP_PIN(3, 7),  RCAR_GP_PIN(3, 6),  RCAR_GP_PIN(3, 5),
+	RCAR_GP_PIN(3, 4),  RCAR_GP_PIN(3, 3),  RCAR_GP_PIN(3, 2),
+	RCAR_GP_PIN(3, 1),  RCAR_GP_PIN(3, 0),
+	RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 13),
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 11), RCAR_GP_PIN(3, 10),
+	RCAR_GP_PIN(3, 9),  RCAR_GP_PIN(3, 8),
+	RCAR_GP_PIN(3, 23), RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 21),
+	RCAR_GP_PIN(3, 20), RCAR_GP_PIN(3, 19), RCAR_GP_PIN(3, 18),
+	RCAR_GP_PIN(3, 17), RCAR_GP_PIN(3, 16),
+};
+static const unsigned int du_rgb888_mux[] = {
+	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
+	DU1_DR3_MARK, DU1_DR2_MARK, DU1_DR1_MARK, DU1_DR0_MARK,
+	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
+	DU1_DG3_MARK, DU1_DG2_MARK, DU1_DG1_MARK, DU1_DG0_MARK,
+	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
+	DU1_DB3_MARK, DU1_DB2_MARK, DU1_DB1_MARK, DU1_DB0_MARK,
+};
+static const unsigned int du_clk_out_0_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(3, 25),
+};
+static const unsigned int du_clk_out_0_mux[] = {
+	DU1_DOTCLKOUT0_MARK
+};
+static const unsigned int du_clk_out_1_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(3, 26),
+};
+static const unsigned int du_clk_out_1_mux[] = {
+	DU1_DOTCLKOUT1_MARK
+};
+static const unsigned int du_sync_pins[] = {
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(3, 28), RCAR_GP_PIN(3, 27),
+};
+static const unsigned int du_sync_mux[] = {
+	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK
+};
+static const unsigned int du_oddf_pins[] = {
+	/* EXDISP/EXODDF/EXCDE */
+	RCAR_GP_PIN(3, 29),
+};
+static const unsigned int du_oddf_mux[] = {
+	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
+};
+static const unsigned int du_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(3, 31),
+};
+static const unsigned int du_cde_mux[] = {
+	DU1_CDE_MARK,
+};
+static const unsigned int du_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(3, 30),
+};
+static const unsigned int du_disp_mux[] = {
+	DU1_DISP_MARK,
+};
+static const unsigned int du0_clk_in_pins[] = {
+	/* CLKIN */
+	RCAR_GP_PIN(6, 31),
+};
+static const unsigned int du0_clk_in_mux[] = {
+	DU0_DOTCLKIN_MARK
+};
+static const unsigned int du1_clk_in_pins[] = {
+	/* CLKIN */
+	RCAR_GP_PIN(3, 24),
+};
+static const unsigned int du1_clk_in_mux[] = {
+	DU1_DOTCLKIN_MARK
+};
+static const unsigned int du1_clk_in_b_pins[] = {
+	/* CLKIN */
+	RCAR_GP_PIN(7, 19),
+};
+static const unsigned int du1_clk_in_b_mux[] = {
+	DU1_DOTCLKIN_B_MARK,
+};
+static const unsigned int du1_clk_in_c_pins[] = {
+	/* CLKIN */
+	RCAR_GP_PIN(7, 20),
+};
+static const unsigned int du1_clk_in_c_mux[] = {
+	DU1_DOTCLKIN_C_MARK,
+};
+/* - ETH -------------------------------------------------------------------- */
+static const unsigned int eth_link_pins[] = {
+	/* LINK */
+	RCAR_GP_PIN(5, 18),
+};
+static const unsigned int eth_link_mux[] = {
+	ETH_LINK_MARK,
+};
+static const unsigned int eth_magic_pins[] = {
+	/* MAGIC */
+	RCAR_GP_PIN(5, 22),
+};
+static const unsigned int eth_magic_mux[] = {
+	ETH_MAGIC_MARK,
+};
+static const unsigned int eth_mdio_pins[] = {
+	/* MDC, MDIO */
+	RCAR_GP_PIN(5, 24), RCAR_GP_PIN(5, 13),
+};
+static const unsigned int eth_mdio_mux[] = {
+	ETH_MDC_MARK, ETH_MDIO_MARK,
+};
+static const unsigned int eth_rmii_pins[] = {
+	/* RXD[0:1], RX_ER, CRS_DV, TXD[0:1], TX_EN, REF_CLK */
+	RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 15),
+	RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 23), RCAR_GP_PIN(5, 20),
+	RCAR_GP_PIN(5, 21), RCAR_GP_PIN(5, 19),
+};
+static const unsigned int eth_rmii_mux[] = {
+	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_RX_ER_MARK, ETH_CRS_DV_MARK,
+	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK, ETH_REFCLK_MARK,
+};
+/* - HSCIF0 ----------------------------------------------------------------- */
+static const unsigned int hscif0_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(7, 3), RCAR_GP_PIN(7, 4),
+};
+static const unsigned int hscif0_data_mux[] = {
+	HRX0_MARK, HTX0_MARK,
+};
+static const unsigned int hscif0_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(7, 2),
+};
+static const unsigned int hscif0_clk_mux[] = {
+	HSCK0_MARK,
+};
+static const unsigned int hscif0_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(7, 1), RCAR_GP_PIN(7, 0),
+};
+static const unsigned int hscif0_ctrl_mux[] = {
+	HRTS0_N_MARK, HCTS0_N_MARK,
+};
+static const unsigned int hscif0_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 15),
+};
+static const unsigned int hscif0_data_b_mux[] = {
+	HRX0_B_MARK, HTX0_B_MARK,
+};
+static const unsigned int hscif0_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 13),
+};
+static const unsigned int hscif0_ctrl_b_mux[] = {
+	HRTS0_N_B_MARK, HCTS0_N_B_MARK,
+};
+static const unsigned int hscif0_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 0), RCAR_GP_PIN(2, 1),
+};
+static const unsigned int hscif0_data_c_mux[] = {
+	HRX0_C_MARK, HTX0_C_MARK,
+};
+static const unsigned int hscif0_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 31),
+};
+static const unsigned int hscif0_clk_c_mux[] = {
+	HSCK0_C_MARK,
+};
+/* - HSCIF1 ----------------------------------------------------------------- */
+static const unsigned int hscif1_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(7, 5), RCAR_GP_PIN(7, 6),
+};
+static const unsigned int hscif1_data_mux[] = {
+	HRX1_MARK, HTX1_MARK,
+};
+static const unsigned int hscif1_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(7, 7),
+};
+static const unsigned int hscif1_clk_mux[] = {
+	HSCK1_MARK,
+};
+static const unsigned int hscif1_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(7, 9), RCAR_GP_PIN(7, 8),
+};
+static const unsigned int hscif1_ctrl_mux[] = {
+	HRTS1_N_MARK, HCTS1_N_MARK,
+};
+static const unsigned int hscif1_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 18),
+};
+static const unsigned int hscif1_data_b_mux[] = {
+	HRX1_B_MARK, HTX1_B_MARK,
+};
+static const unsigned int hscif1_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(7, 14), RCAR_GP_PIN(7, 15),
+};
+static const unsigned int hscif1_data_c_mux[] = {
+	HRX1_C_MARK, HTX1_C_MARK,
+};
+static const unsigned int hscif1_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(7, 16),
+};
+static const unsigned int hscif1_clk_c_mux[] = {
+	HSCK1_C_MARK,
+};
+static const unsigned int hscif1_ctrl_c_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(7, 18), RCAR_GP_PIN(7, 17),
+};
+static const unsigned int hscif1_ctrl_c_mux[] = {
+	HRTS1_N_C_MARK, HCTS1_N_C_MARK,
+};
+static const unsigned int hscif1_data_d_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 18),
+};
+static const unsigned int hscif1_data_d_mux[] = {
+	HRX1_D_MARK, HTX1_D_MARK,
+};
+static const unsigned int hscif1_data_e_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(7, 14), RCAR_GP_PIN(7, 15),
+};
+static const unsigned int hscif1_data_e_mux[] = {
+	HRX1_C_MARK, HTX1_C_MARK,
+};
+static const unsigned int hscif1_clk_e_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 6),
+};
+static const unsigned int hscif1_clk_e_mux[] = {
+	HSCK1_E_MARK,
+};
+static const unsigned int hscif1_ctrl_e_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(2, 8), RCAR_GP_PIN(2, 7),
+};
+static const unsigned int hscif1_ctrl_e_mux[] = {
+	HRTS1_N_E_MARK, HCTS1_N_E_MARK,
+};
+/* - HSCIF2 ----------------------------------------------------------------- */
+static const unsigned int hscif2_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(4, 16), RCAR_GP_PIN(4, 17),
+};
+static const unsigned int hscif2_data_mux[] = {
+	HRX2_MARK, HTX2_MARK,
+};
+static const unsigned int hscif2_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(4, 15),
+};
+static const unsigned int hscif2_clk_mux[] = {
+	HSCK2_MARK,
+};
+static const unsigned int hscif2_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 13),
+};
+static const unsigned int hscif2_ctrl_mux[] = {
+	HRTS2_N_MARK, HCTS2_N_MARK,
+};
+static const unsigned int hscif2_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 22),
+};
+static const unsigned int hscif2_data_b_mux[] = {
+	HRX2_B_MARK, HTX2_B_MARK,
+};
+static const unsigned int hscif2_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(1, 23), RCAR_GP_PIN(1, 21),
+};
+static const unsigned int hscif2_ctrl_b_mux[] = {
+	HRTS2_N_B_MARK, HCTS2_N_B_MARK,
+};
+static const unsigned int hscif2_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 0), RCAR_GP_PIN(2, 1),
+};
+static const unsigned int hscif2_data_c_mux[] = {
+	HRX2_C_MARK, HTX2_C_MARK,
+};
+static const unsigned int hscif2_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 31),
+};
+static const unsigned int hscif2_clk_c_mux[] = {
+	HSCK2_C_MARK,
+};
+/* - I2C0 ------------------------------------------------------------------- */
+static const unsigned int i2c0_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(0, 24), RCAR_GP_PIN(0, 25),
+};
+static const unsigned int i2c0_mux[] = {
+	SCL0_MARK, SDA0_MARK,
+};
+static const unsigned int i2c0_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 3),
+};
+static const unsigned int i2c0_b_mux[] = {
+	SCL0_B_MARK, SDA0_B_MARK,
+};
+static const unsigned int i2c0_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(0, 16), RCAR_GP_PIN(1, 1),
+};
+static const unsigned int i2c0_c_mux[] = {
+	SCL0_C_MARK, SDA0_C_MARK,
+};
+/* - I2C1 ------------------------------------------------------------------- */
+static const unsigned int i2c1_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 11),
+};
+static const unsigned int i2c1_mux[] = {
+	SCL1_MARK, SDA1_MARK,
+};
+static const unsigned int i2c1_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 5),
+};
+static const unsigned int i2c1_b_mux[] = {
+	SCL1_B_MARK, SDA1_B_MARK,
+};
+static const unsigned int i2c1_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(6, 14), RCAR_GP_PIN(6, 15),
+};
+static const unsigned int i2c1_c_mux[] = {
+	SCL1_C_MARK, SDA1_C_MARK,
+};
+static const unsigned int i2c1_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 26),
+};
+static const unsigned int i2c1_d_mux[] = {
+	SCL1_D_MARK, SDA1_D_MARK,
+};
+static const unsigned int i2c1_e_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(7, 15), RCAR_GP_PIN(7, 16),
+};
+static const unsigned int i2c1_e_mux[] = {
+	SCL1_E_MARK, SDA1_E_MARK,
+};
+/* - I2C2 ------------------------------------------------------------------- */
+static const unsigned int i2c2_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 6), RCAR_GP_PIN(2, 7),
+};
+static const unsigned int i2c2_mux[] = {
+	SCL2_MARK, SDA2_MARK,
+};
+static const unsigned int i2c2_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 26), RCAR_GP_PIN(3, 29),
+};
+static const unsigned int i2c2_b_mux[] = {
+	SCL2_B_MARK, SDA2_B_MARK,
+};
+static const unsigned int i2c2_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 14),
+};
+static const unsigned int i2c2_c_mux[] = {
+	SCL2_C_MARK, SDA2_C_MARK,
+};
+static const unsigned int i2c2_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 18),
+};
+static const unsigned int i2c2_d_mux[] = {
+	SCL2_D_MARK, SDA2_D_MARK,
+};
+/* - I2C3 ------------------------------------------------------------------- */
+static const unsigned int i2c3_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 16),
+};
+static const unsigned int i2c3_mux[] = {
+	SCL3_MARK, SDA3_MARK,
+};
+static const unsigned int i2c3_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 16),
+};
+static const unsigned int i2c3_b_mux[] = {
+	SCL3_B_MARK, SDA3_B_MARK,
+};
+static const unsigned int i2c3_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 23),
+};
+static const unsigned int i2c3_c_mux[] = {
+	SCL3_C_MARK, SDA3_C_MARK,
+};
+static const unsigned int i2c3_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28),
+};
+static const unsigned int i2c3_d_mux[] = {
+	SCL3_D_MARK, SDA3_D_MARK,
+};
+/* - I2C4 ------------------------------------------------------------------- */
+static const unsigned int i2c4_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 14),
+};
+static const unsigned int i2c4_mux[] = {
+	SCL4_MARK, SDA4_MARK,
+};
+static const unsigned int i2c4_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
+};
+static const unsigned int i2c4_b_mux[] = {
+	SCL4_B_MARK, SDA4_B_MARK,
+};
+static const unsigned int i2c4_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(7, 13), RCAR_GP_PIN(7, 14),
+};
+static const unsigned int i2c4_c_mux[] = {
+	SCL4_C_MARK, SDA4_C_MARK,
+};
+/* - I2C7 ------------------------------------------------------------------- */
+static const unsigned int i2c7_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 16),
+};
+static const unsigned int i2c7_mux[] = {
+	SCL7_MARK, SDA7_MARK,
+};
+static const unsigned int i2c7_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 3),
+};
+static const unsigned int i2c7_b_mux[] = {
+	SCL7_B_MARK, SDA7_B_MARK,
+};
+static const unsigned int i2c7_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(6, 28), RCAR_GP_PIN(6, 29),
+};
+static const unsigned int i2c7_c_mux[] = {
+	SCL7_C_MARK, SDA7_C_MARK,
+};
+/* - I2C8 ------------------------------------------------------------------- */
+static const unsigned int i2c8_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 14),
+};
+static const unsigned int i2c8_mux[] = {
+	SCL8_MARK, SDA8_MARK,
+};
+static const unsigned int i2c8_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 5),
+};
+static const unsigned int i2c8_b_mux[] = {
+	SCL8_B_MARK, SDA8_B_MARK,
+};
+static const unsigned int i2c8_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(6, 22), RCAR_GP_PIN(6, 23),
+};
+static const unsigned int i2c8_c_mux[] = {
+	SCL8_C_MARK, SDA8_C_MARK,
+};
+/* - INTC ------------------------------------------------------------------- */
+static const unsigned int intc_irq0_pins[] = {
+	/* IRQ */
+	RCAR_GP_PIN(7, 10),
+};
+static const unsigned int intc_irq0_mux[] = {
+	IRQ0_MARK,
+};
+static const unsigned int intc_irq1_pins[] = {
+	/* IRQ */
+	RCAR_GP_PIN(7, 11),
+};
+static const unsigned int intc_irq1_mux[] = {
+	IRQ1_MARK,
+};
+static const unsigned int intc_irq2_pins[] = {
+	/* IRQ */
+	RCAR_GP_PIN(7, 12),
+};
+static const unsigned int intc_irq2_mux[] = {
+	IRQ2_MARK,
+};
+static const unsigned int intc_irq3_pins[] = {
+	/* IRQ */
+	RCAR_GP_PIN(7, 13),
+};
+static const unsigned int intc_irq3_mux[] = {
+	IRQ3_MARK,
+};
+/* - MMCIF ------------------------------------------------------------------ */
+static const unsigned int mmc_data1_pins[] = {
+	/* D[0] */
+	RCAR_GP_PIN(6, 18),
+};
+static const unsigned int mmc_data1_mux[] = {
+	MMC_D0_MARK,
+};
+static const unsigned int mmc_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(6, 18), RCAR_GP_PIN(6, 19),
+	RCAR_GP_PIN(6, 20), RCAR_GP_PIN(6, 21),
+};
+static const unsigned int mmc_data4_mux[] = {
+	MMC_D0_MARK, MMC_D1_MARK, MMC_D2_MARK, MMC_D3_MARK,
+};
+static const unsigned int mmc_data8_pins[] = {
+	/* D[0:7] */
+	RCAR_GP_PIN(6, 18), RCAR_GP_PIN(6, 19),
+	RCAR_GP_PIN(6, 20), RCAR_GP_PIN(6, 21),
+	RCAR_GP_PIN(6, 22), RCAR_GP_PIN(6, 23),
+	RCAR_GP_PIN(6, 28), RCAR_GP_PIN(6, 29),
+};
+static const unsigned int mmc_data8_mux[] = {
+	MMC_D0_MARK, MMC_D1_MARK, MMC_D2_MARK, MMC_D3_MARK,
+	MMC_D4_MARK, MMC_D5_MARK, MMC_D6_MARK, MMC_D7_MARK,
+};
+static const unsigned int mmc_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(6, 16), RCAR_GP_PIN(6, 17),
+};
+static const unsigned int mmc_ctrl_mux[] = {
+	MMC_CLK_MARK, MMC_CMD_MARK,
+};
+/* - MSIOF0 ----------------------------------------------------------------- */
+static const unsigned int msiof0_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(6, 24),
+};
+static const unsigned int msiof0_clk_mux[] = {
+	MSIOF0_SCK_MARK,
+};
+static const unsigned int msiof0_sync_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(6, 25),
+};
+static const unsigned int msiof0_sync_mux[] = {
+	MSIOF0_SYNC_MARK,
+};
+static const unsigned int msiof0_ss1_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(6, 28),
+};
+static const unsigned int msiof0_ss1_mux[] = {
+	MSIOF0_SS1_MARK,
+};
+static const unsigned int msiof0_ss2_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(6, 29),
+};
+static const unsigned int msiof0_ss2_mux[] = {
+	MSIOF0_SS2_MARK,
+};
+static const unsigned int msiof0_rx_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(6, 27),
+};
+static const unsigned int msiof0_rx_mux[] = {
+	MSIOF0_RXD_MARK,
+};
+static const unsigned int msiof0_tx_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(6, 26),
+};
+static const unsigned int msiof0_tx_mux[] = {
+	MSIOF0_TXD_MARK,
+};
+
+static const unsigned int msiof0_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(0, 16),
+};
+static const unsigned int msiof0_clk_b_mux[] = {
+	MSIOF0_SCK_B_MARK,
+};
+static const unsigned int msiof0_sync_b_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(0, 17),
+};
+static const unsigned int msiof0_sync_b_mux[] = {
+	MSIOF0_SYNC_B_MARK,
+};
+static const unsigned int msiof0_ss1_b_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(0, 18),
+};
+static const unsigned int msiof0_ss1_b_mux[] = {
+	MSIOF0_SS1_B_MARK,
+};
+static const unsigned int msiof0_ss2_b_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(0, 19),
+};
+static const unsigned int msiof0_ss2_b_mux[] = {
+	MSIOF0_SS2_B_MARK,
+};
+static const unsigned int msiof0_rx_b_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(0, 21),
+};
+static const unsigned int msiof0_rx_b_mux[] = {
+	MSIOF0_RXD_B_MARK,
+};
+static const unsigned int msiof0_tx_b_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(0, 20),
+};
+static const unsigned int msiof0_tx_b_mux[] = {
+	MSIOF0_TXD_B_MARK,
+};
+
+static const unsigned int msiof0_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 26),
+};
+static const unsigned int msiof0_clk_c_mux[] = {
+	MSIOF0_SCK_C_MARK,
+};
+static const unsigned int msiof0_sync_c_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(5, 25),
+};
+static const unsigned int msiof0_sync_c_mux[] = {
+	MSIOF0_SYNC_C_MARK,
+};
+static const unsigned int msiof0_ss1_c_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(5, 27),
+};
+static const unsigned int msiof0_ss1_c_mux[] = {
+	MSIOF0_SS1_C_MARK,
+};
+static const unsigned int msiof0_ss2_c_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(5, 28),
+};
+static const unsigned int msiof0_ss2_c_mux[] = {
+	MSIOF0_SS2_C_MARK,
+};
+static const unsigned int msiof0_rx_c_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(5, 29),
+};
+static const unsigned int msiof0_rx_c_mux[] = {
+	MSIOF0_RXD_C_MARK,
+};
+static const unsigned int msiof0_tx_c_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(5, 30),
+};
+static const unsigned int msiof0_tx_c_mux[] = {
+	MSIOF0_TXD_C_MARK,
+};
+/* - MSIOF1 ----------------------------------------------------------------- */
+static const unsigned int msiof1_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(0, 22),
+};
+static const unsigned int msiof1_clk_mux[] = {
+	MSIOF1_SCK_MARK,
+};
+static const unsigned int msiof1_sync_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(0, 23),
+};
+static const unsigned int msiof1_sync_mux[] = {
+	MSIOF1_SYNC_MARK,
+};
+static const unsigned int msiof1_ss1_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(0, 24),
+};
+static const unsigned int msiof1_ss1_mux[] = {
+	MSIOF1_SS1_MARK,
+};
+static const unsigned int msiof1_ss2_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(0, 25),
+};
+static const unsigned int msiof1_ss2_mux[] = {
+	MSIOF1_SS2_MARK,
+};
+static const unsigned int msiof1_rx_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(0, 27),
+};
+static const unsigned int msiof1_rx_mux[] = {
+	MSIOF1_RXD_MARK,
+};
+static const unsigned int msiof1_tx_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(0, 26),
+};
+static const unsigned int msiof1_tx_mux[] = {
+	MSIOF1_TXD_MARK,
+};
+
+static const unsigned int msiof1_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 29),
+};
+static const unsigned int msiof1_clk_b_mux[] = {
+	MSIOF1_SCK_B_MARK,
+};
+static const unsigned int msiof1_sync_b_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(2, 30),
+};
+static const unsigned int msiof1_sync_b_mux[] = {
+	MSIOF1_SYNC_B_MARK,
+};
+static const unsigned int msiof1_ss1_b_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(2, 31),
+};
+static const unsigned int msiof1_ss1_b_mux[] = {
+	MSIOF1_SS1_B_MARK,
+};
+static const unsigned int msiof1_ss2_b_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(7, 16),
+};
+static const unsigned int msiof1_ss2_b_mux[] = {
+	MSIOF1_SS2_B_MARK,
+};
+static const unsigned int msiof1_rx_b_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(7, 18),
+};
+static const unsigned int msiof1_rx_b_mux[] = {
+	MSIOF1_RXD_B_MARK,
+};
+static const unsigned int msiof1_tx_b_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(7, 17),
+};
+static const unsigned int msiof1_tx_b_mux[] = {
+	MSIOF1_TXD_B_MARK,
+};
+
+static const unsigned int msiof1_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 15),
+};
+static const unsigned int msiof1_clk_c_mux[] = {
+	MSIOF1_SCK_C_MARK,
+};
+static const unsigned int msiof1_sync_c_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(2, 16),
+};
+static const unsigned int msiof1_sync_c_mux[] = {
+	MSIOF1_SYNC_C_MARK,
+};
+static const unsigned int msiof1_rx_c_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(2, 18),
+};
+static const unsigned int msiof1_rx_c_mux[] = {
+	MSIOF1_RXD_C_MARK,
+};
+static const unsigned int msiof1_tx_c_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(2, 17),
+};
+static const unsigned int msiof1_tx_c_mux[] = {
+	MSIOF1_TXD_C_MARK,
+};
+
+static const unsigned int msiof1_clk_d_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(0, 28),
+};
+static const unsigned int msiof1_clk_d_mux[] = {
+	MSIOF1_SCK_D_MARK,
+};
+static const unsigned int msiof1_sync_d_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(0, 30),
+};
+static const unsigned int msiof1_sync_d_mux[] = {
+	MSIOF1_SYNC_D_MARK,
+};
+static const unsigned int msiof1_ss1_d_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(0, 29),
+};
+static const unsigned int msiof1_ss1_d_mux[] = {
+	MSIOF1_SS1_D_MARK,
+};
+static const unsigned int msiof1_rx_d_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(0, 27),
+};
+static const unsigned int msiof1_rx_d_mux[] = {
+	MSIOF1_RXD_D_MARK,
+};
+static const unsigned int msiof1_tx_d_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(0, 26),
+};
+static const unsigned int msiof1_tx_d_mux[] = {
+	MSIOF1_TXD_D_MARK,
+};
+
+static const unsigned int msiof1_clk_e_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 18),
+};
+static const unsigned int msiof1_clk_e_mux[] = {
+	MSIOF1_SCK_E_MARK,
+};
+static const unsigned int msiof1_sync_e_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(5, 19),
+};
+static const unsigned int msiof1_sync_e_mux[] = {
+	MSIOF1_SYNC_E_MARK,
+};
+static const unsigned int msiof1_rx_e_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(5, 17),
+};
+static const unsigned int msiof1_rx_e_mux[] = {
+	MSIOF1_RXD_E_MARK,
+};
+static const unsigned int msiof1_tx_e_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(5, 20),
+};
+static const unsigned int msiof1_tx_e_mux[] = {
+	MSIOF1_TXD_E_MARK,
+};
+/* - MSIOF2 ----------------------------------------------------------------- */
+static const unsigned int msiof2_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 13),
+};
+static const unsigned int msiof2_clk_mux[] = {
+	MSIOF2_SCK_MARK,
+};
+static const unsigned int msiof2_sync_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(1, 14),
+};
+static const unsigned int msiof2_sync_mux[] = {
+	MSIOF2_SYNC_MARK,
+};
+static const unsigned int msiof2_ss1_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(1, 17),
+};
+static const unsigned int msiof2_ss1_mux[] = {
+	MSIOF2_SS1_MARK,
+};
+static const unsigned int msiof2_ss2_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(1, 18),
+};
+static const unsigned int msiof2_ss2_mux[] = {
+	MSIOF2_SS2_MARK,
+};
+static const unsigned int msiof2_rx_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(1, 16),
+};
+static const unsigned int msiof2_rx_mux[] = {
+	MSIOF2_RXD_MARK,
+};
+static const unsigned int msiof2_tx_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(1, 15),
+};
+static const unsigned int msiof2_tx_mux[] = {
+	MSIOF2_TXD_MARK,
+};
+
+static const unsigned int msiof2_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(3, 0),
+};
+static const unsigned int msiof2_clk_b_mux[] = {
+	MSIOF2_SCK_B_MARK,
+};
+static const unsigned int msiof2_sync_b_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(3, 1),
+};
+static const unsigned int msiof2_sync_b_mux[] = {
+	MSIOF2_SYNC_B_MARK,
+};
+static const unsigned int msiof2_ss1_b_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(3, 8),
+};
+static const unsigned int msiof2_ss1_b_mux[] = {
+	MSIOF2_SS1_B_MARK,
+};
+static const unsigned int msiof2_ss2_b_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(3, 9),
+};
+static const unsigned int msiof2_ss2_b_mux[] = {
+	MSIOF2_SS2_B_MARK,
+};
+static const unsigned int msiof2_rx_b_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(3, 17),
+};
+static const unsigned int msiof2_rx_b_mux[] = {
+	MSIOF2_RXD_B_MARK,
+};
+static const unsigned int msiof2_tx_b_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(3, 16),
+};
+static const unsigned int msiof2_tx_b_mux[] = {
+	MSIOF2_TXD_B_MARK,
+};
+
+static const unsigned int msiof2_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 2),
+};
+static const unsigned int msiof2_clk_c_mux[] = {
+	MSIOF2_SCK_C_MARK,
+};
+static const unsigned int msiof2_sync_c_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(2, 3),
+};
+static const unsigned int msiof2_sync_c_mux[] = {
+	MSIOF2_SYNC_C_MARK,
+};
+static const unsigned int msiof2_rx_c_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(2, 5),
+};
+static const unsigned int msiof2_rx_c_mux[] = {
+	MSIOF2_RXD_C_MARK,
+};
+static const unsigned int msiof2_tx_c_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(2, 4),
+};
+static const unsigned int msiof2_tx_c_mux[] = {
+	MSIOF2_TXD_C_MARK,
+};
+
+static const unsigned int msiof2_clk_d_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 14),
+};
+static const unsigned int msiof2_clk_d_mux[] = {
+	MSIOF2_SCK_D_MARK,
+};
+static const unsigned int msiof2_sync_d_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(2, 15),
+};
+static const unsigned int msiof2_sync_d_mux[] = {
+	MSIOF2_SYNC_D_MARK,
+};
+static const unsigned int msiof2_ss1_d_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(2, 17),
+};
+static const unsigned int msiof2_ss1_d_mux[] = {
+	MSIOF2_SS1_D_MARK,
+};
+static const unsigned int msiof2_ss2_d_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(2, 19),
+};
+static const unsigned int msiof2_ss2_d_mux[] = {
+	MSIOF2_SS2_D_MARK,
+};
+static const unsigned int msiof2_rx_d_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(2, 18),
+};
+static const unsigned int msiof2_rx_d_mux[] = {
+	MSIOF2_RXD_D_MARK,
+};
+static const unsigned int msiof2_tx_d_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(2, 16),
+};
+static const unsigned int msiof2_tx_d_mux[] = {
+	MSIOF2_TXD_D_MARK,
+};
+
+static const unsigned int msiof2_clk_e_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(7, 15),
+};
+static const unsigned int msiof2_clk_e_mux[] = {
+	MSIOF2_SCK_E_MARK,
+};
+static const unsigned int msiof2_sync_e_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(7, 16),
+};
+static const unsigned int msiof2_sync_e_mux[] = {
+	MSIOF2_SYNC_E_MARK,
+};
+static const unsigned int msiof2_rx_e_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(7, 14),
+};
+static const unsigned int msiof2_rx_e_mux[] = {
+	MSIOF2_RXD_E_MARK,
+};
+static const unsigned int msiof2_tx_e_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(7, 13),
+};
+static const unsigned int msiof2_tx_e_mux[] = {
+	MSIOF2_TXD_E_MARK,
+};
+/* - QSPI ------------------------------------------------------------------- */
+static const unsigned int qspi_ctrl_pins[] = {
+	/* SPCLK, SSL */
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 9),
+};
+static const unsigned int qspi_ctrl_mux[] = {
+	SPCLK_MARK, SSL_MARK,
+};
+static const unsigned int qspi_data2_pins[] = {
+	/* MOSI_IO0, MISO_IO1 */
+	RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
+};
+static const unsigned int qspi_data2_mux[] = {
+	MOSI_IO0_MARK, MISO_IO1_MARK,
+};
+static const unsigned int qspi_data4_pins[] = {
+	/* MOSI_IO0, MISO_IO1, IO2, IO3 */
+	RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+	RCAR_GP_PIN(1, 8),
+};
+static const unsigned int qspi_data4_mux[] = {
+	MOSI_IO0_MARK, MISO_IO1_MARK, IO2_MARK, IO3_MARK,
+};
+
+static const unsigned int qspi_ctrl_b_pins[] = {
+	/* SPCLK, SSL */
+	RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 5),
+};
+static const unsigned int qspi_ctrl_b_mux[] = {
+	SPCLK_B_MARK, SSL_B_MARK,
+};
+static const unsigned int qspi_data2_b_pins[] = {
+	/* MOSI_IO0, MISO_IO1 */
+	RCAR_GP_PIN(6, 1), RCAR_GP_PIN(6, 2),
+};
+static const unsigned int qspi_data2_b_mux[] = {
+	MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
+};
+static const unsigned int qspi_data4_b_pins[] = {
+	/* MOSI_IO0, MISO_IO1, IO2, IO3 */
+	RCAR_GP_PIN(6, 1), RCAR_GP_PIN(6, 2), RCAR_GP_PIN(6, 3),
+	RCAR_GP_PIN(6, 4),
+};
+static const unsigned int qspi_data4_b_mux[] = {
+	SPCLK_B_MARK, MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
+	IO2_B_MARK, IO3_B_MARK, SSL_B_MARK,
+};
+/* - SCIF0 ------------------------------------------------------------------ */
+static const unsigned int scif0_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 6),
+};
+static const unsigned int scif0_data_mux[] = {
+	RX0_MARK, TX0_MARK,
+};
+static const unsigned int scif0_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(3, 1), RCAR_GP_PIN(3, 0),
+};
+static const unsigned int scif0_data_b_mux[] = {
+	RX0_B_MARK, TX0_B_MARK,
+};
+static const unsigned int scif0_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(4, 26), RCAR_GP_PIN(4, 25),
+};
+static const unsigned int scif0_data_c_mux[] = {
+	RX0_C_MARK, TX0_C_MARK,
+};
+static const unsigned int scif0_data_d_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(2, 22),
+};
+static const unsigned int scif0_data_d_mux[] = {
+	RX0_D_MARK, TX0_D_MARK,
+};
+static const unsigned int scif0_data_e_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(6, 29), RCAR_GP_PIN(6, 28),
+};
+static const unsigned int scif0_data_e_mux[] = {
+	RX0_E_MARK, TX0_E_MARK,
+};
+/* - SCIF1 ------------------------------------------------------------------ */
+static const unsigned int scif1_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 8),
+};
+static const unsigned int scif1_data_mux[] = {
+	RX1_MARK, TX1_MARK,
+};
+static const unsigned int scif1_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(3, 9), RCAR_GP_PIN(3, 8),
+};
+static const unsigned int scif1_data_b_mux[] = {
+	RX1_B_MARK, TX1_B_MARK,
+};
+static const unsigned int scif1_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(3, 10),
+};
+static const unsigned int scif1_clk_b_mux[] = {
+	SCIF1_SCK_B_MARK,
+};
+static const unsigned int scif1_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 27),
+};
+static const unsigned int scif1_data_c_mux[] = {
+	RX1_C_MARK, TX1_C_MARK,
+};
+static const unsigned int scif1_data_d_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 25), RCAR_GP_PIN(2, 24),
+};
+static const unsigned int scif1_data_d_mux[] = {
+	RX1_D_MARK, TX1_D_MARK,
+};
+/* - SCIF2 ------------------------------------------------------------------ */
+static const unsigned int scif2_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 30), RCAR_GP_PIN(2, 31),
+};
+static const unsigned int scif2_data_mux[] = {
+	RX2_MARK, TX2_MARK,
+};
+static const unsigned int scif2_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(3, 17), RCAR_GP_PIN(3, 16),
+};
+static const unsigned int scif2_data_b_mux[] = {
+	RX2_B_MARK, TX2_B_MARK,
+};
+static const unsigned int scif2_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(3, 18),
+};
+static const unsigned int scif2_clk_b_mux[] = {
+	SCIF2_SCK_B_MARK,
+};
+static const unsigned int scif2_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(6, 24), RCAR_GP_PIN(6, 25),
+};
+static const unsigned int scif2_data_c_mux[] = {
+	RX2_C_MARK, TX2_C_MARK,
+};
+static const unsigned int scif2_data_e_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 7), RCAR_GP_PIN(2, 8),
+};
+static const unsigned int scif2_data_e_mux[] = {
+	RX2_E_MARK, TX2_E_MARK,
+};
+/* - SCIF3 ------------------------------------------------------------------ */
+static const unsigned int scif3_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 21),
+};
+static const unsigned int scif3_data_mux[] = {
+	RX3_MARK, TX3_MARK,
+};
+static const unsigned int scif3_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(3, 23),
+};
+static const unsigned int scif3_clk_mux[] = {
+	SCIF3_SCK_MARK,
+};
+static const unsigned int scif3_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(3, 26),
+};
+static const unsigned int scif3_data_b_mux[] = {
+	RX3_B_MARK, TX3_B_MARK,
+};
+static const unsigned int scif3_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(4, 8),
+};
+static const unsigned int scif3_clk_b_mux[] = {
+	SCIF3_SCK_B_MARK,
+};
+static const unsigned int scif3_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(6, 7), RCAR_GP_PIN(6, 6),
+};
+static const unsigned int scif3_data_c_mux[] = {
+	RX3_C_MARK, TX3_C_MARK,
+};
+static const unsigned int scif3_data_d_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 27), RCAR_GP_PIN(2, 26),
+};
+static const unsigned int scif3_data_d_mux[] = {
+	RX3_D_MARK, TX3_D_MARK,
+};
+/* - SCIF4 ------------------------------------------------------------------ */
+static const unsigned int scif4_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(4, 2), RCAR_GP_PIN(4, 1),
+};
+static const unsigned int scif4_data_mux[] = {
+	RX4_MARK, TX4_MARK,
+};
+static const unsigned int scif4_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 0),
+};
+static const unsigned int scif4_data_b_mux[] = {
+	RX4_B_MARK, TX4_B_MARK,
+};
+static const unsigned int scif4_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(7, 22), RCAR_GP_PIN(7, 21),
+};
+static const unsigned int scif4_data_c_mux[] = {
+	RX4_C_MARK, TX4_C_MARK,
+};
+/* - SCIF5 ------------------------------------------------------------------ */
+static const unsigned int scif5_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 3),
+};
+static const unsigned int scif5_data_mux[] = {
+	RX5_MARK, TX5_MARK,
+};
+static const unsigned int scif5_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(6, 23), RCAR_GP_PIN(6, 22),
+};
+static const unsigned int scif5_data_b_mux[] = {
+	RX5_B_MARK, TX5_B_MARK,
+};
+/* - SCIFA0 ----------------------------------------------------------------- */
+static const unsigned int scifa0_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 6),
+};
+static const unsigned int scifa0_data_mux[] = {
+	SCIFA0_RXD_MARK, SCIFA0_TXD_MARK,
+};
+static const unsigned int scifa0_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(3, 1), RCAR_GP_PIN(3, 0),
+};
+static const unsigned int scifa0_data_b_mux[] = {
+	SCIFA0_RXD_B_MARK, SCIFA0_TXD_B_MARK
+};
+/* - SCIFA1 ----------------------------------------------------------------- */
+static const unsigned int scifa1_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 8),
+};
+static const unsigned int scifa1_data_mux[] = {
+	SCIFA1_RXD_MARK, SCIFA1_TXD_MARK,
+};
+static const unsigned int scifa1_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(3, 10),
+};
+static const unsigned int scifa1_clk_mux[] = {
+	SCIFA1_SCK_MARK,
+};
+static const unsigned int scifa1_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(3, 9), RCAR_GP_PIN(3, 8),
+};
+static const unsigned int scifa1_data_b_mux[] = {
+	SCIFA1_RXD_B_MARK, SCIFA1_TXD_B_MARK,
+};
+static const unsigned int scifa1_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 0),
+};
+static const unsigned int scifa1_clk_b_mux[] = {
+	SCIFA1_SCK_B_MARK,
+};
+static const unsigned int scifa1_data_c_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 3),
+};
+static const unsigned int scifa1_data_c_mux[] = {
+	SCIFA1_RXD_C_MARK, SCIFA1_TXD_C_MARK,
+};
+/* - SCIFA2 ----------------------------------------------------------------- */
+static const unsigned int scifa2_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(2, 30), RCAR_GP_PIN(2, 31),
+};
+static const unsigned int scifa2_data_mux[] = {
+	SCIFA2_RXD_MARK, SCIFA2_TXD_MARK,
+};
+static const unsigned int scifa2_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(3, 18),
+};
+static const unsigned int scifa2_clk_mux[] = {
+	SCIFA2_SCK_MARK,
+};
+static const unsigned int scifa2_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(3, 17), RCAR_GP_PIN(3, 16),
+};
+static const unsigned int scifa2_data_b_mux[] = {
+	SCIFA2_RXD_B_MARK, SCIFA2_TXD_B_MARK,
+};
+/* - SCIFA3 ----------------------------------------------------------------- */
+static const unsigned int scifa3_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 21),
+};
+static const unsigned int scifa3_data_mux[] = {
+	SCIFA3_RXD_MARK, SCIFA3_TXD_MARK,
+};
+static const unsigned int scifa3_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(3, 23),
+};
+static const unsigned int scifa3_clk_mux[] = {
+	SCIFA3_SCK_MARK,
+};
+static const unsigned int scifa3_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 20),
+};
+static const unsigned int scifa3_data_b_mux[] = {
+	SCIFA3_RXD_B_MARK, SCIFA3_TXD_B_MARK,
+};
+static const unsigned int scifa3_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(4, 8),
+};
+static const unsigned int scifa3_clk_b_mux[] = {
+	SCIFA3_SCK_B_MARK,
+};
+static const unsigned int scifa3_data_c_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(7, 21), RCAR_GP_PIN(7, 20),
+};
+static const unsigned int scifa3_data_c_mux[] = {
+	SCIFA3_RXD_C_MARK, SCIFA3_TXD_C_MARK,
+};
+static const unsigned int scifa3_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(7, 22),
+};
+static const unsigned int scifa3_clk_c_mux[] = {
+	SCIFA3_SCK_C_MARK,
+};
+/* - SCIFA4 ----------------------------------------------------------------- */
+static const unsigned int scifa4_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(4, 2), RCAR_GP_PIN(4, 1),
+};
+static const unsigned int scifa4_data_mux[] = {
+	SCIFA4_RXD_MARK, SCIFA4_TXD_MARK,
+};
+static const unsigned int scifa4_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 0),
+};
+static const unsigned int scifa4_data_b_mux[] = {
+	SCIFA4_RXD_B_MARK, SCIFA4_TXD_B_MARK,
+};
+static const unsigned int scifa4_data_c_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(7, 22), RCAR_GP_PIN(7, 21),
+};
+static const unsigned int scifa4_data_c_mux[] = {
+	SCIFA4_RXD_C_MARK, SCIFA4_TXD_C_MARK,
+};
+/* - SCIFA5 ----------------------------------------------------------------- */
+static const unsigned int scifa5_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 3),
+};
+static const unsigned int scifa5_data_mux[] = {
+	SCIFA5_RXD_MARK, SCIFA5_TXD_MARK,
+};
+static const unsigned int scifa5_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(6, 7), RCAR_GP_PIN(6, 6),
+};
+static const unsigned int scifa5_data_b_mux[] = {
+	SCIFA5_RXD_B_MARK, SCIFA5_TXD_B_MARK,
+};
+static const unsigned int scifa5_data_c_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(6, 23), RCAR_GP_PIN(6, 22),
+};
+static const unsigned int scifa5_data_c_mux[] = {
+	SCIFA5_RXD_C_MARK, SCIFA5_TXD_C_MARK,
+};
+/* - SCIFB0 ----------------------------------------------------------------- */
+static const unsigned int scifb0_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(7, 3), RCAR_GP_PIN(7, 4),
+};
+static const unsigned int scifb0_data_mux[] = {
+	SCIFB0_RXD_MARK, SCIFB0_TXD_MARK,
+};
+static const unsigned int scifb0_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(7, 2),
+};
+static const unsigned int scifb0_clk_mux[] = {
+	SCIFB0_SCK_MARK,
+};
+static const unsigned int scifb0_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(7, 1), RCAR_GP_PIN(7, 0),
+};
+static const unsigned int scifb0_ctrl_mux[] = {
+	SCIFB0_RTS_N_MARK, SCIFB0_CTS_N_MARK,
+};
+static const unsigned int scifb0_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 21),
+};
+static const unsigned int scifb0_data_b_mux[] = {
+	SCIFB0_RXD_B_MARK, SCIFB0_TXD_B_MARK,
+};
+static const unsigned int scifb0_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 31),
+};
+static const unsigned int scifb0_clk_b_mux[] = {
+	SCIFB0_SCK_B_MARK,
+};
+static const unsigned int scifb0_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 23),
+};
+static const unsigned int scifb0_ctrl_b_mux[] = {
+	SCIFB0_RTS_N_B_MARK, SCIFB0_CTS_N_B_MARK,
+};
+static const unsigned int scifb0_data_c_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(2, 0), RCAR_GP_PIN(2, 1),
+};
+static const unsigned int scifb0_data_c_mux[] = {
+	SCIFB0_RXD_C_MARK, SCIFB0_TXD_C_MARK,
+};
+static const unsigned int scifb0_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 30),
+};
+static const unsigned int scifb0_clk_c_mux[] = {
+	SCIFB0_SCK_C_MARK,
+};
+static const unsigned int scifb0_data_d_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 18),
+};
+static const unsigned int scifb0_data_d_mux[] = {
+	SCIFB0_RXD_D_MARK, SCIFB0_TXD_D_MARK,
+};
+static const unsigned int scifb0_clk_d_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(4, 17),
+};
+static const unsigned int scifb0_clk_d_mux[] = {
+	SCIFB0_SCK_D_MARK,
+};
+/* - SCIFB1 ----------------------------------------------------------------- */
+static const unsigned int scifb1_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(7, 5), RCAR_GP_PIN(7, 6),
+};
+static const unsigned int scifb1_data_mux[] = {
+	SCIFB1_RXD_MARK, SCIFB1_TXD_MARK,
+};
+static const unsigned int scifb1_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(7, 7),
+};
+static const unsigned int scifb1_clk_mux[] = {
+	SCIFB1_SCK_MARK,
+};
+static const unsigned int scifb1_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(7, 9), RCAR_GP_PIN(7, 8),
+};
+static const unsigned int scifb1_ctrl_mux[] = {
+	SCIFB1_RTS_N_MARK, SCIFB1_CTS_N_MARK,
+};
+static const unsigned int scifb1_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 18),
+};
+static const unsigned int scifb1_data_b_mux[] = {
+	SCIFB1_RXD_B_MARK, SCIFB1_TXD_B_MARK,
+};
+static const unsigned int scifb1_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 3),
+};
+static const unsigned int scifb1_clk_b_mux[] = {
+	SCIFB1_SCK_B_MARK,
+};
+static const unsigned int scifb1_data_c_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 3),
+};
+static const unsigned int scifb1_data_c_mux[] = {
+	SCIFB1_RXD_C_MARK, SCIFB1_TXD_C_MARK,
+};
+static const unsigned int scifb1_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(7, 11),
+};
+static const unsigned int scifb1_clk_c_mux[] = {
+	SCIFB1_SCK_C_MARK,
+};
+static const unsigned int scifb1_data_d_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(7, 10), RCAR_GP_PIN(7, 12),
+};
+static const unsigned int scifb1_data_d_mux[] = {
+	SCIFB1_RXD_D_MARK, SCIFB1_TXD_D_MARK,
+};
+/* - SCIFB2 ----------------------------------------------------------------- */
+static const unsigned int scifb2_data_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(4, 16), RCAR_GP_PIN(4, 17),
+};
+static const unsigned int scifb2_data_mux[] = {
+	SCIFB2_RXD_MARK, SCIFB2_TXD_MARK,
+};
+static const unsigned int scifb2_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(4, 15),
+};
+static const unsigned int scifb2_clk_mux[] = {
+	SCIFB2_SCK_MARK,
+};
+static const unsigned int scifb2_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 13),
+};
+static const unsigned int scifb2_ctrl_mux[] = {
+	SCIFB2_RTS_N_MARK, SCIFB2_CTS_N_MARK,
+};
+static const unsigned int scifb2_data_b_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 13),
+};
+static const unsigned int scifb2_data_b_mux[] = {
+	SCIFB2_RXD_B_MARK, SCIFB2_TXD_B_MARK,
+};
+static const unsigned int scifb2_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 31),
+};
+static const unsigned int scifb2_clk_b_mux[] = {
+	SCIFB2_SCK_B_MARK,
+};
+static const unsigned int scifb2_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 14),
+};
+static const unsigned int scifb2_ctrl_b_mux[] = {
+	SCIFB2_RTS_N_B_MARK, SCIFB2_CTS_N_B_MARK,
+};
+static const unsigned int scifb2_data_c_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(2, 0), RCAR_GP_PIN(2, 1),
+};
+static const unsigned int scifb2_data_c_mux[] = {
+	SCIFB2_RXD_C_MARK, SCIFB2_TXD_C_MARK,
+};
+static const unsigned int scifb2_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 27),
+};
+static const unsigned int scifb2_clk_c_mux[] = {
+	SCIFB2_SCK_C_MARK,
+};
+static const unsigned int scifb2_data_d_pins[] = {
+	/* RXD, TXD */
+	RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 25),
+};
+static const unsigned int scifb2_data_d_mux[] = {
+	SCIFB2_RXD_D_MARK, SCIFB2_TXD_D_MARK,
+};
+/* - SDHI0 ------------------------------------------------------------------ */
+static const unsigned int sdhi0_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 2),
+};
+static const unsigned int sdhi0_data1_mux[] = {
+	SD0_DATA0_MARK,
+};
+static const unsigned int sdhi0_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(6, 2), RCAR_GP_PIN(6, 3),
+	RCAR_GP_PIN(6, 4), RCAR_GP_PIN(6, 5),
+};
+static const unsigned int sdhi0_data4_mux[] = {
+	SD0_DATA0_MARK, SD0_DATA1_MARK, SD0_DATA2_MARK, SD0_DATA3_MARK,
+};
+static const unsigned int sdhi0_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 1),
+};
+static const unsigned int sdhi0_ctrl_mux[] = {
+	SD0_CLK_MARK, SD0_CMD_MARK,
+};
+static const unsigned int sdhi0_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(6, 6),
+};
+static const unsigned int sdhi0_cd_mux[] = {
+	SD0_CD_MARK,
+};
+static const unsigned int sdhi0_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(6, 7),
+};
+static const unsigned int sdhi0_wp_mux[] = {
+	SD0_WP_MARK,
+};
+/* - SDHI1 ------------------------------------------------------------------ */
+static const unsigned int sdhi1_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 10),
+};
+static const unsigned int sdhi1_data1_mux[] = {
+	SD1_DATA0_MARK,
+};
+static const unsigned int sdhi1_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(6, 10), RCAR_GP_PIN(6, 11),
+	RCAR_GP_PIN(6, 12), RCAR_GP_PIN(6, 13),
+};
+static const unsigned int sdhi1_data4_mux[] = {
+	SD1_DATA0_MARK, SD1_DATA1_MARK, SD1_DATA2_MARK, SD1_DATA3_MARK,
+};
+static const unsigned int sdhi1_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(6, 8), RCAR_GP_PIN(6, 9),
+};
+static const unsigned int sdhi1_ctrl_mux[] = {
+	SD1_CLK_MARK, SD1_CMD_MARK,
+};
+static const unsigned int sdhi1_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(6, 14),
+};
+static const unsigned int sdhi1_cd_mux[] = {
+	SD1_CD_MARK,
+};
+static const unsigned int sdhi1_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(6, 15),
+};
+static const unsigned int sdhi1_wp_mux[] = {
+	SD1_WP_MARK,
+};
+/* - SDHI2 ------------------------------------------------------------------ */
+static const unsigned int sdhi2_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 18),
+};
+static const unsigned int sdhi2_data1_mux[] = {
+	SD2_DATA0_MARK,
+};
+static const unsigned int sdhi2_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(6, 18), RCAR_GP_PIN(6, 19),
+	RCAR_GP_PIN(6, 20), RCAR_GP_PIN(6, 21),
+};
+static const unsigned int sdhi2_data4_mux[] = {
+	SD2_DATA0_MARK, SD2_DATA1_MARK, SD2_DATA2_MARK, SD2_DATA3_MARK,
+};
+static const unsigned int sdhi2_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(6, 16), RCAR_GP_PIN(6, 17),
+};
+static const unsigned int sdhi2_ctrl_mux[] = {
+	SD2_CLK_MARK, SD2_CMD_MARK,
+};
+static const unsigned int sdhi2_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(6, 22),
+};
+static const unsigned int sdhi2_cd_mux[] = {
+	SD2_CD_MARK,
+};
+static const unsigned int sdhi2_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(6, 23),
+};
+static const unsigned int sdhi2_wp_mux[] = {
+	SD2_WP_MARK,
+};
+
+/* - SSI -------------------------------------------------------------------- */
+static const unsigned int ssi0_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 2),
+};
+
+static const unsigned int ssi0_data_mux[] = {
+	SSI_SDATA0_MARK,
+};
+
+static const unsigned int ssi0_data_b_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(3, 4),
+};
+
+static const unsigned int ssi0_data_b_mux[] = {
+	SSI_SDATA0_B_MARK,
+};
+
+static const unsigned int ssi0129_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 0), RCAR_GP_PIN(2, 1),
+};
+
+static const unsigned int ssi0129_ctrl_mux[] = {
+	SSI_SCK0129_MARK, SSI_WS0129_MARK,
+};
+
+static const unsigned int ssi0129_ctrl_b_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(3, 2), RCAR_GP_PIN(3, 3),
+};
+
+static const unsigned int ssi0129_ctrl_b_mux[] = {
+	SSI_SCK0129_B_MARK, SSI_WS0129_B_MARK,
+};
+
+static const unsigned int ssi1_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 5),
+};
+
+static const unsigned int ssi1_data_mux[] = {
+	SSI_SDATA1_MARK,
+};
+
+static const unsigned int ssi1_data_b_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(3, 7),
+};
+
+static const unsigned int ssi1_data_b_mux[] = {
+	SSI_SDATA1_B_MARK,
+};
+
+static const unsigned int ssi1_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 3), RCAR_GP_PIN(2, 4),
+};
+
+static const unsigned int ssi1_ctrl_mux[] = {
+	SSI_SCK1_MARK, SSI_WS1_MARK,
+};
+
+static const unsigned int ssi1_ctrl_b_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(3, 5), RCAR_GP_PIN(3, 6),
+};
+
+static const unsigned int ssi1_ctrl_b_mux[] = {
+	SSI_SCK1_B_MARK, SSI_WS1_B_MARK,
+};
+
+static const unsigned int ssi2_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 8),
+};
+
+static const unsigned int ssi2_data_mux[] = {
+	SSI_SDATA2_MARK,
+};
+
+static const unsigned int ssi2_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 6), RCAR_GP_PIN(2, 7),
+};
+
+static const unsigned int ssi2_ctrl_mux[] = {
+	SSI_SCK2_MARK, SSI_WS2_MARK,
+};
+
+static const unsigned int ssi3_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 11),
+};
+
+static const unsigned int ssi3_data_mux[] = {
+	SSI_SDATA3_MARK,
+};
+
+static const unsigned int ssi34_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 9), RCAR_GP_PIN(2, 10),
+};
+
+static const unsigned int ssi34_ctrl_mux[] = {
+	SSI_SCK34_MARK, SSI_WS34_MARK,
+};
+
+static const unsigned int ssi4_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 14),
+};
+
+static const unsigned int ssi4_data_mux[] = {
+	SSI_SDATA4_MARK,
+};
+
+static const unsigned int ssi4_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 13),
+};
+
+static const unsigned int ssi4_ctrl_mux[] = {
+	SSI_SCK4_MARK, SSI_WS4_MARK,
+};
+
+static const unsigned int ssi5_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 17),
+};
+
+static const unsigned int ssi5_data_mux[] = {
+	SSI_SDATA5_MARK,
+};
+
+static const unsigned int ssi5_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 16),
+};
+
+static const unsigned int ssi5_ctrl_mux[] = {
+	SSI_SCK5_MARK, SSI_WS5_MARK,
+};
+
+static const unsigned int ssi6_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 20),
+};
+
+static const unsigned int ssi6_data_mux[] = {
+	SSI_SDATA6_MARK,
+};
+
+static const unsigned int ssi6_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 18), RCAR_GP_PIN(2, 19),
+};
+
+static const unsigned int ssi6_ctrl_mux[] = {
+	SSI_SCK6_MARK, SSI_WS6_MARK,
+};
+
+static const unsigned int ssi7_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 23),
+};
+
+static const unsigned int ssi7_data_mux[] = {
+	SSI_SDATA7_MARK,
+};
+
+static const unsigned int ssi7_data_b_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(3, 12),
+};
+
+static const unsigned int ssi7_data_b_mux[] = {
+	SSI_SDATA7_B_MARK,
+};
+
+static const unsigned int ssi78_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 21), RCAR_GP_PIN(2, 22),
+};
+
+static const unsigned int ssi78_ctrl_mux[] = {
+	SSI_SCK78_MARK, SSI_WS78_MARK,
+};
+
+static const unsigned int ssi78_ctrl_b_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
+};
+
+static const unsigned int ssi78_ctrl_b_mux[] = {
+	SSI_SCK78_B_MARK, SSI_WS78_B_MARK,
+};
+
+static const unsigned int ssi8_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 24),
+};
+
+static const unsigned int ssi8_data_mux[] = {
+	SSI_SDATA8_MARK,
+};
+
+static const unsigned int ssi8_data_b_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(3, 13),
+};
+
+static const unsigned int ssi8_data_b_mux[] = {
+	SSI_SDATA8_B_MARK,
+};
+
+static const unsigned int ssi9_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(2, 27),
+};
+
+static const unsigned int ssi9_data_mux[] = {
+	SSI_SDATA9_MARK,
+};
+
+static const unsigned int ssi9_data_b_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(3, 18),
+};
+
+static const unsigned int ssi9_data_b_mux[] = {
+	SSI_SDATA9_B_MARK,
+};
+
+static const unsigned int ssi9_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(2, 25), RCAR_GP_PIN(2, 26),
+};
+
+static const unsigned int ssi9_ctrl_mux[] = {
+	SSI_SCK9_MARK, SSI_WS9_MARK,
+};
+
+static const unsigned int ssi9_ctrl_b_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
+};
+
+static const unsigned int ssi9_ctrl_b_mux[] = {
+	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
+};
+
+/* - USB0 ------------------------------------------------------------------- */
+static const unsigned int usb0_pins[] = {
+	RCAR_GP_PIN(7, 23), /* PWEN */
+	RCAR_GP_PIN(7, 24), /* OVC */
+};
+static const unsigned int usb0_mux[] = {
+	USB0_PWEN_MARK,
+	USB0_OVC_MARK,
+};
+/* - USB1 ------------------------------------------------------------------- */
+static const unsigned int usb1_pins[] = {
+	RCAR_GP_PIN(7, 25), /* PWEN */
+	RCAR_GP_PIN(6, 30), /* OVC */
+};
+static const unsigned int usb1_mux[] = {
+	USB1_PWEN_MARK,
+	USB1_OVC_MARK,
+};
+
+union vin_data {
+	unsigned int data24[24];
+	unsigned int data20[20];
+	unsigned int data16[16];
+	unsigned int data12[12];
+	unsigned int data10[10];
+	unsigned int data8[8];
+};
+
+#define VIN_DATA_PIN_GROUP(n, s)				\
+	{							\
+		.name = #n#s,					\
+		.pins = n##_pins.data##s,			\
+		.mux = n##_mux.data##s,				\
+		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
+	}
+
+/* - VIN0 ------------------------------------------------------------------- */
+static const union vin_data vin0_data_pins = {
+	.data24 = {
+		/* B */
+		RCAR_GP_PIN(4, 5), RCAR_GP_PIN(4, 6),
+		RCAR_GP_PIN(4, 7), RCAR_GP_PIN(4, 8),
+		RCAR_GP_PIN(4, 9), RCAR_GP_PIN(4, 10),
+		RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
+		/* G */
+		RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 14),
+		RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 16),
+		RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 18),
+		RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 20),
+		/* R */
+		RCAR_GP_PIN(4, 21), RCAR_GP_PIN(4, 22),
+		RCAR_GP_PIN(4, 23), RCAR_GP_PIN(4, 24),
+		RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 26),
+		RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
+	},
+};
+static const union vin_data vin0_data_mux = {
+	.data24 = {
+		/* B */
+		VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK,
+		VI0_DATA2_VI0_B2_MARK, VI0_DATA3_VI0_B3_MARK,
+		VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+		VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
+		/* G */
+		VI0_G0_MARK, VI0_G1_MARK,
+		VI0_G2_MARK, VI0_G3_MARK,
+		VI0_G4_MARK, VI0_G5_MARK,
+		VI0_G6_MARK, VI0_G7_MARK,
+		/* R */
+		VI0_R0_MARK, VI0_R1_MARK,
+		VI0_R2_MARK, VI0_R3_MARK,
+		VI0_R4_MARK, VI0_R5_MARK,
+		VI0_R6_MARK, VI0_R7_MARK,
+	},
+};
+static const unsigned int vin0_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(4, 7), RCAR_GP_PIN(4, 8),
+	RCAR_GP_PIN(4, 9), RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
+	/* G */
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 16),
+	RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 18),
+	RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 20),
+	/* R */
+	RCAR_GP_PIN(4, 23), RCAR_GP_PIN(4, 24),
+	RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 26),
+	RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
+};
+static const unsigned int vin0_data18_mux[] = {
+	/* B */
+	VI0_DATA2_VI0_B2_MARK, VI0_DATA3_VI0_B3_MARK,
+	VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
+	/* G */
+	VI0_G2_MARK, VI0_G3_MARK,
+	VI0_G4_MARK, VI0_G5_MARK,
+	VI0_G6_MARK, VI0_G7_MARK,
+	/* R */
+	VI0_R2_MARK, VI0_R3_MARK,
+	VI0_R4_MARK, VI0_R5_MARK,
+	VI0_R6_MARK, VI0_R7_MARK,
+};
+static const unsigned int vin0_sync_pins[] = {
+	RCAR_GP_PIN(4, 3), /* HSYNC */
+	RCAR_GP_PIN(4, 4), /* VSYNC */
+};
+static const unsigned int vin0_sync_mux[] = {
+	VI0_HSYNC_N_MARK,
+	VI0_VSYNC_N_MARK,
+};
+static const unsigned int vin0_field_pins[] = {
+	RCAR_GP_PIN(4, 2),
+};
+static const unsigned int vin0_field_mux[] = {
+	VI0_FIELD_MARK,
+};
+static const unsigned int vin0_clkenb_pins[] = {
+	RCAR_GP_PIN(4, 1),
+};
+static const unsigned int vin0_clkenb_mux[] = {
+	VI0_CLKENB_MARK,
+};
+static const unsigned int vin0_clk_pins[] = {
+	RCAR_GP_PIN(4, 0),
+};
+static const unsigned int vin0_clk_mux[] = {
+	VI0_CLK_MARK,
+};
+/* - VIN1 ----------------------------------------------------------------- */
+static const unsigned int vin1_data8_pins[] = {
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
+	RCAR_GP_PIN(5, 7), RCAR_GP_PIN(5, 8),
+	RCAR_GP_PIN(5, 9), RCAR_GP_PIN(5, 10),
+	RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 12),
+};
+static const unsigned int vin1_data8_mux[] = {
+	VI1_DATA0_MARK, VI1_DATA1_MARK,
+	VI1_DATA2_MARK, VI1_DATA3_MARK,
+	VI1_DATA4_MARK, VI1_DATA5_MARK,
+	VI1_DATA6_MARK, VI1_DATA7_MARK,
+};
+static const unsigned int vin1_sync_pins[] = {
+	RCAR_GP_PIN(5, 0), /* HSYNC */
+	RCAR_GP_PIN(5, 1), /* VSYNC */
+};
+static const unsigned int vin1_sync_mux[] = {
+	VI1_HSYNC_N_MARK,
+	VI1_VSYNC_N_MARK,
+};
+static const unsigned int vin1_field_pins[] = {
+	RCAR_GP_PIN(5, 3),
+};
+static const unsigned int vin1_field_mux[] = {
+	VI1_FIELD_MARK,
+};
+static const unsigned int vin1_clkenb_pins[] = {
+	RCAR_GP_PIN(5, 2),
+};
+static const unsigned int vin1_clkenb_mux[] = {
+	VI1_CLKENB_MARK,
+};
+static const unsigned int vin1_clk_pins[] = {
+	RCAR_GP_PIN(5, 4),
+};
+static const unsigned int vin1_clk_mux[] = {
+	VI1_CLK_MARK,
+};
+static const union vin_data vin1_b_data_pins = {
+	.data24 = {
+		/* B */
+		RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 1),
+		RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 9),
+		RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
+		RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 13),
+		/* G */
+		RCAR_GP_PIN(6, 24), RCAR_GP_PIN(6, 25),
+		RCAR_GP_PIN(6, 26), RCAR_GP_PIN(6, 27),
+		RCAR_GP_PIN(6, 28), RCAR_GP_PIN(6, 29),
+		RCAR_GP_PIN(7, 21), RCAR_GP_PIN(7, 22),
+		/* R */
+		RCAR_GP_PIN(7, 5), RCAR_GP_PIN(7, 6),
+		RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 16),
+		RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 18),
+		RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 20),
+	},
+};
+static const union vin_data vin1_b_data_mux = {
+	.data24 = {
+		/* B */
+		VI1_DATA0_B_MARK, VI1_DATA1_B_MARK,
+		VI1_DATA2_B_MARK, VI1_DATA3_B_MARK,
+		VI1_DATA4_B_MARK, VI1_DATA5_B_MARK,
+		VI1_DATA6_B_MARK, VI1_DATA7_B_MARK,
+		/* G */
+		VI1_G0_B_MARK, VI1_G1_B_MARK,
+		VI1_G2_B_MARK, VI1_G3_B_MARK,
+		VI1_G4_B_MARK, VI1_G5_B_MARK,
+		VI1_G6_B_MARK, VI1_G7_B_MARK,
+		/* R */
+		VI1_R0_B_MARK, VI1_R1_B_MARK,
+		VI1_R2_B_MARK, VI1_R3_B_MARK,
+		VI1_R4_B_MARK, VI1_R5_B_MARK,
+		VI1_R6_B_MARK, VI1_R7_B_MARK,
+	},
+};
+static const unsigned int vin1_b_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 9),
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 13),
+	/* G */
+	RCAR_GP_PIN(6, 26), RCAR_GP_PIN(6, 27),
+	RCAR_GP_PIN(6, 28), RCAR_GP_PIN(6, 29),
+	RCAR_GP_PIN(7, 21), RCAR_GP_PIN(7, 22),
+	/* R */
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 16),
+	RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 18),
+	RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 20),
+};
+static const unsigned int vin1_b_data18_mux[] = {
+	/* B */
+	VI1_DATA0_B_MARK, VI1_DATA1_B_MARK,
+	VI1_DATA2_B_MARK, VI1_DATA3_B_MARK,
+	VI1_DATA4_B_MARK, VI1_DATA5_B_MARK,
+	VI1_DATA6_B_MARK, VI1_DATA7_B_MARK,
+	/* G */
+	VI1_G0_B_MARK, VI1_G1_B_MARK,
+	VI1_G2_B_MARK, VI1_G3_B_MARK,
+	VI1_G4_B_MARK, VI1_G5_B_MARK,
+	VI1_G6_B_MARK, VI1_G7_B_MARK,
+	/* R */
+	VI1_R0_B_MARK, VI1_R1_B_MARK,
+	VI1_R2_B_MARK, VI1_R3_B_MARK,
+	VI1_R4_B_MARK, VI1_R5_B_MARK,
+	VI1_R6_B_MARK, VI1_R7_B_MARK,
+};
+static const unsigned int vin1_b_sync_pins[] = {
+	RCAR_GP_PIN(3, 17), /* HSYNC */
+	RCAR_GP_PIN(3, 18), /* VSYNC */
+};
+static const unsigned int vin1_b_sync_mux[] = {
+	VI1_HSYNC_N_B_MARK,
+	VI1_VSYNC_N_B_MARK,
+};
+static const unsigned int vin1_b_field_pins[] = {
+	RCAR_GP_PIN(3, 20),
+};
+static const unsigned int vin1_b_field_mux[] = {
+	VI1_FIELD_B_MARK,
+};
+static const unsigned int vin1_b_clkenb_pins[] = {
+	RCAR_GP_PIN(3, 19),
+};
+static const unsigned int vin1_b_clkenb_mux[] = {
+	VI1_CLKENB_B_MARK,
+};
+static const unsigned int vin1_b_clk_pins[] = {
+	RCAR_GP_PIN(3, 16),
+};
+static const unsigned int vin1_b_clk_mux[] = {
+	VI1_CLK_B_MARK,
+};
+/* - VIN2 ----------------------------------------------------------------- */
+static const unsigned int vin2_data8_pins[] = {
+	RCAR_GP_PIN(4, 20), RCAR_GP_PIN(4, 21),
+	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 23),
+	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 25),
+	RCAR_GP_PIN(4, 26), RCAR_GP_PIN(4, 27),
+};
+static const unsigned int vin2_data8_mux[] = {
+	VI2_DATA0_MARK, VI2_DATA1_MARK,
+	VI2_DATA2_MARK, VI2_DATA3_MARK,
+	VI2_DATA4_MARK, VI2_DATA5_MARK,
+	VI2_DATA6_MARK, VI2_DATA7_MARK,
+};
+static const unsigned int vin2_sync_pins[] = {
+	RCAR_GP_PIN(4, 15), /* HSYNC */
+	RCAR_GP_PIN(4, 16), /* VSYNC */
+};
+static const unsigned int vin2_sync_mux[] = {
+	VI2_HSYNC_N_MARK,
+	VI2_VSYNC_N_MARK,
+};
+static const unsigned int vin2_field_pins[] = {
+	RCAR_GP_PIN(4, 18),
+};
+static const unsigned int vin2_field_mux[] = {
+	VI2_FIELD_MARK,
+};
+static const unsigned int vin2_clkenb_pins[] = {
+	RCAR_GP_PIN(4, 17),
+};
+static const unsigned int vin2_clkenb_mux[] = {
+	VI2_CLKENB_MARK,
+};
+static const unsigned int vin2_clk_pins[] = {
+	RCAR_GP_PIN(4, 19),
+};
+static const unsigned int vin2_clk_mux[] = {
+	VI2_CLK_MARK,
+};
+/* - SSP ------------------------------------------------------------------- */
+static const unsigned int ssp_pins[] = {
+	RCAR_GP_PIN(5, 25),
+	RCAR_GP_PIN(5, 26),
+	RCAR_GP_PIN(5, 27),
+	RCAR_GP_PIN(5, 28),
+	RCAR_GP_PIN(5, 29),
+};
+
+static const unsigned int ssp_mux[] = {
+	STP_IVCXO27_0_MARK,
+	STP_ISCLK_0_MARK,
+	STP_ISD_0_MARK,
+	STP_ISEN_0_MARK,
+	STP_ISSYNC_0_MARK,
+};
+
+static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(audio_clk_a),
+	SH_PFC_PIN_GROUP(audio_clk_b),
+	SH_PFC_PIN_GROUP(audio_clk_b_b),
+	SH_PFC_PIN_GROUP(audio_clk_c),
+	SH_PFC_PIN_GROUP(audio_clkout),
+	SH_PFC_PIN_GROUP(du_rgb666),
+	SH_PFC_PIN_GROUP(du_rgb888),
+	SH_PFC_PIN_GROUP(du_clk_out_0),
+	SH_PFC_PIN_GROUP(du_clk_out_1),
+	SH_PFC_PIN_GROUP(du_sync),
+	SH_PFC_PIN_GROUP(du_oddf),
+	SH_PFC_PIN_GROUP(du_cde),
+	SH_PFC_PIN_GROUP(du_disp),
+	SH_PFC_PIN_GROUP(du0_clk_in),
+	SH_PFC_PIN_GROUP(du1_clk_in),
+	SH_PFC_PIN_GROUP(du1_clk_in_b),
+	SH_PFC_PIN_GROUP(du1_clk_in_c),
+	SH_PFC_PIN_GROUP(eth_link),
+	SH_PFC_PIN_GROUP(eth_magic),
+	SH_PFC_PIN_GROUP(eth_mdio),
+	SH_PFC_PIN_GROUP(eth_rmii),
+	SH_PFC_PIN_GROUP(hscif0_data),
+	SH_PFC_PIN_GROUP(hscif0_clk),
+	SH_PFC_PIN_GROUP(hscif0_ctrl),
+	SH_PFC_PIN_GROUP(hscif0_data_b),
+	SH_PFC_PIN_GROUP(hscif0_ctrl_b),
+	SH_PFC_PIN_GROUP(hscif0_data_c),
+	SH_PFC_PIN_GROUP(hscif0_clk_c),
+	SH_PFC_PIN_GROUP(hscif1_data),
+	SH_PFC_PIN_GROUP(hscif1_clk),
+	SH_PFC_PIN_GROUP(hscif1_ctrl),
+	SH_PFC_PIN_GROUP(hscif1_data_b),
+	SH_PFC_PIN_GROUP(hscif1_data_c),
+	SH_PFC_PIN_GROUP(hscif1_clk_c),
+	SH_PFC_PIN_GROUP(hscif1_ctrl_c),
+	SH_PFC_PIN_GROUP(hscif1_data_d),
+	SH_PFC_PIN_GROUP(hscif1_data_e),
+	SH_PFC_PIN_GROUP(hscif1_clk_e),
+	SH_PFC_PIN_GROUP(hscif1_ctrl_e),
+	SH_PFC_PIN_GROUP(hscif2_data),
+	SH_PFC_PIN_GROUP(hscif2_clk),
+	SH_PFC_PIN_GROUP(hscif2_ctrl),
+	SH_PFC_PIN_GROUP(hscif2_data_b),
+	SH_PFC_PIN_GROUP(hscif2_ctrl_b),
+	SH_PFC_PIN_GROUP(hscif2_data_c),
+	SH_PFC_PIN_GROUP(hscif2_clk_c),
+	SH_PFC_PIN_GROUP(i2c0),
+	SH_PFC_PIN_GROUP(i2c0_b),
+	SH_PFC_PIN_GROUP(i2c0_c),
+	SH_PFC_PIN_GROUP(i2c1),
+	SH_PFC_PIN_GROUP(i2c1_b),
+	SH_PFC_PIN_GROUP(i2c1_c),
+	SH_PFC_PIN_GROUP(i2c1_d),
+	SH_PFC_PIN_GROUP(i2c1_e),
+	SH_PFC_PIN_GROUP(i2c2),
+	SH_PFC_PIN_GROUP(i2c2_b),
+	SH_PFC_PIN_GROUP(i2c2_c),
+	SH_PFC_PIN_GROUP(i2c2_d),
+	SH_PFC_PIN_GROUP(i2c3),
+	SH_PFC_PIN_GROUP(i2c3_b),
+	SH_PFC_PIN_GROUP(i2c3_c),
+	SH_PFC_PIN_GROUP(i2c3_d),
+	SH_PFC_PIN_GROUP(i2c4),
+	SH_PFC_PIN_GROUP(i2c4_b),
+	SH_PFC_PIN_GROUP(i2c4_c),
+	SH_PFC_PIN_GROUP(i2c7),
+	SH_PFC_PIN_GROUP(i2c7_b),
+	SH_PFC_PIN_GROUP(i2c7_c),
+	SH_PFC_PIN_GROUP(i2c8),
+	SH_PFC_PIN_GROUP(i2c8_b),
+	SH_PFC_PIN_GROUP(i2c8_c),
+	SH_PFC_PIN_GROUP(intc_irq0),
+	SH_PFC_PIN_GROUP(intc_irq1),
+	SH_PFC_PIN_GROUP(intc_irq2),
+	SH_PFC_PIN_GROUP(intc_irq3),
+	SH_PFC_PIN_GROUP(mmc_data1),
+	SH_PFC_PIN_GROUP(mmc_data4),
+	SH_PFC_PIN_GROUP(mmc_data8),
+	SH_PFC_PIN_GROUP(mmc_ctrl),
+	SH_PFC_PIN_GROUP(msiof0_clk),
+	SH_PFC_PIN_GROUP(msiof0_sync),
+	SH_PFC_PIN_GROUP(msiof0_ss1),
+	SH_PFC_PIN_GROUP(msiof0_ss2),
+	SH_PFC_PIN_GROUP(msiof0_rx),
+	SH_PFC_PIN_GROUP(msiof0_tx),
+	SH_PFC_PIN_GROUP(msiof0_clk_b),
+	SH_PFC_PIN_GROUP(msiof0_sync_b),
+	SH_PFC_PIN_GROUP(msiof0_ss1_b),
+	SH_PFC_PIN_GROUP(msiof0_ss2_b),
+	SH_PFC_PIN_GROUP(msiof0_rx_b),
+	SH_PFC_PIN_GROUP(msiof0_tx_b),
+	SH_PFC_PIN_GROUP(msiof0_clk_c),
+	SH_PFC_PIN_GROUP(msiof0_sync_c),
+	SH_PFC_PIN_GROUP(msiof0_ss1_c),
+	SH_PFC_PIN_GROUP(msiof0_ss2_c),
+	SH_PFC_PIN_GROUP(msiof0_rx_c),
+	SH_PFC_PIN_GROUP(msiof0_tx_c),
+	SH_PFC_PIN_GROUP(msiof1_clk),
+	SH_PFC_PIN_GROUP(msiof1_sync),
+	SH_PFC_PIN_GROUP(msiof1_ss1),
+	SH_PFC_PIN_GROUP(msiof1_ss2),
+	SH_PFC_PIN_GROUP(msiof1_rx),
+	SH_PFC_PIN_GROUP(msiof1_tx),
+	SH_PFC_PIN_GROUP(msiof1_clk_b),
+	SH_PFC_PIN_GROUP(msiof1_sync_b),
+	SH_PFC_PIN_GROUP(msiof1_ss1_b),
+	SH_PFC_PIN_GROUP(msiof1_ss2_b),
+	SH_PFC_PIN_GROUP(msiof1_rx_b),
+	SH_PFC_PIN_GROUP(msiof1_tx_b),
+	SH_PFC_PIN_GROUP(msiof1_clk_c),
+	SH_PFC_PIN_GROUP(msiof1_sync_c),
+	SH_PFC_PIN_GROUP(msiof1_rx_c),
+	SH_PFC_PIN_GROUP(msiof1_tx_c),
+	SH_PFC_PIN_GROUP(msiof1_clk_d),
+	SH_PFC_PIN_GROUP(msiof1_sync_d),
+	SH_PFC_PIN_GROUP(msiof1_ss1_d),
+	SH_PFC_PIN_GROUP(msiof1_rx_d),
+	SH_PFC_PIN_GROUP(msiof1_tx_d),
+	SH_PFC_PIN_GROUP(msiof1_clk_e),
+	SH_PFC_PIN_GROUP(msiof1_sync_e),
+	SH_PFC_PIN_GROUP(msiof1_rx_e),
+	SH_PFC_PIN_GROUP(msiof1_tx_e),
+	SH_PFC_PIN_GROUP(msiof2_clk),
+	SH_PFC_PIN_GROUP(msiof2_sync),
+	SH_PFC_PIN_GROUP(msiof2_ss1),
+	SH_PFC_PIN_GROUP(msiof2_ss2),
+	SH_PFC_PIN_GROUP(msiof2_rx),
+	SH_PFC_PIN_GROUP(msiof2_tx),
+	SH_PFC_PIN_GROUP(msiof2_clk_b),
+	SH_PFC_PIN_GROUP(msiof2_sync_b),
+	SH_PFC_PIN_GROUP(msiof2_ss1_b),
+	SH_PFC_PIN_GROUP(msiof2_ss2_b),
+	SH_PFC_PIN_GROUP(msiof2_rx_b),
+	SH_PFC_PIN_GROUP(msiof2_tx_b),
+	SH_PFC_PIN_GROUP(msiof2_clk_c),
+	SH_PFC_PIN_GROUP(msiof2_sync_c),
+	SH_PFC_PIN_GROUP(msiof2_rx_c),
+	SH_PFC_PIN_GROUP(msiof2_tx_c),
+	SH_PFC_PIN_GROUP(msiof2_clk_d),
+	SH_PFC_PIN_GROUP(msiof2_sync_d),
+	SH_PFC_PIN_GROUP(msiof2_ss1_d),
+	SH_PFC_PIN_GROUP(msiof2_ss2_d),
+	SH_PFC_PIN_GROUP(msiof2_rx_d),
+	SH_PFC_PIN_GROUP(msiof2_tx_d),
+	SH_PFC_PIN_GROUP(msiof2_clk_e),
+	SH_PFC_PIN_GROUP(msiof2_sync_e),
+	SH_PFC_PIN_GROUP(msiof2_rx_e),
+	SH_PFC_PIN_GROUP(msiof2_tx_e),
+	SH_PFC_PIN_GROUP(qspi_ctrl),
+	SH_PFC_PIN_GROUP(qspi_data2),
+	SH_PFC_PIN_GROUP(qspi_data4),
+	SH_PFC_PIN_GROUP(qspi_ctrl_b),
+	SH_PFC_PIN_GROUP(qspi_data2_b),
+	SH_PFC_PIN_GROUP(qspi_data4_b),
+	SH_PFC_PIN_GROUP(scif0_data),
+	SH_PFC_PIN_GROUP(scif0_data_b),
+	SH_PFC_PIN_GROUP(scif0_data_c),
+	SH_PFC_PIN_GROUP(scif0_data_d),
+	SH_PFC_PIN_GROUP(scif0_data_e),
+	SH_PFC_PIN_GROUP(scif1_data),
+	SH_PFC_PIN_GROUP(scif1_data_b),
+	SH_PFC_PIN_GROUP(scif1_clk_b),
+	SH_PFC_PIN_GROUP(scif1_data_c),
+	SH_PFC_PIN_GROUP(scif1_data_d),
+	SH_PFC_PIN_GROUP(scif2_data),
+	SH_PFC_PIN_GROUP(scif2_data_b),
+	SH_PFC_PIN_GROUP(scif2_clk_b),
+	SH_PFC_PIN_GROUP(scif2_data_c),
+	SH_PFC_PIN_GROUP(scif2_data_e),
+	SH_PFC_PIN_GROUP(scif3_data),
+	SH_PFC_PIN_GROUP(scif3_clk),
+	SH_PFC_PIN_GROUP(scif3_data_b),
+	SH_PFC_PIN_GROUP(scif3_clk_b),
+	SH_PFC_PIN_GROUP(scif3_data_c),
+	SH_PFC_PIN_GROUP(scif3_data_d),
+	SH_PFC_PIN_GROUP(scif4_data),
+	SH_PFC_PIN_GROUP(scif4_data_b),
+	SH_PFC_PIN_GROUP(scif4_data_c),
+	SH_PFC_PIN_GROUP(scif5_data),
+	SH_PFC_PIN_GROUP(scif5_data_b),
+	SH_PFC_PIN_GROUP(scifa0_data),
+	SH_PFC_PIN_GROUP(scifa0_data_b),
+	SH_PFC_PIN_GROUP(scifa1_data),
+	SH_PFC_PIN_GROUP(scifa1_clk),
+	SH_PFC_PIN_GROUP(scifa1_data_b),
+	SH_PFC_PIN_GROUP(scifa1_clk_b),
+	SH_PFC_PIN_GROUP(scifa1_data_c),
+	SH_PFC_PIN_GROUP(scifa2_data),
+	SH_PFC_PIN_GROUP(scifa2_clk),
+	SH_PFC_PIN_GROUP(scifa2_data_b),
+	SH_PFC_PIN_GROUP(scifa3_data),
+	SH_PFC_PIN_GROUP(scifa3_clk),
+	SH_PFC_PIN_GROUP(scifa3_data_b),
+	SH_PFC_PIN_GROUP(scifa3_clk_b),
+	SH_PFC_PIN_GROUP(scifa3_data_c),
+	SH_PFC_PIN_GROUP(scifa3_clk_c),
+	SH_PFC_PIN_GROUP(scifa4_data),
+	SH_PFC_PIN_GROUP(scifa4_data_b),
+	SH_PFC_PIN_GROUP(scifa4_data_c),
+	SH_PFC_PIN_GROUP(scifa5_data),
+	SH_PFC_PIN_GROUP(scifa5_data_b),
+	SH_PFC_PIN_GROUP(scifa5_data_c),
+	SH_PFC_PIN_GROUP(scifb0_data),
+	SH_PFC_PIN_GROUP(scifb0_clk),
+	SH_PFC_PIN_GROUP(scifb0_ctrl),
+	SH_PFC_PIN_GROUP(scifb0_data_b),
+	SH_PFC_PIN_GROUP(scifb0_clk_b),
+	SH_PFC_PIN_GROUP(scifb0_ctrl_b),
+	SH_PFC_PIN_GROUP(scifb0_data_c),
+	SH_PFC_PIN_GROUP(scifb0_clk_c),
+	SH_PFC_PIN_GROUP(scifb0_data_d),
+	SH_PFC_PIN_GROUP(scifb0_clk_d),
+	SH_PFC_PIN_GROUP(scifb1_data),
+	SH_PFC_PIN_GROUP(scifb1_clk),
+	SH_PFC_PIN_GROUP(scifb1_ctrl),
+	SH_PFC_PIN_GROUP(scifb1_data_b),
+	SH_PFC_PIN_GROUP(scifb1_clk_b),
+	SH_PFC_PIN_GROUP(scifb1_data_c),
+	SH_PFC_PIN_GROUP(scifb1_clk_c),
+	SH_PFC_PIN_GROUP(scifb1_data_d),
+	SH_PFC_PIN_GROUP(scifb2_data),
+	SH_PFC_PIN_GROUP(scifb2_clk),
+	SH_PFC_PIN_GROUP(scifb2_ctrl),
+	SH_PFC_PIN_GROUP(scifb2_data_b),
+	SH_PFC_PIN_GROUP(scifb2_clk_b),
+	SH_PFC_PIN_GROUP(scifb2_ctrl_b),
+	SH_PFC_PIN_GROUP(scifb2_data_c),
+	SH_PFC_PIN_GROUP(scifb2_clk_c),
+	SH_PFC_PIN_GROUP(scifb2_data_d),
+	SH_PFC_PIN_GROUP(sdhi0_data1),
+	SH_PFC_PIN_GROUP(sdhi0_data4),
+	SH_PFC_PIN_GROUP(sdhi0_ctrl),
+	SH_PFC_PIN_GROUP(sdhi0_cd),
+	SH_PFC_PIN_GROUP(sdhi0_wp),
+	SH_PFC_PIN_GROUP(sdhi1_data1),
+	SH_PFC_PIN_GROUP(sdhi1_data4),
+	SH_PFC_PIN_GROUP(sdhi1_ctrl),
+	SH_PFC_PIN_GROUP(sdhi1_cd),
+	SH_PFC_PIN_GROUP(sdhi1_wp),
+	SH_PFC_PIN_GROUP(sdhi2_data1),
+	SH_PFC_PIN_GROUP(sdhi2_data4),
+	SH_PFC_PIN_GROUP(sdhi2_ctrl),
+	SH_PFC_PIN_GROUP(sdhi2_cd),
+	SH_PFC_PIN_GROUP(sdhi2_wp),
+	SH_PFC_PIN_GROUP(ssi0_data),
+	SH_PFC_PIN_GROUP(ssi0_data_b),
+	SH_PFC_PIN_GROUP(ssi0129_ctrl),
+	SH_PFC_PIN_GROUP(ssi0129_ctrl_b),
+	SH_PFC_PIN_GROUP(ssi1_data),
+	SH_PFC_PIN_GROUP(ssi1_data_b),
+	SH_PFC_PIN_GROUP(ssi1_ctrl),
+	SH_PFC_PIN_GROUP(ssi1_ctrl_b),
+	SH_PFC_PIN_GROUP(ssi2_data),
+	SH_PFC_PIN_GROUP(ssi2_ctrl),
+	SH_PFC_PIN_GROUP(ssi3_data),
+	SH_PFC_PIN_GROUP(ssi34_ctrl),
+	SH_PFC_PIN_GROUP(ssi4_data),
+	SH_PFC_PIN_GROUP(ssi4_ctrl),
+	SH_PFC_PIN_GROUP(ssi5_data),
+	SH_PFC_PIN_GROUP(ssi5_ctrl),
+	SH_PFC_PIN_GROUP(ssi6_data),
+	SH_PFC_PIN_GROUP(ssi6_ctrl),
+	SH_PFC_PIN_GROUP(ssi7_data),
+	SH_PFC_PIN_GROUP(ssi7_data_b),
+	SH_PFC_PIN_GROUP(ssi78_ctrl),
+	SH_PFC_PIN_GROUP(ssi78_ctrl_b),
+	SH_PFC_PIN_GROUP(ssi8_data),
+	SH_PFC_PIN_GROUP(ssi8_data_b),
+	SH_PFC_PIN_GROUP(ssi9_data),
+	SH_PFC_PIN_GROUP(ssi9_data_b),
+	SH_PFC_PIN_GROUP(ssi9_ctrl),
+	SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb1),
+	SH_PFC_PIN_GROUP(ssp),
+	VIN_DATA_PIN_GROUP(vin0_data, 24),
+	VIN_DATA_PIN_GROUP(vin0_data, 20),
+	SH_PFC_PIN_GROUP(vin0_data18),
+	VIN_DATA_PIN_GROUP(vin0_data, 16),
+	VIN_DATA_PIN_GROUP(vin0_data, 12),
+	VIN_DATA_PIN_GROUP(vin0_data, 10),
+	VIN_DATA_PIN_GROUP(vin0_data, 8),
+	SH_PFC_PIN_GROUP(vin0_sync),
+	SH_PFC_PIN_GROUP(vin0_field),
+	SH_PFC_PIN_GROUP(vin0_clkenb),
+	SH_PFC_PIN_GROUP(vin0_clk),
+	SH_PFC_PIN_GROUP(vin1_data8),
+	SH_PFC_PIN_GROUP(vin1_sync),
+	SH_PFC_PIN_GROUP(vin1_field),
+	SH_PFC_PIN_GROUP(vin1_clkenb),
+	SH_PFC_PIN_GROUP(vin1_clk),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 24),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 20),
+	SH_PFC_PIN_GROUP(vin1_b_data18),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 16),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 12),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 10),
+	VIN_DATA_PIN_GROUP(vin1_b_data, 8),
+	SH_PFC_PIN_GROUP(vin1_b_sync),
+	SH_PFC_PIN_GROUP(vin1_b_field),
+	SH_PFC_PIN_GROUP(vin1_b_clkenb),
+	SH_PFC_PIN_GROUP(vin1_b_clk),
+	SH_PFC_PIN_GROUP(vin2_data8),
+	SH_PFC_PIN_GROUP(vin2_sync),
+	SH_PFC_PIN_GROUP(vin2_field),
+	SH_PFC_PIN_GROUP(vin2_clkenb),
+	SH_PFC_PIN_GROUP(vin2_clk),
+};
+
+static const char * const audio_clk_groups[] = {
+	"audio_clk_a",
+	"audio_clk_b",
+	"audio_clk_b_b",
+	"audio_clk_c",
+	"audio_clkout",
+};
+
+static const char * const du_groups[] = {
+	"du_rgb666",
+	"du_rgb888",
+	"du_clk_out_0",
+	"du_clk_out_1",
+	"du_sync",
+	"du_oddf",
+	"du_cde",
+	"du_disp",
+};
+
+static const char * const du0_groups[] = {
+	"du0_clk_in",
+};
+
+static const char * const du1_groups[] = {
+	"du1_clk_in",
+	"du1_clk_in_b",
+	"du1_clk_in_c",
+};
+
+static const char * const eth_groups[] = {
+	"eth_link",
+	"eth_magic",
+	"eth_mdio",
+	"eth_rmii",
+};
+
+static const char * const hscif0_groups[] = {
+	"hscif0_data",
+	"hscif0_clk",
+	"hscif0_ctrl",
+	"hscif0_data_b",
+	"hscif0_ctrl_b",
+	"hscif0_data_c",
+	"hscif0_clk_c",
+};
+
+static const char * const hscif1_groups[] = {
+	"hscif1_data",
+	"hscif1_clk",
+	"hscif1_ctrl",
+	"hscif1_data_b",
+	"hscif1_data_c",
+	"hscif1_clk_c",
+	"hscif1_ctrl_c",
+	"hscif1_data_d",
+	"hscif1_data_e",
+	"hscif1_clk_e",
+	"hscif1_ctrl_e",
+};
+
+static const char * const hscif2_groups[] = {
+	"hscif2_data",
+	"hscif2_clk",
+	"hscif2_ctrl",
+	"hscif2_data_b",
+	"hscif2_ctrl_b",
+	"hscif2_data_c",
+	"hscif2_clk_c",
+};
+
+static const char * const i2c0_groups[] = {
+	"i2c0",
+	"i2c0_b",
+	"i2c0_c",
+};
+
+static const char * const i2c1_groups[] = {
+	"i2c1",
+	"i2c1_b",
+	"i2c1_c",
+	"i2c1_d",
+	"i2c1_e",
+};
+
+static const char * const i2c2_groups[] = {
+	"i2c2",
+	"i2c2_b",
+	"i2c2_c",
+	"i2c2_d",
+};
+
+static const char * const i2c3_groups[] = {
+	"i2c3",
+	"i2c3_b",
+	"i2c3_c",
+	"i2c3_d",
+};
+
+static const char * const i2c4_groups[] = {
+	"i2c4",
+	"i2c4_b",
+	"i2c4_c",
+};
+
+static const char * const i2c7_groups[] = {
+	"i2c7",
+	"i2c7_b",
+	"i2c7_c",
+};
+
+static const char * const i2c8_groups[] = {
+	"i2c8",
+	"i2c8_b",
+	"i2c8_c",
+};
+
+static const char * const intc_groups[] = {
+	"intc_irq0",
+	"intc_irq1",
+	"intc_irq2",
+	"intc_irq3",
+};
+
+static const char * const mmc_groups[] = {
+	"mmc_data1",
+	"mmc_data4",
+	"mmc_data8",
+	"mmc_ctrl",
+};
+
+static const char * const msiof0_groups[] = {
+	"msiof0_clk",
+	"msiof0_sync",
+	"msiof0_ss1",
+	"msiof0_ss2",
+	"msiof0_rx",
+	"msiof0_tx",
+	"msiof0_clk_b",
+	"msiof0_sync_b",
+	"msiof0_ss1_b",
+	"msiof0_ss2_b",
+	"msiof0_rx_b",
+	"msiof0_tx_b",
+	"msiof0_clk_c",
+	"msiof0_sync_c",
+	"msiof0_ss1_c",
+	"msiof0_ss2_c",
+	"msiof0_rx_c",
+	"msiof0_tx_c",
+};
+
+static const char * const msiof1_groups[] = {
+	"msiof1_clk",
+	"msiof1_sync",
+	"msiof1_ss1",
+	"msiof1_ss2",
+	"msiof1_rx",
+	"msiof1_tx",
+	"msiof1_clk_b",
+	"msiof1_sync_b",
+	"msiof1_ss1_b",
+	"msiof1_ss2_b",
+	"msiof1_rx_b",
+	"msiof1_tx_b",
+	"msiof1_clk_c",
+	"msiof1_sync_c",
+	"msiof1_rx_c",
+	"msiof1_tx_c",
+	"msiof1_clk_d",
+	"msiof1_sync_d",
+	"msiof1_ss1_d",
+	"msiof1_rx_d",
+	"msiof1_tx_d",
+	"msiof1_clk_e",
+	"msiof1_sync_e",
+	"msiof1_rx_e",
+	"msiof1_tx_e",
+};
+
+static const char * const msiof2_groups[] = {
+	"msiof2_clk",
+	"msiof2_sync",
+	"msiof2_ss1",
+	"msiof2_ss2",
+	"msiof2_rx",
+	"msiof2_tx",
+	"msiof2_clk_b",
+	"msiof2_sync_b",
+	"msiof2_ss1_b",
+	"msiof2_ss2_b",
+	"msiof2_rx_b",
+	"msiof2_tx_b",
+	"msiof2_clk_c",
+	"msiof2_sync_c",
+	"msiof2_rx_c",
+	"msiof2_tx_c",
+	"msiof2_clk_d",
+	"msiof2_sync_d",
+	"msiof2_ss1_d",
+	"msiof2_ss2_d",
+	"msiof2_rx_d",
+	"msiof2_tx_d",
+	"msiof2_clk_e",
+	"msiof2_sync_e",
+	"msiof2_rx_e",
+	"msiof2_tx_e",
+};
+
+static const char * const qspi_groups[] = {
+	"qspi_ctrl",
+	"qspi_data2",
+	"qspi_data4",
+	"qspi_ctrl_b",
+	"qspi_data2_b",
+	"qspi_data4_b",
+};
+
+static const char * const scif0_groups[] = {
+	"scif0_data",
+	"scif0_data_b",
+	"scif0_data_c",
+	"scif0_data_d",
+	"scif0_data_e",
+};
+
+static const char * const scif1_groups[] = {
+	"scif1_data",
+	"scif1_data_b",
+	"scif1_clk_b",
+	"scif1_data_c",
+	"scif1_data_d",
+};
+
+static const char * const scif2_groups[] = {
+	"scif2_data",
+	"scif2_data_b",
+	"scif2_clk_b",
+	"scif2_data_c",
+	"scif2_data_e",
+};
+static const char * const scif3_groups[] = {
+	"scif3_data",
+	"scif3_clk",
+	"scif3_data_b",
+	"scif3_clk_b",
+	"scif3_data_c",
+	"scif3_data_d",
+};
+static const char * const scif4_groups[] = {
+	"scif4_data",
+	"scif4_data_b",
+	"scif4_data_c",
+};
+static const char * const scif5_groups[] = {
+	"scif5_data",
+	"scif5_data_b",
+};
+static const char * const scifa0_groups[] = {
+	"scifa0_data",
+	"scifa0_data_b",
+};
+static const char * const scifa1_groups[] = {
+	"scifa1_data",
+	"scifa1_clk",
+	"scifa1_data_b",
+	"scifa1_clk_b",
+	"scifa1_data_c",
+};
+static const char * const scifa2_groups[] = {
+	"scifa2_data",
+	"scifa2_clk",
+	"scifa2_data_b",
+};
+static const char * const scifa3_groups[] = {
+	"scifa3_data",
+	"scifa3_clk",
+	"scifa3_data_b",
+	"scifa3_clk_b",
+	"scifa3_data_c",
+	"scifa3_clk_c",
+};
+static const char * const scifa4_groups[] = {
+	"scifa4_data",
+	"scifa4_data_b",
+	"scifa4_data_c",
+};
+static const char * const scifa5_groups[] = {
+	"scifa5_data",
+	"scifa5_data_b",
+	"scifa5_data_c",
+};
+static const char * const scifb0_groups[] = {
+	"scifb0_data",
+	"scifb0_clk",
+	"scifb0_ctrl",
+	"scifb0_data_b",
+	"scifb0_clk_b",
+	"scifb0_ctrl_b",
+	"scifb0_data_c",
+	"scifb0_clk_c",
+	"scifb0_data_d",
+	"scifb0_clk_d",
+};
+static const char * const scifb1_groups[] = {
+	"scifb1_data",
+	"scifb1_clk",
+	"scifb1_ctrl",
+	"scifb1_data_b",
+	"scifb1_clk_b",
+	"scifb1_data_c",
+	"scifb1_clk_c",
+	"scifb1_data_d",
+};
+static const char * const scifb2_groups[] = {
+	"scifb2_data",
+	"scifb2_clk",
+	"scifb2_ctrl",
+	"scifb2_data_b",
+	"scifb2_clk_b",
+	"scifb2_ctrl_b",
+	"scifb0_data_c",
+	"scifb2_clk_c",
+	"scifb2_data_d",
+};
+
+static const char * const sdhi0_groups[] = {
+	"sdhi0_data1",
+	"sdhi0_data4",
+	"sdhi0_ctrl",
+	"sdhi0_cd",
+	"sdhi0_wp",
+};
+
+static const char * const sdhi1_groups[] = {
+	"sdhi1_data1",
+	"sdhi1_data4",
+	"sdhi1_ctrl",
+	"sdhi1_cd",
+	"sdhi1_wp",
+};
+
+static const char * const sdhi2_groups[] = {
+	"sdhi2_data1",
+	"sdhi2_data4",
+	"sdhi2_ctrl",
+	"sdhi2_cd",
+	"sdhi2_wp",
+};
+
+static const char * const ssi_groups[] = {
+	"ssi0_data",
+	"ssi0_data_b",
+	"ssi0129_ctrl",
+	"ssi0129_ctrl_b",
+	"ssi1_data",
+	"ssi1_data_b",
+	"ssi1_ctrl",
+	"ssi1_ctrl_b",
+	"ssi2_data",
+	"ssi2_ctrl",
+	"ssi3_data",
+	"ssi34_ctrl",
+	"ssi4_data",
+	"ssi4_ctrl",
+	"ssi5_data",
+	"ssi5_ctrl",
+	"ssi6_data",
+	"ssi6_ctrl",
+	"ssi7_data",
+	"ssi7_data_b",
+	"ssi78_ctrl",
+	"ssi78_ctrl_b",
+	"ssi8_data",
+	"ssi8_data_b",
+	"ssi9_data",
+	"ssi9_data_b",
+	"ssi9_ctrl",
+	"ssi9_ctrl_b",
+};
+
+static const char * const usb0_groups[] = {
+	"usb0",
+};
+static const char * const usb1_groups[] = {
+	"usb1",
+};
+
+static const char * const ssp_groups[] = {
+	"ssp",
+};
+
+static const char * const vin0_groups[] = {
+	"vin0_data24",
+	"vin0_data20",
+	"vin0_data18",
+	"vin0_data16",
+	"vin0_data12",
+	"vin0_data10",
+	"vin0_data8",
+	"vin0_sync",
+	"vin0_field",
+	"vin0_clkenb",
+	"vin0_clk",
+};
+
+static const char * const vin1_groups[] = {
+	"vin1_data8",
+	"vin1_sync",
+	"vin1_field",
+	"vin1_clkenb",
+	"vin1_clk",
+	"vin1_b_data24",
+	"vin1_b_data20",
+	"vin1_b_data18",
+	"vin1_b_data16",
+	"vin1_b_data12",
+	"vin1_b_data10",
+	"vin1_b_data8",
+	"vin1_b_sync",
+	"vin1_b_field",
+	"vin1_b_clkenb",
+	"vin1_b_clk",
+};
+
+static const char * const vin2_groups[] = {
+	"vin2_data8",
+	"vin2_sync",
+	"vin2_field",
+	"vin2_clkenb",
+	"vin2_clk",
+};
+
+static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(audio_clk),
+	SH_PFC_FUNCTION(du),
+	SH_PFC_FUNCTION(du0),
+	SH_PFC_FUNCTION(du1),
+	SH_PFC_FUNCTION(eth),
+	SH_PFC_FUNCTION(hscif0),
+	SH_PFC_FUNCTION(hscif1),
+	SH_PFC_FUNCTION(hscif2),
+	SH_PFC_FUNCTION(i2c0),
+	SH_PFC_FUNCTION(i2c1),
+	SH_PFC_FUNCTION(i2c2),
+	SH_PFC_FUNCTION(i2c3),
+	SH_PFC_FUNCTION(i2c4),
+	SH_PFC_FUNCTION(i2c7),
+	SH_PFC_FUNCTION(i2c8),
+	SH_PFC_FUNCTION(intc),
+	SH_PFC_FUNCTION(mmc),
+	SH_PFC_FUNCTION(msiof0),
+	SH_PFC_FUNCTION(msiof1),
+	SH_PFC_FUNCTION(msiof2),
+	SH_PFC_FUNCTION(qspi),
+	SH_PFC_FUNCTION(scif0),
+	SH_PFC_FUNCTION(scif1),
+	SH_PFC_FUNCTION(scif2),
+	SH_PFC_FUNCTION(scif3),
+	SH_PFC_FUNCTION(scif4),
+	SH_PFC_FUNCTION(scif5),
+	SH_PFC_FUNCTION(scifa0),
+	SH_PFC_FUNCTION(scifa1),
+	SH_PFC_FUNCTION(scifa2),
+	SH_PFC_FUNCTION(scifa3),
+	SH_PFC_FUNCTION(scifa4),
+	SH_PFC_FUNCTION(scifa5),
+	SH_PFC_FUNCTION(scifb0),
+	SH_PFC_FUNCTION(scifb1),
+	SH_PFC_FUNCTION(scifb2),
+	SH_PFC_FUNCTION(sdhi0),
+	SH_PFC_FUNCTION(sdhi1),
+	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(ssi),
+	SH_PFC_FUNCTION(usb0),
+	SH_PFC_FUNCTION(usb1),
+	SH_PFC_FUNCTION(ssp),
+	SH_PFC_FUNCTION(vin0),
+	SH_PFC_FUNCTION(vin1),
+	SH_PFC_FUNCTION(vin2),
+};
-- 
2.3.5

