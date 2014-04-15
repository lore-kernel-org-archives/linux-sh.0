From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:45:21 +0000
Subject: [PATCH 2/5] [DEBUG] r8a7791: show MSTP clock status during boot-up
Message-Id: <1397565924-23541-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-r8a7791.c |  199 ++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index ddb47dab86ff..d3477d8062ea 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -489,6 +489,201 @@ static const struct mstp_disable smstp_disable[] __initconst = {
 	{ SMSTPCR11, SMSTP11_DISABLE },
 };
 
+#define MSTP_BIT(name, reg)				\
+{							\
+	#name,						\
+	MSTPSR ## reg, RMSTPCR ## reg, SMSTPCR ## reg,	\
+	MSTP ## reg ## _ ## name			\
+}
+
+static const struct mstp_clock {
+	const char *name;
+	unsigned long sr, rc, sc;
+	u32 mask;
+} mstp_clocks[] = {
+	MSTP_BIT(2DDMAC, 1),
+	MSTP_BIT(3DG, 1),
+	MSTP_BIT(ADG, 9),
+	MSTP_BIT(ADSP, 5),
+	MSTP_BIT(ARMREG, 0),
+	MSTP_BIT(AUDIO_DMAC0, 5),
+	MSTP_BIT(AUDIO_DMAC1, 5),
+	MSTP_BIT(CMM0, 7),
+	MSTP_BIT(CMM1, 7),
+	MSTP_BIT(CMT0, 1),
+	MSTP_BIT(CMT1, 3),
+	MSTP_BIT(CRYPT_ENGINE, 2),
+	MSTP_BIT(DARC, 9),
+	MSTP_BIT(DCU, 8),
+	MSTP_BIT(DDM, 4),
+	MSTP_BIT(DTCP, 9),
+	MSTP_BIT(DU0, 7),
+	MSTP_BIT(DU1, 7),
+	MSTP_BIT(EHCI, 7),
+	MSTP_BIT(ETHERAVB, 8),
+	MSTP_BIT(ETHER, 8),
+	MSTP_BIT(FDP0, 1),
+	MSTP_BIT(FDP1, 1),
+	MSTP_BIT(GPIO0, 9),
+	MSTP_BIT(GPIO1, 9),
+	MSTP_BIT(GPIO2, 9),
+	MSTP_BIT(GPIO3, 9),
+	MSTP_BIT(GPIO4, 9),
+	MSTP_BIT(GPIO5, 9),
+	MSTP_BIT(GPIO6, 9),
+	MSTP_BIT(GPIO7, 9),
+	MSTP_BIT(GPS, 9),
+	MSTP_BIT(GYRO_ADC_IF, 9),
+	MSTP_BIT(HSCIF0, 7),
+	MSTP_BIT(HSCIF1, 7),
+	MSTP_BIT(HSCIF2, 7),
+	MSTP_BIT(HSUSB, 7),
+	MSTP_BIT(H_UDI, 0),
+	MSTP_BIT(I2C0, 9),
+	MSTP_BIT(I2C1, 9),
+	MSTP_BIT(I2C2, 9),
+	MSTP_BIT(I2C3, 9),
+	MSTP_BIT(I2C4, 9),
+	MSTP_BIT(I2C5, 9),
+	MSTP_BIT(IEBUS, 9),
+	MSTP_BIT(IIC0, 3),
+	MSTP_BIT(IIC1, 3),
+	MSTP_BIT(IICDVFS, 9),
+	MSTP_BIT(IMP_X4, 8),
+	MSTP_BIT(IMR_LSX2_0, 8),
+	MSTP_BIT(IMR_LSX2_1, 8),
+	MSTP_BIT(INTC_RT, 0),
+	MSTP_BIT(INTC_SY, 4),		// DO NOT DISABLE
+	MSTP_BIT(IPMMU_SGX, 8),
+	MSTP_BIT(IRDA, 3),
+	MSTP_BIT(IRQC, 4),
+	MSTP_BIT(JPU, 1),
+	MSTP_BIT(LVDS0, 7),
+	MSTP_BIT(MFIS, 2),
+	MSTP_BIT(MLBPLUS, 8),
+	MSTP_BIT(MLM, 9),
+	MSTP_BIT(MMC0, 3),
+	MSTP_BIT(MSIOF0, 0),
+	MSTP_BIT(MSIOF1, 2),
+	MSTP_BIT(MSIOF2, 2),
+	MSTP_BIT(PCIEC, 3),
+	MSTP_BIT(PUBLIC_BOOT_ROM, 5),
+	MSTP_BIT(PWM, 5),
+	MSTP_BIT(QSPI, 9),
+	MSTP_BIT(RCAN0, 9),
+	MSTP_BIT(RCAN1, 9),
+	MSTP_BIT(REMOCON, 9),
+	MSTP_BIT(RGP2, 8),
+	MSTP_BIT(RTDMAC, 0),
+	MSTP_BIT(RWDT, 4),
+	MSTP_BIT(SATA0, 8),
+	MSTP_BIT(SATA1, 8),
+	MSTP_BIT(SCIF0, 7),		// May be used by serial console
+	MSTP_BIT(SCIF1, 7),
+	MSTP_BIT(SCIF2, 7),
+	MSTP_BIT(SCIF3, 7),
+	MSTP_BIT(SCIF4, 7),
+	MSTP_BIT(SCIF5, 7),
+	MSTP_BIT(SCIFA0, 2),
+	MSTP_BIT(SCIFA1, 2),
+	MSTP_BIT(SCIFA2, 2),
+	MSTP_BIT(SCIFA3, 11),
+	MSTP_BIT(SCIFA4, 11),
+	MSTP_BIT(SCIFA5, 11),
+	MSTP_BIT(SCIFB0, 2),
+	MSTP_BIT(SCIFB1, 2),
+	MSTP_BIT(SCIFB2, 2),
+	MSTP_BIT(SCU_ALL, 10),
+	MSTP_BIT(SCU_CTU0x_MIX0, 10),
+	MSTP_BIT(SCU_CTU1x_MIX1, 10),
+	MSTP_BIT(SCU_DVC0, 10),
+	MSTP_BIT(SCU_DVC1, 10),
+	MSTP_BIT(SCU_SRC0, 10),
+	MSTP_BIT(SCU_SRC1, 10),
+	MSTP_BIT(SCU_SRC2, 10),
+	MSTP_BIT(SCU_SRC3, 10),
+	MSTP_BIT(SCU_SRC4, 10),
+	MSTP_BIT(SCU_SRC5, 10),
+	MSTP_BIT(SCU_SRC6, 10),
+	MSTP_BIT(SCU_SRC7, 10),
+	MSTP_BIT(SCU_SRC8, 10),
+	MSTP_BIT(SCU_SRC9, 10),
+	MSTP_BIT(SDHI0, 3),
+	MSTP_BIT(SDHI1, 3),
+	MSTP_BIT(SDHI2, 3),
+	MSTP_BIT(SECURE_BOOT_ROM, 5),
+	MSTP_BIT(SECURE_UPTIME_CLOCK, 4),
+	MSTP_BIT(SIM_CARD_IF, 9),
+	MSTP_BIT(SPEED_PULSE_IF, 9),
+	MSTP_BIT(SPUV, 5),
+	MSTP_BIT(SSI0, 10),
+	MSTP_BIT(SSI1, 10),
+	MSTP_BIT(SSI2, 10),
+	MSTP_BIT(SSI3, 10),
+	MSTP_BIT(SSI4, 10),
+	MSTP_BIT(SSI5, 10),
+	MSTP_BIT(SSI6, 10),
+	MSTP_BIT(SSI7, 10),
+	MSTP_BIT(SSI8, 10),
+	MSTP_BIT(SSI9, 10),
+	MSTP_BIT(SSI_ALL, 10),
+	MSTP_BIT(SSP1, 1),
+	MSTP_BIT(SSUSB, 3),
+	MSTP_BIT(STB, 1),
+	MSTP_BIT(SYS_DMAC0, 2),
+	MSTP_BIT(SYS_DMAC1, 2),
+	MSTP_BIT(THERMAL_SENSOR, 5),
+	MSTP_BIT(TMU0, 1),
+	MSTP_BIT(TMU1, 1),
+	MSTP_BIT(TMU2, 1),
+	MSTP_BIT(TMU3, 1),
+	MSTP_BIT(TPU0, 3),
+	MSTP_BIT(TSIF0, 1),
+	MSTP_BIT(USBDMAC0, 3),
+	MSTP_BIT(USBDMAC1, 3),
+	MSTP_BIT(VCP0, 1),
+	MSTP_BIT(VIN0, 8),
+	MSTP_BIT(VIN1, 8),
+	MSTP_BIT(VIN2, 8),
+	MSTP_BIT(VPC0, 1),
+	MSTP_BIT(VSP1DU0, 1),
+	MSTP_BIT(VSP1DU1, 1),
+	MSTP_BIT(VSPI1, 1),
+};
+
+void r8a7791_show_mstp_clocks(struct seq_file *m)
+{
+	void __iomem *base, *offset;
+	unsigned int i;
+
+	base = ioremap(MSTP_BASE, 4096);
+	if (!base) {
+		pr_err("Cannot ioremap MSTP regs\n");
+		return;
+	}
+
+	offset = base - MSTP_BASE;
+
+	for (i = 0; i < ARRAY_SIZE(mstp_clocks); i++) {
+		u32 sr, rc, sc, mask;
+		sr = ioread32(mstp_clocks[i].sr + offset);
+		mask = mstp_clocks[i].mask;
+		if (sr & mask)
+			continue;
+		rc = ioread32(mstp_clocks[i].rc + offset);
+		sc = ioread32(mstp_clocks[i].sc + offset);
+		if (m)
+			seq_printf(m, "%-20s: %c %c\n", mstp_clocks[i].name,
+				   rc & mask ? '.' : 'R',
+				   sc & mask ? '.' : 'S');
+		else
+			pr_info("%-20s: %c %c\n", mstp_clocks[i].name,
+				rc & mask ? '.' : 'R', sc & mask ? '.' : 'S');
+	}
+
+	iounmap(base);
+}
+
 static void __init r8a7791_disable_mstp_clocks(void)
 {
 	void __iomem *base, *offset, *reg;
@@ -508,6 +703,8 @@ static void __init r8a7791_disable_mstp_clocks(void)
 
 	offset = base - MSTP_BASE;
 
+	r8a7791_show_mstp_clocks(NULL);
+
 	pr_info("Disabling MSTP clocks for the Realtime Core\n");
 	for (i = 0; i < ARRAY_SIZE(rmstp_disable); i++) {
 		pr_info("  0x%08lx: 0x%08x\n", rmstp_disable[i].reg,
@@ -524,6 +721,8 @@ static void __init r8a7791_disable_mstp_clocks(void)
 		iowrite32(ioread32(reg) | smstp_disable[i].bits, reg);
 	}
 
+	r8a7791_show_mstp_clocks(NULL);
+
 	iounmap(base);
 }
 
-- 
1.7.9.5

