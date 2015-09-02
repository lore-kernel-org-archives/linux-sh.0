From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 14:58:00 +0000
Subject: Re: topic/gen3-latest
Message-Id: <alpine.DEB.2.10.1509021650580.5505@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdXLKW4FkwbrhKoToV9BdHruK4VmvnMzofCEUSnuxk-_nQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXLKW4FkwbrhKoToV9BdHruK4VmvnMzofCEUSnuxk-_nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 2 Sep 2015, Geert Uytterhoeven wrote:
> On Wed, Sep 2, 2015 at 11:32 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > I've updated topic/gen3-latest in
> > https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git with:
> >   - topic/gen3-cpg-v6
> >   - topic/r8a7795-pfc-v2
> >   - topic/gen3-modemr-syscon-v1
> 
> The above works fine, as CONFIG_PINCTRL is not yet selected by ARCH_RENESAS.
> 
> As soon as CONFIG_PINCTRL=y, the system seems to boot fine, but serial input
> on the console does not work.
> 
> Disabling CONFIG_PINCTRL _or_ reverting from topic/r8a7795-pfc-v2 to
> topic/r8a7795-pfc-v1 fixes the issue.
> 
> Looking into it...

From 770768d62661b0a273e24f1d0ebc12e5f80fcd8f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 2 Sep 2015 16:40:21 +0200
Subject: [PATCH] sh-pfc: r8a7795: Add missing 16th column in IPSR data

Each IPx_y_z macro is supposed to provide the values for a 4-bit field,
i.e. it should provide 16 values, not 15.

Without this, only the functions selected by IPSRx[31:28] are configured
correctly. For other functions, the wrong values and fields are written.

E.g. for SCIF2, 0xa resp. 0x9 were written to IPSR12 fields 5 resp. 6,
instead of 0 to both IPSR12 fields 6 and 7, breaking console input.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be folded into "sh-pfc: Initial R8A7795 PFC support"

 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 290 +++++++++++++++++------------------
 1 file changed, 145 insertions(+), 145 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 7426df7c74814d21..f1325bf63a192bc1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -231,151 +231,151 @@
 #define GPSR7_0		FM(AVS1)
 
 
