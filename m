From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:45:20 +0000
Subject: [PATCH 1/5] [DEBUG] ARM: shmobile: r8a7791: Disable MSTP clocks during boot
Message-Id: <1397565924-23541-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Each module clock has actually two disable bits: one for the System Core
(ARM) in an SMSTPCRx register, and one for the Realtime Core (SH) in an
RMSTPRx register. Currently we don't touch the bits meant for the
Realtime Core, so some clocks may inadvertently be enabled and still run,
wasting power, while they're disabled in the SMSTPCRx register.
The actual state of the clock is indicated in the corresponding status
register.

In addition, some MSTP clocks may inadvertently be enabled before boot up,
hiding bugs in drivers, and clock / power management core code.

To expose such bugs:
  - Set the disable bits for the Realtime Core for all module clocks,
  - Set the disable bits for the System Core for all module clocks (except
    for INTC_SY, which is always needed, and SCIF0/SCIF1, which may be
    used for a serial console).
This is only done when booted from the System Core.

After this, e.g. QSPI fails to work if we deliberately keep its clock
disabled in the SMSTPCRx register.

Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Move r8a7791_disable_mstp_clocks() call from the end to the start of
    r8a7791_add_dt_devices(),
  - Merge RMSTP and SMSTP disable into a single patch.
v2:
  - Disable all clocks, not just the clocks we use,
  - Clocks are now disabled for both legacy and multi-platform,
  - Clocks are only disabled when booted from the System Core.
---
 arch/arm/mach-shmobile/setup-r8a7791.c |  345 ++++++++++++++++++++++++++++++++
 1 file changed, 345 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 74271c622475..ddb47dab86ff 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -183,8 +183,353 @@ static const struct resource thermal_resources[] __initconst = {
 					thermal_resources,		\
 					ARRAY_SIZE(thermal_resources))
 
