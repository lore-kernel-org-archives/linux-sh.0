From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 12 Apr 2012 06:45:32 +0000
Subject: [PATCH 1/2] sh: Add initial support for SH7734 CPU subtype
Message-Id: <1334213133-11140-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1332993899-15946-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1332993899-15946-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This implements initial support for the SH7734.
This adds support SCIF, TMU and RTC.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---

V3: Remove support for HCI-SH and I2C.
    Change to use the div4 clock API. 
    Change to use SCIx_IRQ_MUXED().
V2: Fix build clock framework on 3.4-rc2

 arch/sh/Kconfig                        |   12 +-
 arch/sh/include/asm/processor.h        |    2 +-
 arch/sh/include/cpu-sh4/cpu/freq.h     |    5 +
 arch/sh/include/cpu-sh4/cpu/sh7734.h   |  306 ++++++++++++
 arch/sh/kernel/cpu/proc.c              |    3 +-
 arch/sh/kernel/cpu/sh4/probe.c         |    3 +
 arch/sh/kernel/cpu/sh4a/Makefile       |    2 +
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c |  266 +++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |  800 ++++++++++++++++++++++++++++++++
 9 files changed, 1396 insertions(+), 3 deletions(-)
 create mode 100644 arch/sh/include/cpu-sh4/cpu/sh7734.h
 create mode 100644 arch/sh/kernel/cpu/sh4a/clock-sh7734.c
 create mode 100644 arch/sh/kernel/cpu/sh4a/setup-sh7734.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ff9e033..ed2419f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -427,6 +427,16 @@ config CPU_SUBTYPE_SH7724
 	help
 	  Select SH7724 if you have an SH-MobileR2R CPU.
 
+config CPU_SUBTYPE_SH7734
+	bool "Support SH7734 processor"
+	select CPU_SH4A
+	select CPU_SHX2
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select USB_ARCH_HAS_OHCI
+	select USB_ARCH_HAS_EHCI
+	help
+	  Select SH7734 if you have a SH4A SH7734 CPU.
+
 config CPU_SUBTYPE_SH7757
 	bool "Support SH7757 processor"
 	select CPU_SH4A
@@ -584,7 +594,7 @@ config SH_CLK_CPG
 config SH_CLK_CPG_LEGACY
 	depends on SH_CLK_CPG
 	def_bool y if !CPU_SUBTYPE_SH7785 && !ARCH_SHMOBILE && \