-/* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */ 	/* 8 */			/* 9 */		/* A */		/* B */		/* C - E */
-#define IP0_3_0		FM(AVB_MDC)		F_(0,0)		FM(MSIOF2_SS2_C)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP0_7_4		FM(AVB_MAGIC)		F_(0,0)		FM(MSIOF2_SS1_C)	FM(SCK4_A)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP0_11_8	FM(AVB_PHY_INT)		F_(0,0)		FM(MSIOF2_SYNC_C)	FM(RX4_A)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP0_15_12	FM(AVB_LINK)		F_(0,0)		FM(MSIOF2_SCK_C)	FM(TX4_A)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP0_19_16	FM(AVB_AVTP_MATCH_A)	F_(0,0)		FM(MSIOF2_RXD_C)	FM(CTS4_N_A)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP0_23_20	FM(AVB_AVTP_CAPTURE_A)	F_(0,0)		FM(MSIOF2_TXD_C)	FM(RTS4_N_TANS_A)		F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP0_27_24	FM(IRQ0)		FM(QPOLB)	F_(0,0)			FM(DU_CDE)			FM(VI4_DATA0_B)	FM(CAN0_TX_B)	FM(CANFD0_TX_B)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP0_31_28	FM(IRQ1)		FM(QPOLA)	F_(0,0)			FM(DU_DISP)			FM(VI4_DATA1_B)	FM(CAN0_RX_B)	FM(CANFD0_RX_B)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP1_3_0		FM(IRQ2)		FM(QCPV_QDE)	F_(0,0)			FM(DU_EXODDF_DU_ODDF_DISP_CDE)	FM(VI4_DATA2_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(PWM3_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP1_7_4		FM(IRQ3)		FM(QSTVB_QVE)	FM(A25)			FM(DU_DOTCLKOUT1)		FM(VI4_DATA3_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(PWM4_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP1_11_8	FM(IRQ4)		FM(QSTH_QHS)	FM(A24)			FM(DU_EXHSYNC_DU_HSYNC)		FM(VI4_DATA4_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(PWM5_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP1_15_12	FM(IRQ5)		FM(QSTB_QHE)	FM(A23)			FM(DU_EXVSYNC_DU_VSYNC)		FM(VI4_DATA5_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(PWM6_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP1_19_16	FM(PWM0)		FM(AVB_AVTP_PPS)FM(A22)			F_(0,0)				FM(VI4_DATA6_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(IECLK_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP1_23_20	FM(PWM1_A)		F_(0,0)		FM(A21)			FM(HRX3_D)			FM(VI4_DATA7_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(IERX_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP1_27_24	FM(PWM2_A)		F_(0,0)		FM(A20)			FM(HTX3_D)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(IETX_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP1_31_28	FM(A0)			FM(LCDOUT16)	FM(MSIOF3_SYNC_B)	F_(0,0)				FM(VI4_DATA8)	F_(0,0)		FM(DU_DB0)		F_(0,0)		F_(0,0)			FM(PWM3_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP2_3_0		FM(A1)			FM(LCDOUT17)	FM(MSIOF3_TXD_B)	F_(0,0)				FM(VI4_DATA9)	F_(0,0)		FM(DU_DB1)		F_(0,0)		F_(0,0)			FM(PWM4_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP2_7_4		FM(A2)			FM(LCDOUT18)	FM(MSIOF3_SCK_B)	F_(0,0)				FM(VI4_DATA10)	F_(0,0)		FM(DU_DB2)		F_(0,0)		F_(0,0)			FM(PWM5_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP2_11_8	FM(A3)			FM(LCDOUT19)	FM(MSIOF3_RXD_B)	F_(0,0)				FM(VI4_DATA11)	F_(0,0)		FM(DU_DB3)		F_(0,0)		F_(0,0)			FM(PWM6_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-
-/* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */ 	/* 8 */			/* 9 */		/* A */		/* B */		/* C - E */
-#define IP2_15_12	FM(A4)			FM(LCDOUT20)	FM(MSIOF3_SS1_B)	F_(0,0)				FM(VI4_DATA12)	FM(VI5_DATA12)	FM(DU_DB4)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP2_19_16	FM(A5)			FM(LCDOUT21)	FM(MSIOF3_SS2_B)	FM(SCK4_B)			FM(VI4_DATA13)	FM(VI5_DATA13)	FM(DU_DB5)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP2_23_20	FM(A6)			FM(LCDOUT22)	FM(MSIOF2_SS1_A)	FM(RX4_B)			FM(VI4_DATA14)	FM(VI5_DATA14)	FM(DU_DB6)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP2_27_24	FM(A7)			FM(LCDOUT23)	FM(MSIOF2_SS2_A)	FM(TX4_B)			FM(VI4_DATA15)	FM(VI5_DATA15)	FM(DU_DB7)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP2_31_28	FM(A8)			FM(RX3_B)	FM(MSIOF2_SYNC_A)	FM(HRX4_B)			F_(0,0)		F_(0,0)		F_(0,0)			FM(SDA6_A)	FM(AVB_AVTP_MATCH_B)	FM(PWM1_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP3_3_0		FM(A9)			F_(0,0)		FM(MSIOF2_SCK_A)	FM(CTS4_N_B)			F_(0,0)		FM(VI5_VSYNC_N)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP3_7_4		FM(A10)			F_(0,0)		FM(MSIOF2_RXD_A)	FM(RTS4_N_TANS_B)		F_(0,0)		FM(VI5_HSYNC_N)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP3_11_8	FM(A11)			FM(TX3_B)	FM(MSIOF2_TXD_A)	FM(HTX4_B)			FM(HSCK4)	FM(VI5_FIELD)	F_(0,0)			FM(SCL6_A)	FM(AVB_AVTP_CAPTURE_B)	FM(PWM2_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP3_15_12	FM(A12)			FM(LCDOUT12)	FM(MSIOF3_SCK_C)	F_(0,0)				FM(HRX4_A)	FM(VI5_DATA8)	FM(DU_DG4)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP3_19_16	FM(A13)			FM(LCDOUT13)	FM(MSIOF3_SYNC_C)	F_(0,0)				FM(HTX4_A)	FM(VI5_DATA9)	FM(DU_DG5)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP3_23_20	FM(A14)			FM(LCDOUT14)	FM(MSIOF3_RXD_C)	F_(0,0)				FM(HCTS4_N)	FM(VI5_DATA10)	FM(DU_DG6)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP3_27_24	FM(A15)			FM(LCDOUT15)	FM(MSIOF3_TXD_C)	F_(0,0)				FM(HRTS4_N)	FM(VI5_DATA11)	FM(DU_DG7)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP3_31_28	FM(A16)			FM(LCDOUT8)	F_(0,0)			F_(0,0)				FM(VI4_FIELD)	F_(0,0)		FM(DU_DG0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP4_3_0		FM(A17)			FM(LCDOUT9)	F_(0,0)			F_(0,0)				FM(VI4_VSYNC_N)	F_(0,0)		FM(DU_DG1)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP4_7_4		FM(A18)			FM(LCDOUT10)	F_(0,0)			F_(0,0)				FM(VI4_HSYNC_N)	F_(0,0)		FM(DU_DG2)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP4_11_8	FM(A19)			FM(LCDOUT11)	F_(0,0)			F_(0,0)				FM(VI4_CLKENB)	F_(0,0)		FM(DU_DG3)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP4_15_12	FM(CS0_N)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		FM(VI5_CLKENB)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP4_19_16	FM(CS1_N_A26)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		FM(VI5_CLK)	F_(0,0)			FM(EX_WAIT0_B)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP4_23_20	FM(BS_N)		FM(QSTVA_QVS)	FM(MSIOF3_SCK_D)	FM(SCK3)			FM(HSCK3)	F_(0,0)		F_(0,0)			F_(0,0)		FM(CAN1_TX)		FM(CANFD1_TX)	FM(IETX_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP4_27_24	FM(RD_N)		F_(0,0)		FM(MSIOF3_SYNC_D)	FM(RX3_A)			FM(HRX3_A)	F_(0,0)		F_(0,0)			F_(0,0)		FM(CAN0_TX_A)		FM(CANFD0_TX_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP4_31_28	FM(RD_WR_N)		F_(0,0)		FM(MSIOF3_RXD_D)	FM(TX3_A)			FM(HTX3_A)	F_(0,0)		F_(0,0)			F_(0,0)		FM(CAN0_RX_A)		FM(CANFD0_RX_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP5_3_0		FM(WE0_N)		F_(0,0)		FM(MSIOF3_TXD_D)	FM(CTS3_N)			FM(HCTS3_N)	F_(0,0)		F_(0,0)			FM(SCL6_B)	FM(CAN_CLK)		F_(0,0)		FM(IECLK_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP5_7_4		FM(WE1_N)		F_(0,0)		FM(MSIOF3_SS1_D)	FM(RTS3_N_TANS)			FM(HRTS3_N)	F_(0,0)		F_(0,0)			FM(SDA6_B)	FM(CAN1_RX)		FM(CANFD1_RX)	FM(IERX_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP5_11_8	FM(EX_WAIT0_A)		FM(QCLK)	F_(0,0)			F_(0,0)				FM(VI4_CLK)	F_(0,0)		FM(DU_DOTCLKOUT0)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP5_15_12	FM(D0)			FM(MSIOF2_SS1_B)FM(MSIOF3_SCK_A)	F_(0,0)				FM(VI4_DATA16)	FM(VI5_DATA0)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP5_19_16	FM(D1)			FM(MSIOF2_SS2_B)FM(MSIOF3_SYNC_A)	F_(0,0)				FM(VI4_DATA17)	FM(VI5_DATA1)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP5_23_20	FM(D2)			F_(0,0)		FM(MSIOF3_RXD_A)	F_(0,0)				FM(VI4_DATA18)	FM(VI5_DATA2)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP5_27_24	FM(D3)			F_(0,0)		FM(MSIOF3_TXD_A)	F_(0,0)				FM(VI4_DATA19)	FM(VI5_DATA3)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP5_31_28	FM(D4)			FM(MSIOF2_SCK_B)F_(0,0)			F_(0,0)				FM(VI4_DATA20)	FM(VI5_DATA4)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP6_3_0		FM(D5)			FM(MSIOF2_SYNC_B)F_(0,0)		F_(0,0)				FM(VI4_DATA21)	FM(VI5_DATA5)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP6_7_4		FM(D6)			FM(MSIOF2_RXD_B)F_(0,0)			F_(0,0)				FM(VI4_DATA22)	FM(VI5_DATA6)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP6_11_8	FM(D7)			FM(MSIOF2_TXD_B)F_(0,0)			F_(0,0)				FM(VI4_DATA23)	FM(VI5_DATA7)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP6_15_12	FM(D8)			FM(LCDOUT0)	FM(MSIOF2_SCK_D)	FM(SCK4_C)			FM(VI4_DATA0_A)	F_(0,0)		FM(DU_DR0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP6_19_16	FM(D9)			FM(LCDOUT1)	FM(MSIOF2_SYNC_D)	F_(0,0)				FM(VI4_DATA1_A)	F_(0,0)		FM(DU_DR1)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP6_23_20	FM(D10)			FM(LCDOUT2)	FM(MSIOF2_RXD_D)	FM(HRX3_B)			FM(VI4_DATA2_A)	FM(CTS4_N_C)	FM(DU_DR2)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP6_27_24	FM(D11)			FM(LCDOUT3)	FM(MSIOF2_TXD_D)	FM(HTX3_B)			FM(VI4_DATA3_A)	FM(RTS4_N_TANS_C)FM(DU_DR3)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP6_31_28	FM(D12)			FM(LCDOUT4)	FM(MSIOF2_SS1_D)	FM(RX4_C)			FM(VI4_DATA4_A)	F_(0,0)		FM(DU_DR4)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP7_3_0		FM(D13)			FM(LCDOUT5)	FM(MSIOF2_SS2_D)	FM(TX4_C)			FM(VI4_DATA5_A)	F_(0,0)		FM(DU_DR5)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP7_7_4		FM(D14)			FM(LCDOUT6)	FM(MSIOF3_SS1_A)	FM(HRX3_C)			FM(VI4_DATA6_A)	F_(0,0)		FM(DU_DR6)		FM(SCL6_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP7_11_8	FM(D15)			FM(LCDOUT7)	FM(MSIOF3_SS2_A)	FM(HTX3_C)			FM(VI4_DATA7_A)	F_(0,0)		FM(DU_DR7)		FM(SDA6_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP7_15_12	FM(FSCLKST)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP7_19_16	FM(SD0_CLK)		F_(0,0)		FM(MSIOF1_SCK_E)	F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_OPWM_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-
-/* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */ 	/* 8 */			/* 9 */		/* A */		/* B */		/* C - E */
-#define IP7_23_20	FM(SD0_CMD)		F_(0,0)		FM(MSIOF1_SYNC_E)	F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_IVCXO27_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP7_27_24	FM(SD0_DAT0)		F_(0,0)		FM(MSIOF1_RXD_E)	F_(0,0)				F_(0,0)		FM(TS_SCK0_B)	FM(STP_ISCLK_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP7_31_28	FM(SD0_DAT1)		F_(0,0)		FM(MSIOF1_TXD_E)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC0_B)FM(STP_ISSYNC_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP8_3_0		FM(SD0_DAT2)		F_(0,0)		FM(MSIOF1_SS1_E)	F_(0,0)				F_(0,0)		FM(TS_SDAT0_B)	FM(STP_ISD_0_B)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP8_7_4		FM(SD0_DAT3)		F_(0,0)		FM(MSIOF1_SS2_E)	F_(0,0)				F_(0,0)		FM(TS_SDEN0_B)	FM(STP_ISEN_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP8_11_8	FM(SD1_CLK)		F_(0,0)		FM(MSIOF1_SCK_G)	F_(0,0)				F_(0,0)		FM(SIM0_CLK_A)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP8_15_12	FM(SD1_CMD)		F_(0,0)		FM(MSIOF1_SYNC_G)	F_(0,0)				F_(0,0)		FM(SIM0_D_A)	FM(STP_IVCXO27_1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP8_19_16	FM(SD1_DAT0)		FM(SD2_DAT4)	FM(MSIOF1_RXD_G)	F_(0,0)				F_(0,0)		FM(TS_SCK1_B)	FM(STP_ISCLK_1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP8_23_20	FM(SD1_DAT1)		FM(SD2_DAT5)	FM(MSIOF1_TXD_G)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC1_B)FM(STP_ISSYNC_1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP8_27_24	FM(SD1_DAT2)		FM(SD2_DAT6)	FM(MSIOF1_SS1_G)	F_(0,0)				F_(0,0)		FM(TS_SDAT1_B)	FM(STP_ISD_1_B)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP8_31_28	FM(SD1_DAT3)		FM(SD2_DAT7)	FM(MSIOF1_SS2_G)	F_(0,0)				F_(0,0)		FM(TS_SDEN1_B)	FM(STP_ISEN_1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP9_3_0		FM(SD2_CLK)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP9_7_4		FM(SD2_DAT0)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP9_11_8	FM(SD2_DAT1)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP9_15_12	FM(SD2_DAT2)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP9_19_16	FM(SD2_DAT3)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP9_23_20	FM(SD2_DS)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		FM(SATA_DEVSLP_B)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP9_27_24	FM(SD3_DAT4)		FM(SD2_CD_A)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP9_31_28	FM(SD3_DAT5)		FM(SD2_WP_A)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP10_3_0	FM(SD3_DAT6)		FM(SD3_CD)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP10_7_4	FM(SD3_DAT7)		FM(SD3_WP)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP10_11_8	FM(SD0_CD)		F_(0,0)		F_(0,0)			F_(0,0)				FM(SCL2_B)	FM(SIM0_RST_A)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP10_15_12	FM(SD0_WP)		F_(0,0)		F_(0,0)			F_(0,0)				FM(SDA2_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP10_19_16	FM(SD1_CD)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		FM(SIM0_CLK_B)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP10_23_20	FM(SD1_WP)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		FM(SIM0_D_B)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP10_27_24	FM(SCK0)		FM(HSCK1_B)	FM(MSIOF1_SS2_B)	FM(AUDIO_CLKC_B)		FM(SDA2_A)	FM(SIM0_RST_B)	FM(STP_OPWM_0_C)	FM(RIF0_CLK_B)	F_(0,0)			FM(ADICHS2)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP10_31_28	FM(RX0)			FM(HRX1_B)	F_(0,0)			F_(0,0)				F_(0,0)		FM(TS_SCK0_C)	FM(STP_ISCLK_0_C)	FM(RIF0_D0_B)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP11_3_0	FM(TX0)			FM(HTX1_B)	F_(0,0)			F_(0,0)				F_(0,0)		FM(TS_SPSYNC0_C)FM(STP_ISSYNC_0_C)	FM(RIF0_D1_B)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP11_7_4	FM(CTS0_N)		FM(HCTS1_N_B)	FM(MSIOF1_SYNC_B)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC1_C)FM(STP_ISSYNC_1_C)	FM(RIF1_SYNC_B)	FM(AUDIO_CLKOUT_C)	FM(ADICS_SAMP)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP11_11_8	FM(RTS0_N_TANS)		FM(HRTS1_N_B)	FM(MSIOF1_SS1_B)	FM(AUDIO_CLKA_B)		FM(SCL2_A)	F_(0,0)		FM(STP_IVCXO27_1_C)	FM(RIF0_SYNC_B)	F_(0,0)			FM(ADICHS1)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP11_15_12	FM(RX1_A)		FM(HRX1_A)	F_(0,0)			F_(0,0)				F_(0,0)		FM(TS_SDAT0_C)	FM(STP_ISD_0_C)		FM(RIF1_CLK_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP11_19_16	FM(TX1_A)		FM(HTX1_A)	F_(0,0)			F_(0,0)				F_(0,0)		FM(TS_SDEN0_C)	FM(STP_ISEN_0_C)	FM(RIF1_D0_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP11_23_20	FM(CTS1_N)		FM(HCTS1_N_A)	FM(MSIOF1_RXD_B)	F_(0,0)				F_(0,0)		FM(TS_SDEN1_C)	FM(STP_ISEN_1_C)	FM(RIF1_D0_B)	F_(0,0)			FM(ADIDATA)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP11_27_24	FM(RTS1_N_TANS)		FM(HRTS1_N_A)	FM(MSIOF1_TXD_B)	F_(0,0)				F_(0,0)		FM(TS_SDAT1_C)	FM(STP_ISD_1_C)		FM(RIF1_D1_B)	F_(0,0)			FM(ADICHS0)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP11_31_28	FM(SCK2)		FM(SCIF_CLK_B)	FM(MSIOF1_SCK_B)	F_(0,0)				F_(0,0)		FM(TS_SCK1_C)	FM(STP_ISCLK_1_C)	FM(RIF1_CLK_B)	F_(0,0)			FM(ADICLK)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP12_3_0	FM(TX2_A)		F_(0,0)		F_(0,0)			FM(SD2_CD_B)			FM(SCL1_A)	F_(0,0)		FM(FMCLK_A)		FM(RIF1_D1_C)	F_(0,0)			FM(FSO_CFE_0_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP12_7_4	FM(RX2_A)		F_(0,0)		F_(0,0)			FM(SD2_WP_B)			FM(SDA1_A)	F_(0,0)		FM(FMIN_A)		FM(RIF1_SYNC_C)	F_(0,0)			FM(FSO_CFE_1_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP12_11_8	FM(HSCK0)		F_(0,0)		FM(MSIOF1_SCK_D)	FM(AUDIO_CLKB_A)		FM(SSI_SDATA1_B)FM(TS_SCK0_D)	FM(STP_ISCLK_0_D)	FM(RIF0_CLK_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP12_15_12	FM(HRX0)		F_(0,0)		FM(MSIOF1_RXD_D)	F_(0,0)				FM(SSI_SDATA2_B)FM(TS_SDEN0_D)	FM(STP_ISEN_0_D)	FM(RIF0_D0_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP12_19_16	FM(HTX0)		F_(0,0)		FM(MSIOF1_TXD_D)	F_(0,0)				FM(SSI_SDATA9_B)FM(TS_SDAT0_D)	FM(STP_ISD_0_D)		FM(RIF0_D1_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP12_23_20	FM(HCTS0_N)		FM(RX2_B)	FM(MSIOF1_SYNC_D)	F_(0,0)				FM(SSI_SCK9_A)	FM(TS_SPSYNC0_D)FM(STP_ISSYNC_0_D)	FM(RIF0_SYNC_C)	FM(AUDIO_CLKOUT1_A)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP12_27_24	FM(HRTS0_N)		FM(TX2_B)	FM(MSIOF1_SS1_D)	F_(0,0)				FM(SSI_WS9_A)	F_(0,0)		FM(STP_IVCXO27_0_D)	FM(BPFCLK_A)	FM(AUDIO_CLKOUT2_A)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-
-/* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */ 	/* 8 */			/* 9 */		/* A */		/* B */		/* C - E */
-#define IP12_31_28	FM(MSIOF0_SYNC)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		FM(AUDIO_CLKOUT_A)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP13_3_0	FM(MSIOF0_SS1)		FM(RX5)		F_(0,0)			FM(AUDIO_CLKA_C)		FM(SSI_SCK2_A)	F_(0,0)		FM(STP_IVCXO27_0_C)	F_(0,0)		FM(AUDIO_CLKOUT3_A)	F_(0,0)		FM(TCLK1_B)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP13_7_4	FM(MSIOF0_SS2)		FM(TX5)		FM(MSIOF1_SS2_D)	FM(AUDIO_CLKC_A)		FM(SSI_WS2_A)	F_(0,0)		FM(STP_OPWM_0_D)	F_(0,0)		FM(AUDIO_CLKOUT_D)	F_(0,0)		FM(SPEEDIN_B)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP13_11_8	FM(MLB_CLK)		F_(0,0)		FM(MSIOF1_SCK_F)	F_(0,0)				FM(SCL1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP13_15_12	FM(MLB_SIG)		FM(RX1_B)	FM(MSIOF1_SYNC_F)	F_(0,0)				FM(SDA1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP13_19_16	FM(MLB_DAT)		FM(TX1_B)	FM(MSIOF1_RXD_F)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP13_23_20	FM(SSI_SCK0129)		F_(0,0)		FM(MSIOF1_TXD_F)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP13_27_24	FM(SSI_WS0129)		F_(0,0)		FM(MSIOF1_SS1_F)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP13_31_28	FM(SSI_SDATA0)		F_(0,0)		FM(MSIOF1_SS2_F)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP14_3_0	FM(SSI_SDATA1_A)	F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP14_7_4	FM(SSI_SDATA2_A)	F_(0,0)		F_(0,0)			F_(0,0)				FM(SSI_SCK1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP14_11_8	FM(SSI_SCK34)		F_(0,0)		FM(MSIOF1_SS1_A)	F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_OPWM_0_A)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP14_15_12	FM(SSI_WS34)		FM(HCTS2_N_A)	FM(MSIOF1_SS2_A)	F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_IVCXO27_0_A)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP14_19_16	FM(SSI_SDATA3)		FM(HRTS2_N_A)	FM(MSIOF1_TXD_A)	F_(0,0)				F_(0,0)		FM(TS_SCK0_A)	FM(STP_ISCLK_0_A)	FM(RIF0_D1_A)	FM(RIF2_D0_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP14_23_20	FM(SSI_SCK4)		FM(HRX2_A)	FM(MSIOF1_SCK_A)	F_(0,0)				F_(0,0)		FM(TS_SDAT0_A)	FM(STP_ISD_0_A)		FM(RIF0_CLK_A)	FM(RIF2_CLK_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP14_27_24	FM(SSI_WS4)		FM(HTX2_A)	FM(MSIOF1_SYNC_A)	F_(0,0)				F_(0,0)		FM(TS_SDEN0_A)	FM(STP_ISEN_0_A)	FM(RIF0_SYNC_A)	FM(RIF2_SYNC_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP14_31_28	FM(SSI_SDATA4)		FM(HSCK2_A)	FM(MSIOF1_RXD_A)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC0_A)FM(STP_ISSYNC_0_A)	FM(RIF0_D0_A)	FM(RIF2_D1_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP15_3_0	FM(SSI_SCK6)		FM(USB2_PWEN)	F_(0,0)			FM(SIM0_RST_D)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP15_7_4	FM(SSI_WS6)		FM(USB2_OVC)	F_(0,0)			FM(SIM0_D_D)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP15_11_8	FM(SSI_SDATA6)		F_(0,0)		F_(0,0)			FM(SIM0_CLK_D)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		FM(SATA_DEVSLP_A)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP15_15_12	FM(SSI_SCK78)		FM(HRX2_B)	FM(MSIOF1_SCK_C)	F_(0,0)				F_(0,0)		FM(TS_SCK1_A)	FM(STP_ISCLK_1_A)	FM(RIF1_CLK_A)	FM(RIF3_CLK_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP15_19_16	FM(SSI_WS78)		FM(HTX2_B)	FM(MSIOF1_SYNC_C)	F_(0,0)				F_(0,0)		FM(TS_SDAT1_A)	FM(STP_ISD_1_A)		FM(RIF1_SYNC_A)	FM(RIF3_SYNC_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP15_23_20	FM(SSI_SDATA7)		FM(HCTS2_N_B)	FM(MSIOF1_RXD_C)	F_(0,0)				F_(0,0)		FM(TS_SDEN1_A)	FM(STP_ISEN_1_A)	FM(RIF1_D0_A)	FM(RIF3_D0_A)		F_(0,0)		FM(TCLK2_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP15_27_24	FM(SSI_SDATA8)		FM(HRTS2_N_B)	FM(MSIOF1_TXD_C)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC1_A)FM(STP_ISSYNC_1_A)	FM(RIF1_D1_A)	FM(RIF3_D1_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP15_31_28	FM(SSI_SDATA9_A)	FM(HSCK2_B)	FM(MSIOF1_SS1_C)	FM(HSCK1_A)			FM(SSI_WS1_B)	FM(SCK1)	FM(STP_IVCXO27_1_A)	FM(SCK5)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP16_3_0	FM(AUDIO_CLKA_A)	F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		FM(CC5_OSCOUT)	F_(0,0) F_(0,0) F_(0,0)
-#define IP16_7_4	FM(AUDIO_CLKB_B)	FM(SCIF_CLK_A)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_IVCXO27_1_D)	FM(REMOCON_A)	F_(0,0)			F_(0,0)		FM(TCLK1_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP16_11_8	FM(USB0_PWEN)		F_(0,0)		F_(0,0)			FM(SIM0_RST_C)			F_(0,0)		FM(TS_SCK1_D)	FM(STP_ISCLK_1_D)	FM(BPFCLK_B)	FM(RIF3_CLK_B)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP16_15_12	FM(USB0_OVC)		F_(0,0)		F_(0,0)			FM(SIM0_D_C)			F_(0,0)		FM(TS_SDAT1_D)	FM(STP_ISD_1_D)		F_(0,0)		FM(RIF3_SYNC_B)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP16_19_16	FM(USB1_PWEN)		F_(0,0)		F_(0,0)			FM(SIM0_CLK_C)			FM(SSI_SCK1_A)	FM(TS_SCK0_E)	FM(STP_ISCLK_0_E)	FM(FMCLK_B)	FM(RIF2_CLK_B)		F_(0,0)		FM(SPEEDIN_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP16_23_20	FM(USB1_OVC)		F_(0,0)		FM(MSIOF1_SS2_C)	F_(0,0)				FM(SSI_WS1_A)	FM(TS_SDAT0_E)	FM(STP_ISD_0_E)		FM(FMIN_B)	FM(RIF2_SYNC_B)		F_(0,0)		FM(REMOCON_B)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0)
-#define IP16_27_24	FM(USB30_PWEN)		F_(0,0)		F_(0,0)			FM(AUDIO_CLKOUT_B)		FM(SSI_SCK2_B)	FM(TS_SDEN1_D)	FM(STP_ISEN_1_D)	FM(STP_OPWM_0_E)FM(RIF3_D0_B)		F_(0,0)		FM(TCLK2_B)	FM(TPU0TO0)	F_(0,0) F_(0,0) F_(0,0)
-#define IP16_31_28	FM(USB30_OVC)		F_(0,0)		F_(0,0)			FM(AUDIO_CLKOUT1_B)		FM(SSI_WS2_B)	FM(TS_SPSYNC1_D)FM(STP_ISSYNC_1_D)	FM(STP_IVCXO27_0_E)FM(RIF3_D1_B)	F_(0,0)		FM(FSO_TOE_B)	FM(TPU0TO1)	F_(0,0) F_(0,0) F_(0,0)
-#define IP17_3_0	FM(USB31_PWEN)		F_(0,0)		F_(0,0)			FM(AUDIO_CLKOUT2_B)		FM(SSI_SCK9_B)	FM(TS_SDEN0_E)	FM(STP_ISEN_0_E)	F_(0,0)		FM(RIF2_D0_B)		F_(0,0)		F_(0,0)		FM(TPU0TO2)	F_(0,0) F_(0,0) F_(0,0)
-#define IP17_7_4	FM(USB31_OVC)		F_(0,0)		F_(0,0)			FM(AUDIO_CLKOUT3_B)		FM(SSI_WS9_B)	FM(TS_SPSYNC0_E)FM(STP_ISSYNC_0_E)	F_(0,0)		FM(RIF2_D1_B)		F_(0,0)		F_(0,0)		FM(TPU0TO3)	F_(0,0) F_(0,0) F_(0,0)
+/* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */ 	/* 8 */			/* 9 */		/* A */		/* B */		/* C - F */
+#define IP0_3_0		FM(AVB_MDC)		F_(0,0)		FM(MSIOF2_SS2_C)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP0_7_4		FM(AVB_MAGIC)		F_(0,0)		FM(MSIOF2_SS1_C)	FM(SCK4_A)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP0_11_8	FM(AVB_PHY_INT)		F_(0,0)		FM(MSIOF2_SYNC_C)	FM(RX4_A)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP0_15_12	FM(AVB_LINK)		F_(0,0)		FM(MSIOF2_SCK_C)	FM(TX4_A)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP0_19_16	FM(AVB_AVTP_MATCH_A)	F_(0,0)		FM(MSIOF2_RXD_C)	FM(CTS4_N_A)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP0_23_20	FM(AVB_AVTP_CAPTURE_A)	F_(0,0)		FM(MSIOF2_TXD_C)	FM(RTS4_N_TANS_A)		F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP0_27_24	FM(IRQ0)		FM(QPOLB)	F_(0,0)			FM(DU_CDE)			FM(VI4_DATA0_B)	FM(CAN0_TX_B)	FM(CANFD0_TX_B)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP0_31_28	FM(IRQ1)		FM(QPOLA)	F_(0,0)			FM(DU_DISP)			FM(VI4_DATA1_B)	FM(CAN0_RX_B)	FM(CANFD0_RX_B)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP1_3_0		FM(IRQ2)		FM(QCPV_QDE)	F_(0,0)			FM(DU_EXODDF_DU_ODDF_DISP_CDE)	FM(VI4_DATA2_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(PWM3_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP1_7_4		FM(IRQ3)		FM(QSTVB_QVE)	FM(A25)			FM(DU_DOTCLKOUT1)		FM(VI4_DATA3_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(PWM4_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP1_11_8	FM(IRQ4)		FM(QSTH_QHS)	FM(A24)			FM(DU_EXHSYNC_DU_HSYNC)		FM(VI4_DATA4_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(PWM5_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP1_15_12	FM(IRQ5)		FM(QSTB_QHE)	FM(A23)			FM(DU_EXVSYNC_DU_VSYNC)		FM(VI4_DATA5_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(PWM6_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP1_19_16	FM(PWM0)		FM(AVB_AVTP_PPS)FM(A22)			F_(0,0)				FM(VI4_DATA6_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(IECLK_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP1_23_20	FM(PWM1_A)		F_(0,0)		FM(A21)			FM(HRX3_D)			FM(VI4_DATA7_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(IERX_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP1_27_24	FM(PWM2_A)		F_(0,0)		FM(A20)			FM(HTX3_D)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			FM(IETX_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP1_31_28	FM(A0)			FM(LCDOUT16)	FM(MSIOF3_SYNC_B)	F_(0,0)				FM(VI4_DATA8)	F_(0,0)		FM(DU_DB0)		F_(0,0)		F_(0,0)			FM(PWM3_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP2_3_0		FM(A1)			FM(LCDOUT17)	FM(MSIOF3_TXD_B)	F_(0,0)				FM(VI4_DATA9)	F_(0,0)		FM(DU_DB1)		F_(0,0)		F_(0,0)			FM(PWM4_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP2_7_4		FM(A2)			FM(LCDOUT18)	FM(MSIOF3_SCK_B)	F_(0,0)				FM(VI4_DATA10)	F_(0,0)		FM(DU_DB2)		F_(0,0)		F_(0,0)			FM(PWM5_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP2_11_8	FM(A3)			FM(LCDOUT19)	FM(MSIOF3_RXD_B)	F_(0,0)				FM(VI4_DATA11)	F_(0,0)		FM(DU_DB3)		F_(0,0)		F_(0,0)			FM(PWM6_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+
+/* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */ 	/* 8 */			/* 9 */		/* A */		/* B */		/* C - F */
+#define IP2_15_12	FM(A4)			FM(LCDOUT20)	FM(MSIOF3_SS1_B)	F_(0,0)				FM(VI4_DATA12)	FM(VI5_DATA12)	FM(DU_DB4)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP2_19_16	FM(A5)			FM(LCDOUT21)	FM(MSIOF3_SS2_B)	FM(SCK4_B)			FM(VI4_DATA13)	FM(VI5_DATA13)	FM(DU_DB5)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP2_23_20	FM(A6)			FM(LCDOUT22)	FM(MSIOF2_SS1_A)	FM(RX4_B)			FM(VI4_DATA14)	FM(VI5_DATA14)	FM(DU_DB6)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP2_27_24	FM(A7)			FM(LCDOUT23)	FM(MSIOF2_SS2_A)	FM(TX4_B)			FM(VI4_DATA15)	FM(VI5_DATA15)	FM(DU_DB7)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP2_31_28	FM(A8)			FM(RX3_B)	FM(MSIOF2_SYNC_A)	FM(HRX4_B)			F_(0,0)		F_(0,0)		F_(0,0)			FM(SDA6_A)	FM(AVB_AVTP_MATCH_B)	FM(PWM1_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP3_3_0		FM(A9)			F_(0,0)		FM(MSIOF2_SCK_A)	FM(CTS4_N_B)			F_(0,0)		FM(VI5_VSYNC_N)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP3_7_4		FM(A10)			F_(0,0)		FM(MSIOF2_RXD_A)	FM(RTS4_N_TANS_B)		F_(0,0)		FM(VI5_HSYNC_N)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP3_11_8	FM(A11)			FM(TX3_B)	FM(MSIOF2_TXD_A)	FM(HTX4_B)			FM(HSCK4)	FM(VI5_FIELD)	F_(0,0)			FM(SCL6_A)	FM(AVB_AVTP_CAPTURE_B)	FM(PWM2_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP3_15_12	FM(A12)			FM(LCDOUT12)	FM(MSIOF3_SCK_C)	F_(0,0)				FM(HRX4_A)	FM(VI5_DATA8)	FM(DU_DG4)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP3_19_16	FM(A13)			FM(LCDOUT13)	FM(MSIOF3_SYNC_C)	F_(0,0)				FM(HTX4_A)	FM(VI5_DATA9)	FM(DU_DG5)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP3_23_20	FM(A14)			FM(LCDOUT14)	FM(MSIOF3_RXD_C)	F_(0,0)				FM(HCTS4_N)	FM(VI5_DATA10)	FM(DU_DG6)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP3_27_24	FM(A15)			FM(LCDOUT15)	FM(MSIOF3_TXD_C)	F_(0,0)				FM(HRTS4_N)	FM(VI5_DATA11)	FM(DU_DG7)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP3_31_28	FM(A16)			FM(LCDOUT8)	F_(0,0)			F_(0,0)				FM(VI4_FIELD)	F_(0,0)		FM(DU_DG0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP4_3_0		FM(A17)			FM(LCDOUT9)	F_(0,0)			F_(0,0)				FM(VI4_VSYNC_N)	F_(0,0)		FM(DU_DG1)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP4_7_4		FM(A18)			FM(LCDOUT10)	F_(0,0)			F_(0,0)				FM(VI4_HSYNC_N)	F_(0,0)		FM(DU_DG2)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP4_11_8	FM(A19)			FM(LCDOUT11)	F_(0,0)			F_(0,0)				FM(VI4_CLKENB)	F_(0,0)		FM(DU_DG3)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP4_15_12	FM(CS0_N)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		FM(VI5_CLKENB)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP4_19_16	FM(CS1_N_A26)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		FM(VI5_CLK)	F_(0,0)			FM(EX_WAIT0_B)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP4_23_20	FM(BS_N)		FM(QSTVA_QVS)	FM(MSIOF3_SCK_D)	FM(SCK3)			FM(HSCK3)	F_(0,0)		F_(0,0)			F_(0,0)		FM(CAN1_TX)		FM(CANFD1_TX)	FM(IETX_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP4_27_24	FM(RD_N)		F_(0,0)		FM(MSIOF3_SYNC_D)	FM(RX3_A)			FM(HRX3_A)	F_(0,0)		F_(0,0)			F_(0,0)		FM(CAN0_TX_A)		FM(CANFD0_TX_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP4_31_28	FM(RD_WR_N)		F_(0,0)		FM(MSIOF3_RXD_D)	FM(TX3_A)			FM(HTX3_A)	F_(0,0)		F_(0,0)			F_(0,0)		FM(CAN0_RX_A)		FM(CANFD0_RX_A)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP5_3_0		FM(WE0_N)		F_(0,0)		FM(MSIOF3_TXD_D)	FM(CTS3_N)			FM(HCTS3_N)	F_(0,0)		F_(0,0)			FM(SCL6_B)	FM(CAN_CLK)		F_(0,0)		FM(IECLK_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP5_7_4		FM(WE1_N)		F_(0,0)		FM(MSIOF3_SS1_D)	FM(RTS3_N_TANS)			FM(HRTS3_N)	F_(0,0)		F_(0,0)			FM(SDA6_B)	FM(CAN1_RX)		FM(CANFD1_RX)	FM(IERX_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP5_11_8	FM(EX_WAIT0_A)		FM(QCLK)	F_(0,0)			F_(0,0)				FM(VI4_CLK)	F_(0,0)		FM(DU_DOTCLKOUT0)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP5_15_12	FM(D0)			FM(MSIOF2_SS1_B)FM(MSIOF3_SCK_A)	F_(0,0)				FM(VI4_DATA16)	FM(VI5_DATA0)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP5_19_16	FM(D1)			FM(MSIOF2_SS2_B)FM(MSIOF3_SYNC_A)	F_(0,0)				FM(VI4_DATA17)	FM(VI5_DATA1)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP5_23_20	FM(D2)			F_(0,0)		FM(MSIOF3_RXD_A)	F_(0,0)				FM(VI4_DATA18)	FM(VI5_DATA2)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP5_27_24	FM(D3)			F_(0,0)		FM(MSIOF3_TXD_A)	F_(0,0)				FM(VI4_DATA19)	FM(VI5_DATA3)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP5_31_28	FM(D4)			FM(MSIOF2_SCK_B)F_(0,0)			F_(0,0)				FM(VI4_DATA20)	FM(VI5_DATA4)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP6_3_0		FM(D5)			FM(MSIOF2_SYNC_B)F_(0,0)		F_(0,0)				FM(VI4_DATA21)	FM(VI5_DATA5)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP6_7_4		FM(D6)			FM(MSIOF2_RXD_B)F_(0,0)			F_(0,0)				FM(VI4_DATA22)	FM(VI5_DATA6)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP6_11_8	FM(D7)			FM(MSIOF2_TXD_B)F_(0,0)			F_(0,0)				FM(VI4_DATA23)	FM(VI5_DATA7)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP6_15_12	FM(D8)			FM(LCDOUT0)	FM(MSIOF2_SCK_D)	FM(SCK4_C)			FM(VI4_DATA0_A)	F_(0,0)		FM(DU_DR0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP6_19_16	FM(D9)			FM(LCDOUT1)	FM(MSIOF2_SYNC_D)	F_(0,0)				FM(VI4_DATA1_A)	F_(0,0)		FM(DU_DR1)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP6_23_20	FM(D10)			FM(LCDOUT2)	FM(MSIOF2_RXD_D)	FM(HRX3_B)			FM(VI4_DATA2_A)	FM(CTS4_N_C)	FM(DU_DR2)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP6_27_24	FM(D11)			FM(LCDOUT3)	FM(MSIOF2_TXD_D)	FM(HTX3_B)			FM(VI4_DATA3_A)	FM(RTS4_N_TANS_C)FM(DU_DR3)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP6_31_28	FM(D12)			FM(LCDOUT4)	FM(MSIOF2_SS1_D)	FM(RX4_C)			FM(VI4_DATA4_A)	F_(0,0)		FM(DU_DR4)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP7_3_0		FM(D13)			FM(LCDOUT5)	FM(MSIOF2_SS2_D)	FM(TX4_C)			FM(VI4_DATA5_A)	F_(0,0)		FM(DU_DR5)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP7_7_4		FM(D14)			FM(LCDOUT6)	FM(MSIOF3_SS1_A)	FM(HRX3_C)			FM(VI4_DATA6_A)	F_(0,0)		FM(DU_DR6)		FM(SCL6_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP7_11_8	FM(D15)			FM(LCDOUT7)	FM(MSIOF3_SS2_A)	FM(HTX3_C)			FM(VI4_DATA7_A)	F_(0,0)		FM(DU_DR7)		FM(SDA6_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP7_15_12	FM(FSCLKST)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP7_19_16	FM(SD0_CLK)		F_(0,0)		FM(MSIOF1_SCK_E)	F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_OPWM_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+
+/* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */ 	/* 8 */			/* 9 */		/* A */		/* B */		/* C - F */
+#define IP7_23_20	FM(SD0_CMD)		F_(0,0)		FM(MSIOF1_SYNC_E)	F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_IVCXO27_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP7_27_24	FM(SD0_DAT0)		F_(0,0)		FM(MSIOF1_RXD_E)	F_(0,0)				F_(0,0)		FM(TS_SCK0_B)	FM(STP_ISCLK_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP7_31_28	FM(SD0_DAT1)		F_(0,0)		FM(MSIOF1_TXD_E)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC0_B)FM(STP_ISSYNC_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP8_3_0		FM(SD0_DAT2)		F_(0,0)		FM(MSIOF1_SS1_E)	F_(0,0)				F_(0,0)		FM(TS_SDAT0_B)	FM(STP_ISD_0_B)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP8_7_4		FM(SD0_DAT3)		F_(0,0)		FM(MSIOF1_SS2_E)	F_(0,0)				F_(0,0)		FM(TS_SDEN0_B)	FM(STP_ISEN_0_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP8_11_8	FM(SD1_CLK)		F_(0,0)		FM(MSIOF1_SCK_G)	F_(0,0)				F_(0,0)		FM(SIM0_CLK_A)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP8_15_12	FM(SD1_CMD)		F_(0,0)		FM(MSIOF1_SYNC_G)	F_(0,0)				F_(0,0)		FM(SIM0_D_A)	FM(STP_IVCXO27_1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP8_19_16	FM(SD1_DAT0)		FM(SD2_DAT4)	FM(MSIOF1_RXD_G)	F_(0,0)				F_(0,0)		FM(TS_SCK1_B)	FM(STP_ISCLK_1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP8_23_20	FM(SD1_DAT1)		FM(SD2_DAT5)	FM(MSIOF1_TXD_G)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC1_B)FM(STP_ISSYNC_1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP8_27_24	FM(SD1_DAT2)		FM(SD2_DAT6)	FM(MSIOF1_SS1_G)	F_(0,0)				F_(0,0)		FM(TS_SDAT1_B)	FM(STP_ISD_1_B)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP8_31_28	FM(SD1_DAT3)		FM(SD2_DAT7)	FM(MSIOF1_SS2_G)	F_(0,0)				F_(0,0)		FM(TS_SDEN1_B)	FM(STP_ISEN_1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP9_3_0		FM(SD2_CLK)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP9_7_4		FM(SD2_DAT0)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP9_11_8	FM(SD2_DAT1)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP9_15_12	FM(SD2_DAT2)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP9_19_16	FM(SD2_DAT3)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP9_23_20	FM(SD2_DS)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		FM(SATA_DEVSLP_B)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP9_27_24	FM(SD3_DAT4)		FM(SD2_CD_A)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP9_31_28	FM(SD3_DAT5)		FM(SD2_WP_A)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP10_3_0	FM(SD3_DAT6)		FM(SD3_CD)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP10_7_4	FM(SD3_DAT7)		FM(SD3_WP)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP10_11_8	FM(SD0_CD)		F_(0,0)		F_(0,0)			F_(0,0)				FM(SCL2_B)	FM(SIM0_RST_A)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP10_15_12	FM(SD0_WP)		F_(0,0)		F_(0,0)			F_(0,0)				FM(SDA2_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP10_19_16	FM(SD1_CD)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		FM(SIM0_CLK_B)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP10_23_20	FM(SD1_WP)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		FM(SIM0_D_B)	F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP10_27_24	FM(SCK0)		FM(HSCK1_B)	FM(MSIOF1_SS2_B)	FM(AUDIO_CLKC_B)		FM(SDA2_A)	FM(SIM0_RST_B)	FM(STP_OPWM_0_C)	FM(RIF0_CLK_B)	F_(0,0)			FM(ADICHS2)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP10_31_28	FM(RX0)			FM(HRX1_B)	F_(0,0)			F_(0,0)				F_(0,0)		FM(TS_SCK0_C)	FM(STP_ISCLK_0_C)	FM(RIF0_D0_B)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP11_3_0	FM(TX0)			FM(HTX1_B)	F_(0,0)			F_(0,0)				F_(0,0)		FM(TS_SPSYNC0_C)FM(STP_ISSYNC_0_C)	FM(RIF0_D1_B)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP11_7_4	FM(CTS0_N)		FM(HCTS1_N_B)	FM(MSIOF1_SYNC_B)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC1_C)FM(STP_ISSYNC_1_C)	FM(RIF1_SYNC_B)	FM(AUDIO_CLKOUT_C)	FM(ADICS_SAMP)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP11_11_8	FM(RTS0_N_TANS)		FM(HRTS1_N_B)	FM(MSIOF1_SS1_B)	FM(AUDIO_CLKA_B)		FM(SCL2_A)	F_(0,0)		FM(STP_IVCXO27_1_C)	FM(RIF0_SYNC_B)	F_(0,0)			FM(ADICHS1)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP11_15_12	FM(RX1_A)		FM(HRX1_A)	F_(0,0)			F_(0,0)				F_(0,0)		FM(TS_SDAT0_C)	FM(STP_ISD_0_C)		FM(RIF1_CLK_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP11_19_16	FM(TX1_A)		FM(HTX1_A)	F_(0,0)			F_(0,0)				F_(0,0)		FM(TS_SDEN0_C)	FM(STP_ISEN_0_C)	FM(RIF1_D0_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP11_23_20	FM(CTS1_N)		FM(HCTS1_N_A)	FM(MSIOF1_RXD_B)	F_(0,0)				F_(0,0)		FM(TS_SDEN1_C)	FM(STP_ISEN_1_C)	FM(RIF1_D0_B)	F_(0,0)			FM(ADIDATA)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP11_27_24	FM(RTS1_N_TANS)		FM(HRTS1_N_A)	FM(MSIOF1_TXD_B)	F_(0,0)				F_(0,0)		FM(TS_SDAT1_C)	FM(STP_ISD_1_C)		FM(RIF1_D1_B)	F_(0,0)			FM(ADICHS0)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP11_31_28	FM(SCK2)		FM(SCIF_CLK_B)	FM(MSIOF1_SCK_B)	F_(0,0)				F_(0,0)		FM(TS_SCK1_C)	FM(STP_ISCLK_1_C)	FM(RIF1_CLK_B)	F_(0,0)			FM(ADICLK)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP12_3_0	FM(TX2_A)		F_(0,0)		F_(0,0)			FM(SD2_CD_B)			FM(SCL1_A)	F_(0,0)		FM(FMCLK_A)		FM(RIF1_D1_C)	F_(0,0)			FM(FSO_CFE_0_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP12_7_4	FM(RX2_A)		F_(0,0)		F_(0,0)			FM(SD2_WP_B)			FM(SDA1_A)	F_(0,0)		FM(FMIN_A)		FM(RIF1_SYNC_C)	F_(0,0)			FM(FSO_CFE_1_B)	F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP12_11_8	FM(HSCK0)		F_(0,0)		FM(MSIOF1_SCK_D)	FM(AUDIO_CLKB_A)		FM(SSI_SDATA1_B)FM(TS_SCK0_D)	FM(STP_ISCLK_0_D)	FM(RIF0_CLK_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP12_15_12	FM(HRX0)		F_(0,0)		FM(MSIOF1_RXD_D)	F_(0,0)				FM(SSI_SDATA2_B)FM(TS_SDEN0_D)	FM(STP_ISEN_0_D)	FM(RIF0_D0_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP12_19_16	FM(HTX0)		F_(0,0)		FM(MSIOF1_TXD_D)	F_(0,0)				FM(SSI_SDATA9_B)FM(TS_SDAT0_D)	FM(STP_ISD_0_D)		FM(RIF0_D1_C)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP12_23_20	FM(HCTS0_N)		FM(RX2_B)	FM(MSIOF1_SYNC_D)	F_(0,0)				FM(SSI_SCK9_A)	FM(TS_SPSYNC0_D)FM(STP_ISSYNC_0_D)	FM(RIF0_SYNC_C)	FM(AUDIO_CLKOUT1_A)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP12_27_24	FM(HRTS0_N)		FM(TX2_B)	FM(MSIOF1_SS1_D)	F_(0,0)				FM(SSI_WS9_A)	F_(0,0)		FM(STP_IVCXO27_0_D)	FM(BPFCLK_A)	FM(AUDIO_CLKOUT2_A)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+
+/* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */ 	/* 8 */			/* 9 */		/* A */		/* B */		/* C - F */
+#define IP12_31_28	FM(MSIOF0_SYNC)		F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		FM(AUDIO_CLKOUT_A)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP13_3_0	FM(MSIOF0_SS1)		FM(RX5)		F_(0,0)			FM(AUDIO_CLKA_C)		FM(SSI_SCK2_A)	F_(0,0)		FM(STP_IVCXO27_0_C)	F_(0,0)		FM(AUDIO_CLKOUT3_A)	F_(0,0)		FM(TCLK1_B)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP13_7_4	FM(MSIOF0_SS2)		FM(TX5)		FM(MSIOF1_SS2_D)	FM(AUDIO_CLKC_A)		FM(SSI_WS2_A)	F_(0,0)		FM(STP_OPWM_0_D)	F_(0,0)		FM(AUDIO_CLKOUT_D)	F_(0,0)		FM(SPEEDIN_B)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP13_11_8	FM(MLB_CLK)		F_(0,0)		FM(MSIOF1_SCK_F)	F_(0,0)				FM(SCL1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP13_15_12	FM(MLB_SIG)		FM(RX1_B)	FM(MSIOF1_SYNC_F)	F_(0,0)				FM(SDA1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP13_19_16	FM(MLB_DAT)		FM(TX1_B)	FM(MSIOF1_RXD_F)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP13_23_20	FM(SSI_SCK0129)		F_(0,0)		FM(MSIOF1_TXD_F)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP13_27_24	FM(SSI_WS0129)		F_(0,0)		FM(MSIOF1_SS1_F)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP13_31_28	FM(SSI_SDATA0)		F_(0,0)		FM(MSIOF1_SS2_F)	F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP14_3_0	FM(SSI_SDATA1_A)	F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP14_7_4	FM(SSI_SDATA2_A)	F_(0,0)		F_(0,0)			F_(0,0)				FM(SSI_SCK1_B)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP14_11_8	FM(SSI_SCK34)		F_(0,0)		FM(MSIOF1_SS1_A)	F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_OPWM_0_A)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP14_15_12	FM(SSI_WS34)		FM(HCTS2_N_A)	FM(MSIOF1_SS2_A)	F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_IVCXO27_0_A)	F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP14_19_16	FM(SSI_SDATA3)		FM(HRTS2_N_A)	FM(MSIOF1_TXD_A)	F_(0,0)				F_(0,0)		FM(TS_SCK0_A)	FM(STP_ISCLK_0_A)	FM(RIF0_D1_A)	FM(RIF2_D0_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP14_23_20	FM(SSI_SCK4)		FM(HRX2_A)	FM(MSIOF1_SCK_A)	F_(0,0)				F_(0,0)		FM(TS_SDAT0_A)	FM(STP_ISD_0_A)		FM(RIF0_CLK_A)	FM(RIF2_CLK_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP14_27_24	FM(SSI_WS4)		FM(HTX2_A)	FM(MSIOF1_SYNC_A)	F_(0,0)				F_(0,0)		FM(TS_SDEN0_A)	FM(STP_ISEN_0_A)	FM(RIF0_SYNC_A)	FM(RIF2_SYNC_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP14_31_28	FM(SSI_SDATA4)		FM(HSCK2_A)	FM(MSIOF1_RXD_A)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC0_A)FM(STP_ISSYNC_0_A)	FM(RIF0_D0_A)	FM(RIF2_D1_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP15_3_0	FM(SSI_SCK6)		FM(USB2_PWEN)	F_(0,0)			FM(SIM0_RST_D)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP15_7_4	FM(SSI_WS6)		FM(USB2_OVC)	F_(0,0)			FM(SIM0_D_D)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP15_11_8	FM(SSI_SDATA6)		F_(0,0)		F_(0,0)			FM(SIM0_CLK_D)			F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		FM(SATA_DEVSLP_A)	F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP15_15_12	FM(SSI_SCK78)		FM(HRX2_B)	FM(MSIOF1_SCK_C)	F_(0,0)				F_(0,0)		FM(TS_SCK1_A)	FM(STP_ISCLK_1_A)	FM(RIF1_CLK_A)	FM(RIF3_CLK_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP15_19_16	FM(SSI_WS78)		FM(HTX2_B)	FM(MSIOF1_SYNC_C)	F_(0,0)				F_(0,0)		FM(TS_SDAT1_A)	FM(STP_ISD_1_A)		FM(RIF1_SYNC_A)	FM(RIF3_SYNC_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP15_23_20	FM(SSI_SDATA7)		FM(HCTS2_N_B)	FM(MSIOF1_RXD_C)	F_(0,0)				F_(0,0)		FM(TS_SDEN1_A)	FM(STP_ISEN_1_A)	FM(RIF1_D0_A)	FM(RIF3_D0_A)		F_(0,0)		FM(TCLK2_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP15_27_24	FM(SSI_SDATA8)		FM(HRTS2_N_B)	FM(MSIOF1_TXD_C)	F_(0,0)				F_(0,0)		FM(TS_SPSYNC1_A)FM(STP_ISSYNC_1_A)	FM(RIF1_D1_A)	FM(RIF3_D1_A)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP15_31_28	FM(SSI_SDATA9_A)	FM(HSCK2_B)	FM(MSIOF1_SS1_C)	FM(HSCK1_A)			FM(SSI_WS1_B)	FM(SCK1)	FM(STP_IVCXO27_1_A)	FM(SCK5)	F_(0,0)			F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP16_3_0	FM(AUDIO_CLKA_A)	F_(0,0)		F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)			F_(0,0)		F_(0,0)		FM(CC5_OSCOUT)	F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP16_7_4	FM(AUDIO_CLKB_B)	FM(SCIF_CLK_A)	F_(0,0)			F_(0,0)				F_(0,0)		F_(0,0)		FM(STP_IVCXO27_1_D)	FM(REMOCON_A)	F_(0,0)			F_(0,0)		FM(TCLK1_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP16_11_8	FM(USB0_PWEN)		F_(0,0)		F_(0,0)			FM(SIM0_RST_C)			F_(0,0)		FM(TS_SCK1_D)	FM(STP_ISCLK_1_D)	FM(BPFCLK_B)	FM(RIF3_CLK_B)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP16_15_12	FM(USB0_OVC)		F_(0,0)		F_(0,0)			FM(SIM0_D_C)			F_(0,0)		FM(TS_SDAT1_D)	FM(STP_ISD_1_D)		F_(0,0)		FM(RIF3_SYNC_B)		F_(0,0)		F_(0,0)		F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP16_19_16	FM(USB1_PWEN)		F_(0,0)		F_(0,0)			FM(SIM0_CLK_C)			FM(SSI_SCK1_A)	FM(TS_SCK0_E)	FM(STP_ISCLK_0_E)	FM(FMCLK_B)	FM(RIF2_CLK_B)		F_(0,0)		FM(SPEEDIN_A)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP16_23_20	FM(USB1_OVC)		F_(0,0)		FM(MSIOF1_SS2_C)	F_(0,0)				FM(SSI_WS1_A)	FM(TS_SDAT0_E)	FM(STP_ISD_0_E)		FM(FMIN_B)	FM(RIF2_SYNC_B)		F_(0,0)		FM(REMOCON_B)	F_(0,0)		F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP16_27_24	FM(USB30_PWEN)		F_(0,0)		F_(0,0)			FM(AUDIO_CLKOUT_B)		FM(SSI_SCK2_B)	FM(TS_SDEN1_D)	FM(STP_ISEN_1_D)	FM(STP_OPWM_0_E)FM(RIF3_D0_B)		F_(0,0)		FM(TCLK2_B)	FM(TPU0TO0)	F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP16_31_28	FM(USB30_OVC)		F_(0,0)		F_(0,0)			FM(AUDIO_CLKOUT1_B)		FM(SSI_WS2_B)	FM(TS_SPSYNC1_D)FM(STP_ISSYNC_1_D)	FM(STP_IVCXO27_0_E)FM(RIF3_D1_B)	F_(0,0)		FM(FSO_TOE_B)	FM(TPU0TO1)	F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP17_3_0	FM(USB31_PWEN)		F_(0,0)		F_(0,0)			FM(AUDIO_CLKOUT2_B)		FM(SSI_SCK9_B)	FM(TS_SDEN0_E)	FM(STP_ISEN_0_E)	F_(0,0)		FM(RIF2_D0_B)		F_(0,0)		F_(0,0)		FM(TPU0TO2)	F_(0,0) F_(0,0) F_(0,0) F_(0,0)
+#define IP17_7_4	FM(USB31_OVC)		F_(0,0)		F_(0,0)			FM(AUDIO_CLKOUT3_B)		FM(SSI_WS9_B)	FM(TS_SPSYNC0_E)FM(STP_ISSYNC_0_E)	F_(0,0)		FM(RIF2_D1_B)		F_(0,0)		F_(0,0)		FM(TPU0TO3)	F_(0,0) F_(0,0) F_(0,0) F_(0,0)
 
 #define PINMUX_GPSR	\
 \
-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