+#define MSTP_BASE	0xe6150000
+
+#define MSTPSR0		0xe6150030
+#define MSTPSR1		0xe6150038
+#define MSTPSR2		0xe6150040
+#define MSTPSR3		0xe6150048
+#define MSTPSR4		0xe615004c
+#define MSTPSR5		0xe615003c
+#define MSTPSR6		0xe61501c0
+#define MSTPSR7		0xe61501c4
+#define MSTPSR8		0xe61509a0
+#define MSTPSR9		0xe61509a4
+#define MSTPSR10	0xe61509a8
+#define MSTPSR11	0xe61509ac
+
+#define RMSTPCR0	0xe6150110
+#define RMSTPCR1	0xe6150114
+#define RMSTPCR2	0xe6150118
+#define RMSTPCR3	0xe615011c
+#define RMSTPCR4	0xe6150120
+#define RMSTPCR5	0xe6150124
+#define RMSTPCR6	0xe6150128
+#define RMSTPCR7	0xe615012c
+#define RMSTPCR8	0xe6150980
+#define RMSTPCR9	0xe6150984
+#define RMSTPCR10	0xe6150988
+#define RMSTPCR11	0xe615098c
+
+#define SMSTPCR0	0xe6150130
+#define SMSTPCR1	0xe6150134
+#define SMSTPCR2	0xe6150138
+#define SMSTPCR3	0xe615013c
+#define SMSTPCR4	0xe6150140
+#define SMSTPCR5	0xe6150144
+#define SMSTPCR6	0xe6150148
+#define SMSTPCR7	0xe615014c
+#define SMSTPCR8	0xe6150990
+#define SMSTPCR9	0xe6150994
+#define SMSTPCR10	0xe6150998
+#define SMSTPCR11	0xe615099c
+
+#define MSTP0_INTC_RT			BIT(22)
+#define MSTP0_RTDMAC			BIT(21)
+#define MSTP0_H_UDI			BIT(18)
+#define MSTP0_ARMREG			BIT(11)
+#define MSTP0_MSIOF0			BIT( 0)
+
+#define MSTP1_VSPI1			BIT(31)
+#define MSTP1_VSP1DU0			BIT(28)
+#define MSTP1_VSP1DU1			BIT(27)
+#define MSTP1_TMU0			BIT(25)
+#define MSTP1_CMT0			BIT(24)
+#define MSTP1_TMU2			BIT(22)
+#define MSTP1_TMU3			BIT(21)
+#define MSTP1_FDP0			BIT(19)
+#define MSTP1_FDP1			BIT(18)
+#define MSTP1_2DDMAC			BIT(15)
+#define MSTP1_3DG			BIT(12)
+#define MSTP1_TMU1			BIT(11)
+#define MSTP1_SSP1			BIT( 9)
+#define MSTP1_TSIF0			BIT( 8)
+#define MSTP1_JPU			BIT( 6)
+#define MSTP1_STB			BIT( 4)
+#define MSTP1_VPC0			BIT( 3)
+#define MSTP1_VCP0			BIT( 1)
+
+#define MSTP2_CRYPT_ENGINE		BIT(28)	/* Secure mode only */
+#define MSTP2_SYS_DMAC0			BIT(19)
+#define MSTP2_SYS_DMAC1			BIT(18)
+#define MSTP2_SCIFB2			BIT(16)
+#define MSTP2_MFIS			BIT(13)
+#define MSTP2_MSIOF1			BIT( 8)
+#define MSTP2_SCIFB1			BIT( 7)
+#define MSTP2_SCIFB0			BIT( 6)
+#define MSTP2_MSIOF2			BIT( 5)
+#define MSTP2_SCIFA0			BIT( 4)
+#define MSTP2_SCIFA1			BIT( 3)
+#define MSTP2_SCIFA2			BIT( 2)
+
+#define MSTP3_USBDMAC1			BIT(31)
+#define MSTP3_USBDMAC0			BIT(30)
+#define MSTP3_CMT1			BIT(29)
+#define MSTP3_SSUSB			BIT(28)
+#define MSTP3_IIC1			BIT(23)
+#define MSTP3_PCIEC			BIT(19)
+#define MSTP3_IIC0			BIT(18)
+#define MSTP3_MMC0			BIT(15)
+#define MSTP3_SDHI0			BIT(14)
+#define MSTP3_SDHI1			BIT(12)
+#define MSTP3_SDHI2			BIT(11)
+#define MSTP3_IRDA			BIT(10)
+#define MSTP3_TPU0			BIT( 4)
+
+#define MSTP4_SECURE_UPTIME_CLOCK	BIT(31)	/* Secure mode only */
+#define MSTP4_INTC_SY			BIT( 8)
+#define MSTP4_IRQC			BIT( 7)
+#define MSTP4_DDM			BIT( 6)
+#define MSTP4_RWDT			BIT( 2)
+
+#define MSTP5_SECURE_BOOT_ROM		BIT(30)	/* Secure mode only */
+#define MSTP5_PUBLIC_BOOT_ROM		BIT(26)
+#define MSTP5_PWM			BIT(23)
+#define MSTP5_THERMAL_SENSOR		BIT(22)
+#define MSTP5_SPUV			BIT( 9)
+#define MSTP5_ADSP			BIT( 6)
+#define MSTP5_AUDIO_DMAC0		BIT( 2)
+#define MSTP5_AUDIO_DMAC1		BIT( 1)
+
+#define MSTP7_LVDS0			BIT(26)
+#define MSTP7_DU0			BIT(24)
+#define MSTP7_DU1			BIT(23)
+#define MSTP7_SCIF0			BIT(21)
+#define MSTP7_SCIF1			BIT(20)
+#define MSTP7_SCIF2			BIT(19)
+#define MSTP7_SCIF3			BIT(18)
+#define MSTP7_HSCIF0			BIT(17)
+#define MSTP7_HSCIF1			BIT(16)
+#define MSTP7_SCIF4			BIT(15)
+#define MSTP7_SCIF5			BIT(14)
+#define MSTP7_HSCIF2			BIT(13)
+#define MSTP7_CMM0			BIT(10)
+#define MSTP7_CMM1			BIT( 9)
+#define MSTP7_HSUSB			BIT( 4)
+#define MSTP7_EHCI			BIT( 3)
+
+#define MSTP8_DCU			BIT(30)
+#define MSTP8_IMP_X4			BIT(24)
+#define MSTP8_IMR_LSX2_0		BIT(23)
+#define MSTP8_IMR_LSX2_1		BIT(22)
+#define MSTP8_SATA0			BIT(15)
+#define MSTP8_SATA1			BIT(14)
+#define MSTP8_ETHER			BIT(13)
+#define MSTP8_ETHERAVB			BIT(12)
+#define MSTP8_VIN0			BIT(11)
+#define MSTP8_VIN1			BIT(10)
+#define MSTP8_VIN2			BIT( 9)
+#define MSTP8_RGP2			BIT( 7)
+#define MSTP8_MLBPLUS			BIT( 2)
+#define MSTP8_IPMMU_SGX			BIT( 0)
+
+#define MSTP9_I2C0			BIT(31)
+#define MSTP9_I2C1			BIT(30)
+#define MSTP9_I2C2			BIT(29)
+#define MSTP9_I2C3			BIT(28)
+#define MSTP9_I2C4			BIT(27)
+#define MSTP9_IICDVFS			BIT(26)
+#define MSTP9_I2C5			BIT(25)
+#define MSTP9_MLM			BIT(24)
+#define MSTP9_DTCP			BIT(23)
+#define MSTP9_ADG			BIT(22)
+#define MSTP9_SIM_CARD_IF		BIT(20)
+#define MSTP9_IEBUS			BIT(18)
+#define MSTP9_QSPI			BIT(17)
+#define MSTP9_RCAN0			BIT(16)
+#define MSTP9_RCAN1			BIT(15)
+#define MSTP9_GPIO0			BIT(12)
+#define MSTP9_GPIO1			BIT(11)
+#define MSTP9_GPIO2			BIT(10)
+#define MSTP9_GPIO3			BIT( 9)
+#define MSTP9_GPIO4			BIT( 8)
+#define MSTP9_GPIO5			BIT( 7)
+#define MSTP9_DARC			BIT( 6)
+#define MSTP9_GPIO6			BIT( 5)
+#define MSTP9_GPIO7			BIT( 4)
+#define MSTP9_REMOCON			BIT( 3)
+#define MSTP9_SPEED_PULSE_IF		BIT( 2)
+#define MSTP9_GYRO_ADC_IF		BIT( 1)
+#define MSTP9_GPS			BIT( 0)
+
+#define MSTP10_SCU_SRC0			BIT(31)
+#define MSTP10_SCU_SRC1			BIT(30)
+#define MSTP10_SCU_SRC2			BIT(29)
+#define MSTP10_SCU_SRC3			BIT(28)
+#define MSTP10_SCU_SRC4			BIT(27)
+#define MSTP10_SCU_SRC5			BIT(26)
+#define MSTP10_SCU_SRC6			BIT(25)
+#define MSTP10_SCU_SRC7			BIT(24)
+#define MSTP10_SCU_SRC8			BIT(23)
+#define MSTP10_SCU_SRC9			BIT(22)
+#define MSTP10_SCU_CTU0x_MIX0		BIT(21)
+#define MSTP10_SCU_CTU1x_MIX1		BIT(20)
+#define MSTP10_SCU_DVC0			BIT(19)
+#define MSTP10_SCU_DVC1			BIT(18)
+#define MSTP10_SCU_ALL			BIT(17)	/* Stop bits 31-18 */
+#define MSTP10_SSI0			BIT(15)
+#define MSTP10_SSI1			BIT(14)
+#define MSTP10_SSI2			BIT(13)
+#define MSTP10_SSI3			BIT(12)
+#define MSTP10_SSI4			BIT(11)
+#define MSTP10_SSI5			BIT(10)
+#define MSTP10_SSI6			BIT( 9)
+#define MSTP10_SSI7			BIT( 8)
+#define MSTP10_SSI8			BIT( 7)
+#define MSTP10_SSI9			BIT( 6)
+#define MSTP10_SSI_ALL			BIT( 5)	/* Stop bits 15-6 */
+
+#define MSTP11_SCIFA5			BIT( 8)
+#define MSTP11_SCIFA4			BIT( 7)
+#define MSTP11_SCIFA3			BIT( 6)
+
+
+#define SMSTP0_DISABLE	\
+	MSTP0_INTC_RT | MSTP0_RTDMAC | MSTP0_H_UDI | MSTP0_ARMREG | \
+	MSTP0_MSIOF0
+
+#define SMSTP1_DISABLE	\
+	MSTP1_VSPI1 | MSTP1_VSP1DU0 | MSTP1_VSP1DU1 | MSTP1_TMU0 | \
+	MSTP1_CMT0 | MSTP1_TMU2 | MSTP1_TMU3 | MSTP1_FDP0 | MSTP1_FDP1 | \
+	MSTP1_2DDMAC | MSTP1_3DG | MSTP1_TMU1 | MSTP1_SSP1 | MSTP1_TSIF0 | \
+	MSTP1_JPU | MSTP1_STB | MSTP1_VPC0 | MSTP1_VCP0
+
+#define SMSTP2_DISABLE	\
+	MSTP2_CRYPT_ENGINE | MSTP2_SYS_DMAC0 | MSTP2_SYS_DMAC1 | \
+	MSTP2_SCIFB2 | MSTP2_MFIS | MSTP2_MSIOF1 | MSTP2_SCIFB1 | \
+	MSTP2_SCIFB0 | MSTP2_MSIOF2 | MSTP2_SCIFA0 | MSTP2_SCIFA1 | \
+	MSTP2_SCIFA2
+
+#define SMSTP3_DISABLE	\
+	MSTP3_USBDMAC1 | MSTP3_USBDMAC0 | MSTP3_CMT1 | MSTP3_SSUSB | \
+	MSTP3_IIC1 | MSTP3_PCIEC | MSTP3_IIC0 | MSTP3_MMC0 | MSTP3_SDHI0 | \
+	MSTP3_SDHI1 | MSTP3_SDHI2 | MSTP3_IRDA | MSTP3_TPU0
+
+#define SMSTP4_DISABLE	\
+	MSTP4_SECURE_UPTIME_CLOCK | MSTP4_IRQC | MSTP4_DDM | MSTP4_RWDT
+
+#define SMSTP5_DISABLE	\
+	MSTP5_SECURE_BOOT_ROM | MSTP5_PUBLIC_BOOT_ROM | MSTP5_PWM | \
+	MSTP5_THERMAL_SENSOR | MSTP5_SPUV | MSTP5_ADSP | MSTP5_AUDIO_DMAC0 | \
+	MSTP5_AUDIO_DMAC1
+
+#define SMSTP7_DISABLE	\
+	MSTP7_LVDS0 | MSTP7_DU0 | MSTP7_DU1 | MSTP7_SCIF2 | MSTP7_SCIF3 | \
+	MSTP7_HSCIF0 | MSTP7_HSCIF1 | MSTP7_SCIF4 | MSTP7_SCIF5 | \
+	MSTP7_HSCIF2 | MSTP7_CMM0 | MSTP7_CMM1 | MSTP7_HSUSB | MSTP7_EHCI
+
+#define SMSTP8_DISABLE	\
+	MSTP8_DCU | MSTP8_IMP_X4 | MSTP8_IMR_LSX2_0 | MSTP8_IMR_LSX2_1 | \
+	MSTP8_SATA0 | MSTP8_SATA1 | MSTP8_ETHER | MSTP8_ETHERAVB | \
+	MSTP8_VIN0 | MSTP8_VIN1 | MSTP8_VIN2 | MSTP8_RGP2 | MSTP8_MLBPLUS | \
+	MSTP8_IPMMU_SGX
+
+#define SMSTP9_DISABLE	\
+	MSTP9_I2C0 | MSTP9_I2C1 | MSTP9_I2C2 | MSTP9_I2C3 | MSTP9_I2C4 | \
+	MSTP9_IICDVFS | MSTP9_I2C5 | MSTP9_MLM | MSTP9_DTCP | MSTP9_ADG | \
+	MSTP9_SIM_CARD_IF | MSTP9_IEBUS | MSTP9_QSPI | MSTP9_RCAN0 | \
+	MSTP9_RCAN1 | MSTP9_GPIO0 | MSTP9_GPIO1 | MSTP9_GPIO2 | MSTP9_GPIO3 | \
+	MSTP9_GPIO4 | MSTP9_GPIO5 | MSTP9_DARC | MSTP9_GPIO6 | MSTP9_GPIO7 | \
+	MSTP9_REMOCON | MSTP9_SPEED_PULSE_IF | MSTP9_GYRO_ADC_IF | MSTP9_GPS
+
+#define SMSTP10_DISABLE	\
+	MSTP10_SCU_SRC0 | MSTP10_SCU_SRC1 | MSTP10_SCU_SRC2 | \
+	MSTP10_SCU_SRC3 | MSTP10_SCU_SRC4 | MSTP10_SCU_SRC5 | \
+	MSTP10_SCU_SRC6 | MSTP10_SCU_SRC7 | MSTP10_SCU_SRC8 | \
+	MSTP10_SCU_SRC9 | MSTP10_SCU_CTU0x_MIX0 | MSTP10_SCU_CTU1x_MIX1 | \
+	MSTP10_SCU_DVC0 | MSTP10_SCU_DVC1 | MSTP10_SCU_ALL | MSTP10_SSI0 | \
+	MSTP10_SSI1 | MSTP10_SSI2 | MSTP10_SSI3 | MSTP10_SSI4 | MSTP10_SSI5 | \
+	MSTP10_SSI6 | MSTP10_SSI7 | MSTP10_SSI8 | MSTP10_SSI9 | MSTP10_SSI_ALL
+
+#define SMSTP11_DISABLE	\
+	MSTP11_SCIFA5 | MSTP11_SCIFA4 | MSTP11_SCIFA3
+
+#define RMSTP0_DISABLE	SMSTP0_DISABLE
+#define RMSTP1_DISABLE	SMSTP1_DISABLE
+#define RMSTP2_DISABLE	SMSTP2_DISABLE
+#define RMSTP3_DISABLE	SMSTP3_DISABLE
+#define RMSTP4_DISABLE	SMSTP4_DISABLE | MSTP4_INTC_SY
+#define RMSTP5_DISABLE	SMSTP5_DISABLE
+#define RMSTP7_DISABLE	SMSTP7_DISABLE | MSTP7_SCIF0 | MSTP7_SCIF1
+#define RMSTP8_DISABLE	SMSTP8_DISABLE
+#define RMSTP9_DISABLE	SMSTP9_DISABLE
+#define RMSTP10_DISABLE	SMSTP10_DISABLE
+#define RMSTP11_DISABLE	SMSTP11_DISABLE
+
+struct mstp_disable {
+	unsigned long reg;
+	u32 bits;
+};
+
+static const struct mstp_disable rmstp_disable[] __initconst = {
+	{ RMSTPCR0, RMSTP0_DISABLE },
+	{ RMSTPCR1, RMSTP1_DISABLE },
+	{ RMSTPCR2, RMSTP2_DISABLE },
+	{ RMSTPCR3, RMSTP3_DISABLE },
+	{ RMSTPCR4, RMSTP4_DISABLE },
+	{ RMSTPCR5, RMSTP5_DISABLE },
+	{ RMSTPCR7, RMSTP7_DISABLE },
+	{ RMSTPCR8, RMSTP8_DISABLE },
+	{ RMSTPCR9, RMSTP9_DISABLE },
+	{ RMSTPCR10, RMSTP10_DISABLE },
+	{ RMSTPCR11, RMSTP11_DISABLE },
+};
+
+static const struct mstp_disable smstp_disable[] __initconst = {
+	{ SMSTPCR0, SMSTP0_DISABLE },
+	{ SMSTPCR1, SMSTP1_DISABLE },
+	{ SMSTPCR2, SMSTP2_DISABLE },
+	{ SMSTPCR3, SMSTP3_DISABLE },
+	{ SMSTPCR4, SMSTP4_DISABLE },
+	{ SMSTPCR5, SMSTP5_DISABLE },
+	{ SMSTPCR7, SMSTP7_DISABLE },
+	{ SMSTPCR8, SMSTP8_DISABLE },
+	{ SMSTPCR9, SMSTP9_DISABLE },
+	{ SMSTPCR10, SMSTP10_DISABLE },
+	{ SMSTPCR11, SMSTP11_DISABLE },
+};
+
+static void __init r8a7791_disable_mstp_clocks(void)
+{
+	void __iomem *base, *offset, *reg;
+	unsigned int i;
+
+	/* Do not touch the RMSTP clocks when booted from the Realtime Core */
+	if (rcar_gen2_read_mode_pins() & MD(7)) {
+		pr_warn("Booted from Realtime Core. Skipping MSTP disable\n");
+		return;
+	}
+
+	base = ioremap(MSTP_BASE, 4096);
+	if (!base) {
+		pr_err("Cannot ioremap MSTP regs\n");
+		return;
+	}
+
+	offset = base - MSTP_BASE;
+
+	pr_info("Disabling MSTP clocks for the Realtime Core\n");
+	for (i = 0; i < ARRAY_SIZE(rmstp_disable); i++) {
+		pr_info("  0x%08lx: 0x%08x\n", rmstp_disable[i].reg,
+			rmstp_disable[i].bits);
+		reg = rmstp_disable[i].reg + offset;
+		iowrite32(ioread32(reg) | rmstp_disable[i].bits, reg);
+	}
+
+	pr_info("Disabling MSTP clocks for the System Core\n");
+	for (i = 0; i < ARRAY_SIZE(smstp_disable); i++) {
+		pr_info("  0x%08lx: 0x%08x\n", smstp_disable[i].reg,
+			smstp_disable[i].bits);
+		reg = smstp_disable[i].reg + offset;
+		iowrite32(ioread32(reg) | smstp_disable[i].bits, reg);
+	}
+
+	iounmap(base);
+}
+
 void __init r8a7791_add_dt_devices(void)
 {
+	r8a7791_disable_mstp_clocks();
 	r8a7791_register_scif(0);
 	r8a7791_register_scif(1);
 	r8a7791_register_scif(2);
-- 
1.7.9.5

