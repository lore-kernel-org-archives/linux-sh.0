From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 May 2011 10:39:22 +0000
Subject: [PATCH] ARM: mach-shmobile: Disable sh7372 RT side MSTP bits
Message-Id: <20110517103922.4804.18418.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7372 clock code to set the RT side
set of MSTP bits to a fixed disabled state.

The sh7372 SoC contains two sets of MSTP bits,
one for the ARM (SYS) side, and one for the
SH4AL-DSP (RT) side. The actual clock associated
with the MSTP bit will only be stopped when both
sides have set the MSTP bit to disabled mode.

Some MSTP bits are enabled by default after
hardware reset, so this patch adjusts the code
to disable all MSTP bits associated with the RT
side to allow the SYS side to have full control.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7372.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2011-05-17 19:30:43.000000000 +0900
@@ -44,6 +44,11 @@
 #define DSI1PCKCR	0xe6150098
 #define PLLC01CR	0xe6150028
 #define PLLC2CR		0xe615002c
+#define RMSTPCR0	0xe6150110
+#define RMSTPCR1	0xe6150114
+#define RMSTPCR2	0xe6150118
+#define RMSTPCR3	0xe615011c
+#define RMSTPCR4	0xe6150120
 #define SMSTPCR0	0xe6150130
 #define SMSTPCR1	0xe6150134
 #define SMSTPCR2	0xe6150138
@@ -652,6 +657,13 @@ void __init sh7372_clock_init(void)
 {
 	int k, ret = 0;
 
+	/* make sure MSTP bits on the RT/SH4AL-DSP side are off */
+	__raw_writel(0xe4ef8087, RMSTPCR0);
+	__raw_writel(0xffffffff, RMSTPCR1);
+	__raw_writel(0x37c7f7ff, RMSTPCR2);
+	__raw_writel(0xffffffff, RMSTPCR3);
+	__raw_writel(0xffe0fffd, RMSTPCR4);
+
 	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
 		ret = clk_register(main_clks[k]);
 
