From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 10:18:24 +0000
Subject: [PATCH] sh: Use clk_always_enable() on sh7343 / SE77343
Message-Id: <20080717101824.19622.35284.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717101334.19615.87712.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080717101334.19615.87712.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use clk_always_enable() on the sh7343 processor and in the board code
for Solution Engine 7343. Remove duplicate MSTPCR register definitions.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/se/7343/setup.c         |    4 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   15 +++++++++++++++
 include/asm-sh/se7343.h                |    4 ----
 3 files changed, 15 insertions(+), 8 deletions(-)

--- 0001/arch/sh/boards/se/7343/setup.c
+++ work/arch/sh/boards/se/7343/setup.c	2008-07-17 18:21:58.000000000 +0900
@@ -114,10 +114,6 @@ static void __init sh7343se_setup(char *
 {
 	ctrl_outw(0xf900, FPGA_OUT);	/* FPGA */
 
-	ctrl_outl(0x00001001, MSTPCR0);
-	ctrl_outl(0x00000000, MSTPCR1);
-	ctrl_outl(0xffffbfC0, MSTPCR2);	/* LCDC, BEU, CEU, VEU, KEYSC */
-
 	ctrl_outw(0x0002, PORT_PECR);	/* PORT E 1 = IRQ5 */
 	ctrl_outw(0x0020, PORT_PSELD);
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-07-17 18:25:46.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <asm/clock.h>
 
 static struct resource iic0_resources[] = {
 	[0] = {
@@ -138,8 +139,22 @@ static struct platform_device *sh7343_de
 
 static int __init sh7343_devices_setup(void)
 {
+	clk_always_enable("mstp031"); /* TLB */
+	clk_always_enable("mstp030"); /* IC */
+	clk_always_enable("mstp029"); /* OC */
+	clk_always_enable("mstp028"); /* URAM */
+	clk_always_enable("mstp026"); /* XYMEM */
+	clk_always_enable("mstp023"); /* INTC3 */
+	clk_always_enable("mstp022"); /* INTC */
+	clk_always_enable("mstp020"); /* SuperHyway */
+	clk_always_enable("mstp109"); /* I2C0 */
+	clk_always_enable("mstp108"); /* I2C1 */
+	clk_always_enable("mstp202"); /* VEU */
+	clk_always_enable("mstp201"); /* VPU */
+
 	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
 	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
+
 	return platform_add_devices(sh7343_devices,
 				    ARRAY_SIZE(sh7343_devices));
 }
--- 0001/include/asm-sh/se7343.h
+++ work/include/asm-sh/se7343.h	2008-07-17 18:22:12.000000000 +0900
@@ -115,10 +115,6 @@
 #define PORT_PWDR  	0xA4050166
 #define PORT_PYDR  	0xA4050168
 
-#define MSTPCR0		0xA4150030
-#define MSTPCR1		0xA4150034
-#define MSTPCR2		0xA4150038
-
 #define FPGA_IN		0xb1400000
 #define FPGA_OUT	0xb1400002
 
