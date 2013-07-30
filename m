From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 30 Jul 2013 17:57:25 +0000
Subject: [RFC 3/5] arm: shmobile: KZM9G zboot support (not working)
Message-Id: <1375207047-8655-4-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a more or less literal translation of the low-level setup code
from u-boot, where it works perfectly fine. When booting via the mask
ROM USB loader, however, the DRAM is flaky: many consecutive writes
(usually a couple of MB) bring the system to a halt.
---
 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt |  680 ++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/zboot.h        |    6 +
 2 files changed, 686 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt

diff --git a/arch/arm/mach-shmobile/include/mach/head-kzm9g.txt b/arch/arm/mach-shmobile/include/mach/head-kzm9g.txt
new file mode 100644
index 0000000..09177bb
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/head-kzm9g.txt
@@ -0,0 +1,680 @@
+/* lifted from u-boot */
+
+/*
+ * Copyright (C) 2012 Nobuhiro Iwamatsu <nobuhiro.Iwamatsu.yj@renesas.com>
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+//#include <config.h>
+//#include <asm/macro.h>
+
+/* Global Timer */
+#define GLOBAL_TIMER_BASE_ADDR	(0xF0000200)
+#define MERAM_BASE	(0xE5580000)
+
+/* GIC */
+#define GIC_BASE	(0xF0000100)
+#define ICCICR		(GIC_BASE + 0x000)
+#define ICCPMR		(GIC_BASE + 0x004)
+
+/* Secure control register */
+#define LIFEC_SEC_SRC	(0xE6110008)
+
+/* RWDT */
+#define	RWDT_BASE   (0xE6020000)
+#define	RWTCSRA0	(RWDT_BASE + 0x04)
+#define	RWTCSRB0	(RWDT_BASE + 0x08)
+
+/* HPB Semaphore Control Registers */
+#define HPBSCR_BASE	(0xE6000000)
+#define HPBCTRL0	(HPBSCR_BASE + 0x1010)
+#define HPBCTRL1	(HPBSCR_BASE + 0x1014)
+#define HPBCTRL2	(HPBSCR_BASE + 0x1018)
+#define CCCR		(HPBSCR_BASE + 0x101C)
+#define HPBCTRL4	(HPBSCR_BASE + 0x1024)
+#define HPBCTRL5	(HPBSCR_BASE + 0x1028)
+#define HPBCTRL6	(HPBSCR_BASE + 0x1030)
+#define MPSRC		(HPBSCR_BASE + 0x1600)
+#define	MPACCTL		(HPBSCR_BASE + 0x1604)
+#define	SMGPIOSRC	(HPBSCR_BASE + 0x1820)
+#define	SMGPIOERR	(HPBSCR_BASE + 0x1824)
+#define	SMGPIOTIME	(HPBSCR_BASE + 0x1628)
+#define	SMGPIOCNT	(HPBSCR_BASE + 0x182C)
+#define	SMCMT2SRC	(HPBSCR_BASE + 0x1840)
+#define	SMCMT2ERR	(HPBSCR_BASE + 0x1844)
+#define	SMCMT2TIME	(HPBSCR_BASE + 0x1648)
+#define	SMCMT2CNT	(HPBSCR_BASE + 0x184C)
+#define	SMCPGSRC	(HPBSCR_BASE + 0x1850)
+#define	SMCPGERR	(HPBSCR_BASE + 0x1854)
+#define	SMCPGTIME	(HPBSCR_BASE + 0x1658)
+#define	SMCPGCNT	(HPBSCR_BASE + 0x185C)
+#define	SMSYSCSRC	(HPBSCR_BASE + 0x1870)
+#define	SMSYSCERR	(HPBSCR_BASE + 0x1874)
+#define	SMSYSCTIME	(HPBSCR_BASE + 0x1678)
+#define	SMSYSCCNT	(HPBSCR_BASE + 0x187C)
+
+#define SBSC1_BASE  (0xFE400000)
+#define	SDCR0A		(SBSC1_BASE + 0x0008)
+#define	SDCR1A		(SBSC1_BASE + 0x000C)
+#define	SDPCRA		(SBSC1_BASE + 0x0010)
+#define	SDCR0SA		(SBSC1_BASE + 0x0018)
+#define	SDCR1SA		(SBSC1_BASE + 0x001C)
+#define	RTCSRA		(SBSC1_BASE + 0x0020)
+#define	RTCORA		(SBSC1_BASE + 0x0028)
+#define	RTCORHA		(SBSC1_BASE + 0x002C)
+#define	RTCORSA		(SBSC1_BASE + 0x0030)
+#define	RTCORSHA	(SBSC1_BASE + 0x0034)
+#define	SDWCRC0A	(SBSC1_BASE + 0x0040)
+#define	SDWCRC1A	(SBSC1_BASE + 0x0044)
+#define	SDWCR00A	(SBSC1_BASE + 0x0048)
+#define	SDWCR01A	(SBSC1_BASE + 0x004C)
+#define	SDWCR10A	(SBSC1_BASE + 0x0050)
+#define	SDWCR11A	(SBSC1_BASE + 0x0054)
+#define	SDPDCR0A	(SBSC1_BASE + 0x0058)
+#define	SDWCR2A		(SBSC1_BASE + 0x0060)
+#define	SDWCRC2A	(SBSC1_BASE + 0x0064)
+#define	ZQCCRA		(SBSC1_BASE + 0x0068)
+#define	SDMRACR0A	(SBSC1_BASE + 0x0084)
+#define	SDMRTMPCRA	(SBSC1_BASE + 0x008C)
+#define	SDMRTMPMSKA	(SBSC1_BASE + 0x0094)
+#define	SDGENCNTA	(SBSC1_BASE + 0x009C)
+#define	SDDRVCR0A	(SBSC1_BASE + 0x00B4)
+#define	SDPTDIVCR0A	(SBSC1_BASE + 0x00F0)
+#define	SDPTDIVCR1A	(SBSC1_BASE + 0x00F4)
+#define	SDPTDIVCR2A	(SBSC1_BASE + 0x00F8)
+#define	SDPTCR0A	(SBSC1_BASE + 0x0100)
+#define	SDPTCR1A	(SBSC1_BASE + 0x0104)
+#define	SDPTCR2A	(SBSC1_BASE + 0x0108)
+#define	SDPTCR3A	(SBSC1_BASE + 0x010C)
+#define	DLLCNT0A	(SBSC1_BASE + 0x0354)
+#define	SDMRA1		(0xFE500000)
+#define	SDMRA2		(0xFE5C0000)
+#define	SDMRA3		(0xFE504000)
+
+#define SBSC2_BASE  (0xFB400000)
+#define	SDCR0B		(SBSC2_BASE + 0x0008)
+#define	SDCR1B		(SBSC2_BASE + 0x000C)
+#define	SDPCRB		(SBSC2_BASE + 0x0010)
+#define	SDCR0SB		(SBSC2_BASE + 0x0018)
+#define	SDCR1SB		(SBSC2_BASE + 0x001C)
+#define	RTCSRB		(SBSC2_BASE + 0x0020)
+#define	RTCORB		(SBSC2_BASE + 0x0028)
+#define	RTCORHB		(SBSC2_BASE + 0x002C)
+#define	RTCORSB		(SBSC2_BASE + 0x0030)
+#define	RTCORSHB	(SBSC2_BASE + 0x0034)
+#define	SDWCRC0B	(SBSC2_BASE + 0x0040)
+#define	SDWCRC1B	(SBSC2_BASE + 0x0044)
+#define	SDWCR00B	(SBSC2_BASE + 0x0048)
+#define	SDWCR01B	(SBSC2_BASE + 0x004C)
+#define	SDWCR10B	(SBSC2_BASE + 0x0050)
+#define	SDWCR11B	(SBSC2_BASE + 0x0054)
+#define	SDPDCR0B	(SBSC2_BASE + 0x0058)
+#define	SDWCR2B		(SBSC2_BASE + 0x0060)
+#define	SDWCRC2B	(SBSC2_BASE + 0x0064)
+#define	ZQCCRB		(SBSC2_BASE + 0x0068)
+#define	SDMRACR0B	(SBSC2_BASE + 0x0084)
+#define	SDMRTMPCRB	(SBSC2_BASE + 0x008C)
+#define	SDMRTMPMSKB	(SBSC2_BASE + 0x0094)
+#define	SDGENCNTB	(SBSC2_BASE + 0x009C)
+#define	DPHYCNT0B	(SBSC2_BASE + 0x00A0)
+#define	DPHYCNT1B	(SBSC2_BASE + 0x00A4)
+#define	DPHYCNT2B	(SBSC2_BASE + 0x00A8)
+#define	SDDRVCR0B	(SBSC2_BASE + 0x00B4)
+#define	SDPTDIVCR0B	(SBSC2_BASE + 0x00F0)
+#define	SDPTDIVCR1B	(SBSC2_BASE + 0x00F4)
+#define	SDPTDIVCR2B	(SBSC2_BASE + 0x00F8)
+#define	SDPTCR0B	(SBSC2_BASE + 0x0100)
+#define	SDPTCR1B	(SBSC2_BASE + 0x0104)
+#define	SDPTCR2B	(SBSC2_BASE + 0x0108)
+#define	SDPTCR3B	(SBSC2_BASE + 0x010C)
+#define	DLLCNT0B	(SBSC2_BASE + 0x0354)
+#define	SDMRB1		(0xFB500000)
+#define	SDMRB2		(0xFB5C0000)
+#define	SDMRB3		(0xFB504000)
+
+#define CPG_BASE   (0xE6150000)
+#define	FRQCRA	(CPG_BASE + 0x0000)
+#define	FRQCRB	(CPG_BASE + 0x0004)
+#define	FRQCRD	(CPG_BASE + 0x00E4)
+#define	VCLKCR1	(CPG_BASE + 0x0008)
+#define	VCLKCR2	(CPG_BASE + 0x000C)
+#define	VCLKCR3	(CPG_BASE + 0x001C)
+#define	ZBCKCR	(CPG_BASE + 0x0010)
+#define	FLCKCR	(CPG_BASE + 0x0014)
+#define	SD0CKCR	(CPG_BASE + 0x0074)
+#define	SD1CKCR	(CPG_BASE + 0x0078)
+#define	SD2CKCR	(CPG_BASE + 0x007C)
+#define	FSIACKCR	(CPG_BASE + 0x0018)
+#define	FSIBCKCR	(CPG_BASE + 0x0090)
+#define	PLL1CR	(CPG_BASE + 0x0028)
+#define	PLL2CR	(CPG_BASE + 0x002C)
+#define	SUBCKCR	(CPG_BASE + 0x0080)
+#define	SPUACKCR	(CPG_BASE + 0x0084)
+#define	SPUVCKCR	(CPG_BASE + 0x0094)
+#define	MSUCKCR	(CPG_BASE + 0x0088)
+#define	HSICKCR	(CPG_BASE + 0x008C)
+#define	FSIBCKCR	(CPG_BASE + 0x0090)
+#define	MFCK1CR	(CPG_BASE + 0x0098)
+#define	MFCK2CR	(CPG_BASE + 0x009C)
+#define	DSITCKCR	(CPG_BASE + 0x0060)
+#define	DSI0PCKCR	(CPG_BASE + 0x0064)
+#define	DSI1PCKCR	(CPG_BASE + 0x0068)
+#define	DSI0PHYCR	(CPG_BASE + 0x006C)
+#define	DSI1PHYCR	(CPG_BASE + 0x0070)
+#define	DVFSCR0	(CPG_BASE + 0x0058)
+#define	DVFSCR1	(CPG_BASE + 0x005C)
+#define	DVFSCR2	(CPG_BASE + 0x0170)
+#define	DVFSCR3	(CPG_BASE + 0x0174)
+#define	DVFSCR4	(CPG_BASE + 0x0178)
+#define	DVFSCR5	(CPG_BASE + 0x017C)
+#define	MPMODE	(CPG_BASE + 0x00CC)
+
+#define RTSTBCR (CPG_BASE + 0x0020)
+#define	SYSTBCR	(CPG_BASE + 0x0024)
+#define	PLLECR	(CPG_BASE + 0x00D0)
+#define	PLL0CR	(CPG_BASE + 0x00D8)
+#define	PLL1CR	(CPG_BASE + 0x0028)
+#define	PLL2CR	(CPG_BASE + 0x002C)
+#define	PLL3CR	(CPG_BASE + 0x00DC)
+#define	PLL0STPCR	(CPG_BASE + 0x00F0)
+#define	PLL1STPCR	(CPG_BASE + 0x00C8)
+#define	PLL2STPCR	(CPG_BASE + 0x00F8)
+#define	PLL3STPCR	(CPG_BASE + 0x00FC)
+#define	MSTPSR0 (CPG_BASE + 0x0030)
+#define	MSTPSR1 (CPG_BASE + 0x0038)
+#define	MSTPSR2 (CPG_BASE + 0x0040)
+#define	MSTPSR3 (CPG_BASE + 0x0048)
+#define	MSTPSR4 (CPG_BASE + 0x004C)
+#define	MSTPSR5 (CPG_BASE + 0x003C)
+#define	RMSTPCR0	(CPG_BASE + 0x0110)
+#define	RMSTPCR1	(CPG_BASE + 0x0114)
+#define	RMSTPCR2	(CPG_BASE + 0x0118)
+#define	RMSTPCR3	(CPG_BASE + 0x011C)
+#define	RMSTPCR4	(CPG_BASE + 0x0120)
+#define	RMSTPCR5	(CPG_BASE + 0x0124)
+#define	SMSTPCR0	(CPG_BASE + 0x0130)
+#define	SMSTPCR1	(CPG_BASE + 0x0134)
+#define	SMSTPCR2	(CPG_BASE + 0x0138)
+#define	SMSTPCR3	(CPG_BASE + 0x013C)
+#define	SMSTPCR4	(CPG_BASE + 0x0140)
+#define	SMSTPCR5	(CPG_BASE + 0x0144)
+#define	CPGXXCR4	(CPG_BASE + 0x0150)
+#define	SRCR0	(CPG_BASE + 0x80A0)
+#define	SRCR1	(CPG_BASE + 0x80A8)
+#define	SRCR2	(CPG_BASE + 0x80B0)
+#define	SRCR3	(CPG_BASE + 0x80A8)
+#define	SRCR4	(CPG_BASE + 0x80BC)
+#define	SRCR5	(CPG_BASE + 0x80C4)
+#define	ASTAT	(CPG_BASE + 0x8054)
+#define	CKSCR	(CPG_BASE + 0x00C0)
+#define	VREFCR	(CPG_BASE + 0x00EC)
+#define WUPCR	(CPG_BASE + 0x1010)
+#define SRESCR	(CPG_BASE + 0x1018)
+#define PCLKCR	(CPG_BASE + 0x1020)
+
+/* BSC */
+#define BSC_BASE	(0xFEC10000)
+#define	CMNCR		BSC_BASE
+#define	CS0BCR		(BSC_BASE + 0x04)
+#define	CS2BCR		(BSC_BASE + 0x08)
+#define	CS4BCR		(BSC_BASE + 0x10)
+#define	CS5ABCR		(BSC_BASE + 0x14)
+#define	CS5BBCR		(BSC_BASE + 0x18)
+#define	CS6ABCR		(BSC_BASE + 0x1c)
+#define	CS6BBCR		(BSC_BASE + 0x20)
+#define	CS0WCR		(BSC_BASE + 0x24)
+#define	CS2WCR		(BSC_BASE + 0x28)
+#define	CS4WCR		(BSC_BASE + 0x30)
+#define	CS5AWCR		(BSC_BASE + 0x34)
+#define	CS5BWCR		(BSC_BASE + 0x38)
+#define	CS6AWCR		(BSC_BASE + 0x3C)
+#define	CS6BWCR		(BSC_BASE + 0x40)
+
+/* SCIF */
+#define SCIF0_BASE	(0xE6C40000)
+#define SCIF1_BASE	(0xE6C50000)
+#define SCIF2_BASE	(0xE6C60000)
+#define SCIF3_BASE	(0xE6C70000)
+#define SCIF4_BASE	(0xE6C80000)
+#define SCIF5_BASE	(0xE6CB0000)
+#define SCIF6_BASE	(0xE6CC0000)
+#define SCIF7_BASE	(0xE6CD0000)
+
+/* loop until a value was compare */
+.macro cmp_loop, addr, data, cmp
+	ldr	r0, =\addr
+	ldr	r1, =\data
+	ldr	r2, =\cmp
+2:
+	ldr	r3, [r0, #0]
+	and	r3, r1, r3
+	cmp	r2, r3
+	bne	2b
+.endm
+
+/* read value from addr, and calc OR with data */
+.macro or_write32, addr, data
+	ldr r4, =\addr
+	ldr r5, =\data
+	ldr r6, [r4]
+	orr r5, r6, r5
+	str r5, [r4]
+.endm
+
+/* read value from addr, and calc AND with data */
+.macro and_write32, addr, data
+	ldr r4, 1f
+	ldr r5, 2f
+	ldr r6, [r4]
+	and r5, r6, r5
+	str r5, [r4]
+	b	3f
+1:	.long \addr
+2:	.long \data
+3:
+.endm
+
+lowlevel_init:
+	/* revert mask rom cache settings; no effect */
+	//mrc	p15, 0, r0, c1, c0, 0
+	//and	r2, r2, #~(0x1800)
+	//mcr	p15, 0, r0, c1, c0, 0
+
+	ldr		r0, =MERAM_BASE
+	mov		r1, #0x0
+	str		r1, [r0]
+
+	mrc		p15, 0, r0, c0, c0, 5
+	ands	r0, r0, #0xF
+	beq		lowlevel_init__
+	b		wait_interrupt
+
+	.pool
+	.align 4
+
+wait_interrupt:
+	ldr     r1, =ICCICR
+	mov     r2, #0x0
+	str     r2, [r1]
+	mov     r2, #0xF0
+	ldr     r1, =ICCPMR
+	str     r2, [r1]
+	ldr     r1, =ICCICR
+	mov     r2, #0x1
+	str     r2, [r1]
+
+wait_loop:
+	wfi
+
+	ldr		r2, [r1, #0xC]
+	str		r2, [r1, #0x10]
+
+	ldr		r0, =MERAM_BASE
+	ldr		r2, [r0]
+	cmp		r2, #0
+	movne	pc, r2
+
+	b		wait_loop
+
+wait_loop_end:
+	.pool
+	.align 4
+
+lowlevel_init__:
+
+#if 1
+	mov r0, #0x200000
+
+loop0:
+	subs r0, r0, #1
+	bne  loop0
+#endif
+
+	EW	RWTCSRA0, 0xA507
+	.pool
+
+	/* revert mask ROM settings; no observable effect */
+	ED	0xe6050018, 0xe3a1a111	/* PORT24CR */
+	ED	SUBCKCR, 0x8080
+
+	//and_write32	LIFEC_SEC_SRC, 0xFFFFFFE7	/* old u-boot */
+	and_write32	LIFEC_SEC_SRC, 0xFFFF7FFF	/* u-boot upstream */
+
+	and_write32	SMSTPCR3,0xFFFF7FFF
+	and_write32	SRCR3, 0xFFFF7FFF
+	and_write32	SMSTPCR2,0xFFFBFFFF
+	and_write32	SRCR2, 0xFFFBFFFF
+	ED		PLLECR, 0x00000000
+
+	cmp_loop	PLLECR, 0x00000F00, 0x00000000
+	cmp_loop	FRQCRB, 0x80000000, 0x00000000
+
+	ED		PLL0CR, 0x2D000000
+	ED		PLL1CR, 0x17100000
+	ED		FRQCRB, 0x96235880
+	cmp_loop	FRQCRB, 0x80000000, 0x00000000
+
+	ED		FLCKCR, 0x0000000B
+	and_write32	SMSTPCR0, 0xFFFFFFFD
+
+	and_write32	SRCR0, 0xFFFFFFFD
+	ED		SMGPIOTIME, 0x00000514
+	ED		SMCMT2TIME, 0x00000514
+	ED		SMCPGTIME, 0x00000514
+	ED		SMSYSCTIME, 0x00000514
+
+	ED		DVFSCR4, 0x00092000
+	ED		DVFSCR5, 0x000000DC
+	ED		PLLECR, 0x00000000
+	cmp_loop	PLLECR, 0x00000F00, 0x00000000
+
+	ED		FRQCRA, 0x0012453C
+	//ED		FRQCRB, 0x80331350
+	ED		FRQCRB, 0x80431350	/* u-boot upstream */
+	cmp_loop	FRQCRB, 0x80000000, 0x00000000
+	ED		FRQCRD, 0x00000B0B
+	cmp_loop	FRQCRD, 0x80000000, 0x00000000
+
+	ED		PCLKCR, 0x00000003
+	ED		VCLKCR1, 0x0000012F
+	ED		VCLKCR2, 0x00000119
+	ED		VCLKCR3, 0x00000119
+	ED		ZBCKCR, 0x00000002
+	//ED		ZBCKCR, 0x00000003	/* higher BSC clock divider */
+	ED		FLCKCR, 0x00000005
+	ED		SD0CKCR, 0x00000080
+	ED		SD1CKCR, 0x00000080
+	ED		SD2CKCR, 0x00000080
+	ED		FSIACKCR, 0x0000003F
+	ED		FSIBCKCR, 0x0000003F
+	ED		SUBCKCR, 0x00000080
+	ED		SPUACKCR, 0x0000000B
+	ED		SPUVCKCR, 0x0000000B
+	ED		MSUCKCR, 0x0000013F
+	ED		HSICKCR, 0x00000080
+	ED		MFCK1CR, 0x0000003F
+	ED		MFCK2CR, 0x0000003F
+	ED		DSITCKCR, 0x00000107
+	ED		DSI0PCKCR, 0x00000313
+	ED		DSI1PCKCR, 0x0000130D
+	ED		DSI0PHYCR, 0x2A800E0E
+	ED		PLL0CR, 0x1E000000
+	ED		PLL0CR, 0x2D000000
+	ED		PLL1CR, 0x17100000
+	ED		PLL2CR, 0x27000080
+	ED		PLL3CR, 0x1D000000
+	ED		PLL0STPCR, 0x00080000
+	ED		PLL1STPCR, 0x000120C0
+	ED		PLL2STPCR, 0x00012000
+	ED		PLL3STPCR, 0x00000030
+	ED		PLLECR, 0x0000000B
+	cmp_loop	PLLECR, 0x00000B00, 0x00000B00
+
+	ED		DVFSCR3, 0x000120F0
+	ED		MPMODE, 0x00000020
+	ED		VREFCR, 0x0000028A
+	ED		RMSTPCR0, 0xE4628087
+	ED		RMSTPCR1, 0xFFFFFFFF
+	ED		RMSTPCR2, 0x53FFFFFF
+	ED		RMSTPCR3, 0xFFFFFFFF
+	ED		RMSTPCR4, 0x00800D3D
+	ED		RMSTPCR5, 0xFFFFF3FF
+	ED		SMSTPCR2, 0x00000000
+	ED		SRCR2, 	0x00040000
+	and_write32	PLLECR,	0xFFFFFFF7
+	cmp_loop	PLLECR,	0x00000800, 0x00000000
+
+	/* set SBSC operational */
+	ED		HPBCTRL6, 0x00000001
+	cmp_loop	HPBCTRL6, 0x00000001, 0x00000001
+
+	/* set SBSC operating frequency */
+	ED		FRQCRD, 0x00001414
+	cmp_loop	FRQCRD, 0x80000000, 0x00000000
+	ED		PLL3CR, 0x1D000000
+	or_write32	PLLECR, 0x00000008
+	cmp_loop	PLLECR, 0x00000800, 0x00000800
+
+	/* enable DLL oscillation in DDRPHY */
+	or_write32	DLLCNT0A, 0x00000002
+	//ED		DLLCNT0A, 0x00030001	/* DLL osc. always on */
+
+	/* wait >= 100 ns */
+	ED		SDGENCNTA, 0x00000005
+	//ED		SDGENCNTA, 0x0000000A
+	cmp_loop	SDGENCNTA, 0xFFFFFFFF, 0x00000000
+
+	/* target LPDDR2 device settings */
+	ED		SDCR0A,	0xACC90159
+	ED		SDCR1A,	0x00010059
+	ED		SDWCRC0A, 0x50874114
+	//ED		SDWCRC0A, 0x50FF7337	/* maximum relax */
+	ED		SDWCRC1A, 0x33199B37
+	//ED		SDWCRC1A, 0x7F3FFF7F	/* maximum relax */
+	ED		SDWCRC2A, 0x008F2313
+	//ED		SDWCRC2A, 0x00FFFFFF	/* maximum relax */
+	ED		SDWCR00A, 0x31020707
+	//ED		SDWCR00A, 0x71F3CF7F	/* maximum relax */
+	ED		SDWCR01A, 0x0017040A
+	//ED		SDWCR01A, 0x001F070F	/* maximum relax */
+	ED		SDWCR10A, 0x31020707
+	//ED		SDWCR10A, 0x71F3CF7F	/* maximum relax */
+	ED		SDWCR11A, 0x0017040A
+	//ED		SDWCR11A, 0x001F070F	/* maximum relax */
+
+	//ED		SDDRVCR0A, 0x05555555
+	ED		SDDRVCR0A, 0x055557ff	/* u-boot upstream */
+	//ED		SDDRVCR0A, 0x0FFFFFFF	/* maximum drivability */
+
+	ED		SDWCR2A, 0x30000000
+
+	/* drive CKE high */
+	or_write32	SDPCRA,	0x00000080
+	cmp_loop	SDPCRA,	0x00000080, 0x00000080
+
+	/* wait >= 200 us */
+	ED		SDGENCNTA, 0x00002710
+	//ED		SDGENCNTA, 0x00004E20
+	cmp_loop	SDGENCNTA, 0xFFFFFFFF, 0x00000000
+
+	/* issue reset command to LPDDR2 device */
+	ED		SDMRACR0A, 0x0000003F
+	ED		SDMRA1,	0x00000000
+
+	/* wait >= 10 (or 1) us (docs inconsistent) */
+	ED		SDGENCNTA, 0x000001F4
+	//ED		SDGENCNTA, 0x000003E8
+	cmp_loop	SDGENCNTA, 0xFFFFFFFF, 0x00000000
+
+	/* MRW ZS initialization calibration command */
+	ED		SDMRACR0A, 0x0000FF0A
+	ED		SDMRA3,	0x00000000
+
+	/* wait >= 1 us */
+	ED		SDGENCNTA, 0x00000032
+	//ED		SDGENCNTA, 0x00000064
+	cmp_loop	SDGENCNTA, 0xFFFFFFFF, 0x00000000
+
+	/* specify operating mode in LPDDR2 */
+	ED		SDMRACR0A, 0x00002201
+	ED		SDMRA1,	0x00000000
+	ED		SDMRACR0A, 0x00000402
+	ED		SDMRA1,	0x00000000
+	//ED		SDMRACR0A, 0x00000403
+	ED		SDMRACR0A, 0x00000203	/* upstream u-boot */
+	ED		SDMRA1,	0x00000000
+
+	/* initialize DDR interface */
+	ED		SDMRA2,	0x00000000
+
+	/* temperature sensor control */
+	ED		SDMRTMPCRA, 0x88800004
+	ED		SDMRTMPMSKA,0x00000004
+
+	/* auto-refreshing control */
+	ED		RTCORA,	0xA55A0032
+	//ED		RTCORA,	0xA55A0012	/* max refresh */
+	ED		RTCORHA, 0xA55A000C
+	//ED		RTCORHA, 0xA55A0006	/* max refresh */
+	ED		RTCSRA,	0xA55A2048
+	//ED		RTCSRA,	0xA55A200C	/* max refresh */
+	//ED		RTCSRA, 0xa55a0048	/* TMPEN = 0 */
+
+	or_write32	SDCR0A,	0x00000800
+	or_write32	SDCR1A,	0x00000400
+
+	/* auto ZQ calibration control */
+	ED		ZQCCRA,	0xFFF20000
+	//ED		ZQCCRA,	0x7FF30000	/* max calib */
+
+	or_write32	DLLCNT0B, 0x00000002
+	ED		SDGENCNTB, 0x00000005
+	//ED		SDGENCNTB, 0x0000000A
+	cmp_loop	SDGENCNTB, 0xFFFFFFFF, 0x00000000
+
+	ED		SDCR0B, 0xACC90159
+	ED		SDCR1B, 0x00010059
+	ED		SDWCRC0B, 0x50874114
+	//ED		SDWCRC0B, 0x50FF7337	/* maximum relax */
+	ED		SDWCRC1B, 0x33199B37
+	//ED		SDWCRC1B, 0x7F3FFF7F	/* maximum relax */
+	ED		SDWCRC2B, 0x008F2313
+	ED		SDWCR00B, 0x31020707
+	ED		SDWCR01B, 0x0017040A
+	ED		SDWCR10B, 0x31020707
+	ED		SDWCR11B, 0x0017040A
+	//ED		SDDRVCR0B, 0x05555555
+	ED		SDDRVCR0B, 0x055557ff	/* upstream u-boot */
+	ED		SDWCR2B, 0x30000000
+	or_write32	SDPCRB, 0x00000080
+	cmp_loop	SDPCRB, 0x00000080, 0x00000080
+
+	ED		SDGENCNTB, 0x00002710
+	//ED		SDGENCNTB, 0x00004E20
+	cmp_loop		SDGENCNTB, 0xFFFFFFFF, 0x00000000
+	ED		SDMRACR0B, 0x0000003F
+	/* upstream u-boot writes to SDMRA1A for both SBSC 1 and 2; doesn't
+           seem to make a lot of sense... */
+	ED		SDMRB1, 0x00000000	
+	//ED		SDMRA1, 0x00000000
+
+	ED		SDGENCNTB, 0x000001F4
+	//ED		SDGENCNTB, 0x000003E8
+	cmp_loop	SDGENCNTB, 0xFFFFFFFF, 0x00000000
+
+	ED		SDMRACR0B, 0x0000FF0A
+	ED		SDMRB3, 0x00000000
+	ED		SDGENCNTB, 0x00000032
+	//ED		SDGENCNTB, 0x00000064
+	cmp_loop	SDGENCNTB, 0xFFFFFFFF, 0x00000000
+
+	ED		SDMRACR0B, 0x00002201
+	ED		SDMRB1, 0x00000000
+	ED		SDMRACR0B, 0x00000402
+	ED		SDMRB1, 0x00000000
+	//ED		SDMRACR0B, 0x00000403
+	ED		SDMRACR0B, 0x00000203	/* upstream u-boot */
+	ED		SDMRB1, 0x00000000
+	ED		SDMRB2, 0x00000000
+	ED		SDMRTMPCRB, 0x88800004
+	ED		SDMRTMPMSKB, 0x00000004
+	ED		RTCORB,  0xA55A0032
+	ED		RTCORHB, 0xA55A000C
+	ED		RTCSRB,  0xA55A2048
+	or_write32	SDCR0B, 0x00000800
+	or_write32	SDCR1B, 0x00000400
+	ED		ZQCCRB, 0xFFF20000
+	or_write32	SDPDCR0B, 0x00030000
+	ED		DPHYCNT1B, 0xA5390000
+	ED		DPHYCNT0B, 0x00001200
+	ED		DPHYCNT1B, 0x07CE0000
+	ED		DPHYCNT0B, 0x00001247
+	cmp_loop	DPHYCNT2B, 0xFFFFFFFF, 0x07CE0000
+
+	and_write32	SDPDCR0B, 0xFFFCFFFF
+
+	ED		FRQCRD, 0x00000B0B
+	cmp_loop	FRQCRD, 0x80000000, 0x00000000
+
+	ED 	CPGXXCR4, 0xfffffffc
+
+	b	1f
+
+	.pool
+	.align 4
+
+1:
+#define CS0BCR_D (0x06C00400)
+#define CS4BCR_D (0x16C90400)
+#define CS0WCR_D (0x55062C42)
+#define CS4WCR_D (0x1e071dc3)
+#define CMNCR_BROMMD0   (1 << 21)
+#define CMNCR_BROMMD1   (1 << 22)
+#define CMNCR_BROMMD    (CMNCR_BROMMD0|CMNCR_BROMMD1)
+#define VCLKCR1_D       (0x27)
+
+#define SMSTPCR1_CMT0   (1 << 24)
+#define SMSTPCR1_I2C0   (1 << 16)
+#define SMSTPCR3_USB    (1 << 22)
+#define SMSTPCR3_I2C1	(1 << 23)
+
+#define PORT32CR (0xE6051020)
+#define PORT33CR (0xE6051021)
+#define PORT34CR (0xE6051022)
+#define PORT35CR (0xE6051023)
+#if 1
+        ED	CS0BCR, CS0BCR_D
+        ED	CS4BCR, CS4BCR_D
+        ED	CS0WCR, CS0WCR_D
+        ED	CS4WCR, CS4WCR_D
+#endif
+
+#if 0
+	ldr	r0, 1f
+	ldr	r1, [r0]
+	
+	orr	r1, r1, #CMNCR_BROMMD
+	str	r1, [r0]
+	b	2f
+1:	.word	CMNCR
+2:
+#else
+	ED	CMNCR, CMNCR_BROMMD
+#endif
+
+#if 1
+	and_write32	SMSTPCR1, ~(SMSTPCR1_CMT0|SMSTPCR1_I2C0)
+	and_write32	SRCR1, ~(SMSTPCR1_CMT0|SMSTPCR1_I2C0)
+	and_write32	SMSTPCR3, ~(SMSTPCR3_USB|SMSTPCR3_I2C1)
+	and_write32	SRCR3, ~(SMSTPCR3_USB|SMSTPCR3_I2C1)
+	//and_write32	SMSTPCR3, ~(SMSTPCR3_I2C1)
+	//and_write32	SRCR3, ~(SMSTPCR3_I2C1)
+	//or_write32 SMSTPCR3, 0x100	/* stop eMMC */
+#endif
+#if 1
+        ED	VCLKCR1, VCLKCR1_D
+#endif
+
+        /* Setup SCIF4 / workaround */
+        EB	PORT32CR, 0x12
+        EB	PORT33CR, 0x22
+        EB	PORT34CR, 0x12
+        EB	PORT35CR, 0x22
diff --git a/arch/arm/mach-shmobile/include/mach/zboot.h b/arch/arm/mach-shmobile/include/mach/zboot.h
index f2d8744..8d2d236 100644
--- a/arch/arm/mach-shmobile/include/mach/zboot.h
+++ b/arch/arm/mach-shmobile/include/mach/zboot.h
@@ -14,6 +14,12 @@
 #define MACH_TYPE	MACH_TYPE_MACKEREL
 #define MEMORY_START	0x40000000
 #include "mach/head-mackerel.txt"
+#elif defined(CONFIG_MACH_KZM9G)
+#define MACH_TYPE	MACH_TYPE_KZM9G
+#include "mach/head-kzm9g.txt"
+#elif defined(CONFIG_MACH_KZM9G_REFERENCE)
+#define MACH_TYPE	MACH_TYPE_KZM9G_REFERENCE
+#include "mach/head-kzm9g.txt"
 #else
 #error "unsupported board."
 #endif
-- 
1.7.10.4