-		      !CPU_SHX3 && !CPU_SUBTYPE_SH7757
+		      !CPU_SHX3 && !CPU_SUBTYPE_SH7757 && !CPU_SUBTYPE_SH7734
 
 source "kernel/time/Kconfig"
 
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index a229c39..26b12fd 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -32,7 +32,7 @@ enum cpu_type {
 
 	/* SH-4A types */
 	CPU_SH7763, CPU_SH7770, CPU_SH7780, CPU_SH7781, CPU_SH7785, CPU_SH7786,
-	CPU_SH7723, CPU_SH7724, CPU_SH7757, CPU_SHX3,
+	CPU_SH7723, CPU_SH7724, CPU_SH7757, CPU_SH7734, CPU_SHX3,
 
 	/* SH4AL-DSP types */
 	CPU_SH7343, CPU_SH7722, CPU_SH7366, CPU_SH7372,
diff --git a/arch/sh/include/cpu-sh4/cpu/freq.h b/arch/sh/include/cpu-sh4/cpu/freq.h
index cffd25e..1631fc23 100644
--- a/arch/sh/include/cpu-sh4/cpu/freq.h
+++ b/arch/sh/include/cpu-sh4/cpu/freq.h
@@ -47,6 +47,11 @@
 #define MSTPCR1			0xa4150034
 #define MSTPCR2			0xa4150038
 
+#elif defined(CONFIG_CPU_SUBTYPE_SH7734)
+#define FRQCR0			0xffc80000
+#define FRQCR2			0xffc80008
+#define FRQMR1			0xffc80014
+#define FRQMR2			0xffc80018
 #elif defined(CONFIG_CPU_SUBTYPE_SH7785)
 #define FRQCR0			0xffc80000
 #define FRQCR1			0xffc80004
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7734.h b/arch/sh/include/cpu-sh4/cpu/sh7734.h
new file mode 100644
index 0000000..2fb9a7b
--- /dev/null
+++ b/arch/sh/include/cpu-sh4/cpu/sh7734.h
@@ -0,0 +1,306 @@
+#ifndef __ASM_SH7734_H__
+#define __ASM_SH7734_H__
+
+/* Pin Function Controller:
+ * GPIO_FN_xx - GPIO used to select pin function
+ * GPIO_GP_x_x - GPIO mapped to real I/O pin on CPU
+ */
+enum {
+	GPIO_GP_0_0, GPIO_GP_0_1, GPIO_GP_0_2, GPIO_GP_0_3,
+	GPIO_GP_0_4, GPIO_GP_0_5, GPIO_GP_0_6, GPIO_GP_0_7,
+	GPIO_GP_0_8, GPIO_GP_0_9, GPIO_GP_0_10, GPIO_GP_0_11,
+	GPIO_GP_0_12, GPIO_GP_0_13, GPIO_GP_0_14, GPIO_GP_0_15,
+	GPIO_GP_0_16, GPIO_GP_0_17, GPIO_GP_0_18, GPIO_GP_0_19,
+	GPIO_GP_0_20, GPIO_GP_0_21, GPIO_GP_0_22, GPIO_GP_0_23,
+	GPIO_GP_0_24, GPIO_GP_0_25, GPIO_GP_0_26, GPIO_GP_0_27,
+	GPIO_GP_0_28, GPIO_GP_0_29, GPIO_GP_0_30, GPIO_GP_0_31,
+
+	GPIO_GP_1_0, GPIO_GP_1_1, GPIO_GP_1_2, GPIO_GP_1_3,
+	GPIO_GP_1_4, GPIO_GP_1_5, GPIO_GP_1_6, GPIO_GP_1_7,
+	GPIO_GP_1_8, GPIO_GP_1_9, GPIO_GP_1_10, GPIO_GP_1_11,
+	GPIO_GP_1_12, GPIO_GP_1_13, GPIO_GP_1_14, GPIO_GP_1_15,
+	GPIO_GP_1_16, GPIO_GP_1_17, GPIO_GP_1_18, GPIO_GP_1_19,
+	GPIO_GP_1_20, GPIO_GP_1_21, GPIO_GP_1_22, GPIO_GP_1_23,
+	GPIO_GP_1_24, GPIO_GP_1_25, GPIO_GP_1_26, GPIO_GP_1_27,
+	GPIO_GP_1_28, GPIO_GP_1_29, GPIO_GP_1_30, GPIO_GP_1_31,
+
+	GPIO_GP_2_0, GPIO_GP_2_1, GPIO_GP_2_2, GPIO_GP_2_3,
+	GPIO_GP_2_4, GPIO_GP_2_5, GPIO_GP_2_6, GPIO_GP_2_7,
+	GPIO_GP_2_8, GPIO_GP_2_9, GPIO_GP_2_10, GPIO_GP_2_11,
+	GPIO_GP_2_12, GPIO_GP_2_13, GPIO_GP_2_14, GPIO_GP_2_15,
+	GPIO_GP_2_16, GPIO_GP_2_17, GPIO_GP_2_18, GPIO_GP_2_19,
+	GPIO_GP_2_20, GPIO_GP_2_21, GPIO_GP_2_22, GPIO_GP_2_23,
+	GPIO_GP_2_24, GPIO_GP_2_25, GPIO_GP_2_26, GPIO_GP_2_27,
+	GPIO_GP_2_28, GPIO_GP_2_29, GPIO_GP_2_30, GPIO_GP_2_31,
+
+	GPIO_GP_3_0, GPIO_GP_3_1, GPIO_GP_3_2, GPIO_GP_3_3,
+	GPIO_GP_3_4, GPIO_GP_3_5, GPIO_GP_3_6, GPIO_GP_3_7,
+	GPIO_GP_3_8, GPIO_GP_3_9, GPIO_GP_3_10, GPIO_GP_3_11,
+	GPIO_GP_3_12, GPIO_GP_3_13, GPIO_GP_3_14, GPIO_GP_3_15,
+	GPIO_GP_3_16, GPIO_GP_3_17, GPIO_GP_3_18, GPIO_GP_3_19,
+	GPIO_GP_3_20, GPIO_GP_3_21, GPIO_GP_3_22, GPIO_GP_3_23,
+	GPIO_GP_3_24, GPIO_GP_3_25, GPIO_GP_3_26, GPIO_GP_3_27,
+	GPIO_GP_3_28, GPIO_GP_3_29, GPIO_GP_3_30, GPIO_GP_3_31,
+
+	GPIO_GP_4_0, GPIO_GP_4_1, GPIO_GP_4_2, GPIO_GP_4_3,
+	GPIO_GP_4_4, GPIO_GP_4_5, GPIO_GP_4_6, GPIO_GP_4_7,
+	GPIO_GP_4_8, GPIO_GP_4_9, GPIO_GP_4_10, GPIO_GP_4_11,
+	GPIO_GP_4_12, GPIO_GP_4_13, GPIO_GP_4_14, GPIO_GP_4_15,
+	GPIO_GP_4_16, GPIO_GP_4_17, GPIO_GP_4_18, GPIO_GP_4_19,
+	GPIO_GP_4_20, GPIO_GP_4_21, GPIO_GP_4_22, GPIO_GP_4_23,
+	GPIO_GP_4_24, GPIO_GP_4_25, GPIO_GP_4_26, GPIO_GP_4_27,
+	GPIO_GP_4_28, GPIO_GP_4_29, GPIO_GP_4_30, GPIO_GP_4_31,
+
+	GPIO_GP_5_0, GPIO_GP_5_1, GPIO_GP_5_2, GPIO_GP_5_3,
+	GPIO_GP_5_4, GPIO_GP_5_5, GPIO_GP_5_6, GPIO_GP_5_7,
+	GPIO_GP_5_8, GPIO_GP_5_9, GPIO_GP_5_10, GPIO_GP_5_11,
+
+	GPIO_FN_CLKOUT, GPIO_FN_BS, GPIO_FN_CS0, GPIO_FN_EX_CS0, GPIO_FN_RD,
+		GPIO_FN_WE0, GPIO_FN_WE1,
+
+	GPIO_FN_SCL0, GPIO_FN_PENC0, GPIO_FN_USB_OVC0,
+
+	GPIO_FN_IRQ2_B, GPIO_FN_IRQ3_B,
+
+	/* IPSR0 */
+	GPIO_FN_A15, GPIO_FN_ST0_VCO_CLKIN, GPIO_FN_LCD_DATA15_A,
+		GPIO_FN_TIOC3D_C,
+	GPIO_FN_A14, GPIO_FN_LCD_DATA14_A, GPIO_FN_TIOC3C_C,
+	GPIO_FN_A13, GPIO_FN_LCD_DATA13_A, GPIO_FN_TIOC3B_C,
+	GPIO_FN_A12, GPIO_FN_LCD_DATA12_A, GPIO_FN_TIOC3A_C,
+	GPIO_FN_A11, GPIO_FN_ST0_D7, GPIO_FN_LCD_DATA11_A,
+		GPIO_FN_TIOC2B_C,
+	GPIO_FN_A10, GPIO_FN_ST0_D6, GPIO_FN_LCD_DATA10_A,
+		GPIO_FN_TIOC2A_C,
+	GPIO_FN_A9, GPIO_FN_ST0_D5, GPIO_FN_LCD_DATA9_A,
+		GPIO_FN_TIOC1B_C,
+	GPIO_FN_A8, GPIO_FN_ST0_D4, GPIO_FN_LCD_DATA8_A,
+		GPIO_FN_TIOC1A_C,
+	GPIO_FN_A7, GPIO_FN_ST0_D3, GPIO_FN_LCD_DATA7_A, GPIO_FN_TIOC0D_C,
+	GPIO_FN_A6, GPIO_FN_ST0_D2, GPIO_FN_LCD_DATA6_A, GPIO_FN_TIOC0C_C,
+	GPIO_FN_A5, GPIO_FN_ST0_D1, GPIO_FN_LCD_DATA5_A, GPIO_FN_TIOC0B_C,
+	GPIO_FN_A4, GPIO_FN_ST0_D0, GPIO_FN_LCD_DATA4_A, GPIO_FN_TIOC0A_C,
+	GPIO_FN_A3, GPIO_FN_ST0_VLD, GPIO_FN_LCD_DATA3_A, GPIO_FN_TCLKD_C,
+	GPIO_FN_A2, GPIO_FN_ST0_SYC, GPIO_FN_LCD_DATA2_A, GPIO_FN_TCLKC_C,
+	GPIO_FN_A1, GPIO_FN_ST0_REQ, GPIO_FN_LCD_DATA1_A, GPIO_FN_TCLKB_C,
+	GPIO_FN_A0, GPIO_FN_ST0_CLKIN, GPIO_FN_LCD_DATA0_A, GPIO_FN_TCLKA_C,
+
+	/* IPSR1 */
+	GPIO_FN_D3, GPIO_FN_SD0_DAT3_A, GPIO_FN_MMC_D3_A, GPIO_FN_ST1_D6,
+		GPIO_FN_FD3_A,
+	GPIO_FN_D2, GPIO_FN_SD0_DAT2_A, GPIO_FN_MMC_D2_A, GPIO_FN_ST1_D5,
+		GPIO_FN_FD2_A,
+	GPIO_FN_D1, GPIO_FN_SD0_DAT1_A, GPIO_FN_MMC_D1_A, GPIO_FN_ST1_D4,
+		GPIO_FN_FD1_A,
+	GPIO_FN_D0, GPIO_FN_SD0_DAT0_A, GPIO_FN_MMC_D0_A, GPIO_FN_ST1_D3,
+		GPIO_FN_FD0_A,
+	GPIO_FN_A25, GPIO_FN_TX2_D, GPIO_FN_ST1_D2,
+	GPIO_FN_A24, GPIO_FN_RX2_D, GPIO_FN_ST1_D1,
+	GPIO_FN_A23, GPIO_FN_ST1_D0, GPIO_FN_LCD_M_DISP_A,
+	GPIO_FN_A22, GPIO_FN_ST1_VLD, GPIO_FN_LCD_VEPWC_A,
+	GPIO_FN_A21, GPIO_FN_ST1_SYC, GPIO_FN_LCD_VCPWC_A,
+	GPIO_FN_A20, GPIO_FN_ST1_REQ, GPIO_FN_LCD_FLM_A,
+	GPIO_FN_A19, GPIO_FN_ST1_CLKIN, GPIO_FN_LCD_CLK_A, GPIO_FN_TIOC4D_C,
+	GPIO_FN_A18, GPIO_FN_ST1_PWM, GPIO_FN_LCD_CL2_A, GPIO_FN_TIOC4C_C,
+	GPIO_FN_A17, GPIO_FN_ST1_VCO_CLKIN, GPIO_FN_LCD_CL1_A, GPIO_FN_TIOC4B_C,
+	GPIO_FN_A16, GPIO_FN_ST0_PWM, GPIO_FN_LCD_DON_A, GPIO_FN_TIOC4A_C,
+
+	/* IPSR2 */
+	GPIO_FN_D14, GPIO_FN_TX2_B, GPIO_FN_FSE_A, GPIO_FN_ET0_TX_CLK_B,
+	GPIO_FN_D13, GPIO_FN_RX2_B, GPIO_FN_FRB_A,	GPIO_FN_ET0_ETXD6_B,
+	GPIO_FN_D12, GPIO_FN_FWE_A, GPIO_FN_ET0_ETXD5_B,
+	GPIO_FN_D11, GPIO_FN_RSPI_MISO_A, GPIO_FN_QMI_QIO1_A,
+		GPIO_FN_FRE_A, GPIO_FN_ET0_ETXD3_B,
+	GPIO_FN_D10, GPIO_FN_RSPI_MOSI_A, GPIO_FN_QMO_QIO0_A,
+		GPIO_FN_FALE_A, GPIO_FN_ET0_ETXD2_B,
+	GPIO_FN_D9, GPIO_FN_SD0_CMD_A, GPIO_FN_MMC_CMD_A, GPIO_FN_QIO3_A,
+		GPIO_FN_FCLE_A, GPIO_FN_ET0_ETXD1_B,
+	GPIO_FN_D8, GPIO_FN_SD0_CLK_A, GPIO_FN_MMC_CLK_A, GPIO_FN_QIO2_A,
+		GPIO_FN_FCE_A, GPIO_FN_ET0_GTX_CLK_B,
+	GPIO_FN_D7, GPIO_FN_RSPI_SSL_A, GPIO_FN_MMC_D7_A, GPIO_FN_QSSL_A,
+		GPIO_FN_FD7_A,
+	GPIO_FN_D6, GPIO_FN_RSPI_RSPCK_A, GPIO_FN_MMC_D6_A, GPIO_FN_QSPCLK_A,
+		GPIO_FN_FD6_A,
+	GPIO_FN_D5, GPIO_FN_SD0_WP_A, GPIO_FN_MMC_D5_A, GPIO_FN_FD5_A,
+	GPIO_FN_D4, GPIO_FN_SD0_CD_A, GPIO_FN_MMC_D4_A, GPIO_FN_ST1_D7,
+		GPIO_FN_FD4_A,
+
+	/* IPSR3 */
+	GPIO_FN_DRACK0, GPIO_FN_SD1_DAT2_A, GPIO_FN_ATAG, GPIO_FN_TCLK1_A,
+		GPIO_FN_ET0_ETXD7,
+	GPIO_FN_EX_WAIT2, GPIO_FN_SD1_DAT1_A, GPIO_FN_DACK2, GPIO_FN_CAN1_RX_C,
+		GPIO_FN_ET0_MAGIC_C, GPIO_FN_ET0_ETXD6_A,
+	GPIO_FN_EX_WAIT1, GPIO_FN_SD1_DAT0_A, GPIO_FN_DREQ2, GPIO_FN_CAN1_TX_C,
+		GPIO_FN_ET0_LINK_C, GPIO_FN_ET0_ETXD5_A,
+	GPIO_FN_EX_WAIT0, GPIO_FN_TCLK1_B,
+	GPIO_FN_RD_WR, GPIO_FN_TCLK0,
+	GPIO_FN_EX_CS5, GPIO_FN_SD1_CMD_A, GPIO_FN_ATADIR, GPIO_FN_QSSL_B,
+		GPIO_FN_ET0_ETXD3_A,
+	GPIO_FN_EX_CS4, GPIO_FN_SD1_WP_A, GPIO_FN_ATAWR, GPIO_FN_QMI_QIO1_B,
+		GPIO_FN_ET0_ETXD2_A,
+	GPIO_FN_EX_CS3, GPIO_FN_SD1_CD_A, GPIO_FN_ATARD, GPIO_FN_QMO_QIO0_B,
+		GPIO_FN_ET0_ETXD1_A,
+	GPIO_FN_EX_CS2, GPIO_FN_TX3_B, GPIO_FN_ATACS1, GPIO_FN_QSPCLK_B,
+		GPIO_FN_ET0_GTX_CLK_A,
+	GPIO_FN_EX_CS1, GPIO_FN_RX3_B, GPIO_FN_ATACS0, GPIO_FN_QIO2_B,
+		GPIO_FN_ET0_ETXD0,
+	GPIO_FN_CS1_A26, GPIO_FN_QIO3_B,
+	GPIO_FN_D15, GPIO_FN_SCK2_B,
+
+	/* IPSR4 */
+	GPIO_FN_SCK2_A, GPIO_FN_VI0_G3,
+	GPIO_FN_RTS1_B, GPIO_FN_VI0_G2,
+	GPIO_FN_CTS1_B, GPIO_FN_VI0_DATA7_VI0_G1,
+	GPIO_FN_TX1_B, GPIO_FN_VI0_DATA6_VI0_G0, GPIO_FN_ET0_PHY_INT_A,
+	GPIO_FN_RX1_B, GPIO_FN_VI0_DATA5_VI0_B5, GPIO_FN_ET0_MAGIC_A,
+	GPIO_FN_SCK1_B, GPIO_FN_VI0_DATA4_VI0_B4, GPIO_FN_ET0_LINK_A,
+	GPIO_FN_RTS0_B, GPIO_FN_VI0_DATA3_VI0_B3, GPIO_FN_ET0_MDIO_A,
+	GPIO_FN_CTS0_B, GPIO_FN_VI0_DATA2_VI0_B2, GPIO_FN_RMII0_MDIO_A,
+		GPIO_FN_ET0_MDC,
+	GPIO_FN_HTX0_A, GPIO_FN_TX1_A, GPIO_FN_VI0_DATA1_VI0_B1,
+		GPIO_FN_RMII0_MDC_A, GPIO_FN_ET0_COL,
+	GPIO_FN_HRX0_A, GPIO_FN_RX1_A, GPIO_FN_VI0_DATA0_VI0_B0,
+		GPIO_FN_RMII0_CRS_DV_A, GPIO_FN_ET0_CRS,
+	GPIO_FN_HSCK0_A, GPIO_FN_SCK1_A, GPIO_FN_VI0_VSYNC,
+		GPIO_FN_RMII0_RX_ER_A, GPIO_FN_ET0_RX_ER,
+	GPIO_FN_HRTS0_A, GPIO_FN_RTS1_A, GPIO_FN_VI0_HSYNC,
+		GPIO_FN_RMII0_TXD_EN_A, GPIO_FN_ET0_RX_DV,
+	GPIO_FN_HCTS0_A, GPIO_FN_CTS1_A, GPIO_FN_VI0_FIELD,
+		GPIO_FN_RMII0_RXD1_A, GPIO_FN_ET0_ERXD7,
+
+	/* IPSR5 */
+	GPIO_FN_SD2_CLK_A, GPIO_FN_RX2_A, GPIO_FN_VI0_G4, GPIO_FN_ET0_RX_CLK_B,
+	GPIO_FN_SD2_CMD_A, GPIO_FN_TX2_A, GPIO_FN_VI0_G5, GPIO_FN_ET0_ERXD2_B,
+	GPIO_FN_SD2_DAT0_A, GPIO_FN_RX3_A, GPIO_FN_VI0_R0, GPIO_FN_ET0_ERXD3_B,
+	GPIO_FN_SD2_DAT1_A, GPIO_FN_TX3_A, GPIO_FN_VI0_R1, GPIO_FN_ET0_MDIO_B,
+	GPIO_FN_SD2_DAT2_A, GPIO_FN_RX4_A, GPIO_FN_VI0_R2, GPIO_FN_ET0_LINK_B,
+	GPIO_FN_SD2_DAT3_A, GPIO_FN_TX4_A, GPIO_FN_VI0_R3, GPIO_FN_ET0_MAGIC_B,
+	GPIO_FN_SD2_CD_A, GPIO_FN_RX5_A, GPIO_FN_VI0_R4, GPIO_FN_ET0_PHY_INT_B,
+	GPIO_FN_SD2_WP_A, GPIO_FN_TX5_A, GPIO_FN_VI0_R5,
+	GPIO_FN_REF125CK, GPIO_FN_ADTRG, GPIO_FN_RX5_C,
+	GPIO_FN_REF50CK, GPIO_FN_CTS1_E, GPIO_FN_HCTS0_D,
+
+	/* IPSR6 */
+	GPIO_FN_DU0_DR0, GPIO_FN_SCIF_CLK_B, GPIO_FN_HRX0_D, GPIO_FN_IETX_A,
+		GPIO_FN_TCLKA_A, GPIO_FN_HIFD00,
+	GPIO_FN_DU0_DR1, GPIO_FN_SCK0_B, GPIO_FN_HTX0_D, GPIO_FN_IERX_A,
+		GPIO_FN_TCLKB_A, GPIO_FN_HIFD01,
+	GPIO_FN_DU0_DR2, GPIO_FN_RX0_B, GPIO_FN_TCLKC_A, GPIO_FN_HIFD02,
+	GPIO_FN_DU0_DR3, GPIO_FN_TX0_B, GPIO_FN_TCLKD_A, GPIO_FN_HIFD03,
+	GPIO_FN_DU0_DR4, GPIO_FN_CTS0_C, GPIO_FN_TIOC0A_A, GPIO_FN_HIFD04,
+	GPIO_FN_DU0_DR5, GPIO_FN_RTS0_C, GPIO_FN_TIOC0B_A, GPIO_FN_HIFD05,
+	GPIO_FN_DU0_DR6, GPIO_FN_SCK1_C, GPIO_FN_TIOC0C_A, GPIO_FN_HIFD06,
+	GPIO_FN_DU0_DR7, GPIO_FN_RX1_C, GPIO_FN_TIOC0D_A, GPIO_FN_HIFD07,
+	GPIO_FN_DU0_DG0, GPIO_FN_TX1_C, GPIO_FN_HSCK0_D, GPIO_FN_IECLK_A,
+		GPIO_FN_TIOC1A_A, GPIO_FN_HIFD08,
+	GPIO_FN_DU0_DG1, GPIO_FN_CTS1_C, GPIO_FN_HRTS0_D, GPIO_FN_TIOC1B_A,
+		GPIO_FN_HIFD09,
+
+	/* IPSR7 */
+	GPIO_FN_DU0_DG2, GPIO_FN_RTS1_C, GPIO_FN_RMII0_MDC_B, GPIO_FN_TIOC2A_A,
+		GPIO_FN_HIFD10,
+	GPIO_FN_DU0_DG3, GPIO_FN_SCK2_C, GPIO_FN_RMII0_MDIO_B, GPIO_FN_TIOC2B_A,
+		GPIO_FN_HIFD11,
+	GPIO_FN_DU0_DG4, GPIO_FN_RX2_C, GPIO_FN_RMII0_CRS_DV_B,
+		GPIO_FN_TIOC3A_A, GPIO_FN_HIFD12,
+	GPIO_FN_DU0_DG5, GPIO_FN_TX2_C, GPIO_FN_RMII0_RX_ER_B,
+		GPIO_FN_TIOC3B_A, GPIO_FN_HIFD13,
+	GPIO_FN_DU0_DG6, GPIO_FN_RX3_C, GPIO_FN_RMII0_RXD0_B,
+		GPIO_FN_TIOC3C_A, GPIO_FN_HIFD14,
+	GPIO_FN_DU0_DG7, GPIO_FN_TX3_C, GPIO_FN_RMII0_RXD1_B,
+		GPIO_FN_TIOC3D_A, GPIO_FN_HIFD15,
+	GPIO_FN_DU0_DB0, GPIO_FN_RX4_C, GPIO_FN_RMII0_TXD_EN_B,
+		GPIO_FN_TIOC4A_A, GPIO_FN_HIFCS,
+	GPIO_FN_DU0_DB1, GPIO_FN_TX4_C, GPIO_FN_RMII0_TXD0_B,
+		GPIO_FN_TIOC4B_A, GPIO_FN_HIFRS,
+	GPIO_FN_DU0_DB2, GPIO_FN_RX5_B, GPIO_FN_RMII0_TXD1_B,
+		GPIO_FN_TIOC4C_A, GPIO_FN_HIFWR,
+	GPIO_FN_DU0_DB3, GPIO_FN_TX5_B, GPIO_FN_TIOC4D_A, GPIO_FN_HIFRD,
+	GPIO_FN_DU0_DB4, GPIO_FN_HIFINT,
+
+	/* IPSR8 */
+	GPIO_FN_DU0_DB5, GPIO_FN_HIFDREQ,
+	GPIO_FN_DU0_DB6, GPIO_FN_HIFRDY,
+	GPIO_FN_DU0_DB7, GPIO_FN_SSI_SCK0_B, GPIO_FN_HIFEBL_B,
+	GPIO_FN_DU0_DOTCLKIN, GPIO_FN_HSPI_CS0_C, GPIO_FN_SSI_WS0_B,
+	GPIO_FN_DU0_DOTCLKOUT, GPIO_FN_HSPI_CLK0_C, GPIO_FN_SSI_SDATA0_B,
+	GPIO_FN_DU0_EXHSYNC_DU0_HSYNC, GPIO_FN_HSPI_TX0_C, GPIO_FN_SSI_SCK1_B,
+	GPIO_FN_DU0_EXVSYNC_DU0_VSYNC, GPIO_FN_HSPI_RX0_C, GPIO_FN_SSI_WS1_B,
+	GPIO_FN_DU0_EXODDF_DU0_ODDF, GPIO_FN_CAN0_RX_B, GPIO_FN_HSCK0_B,
+		GPIO_FN_SSI_SDATA1_B,
+	GPIO_FN_DU0_DISP, GPIO_FN_CAN0_TX_B, GPIO_FN_HRX0_B,
+		GPIO_FN_AUDIO_CLKA_B,
+	GPIO_FN_DU0_CDE, GPIO_FN_HTX0_B, GPIO_FN_AUDIO_CLKB_B,
+		GPIO_FN_LCD_VCPWC_B,
+	GPIO_FN_IRQ0_A, GPIO_FN_HSPI_TX_B, GPIO_FN_RX3_E, GPIO_FN_ET0_ERXD0,
+	GPIO_FN_IRQ1_A, GPIO_FN_HSPI_RX_B, GPIO_FN_TX3_E, GPIO_FN_ET0_ERXD1,
+	GPIO_FN_IRQ2_A, GPIO_FN_CTS0_A, GPIO_FN_HCTS0_B, GPIO_FN_ET0_ERXD2_A,
+	GPIO_FN_IRQ3_A, GPIO_FN_RTS0_A, GPIO_FN_HRTS0_B, GPIO_FN_ET0_ERXD3_A,
+
+	/* IPSR9 */
+	GPIO_FN_VI1_CLK_A, GPIO_FN_FD0_B, GPIO_FN_LCD_DATA0_B,
+	GPIO_FN_VI1_0_A, GPIO_FN_FD1_B, GPIO_FN_LCD_DATA1_B,
+	GPIO_FN_VI1_1_A, GPIO_FN_FD2_B, GPIO_FN_LCD_DATA2_B,
+	GPIO_FN_VI1_2_A, GPIO_FN_FD3_B, GPIO_FN_LCD_DATA3_B,
+	GPIO_FN_VI1_3_A, GPIO_FN_FD4_B, GPIO_FN_LCD_DATA4_B,
+	GPIO_FN_VI1_4_A, GPIO_FN_FD5_B, GPIO_FN_LCD_DATA5_B,
+	GPIO_FN_VI1_5_A, GPIO_FN_FD6_B, GPIO_FN_LCD_DATA6_B,
+	GPIO_FN_VI1_6_A, GPIO_FN_FD7_B, GPIO_FN_LCD_DATA7_B,
+	GPIO_FN_VI1_7_A, GPIO_FN_FCE_B, GPIO_FN_LCD_DATA8_B,
+	GPIO_FN_SSI_SCK0_A, GPIO_FN_TIOC1A_B, GPIO_FN_LCD_DATA9_B,
+	GPIO_FN_SSI_WS0_A, GPIO_FN_TIOC1B_B, GPIO_FN_LCD_DATA10_B,
+	GPIO_FN_SSI_SDATA0_A, GPIO_FN_VI1_0_B, GPIO_FN_TIOC2A_B,
+		GPIO_FN_LCD_DATA11_B,
+	GPIO_FN_SSI_SCK1_A, GPIO_FN_VI1_1_B, GPIO_FN_TIOC2B_B,
+		GPIO_FN_LCD_DATA12_B,
+	GPIO_FN_SSI_WS1_A, GPIO_FN_VI1_2_B, GPIO_FN_LCD_DATA13_B,
+	GPIO_FN_SSI_SDATA1_A, GPIO_FN_VI1_3_B, GPIO_FN_LCD_DATA14_B,
+
+	/* IPSR10 */
+	GPIO_FN_SSI_SCK23, GPIO_FN_VI1_4_B, GPIO_FN_RX1_D, GPIO_FN_FCLE_B,
+		GPIO_FN_LCD_DATA15_B,
+	GPIO_FN_SSI_WS23, GPIO_FN_VI1_5_B, GPIO_FN_TX1_D, GPIO_FN_HSCK0_C,
+		GPIO_FN_FALE_B, GPIO_FN_LCD_DON_B,
+	GPIO_FN_SSI_SDATA2, GPIO_FN_VI1_6_B, GPIO_FN_HRX0_C, GPIO_FN_FRE_B,
+		GPIO_FN_LCD_CL1_B,
+	GPIO_FN_SSI_SDATA3, GPIO_FN_VI1_7_B, GPIO_FN_HTX0_C, GPIO_FN_FWE_B,
+		GPIO_FN_LCD_CL2_B,
+	GPIO_FN_AUDIO_CLKA_A, GPIO_FN_VI1_CLK_B, GPIO_FN_SCK1_D,
+		GPIO_FN_IECLK_B, GPIO_FN_LCD_FLM_B,
+	GPIO_FN_AUDIO_CLKB_A, GPIO_FN_LCD_CLK_B,
+	GPIO_FN_AUDIO_CLKC, GPIO_FN_SCK1_E, GPIO_FN_HCTS0_C, GPIO_FN_FRB_B,
+		GPIO_FN_LCD_VEPWC_B,
+	GPIO_FN_AUDIO_CLKOUT, GPIO_FN_TX1_E, GPIO_FN_HRTS0_C, GPIO_FN_FSE_B,
+		GPIO_FN_LCD_M_DISP_B,
+	GPIO_FN_CAN_CLK_A, GPIO_FN_RX4_D,
+	GPIO_FN_CAN0_TX_A, GPIO_FN_TX4_D, GPIO_FN_MLB_CLK,
+	GPIO_FN_CAN1_RX_A, GPIO_FN_IRQ1_B,
+	GPIO_FN_CAN0_RX_A, GPIO_FN_IRQ0_B, GPIO_FN_MLB_SIG,
+	GPIO_FN_CAN1_TX_A, GPIO_FN_TX5_C, GPIO_FN_MLB_DAT,
+
+	/* IPSR11 */
+	GPIO_FN_SCL1, GPIO_FN_SCIF_CLK_C,
+	GPIO_FN_SDA1, GPIO_FN_RX1_E,
+	GPIO_FN_SDA0, GPIO_FN_HIFEBL_A,
+	GPIO_FN_SDSELF, GPIO_FN_RTS1_E,
+	GPIO_FN_SCIF_CLK_A, GPIO_FN_HSPI_CLK_A, GPIO_FN_VI0_CLK,
+		GPIO_FN_RMII0_TXD0_A, GPIO_FN_ET0_ERXD4,
+	GPIO_FN_SCK0_A, GPIO_FN_HSPI_CS_A, GPIO_FN_VI0_CLKENB,
+		GPIO_FN_RMII0_TXD1_A, GPIO_FN_ET0_ERXD5,
+	GPIO_FN_RX0_A, GPIO_FN_HSPI_RX_A, GPIO_FN_RMII0_RXD0_A,
+		GPIO_FN_ET0_ERXD6,
+	GPIO_FN_TX0_A, GPIO_FN_HSPI_TX_A,
+	GPIO_FN_PENC1, GPIO_FN_TX3_D, GPIO_FN_CAN1_TX_B, GPIO_FN_TX5_D,
+		GPIO_FN_IETX_B,
+	GPIO_FN_USB_OVC1, GPIO_FN_RX3_D, GPIO_FN_CAN1_RX_B, GPIO_FN_RX5_D,
+		GPIO_FN_IERX_B,
+	GPIO_FN_DREQ0, GPIO_FN_SD1_CLK_A, GPIO_FN_ET0_TX_EN,
+	GPIO_FN_DACK0, GPIO_FN_SD1_DAT3_A, GPIO_FN_ET0_TX_ER,
+	GPIO_FN_DREQ1, GPIO_FN_HSPI_CLK_B, GPIO_FN_RX4_B, GPIO_FN_ET0_PHY_INT_C,
+		GPIO_FN_ET0_TX_CLK_A,
+	GPIO_FN_DACK1, GPIO_FN_HSPI_CS_B, GPIO_FN_TX4_B, GPIO_FN_ET0_RX_CLK_A,
+	GPIO_FN_PRESETOUT, GPIO_FN_ST_CLKOUT,
+
+};
+
+#endif /* __ASM_SH7734_H__ */
diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
index f47be87..e3a16d1 100644
--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -25,7 +25,8 @@ static const char *cpu_name[] = {
 	[CPU_SH5_101]	= "SH5-101",	[CPU_SH5_103]	= "SH5-103",
 	[CPU_MXG]	= "MX-G",	[CPU_SH7723]	= "SH7723",
 	[CPU_SH7366]	= "SH7366",	[CPU_SH7724]	= "SH7724",
-	[CPU_SH7372]	= "SH7372",	[CPU_SH_NONE]	= "Unknown"
+	[CPU_SH7372]	= "SH7372",	[CPU_SH7734]	= "SH7734",
+	[CPU_SH_NONE]	= "Unknown"
 };
 
 const char *get_cpu_subtype(struct sh_cpuinfo *c)
diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.c
index 971cf0f..0fbbd50 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -158,6 +158,9 @@ void __cpuinit cpu_probe(void)
 		case 0x40: /* yon-ten-go */
 			boot_cpu_data.type = CPU_SH7372;
 			break;
+		case 0xE0: /* 0x4E0 */
+			boot_cpu_data.type = CPU_SH7734; /* SH7733/SH7734 */
+			break;
 
 		}
 		break;
diff --git a/arch/sh/kernel/cpu/sh4a/Makefile b/arch/sh/kernel/cpu/sh4a/Makefile
index 0b22d10..ed71c3f 100644
--- a/arch/sh/kernel/cpu/sh4a/Makefile
+++ b/arch/sh/kernel/cpu/sh4a/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CPU_SUBTYPE_SH7343)	+= setup-sh7343.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7722)	+= setup-sh7722.o serial-sh7722.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7723)	+= setup-sh7723.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7724)	+= setup-sh7724.o
+obj-$(CONFIG_CPU_SUBTYPE_SH7734)	+= setup-sh7734.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7366)	+= setup-sh7366.o
 obj-$(CONFIG_CPU_SUBTYPE_SHX3)		+= setup-shx3.o intc-shx3.o
 
@@ -30,6 +31,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7343.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7724.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7734)	:= clock-sh7734.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7366.o
 clock-$(CONFIG_CPU_SUBTYPE_SHX3)	:= clock-shx3.o
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7734.c b/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
new file mode 100644
index 0000000..1697642
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
@@ -0,0 +1,266 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/clock-sh7734.c
+ *
+ * Clock framework for SH7734
+ *
+ * Copyright (C) 2011, 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
+ * Copyright (C) 2011, 2012 Renesas Solutions Corp.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+
+static struct clk extal_clk = {
+	.rate       = 33333333,
+};
+
+#define MODEMR          (0xFFCC0020)
+#define MODEMR_MASK     (0x6)
+#define MODEMR_533MHZ   (0x2)
+
+static unsigned long pll_recalc(struct clk *clk)
+{
+	int mode = 12;
+	u32 r = __raw_readl(MODEMR);
+
+	if ((r & MODEMR_MASK) & MODEMR_533MHZ)
+		mode = 16;
+
+	return clk->parent->rate * mode;
+}
+
+static struct sh_clk_ops pll_clk_ops = {
+	.recalc		= pll_recalc,
+};
+
+static struct clk pll_clk = {
+	.ops        = &pll_clk_ops,
+	.parent     = &extal_clk,
+	.flags      = CLK_ENABLE_ON_INIT,
+};
+
+static struct clk *main_clks[] = {
+	&extal_clk,
+	&pll_clk,
+};
+
+static int multipliers[] = { 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
+static int divisors[] = { 1, 3, 2, 3, 4, 6, 8, 9, 12, 16, 18, 24 };
+
+static struct clk_div_mult_table div4_div_mult_table = {
+	.divisors = divisors,
+	.nr_divisors = ARRAY_SIZE(divisors),
+	.multipliers = multipliers,
+	.nr_multipliers = ARRAY_SIZE(multipliers),
+};
+
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
+enum { DIV4_I, DIV4_S, DIV4_B, DIV4_M, DIV4_S1, DIV4_P, DIV4_NR };
+
+#define DIV4(_reg, _bit, _mask, _flags) \
+	SH_CLK_DIV4(&pll_clk, _reg, _bit, _mask, _flags)
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4(FRQMR1, 28, 0x0003, CLK_ENABLE_ON_INIT),
+	[DIV4_S] = DIV4(FRQMR1, 20, 0x000C, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(FRQMR1, 16, 0x0140, CLK_ENABLE_ON_INIT),
+	[DIV4_M] = DIV4(FRQMR1, 12, 0x0004, CLK_ENABLE_ON_INIT),
+	[DIV4_S1] = DIV4(FRQMR1, 4, 0x0030, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4(FRQMR1, 0, 0x0140, CLK_ENABLE_ON_INIT),
+};
+
+#define MSTPCR0	0xFFC80030
+#define MSTPCR1	0xFFC80034
+#define MSTPCR3	0xFFC8003C
+
+enum {
+	MSTP030, MSTP029, /* IIC */
+	MSTP026, MSTP025, MSTP024, /* SCIF */
+	MSTP023,
+	MSTP022, MSTP021,
+	MSTP019, /* HSCIF */
+	MSTP016, MSTP015, MSTP014, /* TMU / TIMER */
+	MSTP012, MSTP011, MSTP010, MSTP009, MSTP008, /* SSI */
+	MSTP007, /* HSPI */
+	MSTP115, /* ADMAC */
+	MSTP114, /* GETHER */
+	MSTP111, /* DMAC */
+	MSTP109, /* VIDEOIN1 */
+	MSTP108, /* VIDEOIN0 */
+	MSTP107, /* RGPVBG */
+	MSTP106, /* 2DG */
+	MSTP103, /* VIEW */
+	MSTP100, /* USB */
+	MSTP331, /* MMC */
+	MSTP330, /* MIMLB */
+	MSTP323, /* SDHI0 */
+	MSTP322, /* SDHI1 */
+	MSTP321, /* SDHI2 */
+	MSTP320, /* RQSPI */
+	MSTP319, /* SRC0 */
+	MSTP318, /* SRC1 */
+	MSTP317, /* RSPI */
+	MSTP316, /* RCAN0 */
+	MSTP315, /* RCAN1 */
+	MSTP314, /* FLTCL */
+	MSTP313, /* ADC */
+	MSTP312, /* MTU */
+	MSTP304, /* IE-BUS */
+	MSTP303, /* RTC */
+	MSTP302, /* HIF */
+	MSTP301, /* STIF0 */
+	MSTP300, /* STIF1 */
+	MSTP_NR };
+
+static struct clk mstp_clks[MSTP_NR] = {
+	/* MSTPCR0 */
+	[MSTP030] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 30, 0),
+	[MSTP029] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 29, 0),
+	[MSTP026] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 26, 0),
+	[MSTP025] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 25, 0),
+	[MSTP024] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 24, 0),
+	[MSTP023] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 23, 0),
+	[MSTP022] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 22, 0),
+	[MSTP021] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	[MSTP019] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 19, 0),
+	[MSTP016] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 16, 0),
+	[MSTP015] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	[MSTP014] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 14, 0),
+	[MSTP012] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 12, 0),
+	[MSTP011] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 11, 0),
+	[MSTP010] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	[MSTP009] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 9, 0),
+	[MSTP008] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 8, 0),
+	[MSTP007] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 7, 0),
+
+	/* MSTPCR1 */
+	[MSTP115] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 15, 0),
+	[MSTP114] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 14, 0),
+	[MSTP111] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 11, 0),
+	[MSTP109] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 9, 0),
+	[MSTP108] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 8, 0),
+	[MSTP107] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 7, 0),
+	[MSTP106] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 6, 0),
+	[MSTP103] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 3, 0),
+	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 0, 0),
+
+	/* MSTPCR3 */
+	[MSTP331] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 31, 0),
+	[MSTP330] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 30, 0),
+	[MSTP323] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 23, 0),
+	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0),
+	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0),
+	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0),
+	[MSTP319] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 19, 0),
+	[MSTP318] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 18, 0),
+	[MSTP317] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 17, 0),
+	[MSTP316] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 16, 0),
+	[MSTP315] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 15, 0),
+	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 14, 0),
+	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 13, 0),
+	[MSTP312] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 12, 0),
+	[MSTP304] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3,  4, 0),
+	[MSTP303] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3,  3, 0),
+	[MSTP302] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3,  2, 0),
+	[MSTP301] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3,  1, 0),
+	[MSTP300] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3,  0, 0),
+};
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("extal", &extal_clk),
+	CLKDEV_CON_ID("pll_clk", &pll_clk),
+
+	/* clocks */
+	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
+	CLKDEV_CON_ID("shyway_clk", &div4_clks[DIV4_S]),
+	CLKDEV_CON_ID("ddr_clk", &div4_clks[DIV4_M]),
+	CLKDEV_CON_ID("bus_clk", &div4_clks[DIV4_B]),
+	CLKDEV_CON_ID("shyway_clk1", &div4_clks[DIV4_S1]),
+	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
+
+	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("i2c-sh7734.0", &mstp_clks[MSTP030]),
+	CLKDEV_DEV_ID("i2c-sh7734.1", &mstp_clks[MSTP029]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP026]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP025]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP024]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP023]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[MSTP022]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP021]),
+	CLKDEV_CON_ID("hscif", &mstp_clks[MSTP019]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[MSTP016]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[MSTP016]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.2", &mstp_clks[MSTP016]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.3", &mstp_clks[MSTP015]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.4", &mstp_clks[MSTP015]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.5", &mstp_clks[MSTP015]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.6", &mstp_clks[MSTP014]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.7", &mstp_clks[MSTP014]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.8", &mstp_clks[MSTP014]),
+	CLKDEV_CON_ID("ssi0", &mstp_clks[MSTP012]),
+	CLKDEV_CON_ID("ssi1", &mstp_clks[MSTP011]),
+	CLKDEV_CON_ID("ssi2", &mstp_clks[MSTP010]),
+	CLKDEV_CON_ID("ssi3", &mstp_clks[MSTP009]),
+	CLKDEV_CON_ID("sss", &mstp_clks[MSTP008]),
+	CLKDEV_CON_ID("hspi", &mstp_clks[MSTP007]),
+	CLKDEV_CON_ID("usb_fck", &mstp_clks[MSTP100]),
+	CLKDEV_CON_ID("videoin0", &mstp_clks[MSTP109]),
+	CLKDEV_CON_ID("videoin1", &mstp_clks[MSTP108]),
+	CLKDEV_CON_ID("rgpvg", &mstp_clks[MSTP107]),
+	CLKDEV_CON_ID("2dg", &mstp_clks[MSTP106]),
+	CLKDEV_CON_ID("view", &mstp_clks[MSTP103]),
+
+	CLKDEV_CON_ID("mmc0", &mstp_clks[MSTP331]),
+	CLKDEV_CON_ID("mimlb0", &mstp_clks[MSTP330]),
+	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP323]),
+	CLKDEV_CON_ID("sdhi1", &mstp_clks[MSTP322]),
+	CLKDEV_CON_ID("sdhi2", &mstp_clks[MSTP321]),
+	CLKDEV_CON_ID("rqspi0", &mstp_clks[MSTP320]),
+	CLKDEV_CON_ID("src0", &mstp_clks[MSTP319]),
+	CLKDEV_CON_ID("src1", &mstp_clks[MSTP318]),
+	CLKDEV_CON_ID("rsp0", &mstp_clks[MSTP317]),
+	CLKDEV_CON_ID("rcan0", &mstp_clks[MSTP316]),
+	CLKDEV_CON_ID("rcan1", &mstp_clks[MSTP315]),
+	CLKDEV_CON_ID("fltcl0", &mstp_clks[MSTP314]),
+	CLKDEV_CON_ID("adc0", &mstp_clks[MSTP313]),
+	CLKDEV_CON_ID("mtu0", &mstp_clks[MSTP312]),
+	CLKDEV_CON_ID("iebus0", &mstp_clks[MSTP304]),
+	CLKDEV_DEV_ID("sh-eth.0", &mstp_clks[MSTP114]),
+	CLKDEV_CON_ID("rtc0", &mstp_clks[MSTP303]),
+	CLKDEV_CON_ID("hif0", &mstp_clks[MSTP302]),
+	CLKDEV_CON_ID("stif0", &mstp_clks[MSTP301]),
+	CLKDEV_CON_ID("stif1", &mstp_clks[MSTP300]),
+};
+
+int __init arch_clk_init(void)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(main_clks); i++)
+		ret |= clk_register(main_clks[i]);
+
+	for (i = 0; i < ARRAY_SIZE(lookups); i++)
+		clkdev_add(&lookups[i]);
+
+	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
+			&div4_table);
+
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+
+	return ret;
+}
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
new file mode 100644
index 0000000..f799971
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -0,0 +1,800 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+
+ * SH7734 Setup
+ *
+ * Copyright (C) 2011,2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
+ * Copyright (C) 2011,2012 Renesas Solutions Corp.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/serial_sci.h>
+#include <linux/sh_timer.h>
+#include <linux/io.h>
+#include <asm/clock.h>
+#include <asm/irq.h>
+#include <cpu/sh7734.h>
+
+/* SCIF */
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase        = 0xFFE40000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scbrr_algo_id  = SCBRR_ALGO_2,
+	.type           = PORT_SCIF,
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x8C0)),
+	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id			= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase        = 0xFFE41000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type           = PORT_SCIF,
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x8E0)),
+	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id         = 1,
+	.dev		= {
+		.platform_data = &scif1_platform_data,
+	},
+};
+
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase        = 0xFFE42000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scbrr_algo_id  = SCBRR_ALGO_2,
+	.type           = PORT_SCIF,
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x900)),
+	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id         = 2,
+	.dev		= {
+		.platform_data = &scif2_platform_data,
+	},
+};
+
+static struct plat_sci_port scif3_platform_data = {
+	.mapbase        = 0xFFE43000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id  = SCBRR_ALGO_2,
+	.type           = PORT_SCIF,
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x920)),
+	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id	        = 3,
+	.dev		= {
+		.platform_data	= &scif3_platform_data,
+	},
+};
+
+static struct plat_sci_port scif4_platform_data = {
+	.mapbase        = 0xFFE44000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type           = PORT_SCIF,
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x940)),
+	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+};
+
+static struct platform_device scif4_device = {
+	.name		= "sh-sci",
+	.id	        = 4,
+	.dev		= {
+		.platform_data	= &scif4_platform_data,
+	},
+};
+
+static struct plat_sci_port scif5_platform_data = {
+	.mapbase        = 0xFFE43000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type           = PORT_SCIF,
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x960)),
+	.regtype		= SCIx_SH4_SCIF_REGTYPE,
+};
+
+static struct platform_device scif5_device = {
+	.name		= "sh-sci",
+	.id	        = 5,
+	.dev		= {
+		.platform_data	= &scif5_platform_data,
+	},
+};
+
+/* RTC */
+static struct resource rtc_resources[] = {
+	[0] = {
+		.name	= "rtc",
+		.start	= 0xFFFC5000,
+		.end	= 0xFFFC5000 + 0x26 - 1,
+		.flags	= IORESOURCE_IO,
+	},
+	[1] = {
+		.start	= evt2irq(0xC00),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device rtc_device = {
+	.name		= "sh-rtc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(rtc_resources),
+	.resource	= rtc_resources,
+};
+
+/* I2C 0 */
+static struct resource i2c0_resources[] = {
+	[0] = {
+		.name	= "IIC0",
+		.start  = 0xFFC70000,
+		.end    = 0xFFC7000A - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = evt2irq(0x860),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device i2c0_device = {
+	.name           = "i2c-sh7734",
+	.id             = 0,
+	.num_resources  = ARRAY_SIZE(i2c0_resources),
+	.resource       = i2c0_resources,
+};
+
+/* TMU */
+static struct sh_timer_config tmu0_platform_data = {
+	.channel_offset = 0x04,
+	.timer_bit = 0,
+	.clockevent_rating = 200,
+};
+
+static struct resource tmu0_resources[] = {
+	[0] = {
+		.start	= 0xFFD80008,
+		.end	= 0xFFD80014 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x400),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu0_device = {
+	.name	= "sh_tmu",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &tmu0_platform_data,
+	},
+	.resource	= tmu0_resources,
+	.num_resources	= ARRAY_SIZE(tmu0_resources),
+};
+
+static struct sh_timer_config tmu1_platform_data = {
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+	.clocksource_rating = 200,
+};
+
+static struct resource tmu1_resources[] = {
+	[0] = {
+		.start	= 0xFFD80014,
+		.end	= 0xFFD80020 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x420),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu1_device = {
+	.name		= "sh_tmu",
+	.id			= 1,
+	.dev = {
+		.platform_data	= &tmu1_platform_data,
+	},
+	.resource	= tmu1_resources,
+	.num_resources	= ARRAY_SIZE(tmu1_resources),
+};
+
+static struct sh_timer_config tmu2_platform_data = {
+	.channel_offset = 0x1c,
+	.timer_bit = 2,
+};
+
+static struct resource tmu2_resources[] = {
+	[0] = {
+		.start	= 0xFFD80020,
+		.end	= 0xFFD80030 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x440),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu2_device = {
+	.name		= "sh_tmu",
+	.id			= 2,
+	.dev = {
+		.platform_data	= &tmu2_platform_data,
+	},
+	.resource	= tmu2_resources,
+	.num_resources	= ARRAY_SIZE(tmu2_resources),
+};
+
+
+static struct sh_timer_config tmu3_platform_data = {
+	.channel_offset = 0x04,
+	.timer_bit = 0,
+};
+
+static struct resource tmu3_resources[] = {
+	[0] = {
+		.start	= 0xFFD81008,
+		.end	= 0xFFD81014 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x480),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu3_device = {
+	.name		= "sh_tmu",
+	.id			= 3,
+	.dev = {
+		.platform_data	= &tmu3_platform_data,
+	},
+	.resource	= tmu3_resources,
+	.num_resources	= ARRAY_SIZE(tmu3_resources),
+};
+
+static struct sh_timer_config tmu4_platform_data = {
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+};
+
+static struct resource tmu4_resources[] = {
+	[0] = {
+		.start	= 0xFFD81014,
+		.end	= 0xFFD81020 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x4A0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu4_device = {
+	.name		= "sh_tmu",
+	.id			= 4,
+	.dev = {
+		.platform_data	= &tmu4_platform_data,
+	},
+	.resource	= tmu4_resources,
+	.num_resources	= ARRAY_SIZE(tmu4_resources),
+};
+
+static struct sh_timer_config tmu5_platform_data = {
+	.channel_offset = 0x1c,
+	.timer_bit = 2,
+};
+
+static struct resource tmu5_resources[] = {
+	[0] = {
+		.start	= 0xFFD81020,
+		.end	= 0xFFD81030 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x4C0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu5_device = {
+	.name		= "sh_tmu",
+	.id			= 5,
+	.dev = {
+		.platform_data	= &tmu5_platform_data,
+	},
+	.resource	= tmu5_resources,
+	.num_resources	= ARRAY_SIZE(tmu5_resources),
+};
+
+static struct sh_timer_config tmu6_platform_data = {
+	.channel_offset = 0x4,
+	.timer_bit = 0,
+};
+
+static struct resource tmu6_resources[] = {
+	[0] = {
+		.start	= 0xFFD82008,
+		.end	= 0xFFD82014 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x500),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu6_device = {
+	.name		= "sh_tmu",
+	.id			= 6,
+	.dev = {
+		.platform_data	= &tmu6_platform_data,
+	},
+	.resource	= tmu6_resources,
+	.num_resources	= ARRAY_SIZE(tmu6_resources),
+};
+
+static struct sh_timer_config tmu7_platform_data = {
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+};
+
+static struct resource tmu7_resources[] = {
+	[0] = {
+		.start	= 0xFFD82014,
+		.end	= 0xFFD82020 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x520),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu7_device = {
+	.name		= "sh_tmu",
+	.id			= 7,
+	.dev = {
+		.platform_data	= &tmu7_platform_data,
+	},
+	.resource	= tmu7_resources,
+	.num_resources	= ARRAY_SIZE(tmu7_resources),
+};
+
+static struct sh_timer_config tmu8_platform_data = {
+	.channel_offset = 0x1c,
+	.timer_bit = 2,
+};
+
+static struct resource tmu8_resources[] = {
+	[0] = {
+		.start	= 0xFFD82020,
+		.end	= 0xFFD82030 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x540),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu8_device = {
+	.name		= "sh_tmu",
+	.id			= 8,
+	.dev = {
+		.platform_data	= &tmu8_platform_data,
+	},
+	.resource	= tmu8_resources,
+	.num_resources	= ARRAY_SIZE(tmu8_resources),
+};
+
+static struct platform_device *sh7734_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+	&tmu3_device,
+	&tmu4_device,
+	&tmu5_device,
+	&tmu6_device,
+	&tmu7_device,
+	&tmu8_device,
+	&rtc_device,
+};
+
+static struct platform_device *sh7734_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+	&tmu3_device,
+	&tmu4_device,
+	&tmu5_device,
+	&tmu6_device,
+	&tmu7_device,
+	&tmu8_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7734_early_devices,
+		ARRAY_SIZE(sh7734_early_devices));
+}
+
+#define GROUP 0
+enum {
+	UNUSED = 0,
+
+	/* interrupt sources */
+
+	IRL0_LLLL, IRL0_LLLH, IRL0_LLHL, IRL0_LLHH,
+	IRL0_LHLL, IRL0_LHLH, IRL0_LHHL, IRL0_LHHH,
+	IRL0_HLLL, IRL0_HLLH, IRL0_HLHL, IRL0_HLHH,
+	IRL0_HHLL, IRL0_HHLH, IRL0_HHHL,
+
+	IRQ0, IRQ1, IRQ2, IRQ3,
+	DU,
+	TMU00, TMU10, TMU20, TMU21,
+	TMU30, TMU40, TMU50, TMU51,
+	TMU60, TMU70, TMU80,
+	RESET_WDT,
+	USB,
+	HUDI,
+	SHDMAC,
+	SSI0, SSI1,	SSI2, SSI3,
+	VIN0,
+	RGPVG,
+	_2DG,
+	MMC,
+	HSPI,
+	LBSCATA,
+	I2C0,
+	RCAN0,
+	MIMLB,
+	SCIF0, SCIF1, SCIF2, SCIF3, SCIF4, SCIF5,
+	LBSCDMAC0, LBSCDMAC1, LBSCDMAC2,
+	RCAN1,
+	SDHI0, SDHI1,
+	IEBUS,
+	HPBDMAC0_3, HPBDMAC4_10, HPBDMAC11_18, HPBDMAC19_22, HPBDMAC23_25_27_28,
+	RTC,
+	VIN1,
+	LCDC,
+	SRC0, SRC1,
+	GETHER,
+	SDHI2,
+	GPIO0_3, GPIO4_5,
+	STIF0, STIF1,
+	ADMAC,
+	HIF,
+	FLCTL,
+	ADC,
+	MTU2,
+	RSPI,
+	QSPI,
+	HSCIF,
+	VEU3F_VE3,
+
+	/* Group */
+	/* Mask */
+	STIF_M,
+	GPIO_M,
+	HPBDMAC_M,
+	LBSCDMAC_M,
+	RCAN_M,
+	SRC_M,
+	SCIF_M,
+	LCDC_M,
+	_2DG_M,
+	VIN_M,
+	TMU_3_M,
+	TMU_0_M,
+
+	/* Priority */
+	RCAN_P,
+	LBSCDMAC_P,
+
+	/* Common */
+	SDHI,
+	SSI,
+	SPI,
+};
+
+static struct intc_vect vectors[] __initdata = {
+	INTC_VECT(DU, 0x3E0),
+	INTC_VECT(TMU00, 0x400),
+	INTC_VECT(TMU10, 0x420),
+	INTC_VECT(TMU20, 0x440),
+	INTC_VECT(TMU30, 0x480),
+	INTC_VECT(TMU40, 0x4A0),
+	INTC_VECT(TMU50, 0x4C0),
+	INTC_VECT(TMU51, 0x4E0),
+	INTC_VECT(TMU60, 0x500),
+	INTC_VECT(TMU70, 0x520),
+	INTC_VECT(TMU80, 0x540),
+	INTC_VECT(RESET_WDT, 0x560),
+	INTC_VECT(USB, 0x580),
+	INTC_VECT(HUDI, 0x600),
+	INTC_VECT(SHDMAC, 0x620),
+	INTC_VECT(SSI0, 0x6C0),
+	INTC_VECT(SSI1, 0x6E0),
+	INTC_VECT(SSI2, 0x700),
+	INTC_VECT(SSI3, 0x720),
+	INTC_VECT(VIN0, 0x740),
+	INTC_VECT(RGPVG, 0x760),
+	INTC_VECT(_2DG, 0x780),
+	INTC_VECT(MMC, 0x7A0),
+	INTC_VECT(HSPI, 0x7E0),
+	INTC_VECT(LBSCATA, 0x840),
+	INTC_VECT(I2C0, 0x860),
+	INTC_VECT(RCAN0, 0x880),
+	INTC_VECT(SCIF0, 0x8A0),
+	INTC_VECT(SCIF1, 0x8C0),
+	INTC_VECT(SCIF2, 0x900),
+	INTC_VECT(SCIF3, 0x920),
+	INTC_VECT(SCIF4, 0x940),
+	INTC_VECT(SCIF5, 0x960),
+	INTC_VECT(LBSCDMAC0, 0x9E0),
+	INTC_VECT(LBSCDMAC1, 0xA00),
+	INTC_VECT(LBSCDMAC2, 0xA20),
+	INTC_VECT(RCAN1, 0xA60),
+	INTC_VECT(SDHI0, 0xAE0),
+	INTC_VECT(SDHI1, 0xB00),
+	INTC_VECT(IEBUS, 0xB20),
+	INTC_VECT(HPBDMAC0_3, 0xB60),
+	INTC_VECT(HPBDMAC4_10, 0xB80),
+	INTC_VECT(HPBDMAC11_18, 0xBA0),
+	INTC_VECT(HPBDMAC19_22, 0xBC0),
+	INTC_VECT(HPBDMAC23_25_27_28, 0xBE0),
+	INTC_VECT(RTC, 0xC00),
+	INTC_VECT(VIN1, 0xC20),
+	INTC_VECT(LCDC, 0xC40),
+	INTC_VECT(SRC0, 0xC60),
+	INTC_VECT(SRC1, 0xC80),
+	INTC_VECT(GETHER, 0xCA0),
+	INTC_VECT(SDHI2, 0xCC0),
+	INTC_VECT(GPIO0_3, 0xCE0),
+	INTC_VECT(GPIO4_5, 0xD00),
+	INTC_VECT(STIF0, 0xD20),
+	INTC_VECT(STIF1, 0xD40),
+	INTC_VECT(ADMAC, 0xDA0),
+	INTC_VECT(HIF, 0xDC0),
+	INTC_VECT(FLCTL, 0xDE0),
+	INTC_VECT(ADC, 0xE00),
+	INTC_VECT(MTU2, 0xE20),
+	INTC_VECT(RSPI, 0xE40),
+	INTC_VECT(QSPI, 0xE60),
+	INTC_VECT(HSCIF, 0xFC0),
+	INTC_VECT(VEU3F_VE3, 0xF40),
+};
+
+static struct intc_group groups[] __initdata = {
+	/* Common */
+	INTC_GROUP(SDHI, SDHI0, SDHI1, SDHI2),
+	INTC_GROUP(SPI, HSPI, RSPI, QSPI),
+	INTC_GROUP(SSI, SSI0, SSI1, SSI2, SSI3),
+
+	/* Mask group */
+	INTC_GROUP(STIF_M, STIF0, STIF1), /* 22 */
+	INTC_GROUP(GPIO_M, GPIO0_3, GPIO4_5), /* 21 */
+	INTC_GROUP(HPBDMAC_M, HPBDMAC0_3, HPBDMAC4_10, HPBDMAC11_18,
+			HPBDMAC19_22, HPBDMAC23_25_27_28), /* 19 */
+	INTC_GROUP(LBSCDMAC_M, LBSCDMAC0, LBSCDMAC1, LBSCDMAC2), /* 18 */
+	INTC_GROUP(RCAN_M, RCAN0, RCAN1, IEBUS), /* 17 */
+	INTC_GROUP(SRC_M, SRC0, SRC1), /* 16 */
+	INTC_GROUP(SCIF_M, SCIF0, SCIF1, SCIF2, SCIF3, SCIF4, SCIF5,
+			HSCIF), /* 14 */
+	INTC_GROUP(LCDC_M, LCDC, MIMLB), /* 13 */
+	INTC_GROUP(_2DG_M, _2DG, RGPVG), /* 12 */
+	INTC_GROUP(VIN_M, VIN0, VIN1), /* 10 */
+	INTC_GROUP(TMU_3_M, TMU30, TMU40, TMU50, TMU51,
+			TMU60, TMU60, TMU70, TMU80), /* 2 */
+	INTC_GROUP(TMU_0_M, TMU00, TMU10, TMU20, TMU21), /* 1 */
+
+	/* Priority group*/
+	INTC_GROUP(RCAN_P, RCAN0, RCAN1), /* INT2PRI5 */
+	INTC_GROUP(LBSCDMAC_P, LBSCDMAC0, LBSCDMAC1), /* INT2PRI5 */
+};
+
+static struct intc_mask_reg mask_registers[] __initdata = {
+	{ 0xFF804040, 0xFF804044, 32, /* INT2MSKRG / INT2MSKCR */
+	  { 0,
+		VEU3F_VE3,
+		SDHI, /* SDHI 0-2 */
+		ADMAC,
+		FLCTL,
+		RESET_WDT,
+		HIF,
+		ADC,
+		MTU2,
+		STIF_M, /* STIF 0,1 */
+		GPIO_M, /* GPIO 0-5*/
+		GETHER,
+		HPBDMAC_M, /* HPBDMAC 0_3 - 23_25_27_28 */
+		LBSCDMAC_M, /* LBSCDMAC 0 - 2 */
+		RCAN_M, /* RCAN, IEBUS */
+		SRC_M,	/* SRC 0,1 */
+		LBSCATA,
+		SCIF_M, /* SCIF 0-5, HSCIF */
+		LCDC_M, /* LCDC, MIMLB */
+		_2DG_M,	/* 2DG, RGPVG */
+		SPI, /* HSPI, RSPI, QSPI */
+		VIN_M,	/* VIN0, 1 */
+		SSI,	/* SSI 0-3 */
+		USB,
+		SHDMAC,
+		HUDI,
+		MMC,
+		RTC,
+		I2C0, /* I2C */ /* I2C 0, 1*/
+		TMU_3_M, /* TMU30 - TMU80 */
+		TMU_0_M, /* TMU00 - TMU21 */
+		DU } },
+};
+
+static struct intc_prio_reg prio_registers[] __initdata = {
+	{ 0xFF804000, 0, 32, 8, /* INT2PRI0 */
+		{ DU, TMU00, TMU10, TMU20 } },
+	{ 0xFF804004, 0, 32, 8, /* INT2PRI1 */
+		{ TMU30, TMU60, RTC, SDHI } },
+	{ 0xFF804008, 0, 32, 8, /* INT2PRI2 */
+		{ HUDI, SHDMAC, USB, SSI } },
+	{ 0xFF80400C, 0, 32, 8, /* INT2PRI3 */
+		{ VIN0, SPI, _2DG, LBSCATA } },
+	{ 0xFF804010, 0, 32, 8, /* INT2PRI4 */
+		{ SCIF0, SCIF3, HSCIF, LCDC } },
+	{ 0xFF804014, 0, 32, 8, /* INT2PRI5 */
+		{ RCAN_P, LBSCDMAC_P, LBSCDMAC2, MMC } },
+	{ 0xFF804018, 0, 32, 8, /* INT2PRI6 */
+		{ HPBDMAC0_3, HPBDMAC4_10, HPBDMAC11_18, HPBDMAC19_22 } },
+	{ 0xFF80401C, 0, 32, 8, /* INT2PRI7 */
+		{ HPBDMAC23_25_27_28, I2C0, SRC0, SRC1 } },
+	{ 0xFF804020, 0, 32, 8, /* INT2PRI8 */
+		{ 0 /* ADIF */, VIN1, RESET_WDT, HIF } },
+	{ 0xFF804024, 0, 32, 8, /* INT2PRI9 */
+		{ ADMAC, FLCTL, GPIO0_3, GPIO4_5 } },
+	{ 0xFF804028, 0, 32, 8, /* INT2PRI10 */
+		{ STIF0, STIF1, VEU3F_VE3, GETHER } },
+	{ 0xFF80402C, 0, 32, 8, /* INT2PRI11 */
+		{ MTU2, RGPVG, MIMLB, IEBUS } },
+};
+
+static DECLARE_INTC_DESC(intc_desc, "sh7734", vectors, groups,
+	mask_registers, prio_registers, NULL);
+
+/* Support for external interrupt pins in IRQ mode */
+
+static struct intc_vect irq3210_vectors[] __initdata = {
+	INTC_VECT(IRQ0, 0x240), INTC_VECT(IRQ1, 0x280),
+	INTC_VECT(IRQ2, 0x2C0), INTC_VECT(IRQ3, 0x300),
+};
+
+static struct intc_sense_reg irq3210_sense_registers[] __initdata = {
+	{ 0xFF80201C, 32, 2, /* ICR1 */
+	{ IRQ0, IRQ1, IRQ2, IRQ3, } },
+};
+
+static struct intc_mask_reg irq3210_ack_registers[] __initdata = {
+	{ 0xFF802024, 0, 32, /* INTREQ */
+	{ IRQ0, IRQ1, IRQ2, IRQ3, } },
+};
+
+static struct intc_mask_reg irq3210_mask_registers[] __initdata = {
+	{ 0xFF802044, 0xFF802064, 32, /* INTMSK0 / INTMSKCLR0 */
+	{ IRQ0, IRQ1, IRQ2, IRQ3, } },
+};
+
+static struct intc_prio_reg irq3210_prio_registers[] __initdata = {
+	{ 0xFF802010, 0, 32, 4, /* INTPRI */
+	{ IRQ0, IRQ1, IRQ2, IRQ3, } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_desc_irq3210, "sh7734-irq3210",
+	irq3210_vectors, NULL,
+	irq3210_mask_registers, irq3210_prio_registers,
+	irq3210_sense_registers, irq3210_ack_registers);
+
+/* External interrupt pins in IRL mode */
+
+static struct intc_vect vectors_irl3210[] __initdata = {
+	INTC_VECT(IRL0_LLLL, 0x200), INTC_VECT(IRL0_LLLH, 0x220),
+	INTC_VECT(IRL0_LLHL, 0x240), INTC_VECT(IRL0_LLHH, 0x260),
+	INTC_VECT(IRL0_LHLL, 0x280), INTC_VECT(IRL0_LHLH, 0x2a0),
+	INTC_VECT(IRL0_LHHL, 0x2c0), INTC_VECT(IRL0_LHHH, 0x2e0),
+	INTC_VECT(IRL0_HLLL, 0x300), INTC_VECT(IRL0_HLLH, 0x320),
+	INTC_VECT(IRL0_HLHL, 0x340), INTC_VECT(IRL0_HLHH, 0x360),
+	INTC_VECT(IRL0_HHLL, 0x380), INTC_VECT(IRL0_HHLH, 0x3a0),
+	INTC_VECT(IRL0_HHHL, 0x3c0),
+};
+
+static DECLARE_INTC_DESC(intc_desc_irl3210, "sh7734-irl3210",
+	vectors_irl3210, NULL, mask_registers, NULL, NULL);
+
+#define INTC_ICR0		0xFF802000
+#define INTC_INTMSK0    0xFF802044
+#define INTC_INTMSK1    0xFF802048
+#define INTC_INTMSKCLR0 0xFF802064
+#define INTC_INTMSKCLR1 0xFF802068
+
+void __init plat_irq_setup(void)
+{
+	/* disable IRQ3-0 */
+	__raw_writel(0xF0000000, INTC_INTMSK0);
+
+	/* disable IRL3-0 */
+	__raw_writel(0x80000000, INTC_INTMSK1);
+
+	/* select IRL mode for IRL3-0 */
+	__raw_writel(__raw_readl(INTC_ICR0) & ~0x00800000, INTC_ICR0);
+
+	/* disable holding function, ie enable "SH-4 Mode (LVLMODE)" */
+	__raw_writel(__raw_readl(INTC_ICR0) | 0x00200000, INTC_ICR0);
+
+	register_intc_controller(&intc_desc);
+}
+
+void __init plat_irq_setup_pins(int mode)
+{
+	switch (mode) {
+	case IRQ_MODE_IRQ3210:
+		/* select IRQ mode for IRL3-0 */
+		__raw_writel(__raw_readl(INTC_ICR0) | 0x00800000, INTC_ICR0);
+		register_intc_controller(&intc_desc_irq3210);
+		break;
+	case IRQ_MODE_IRL3210:
+		/* enable IRL0-3 but don't provide any masking */
+		__raw_writel(0x80000000, INTC_INTMSKCLR1);
+		__raw_writel(0xf0000000, INTC_INTMSKCLR0);
+		break;
+	case IRQ_MODE_IRL3210_MASK:
+		/* enable IRL0-3 and mask using cpu intc controller */
+		__raw_writel(0x80000000, INTC_INTMSKCLR0);
+		register_intc_controller(&intc_desc_irl3210);
+		break;
+	default:
+		BUG();
+	}
+}
-- 
1.7.9.1

