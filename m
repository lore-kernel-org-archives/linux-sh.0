From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 10:16:11 +0000
Subject: [PATCH] sh: Use clk_always_enable() on sh7722 / Migo-R / SE7722
Message-Id: <20080717101611.19619.77427.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717101334.19615.87712.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080717101334.19615.87712.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use clk_always_enable() on the sh7722 processor and in the board code
for Migo-R and Solution Engine 7722. Remove duplicate MSTPCR register
definitions.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c   |    7 +++----
 arch/sh/boards/se/7722/setup.c         |    8 +++-----
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   14 ++++++++++++++
 include/asm-sh/migor.h                 |    4 ----
 include/asm-sh/se7722.h                |    4 ----
 5 files changed, 20 insertions(+), 17 deletions(-)

--- 0001/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-07-17 17:30:48.000000000 +0900
@@ -15,6 +15,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
 #include <linux/smc91x.h>
+#include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
@@ -218,6 +219,8 @@ static struct i2c_board_info __initdata 
 
 static int __init migor_devices_setup(void)
 {
+	clk_always_enable("mstp214"); /* KEYSC */
+
 	i2c_register_board_info(0, migor_i2c_devices,
 				ARRAY_SIZE(migor_i2c_devices));
  
@@ -236,16 +239,12 @@ static void __init migor_setup(char **cm
 	ctrl_outw(ctrl_inw(PORT_PSELA) & ~0x4100, PORT_PSELA);
 	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x4000, PORT_HIZCRA);
 	ctrl_outw(ctrl_inw(PORT_HIZCRC) & ~0xc000, PORT_HIZCRC);
-	ctrl_outl(ctrl_inl(MSTPCR2) & ~0x00004000, MSTPCR2);
 
 	/* NAND Flash */
 	ctrl_outw(ctrl_inw(PORT_PXCR) & 0x0fff, PORT_PXCR);
 	ctrl_outl((ctrl_inl(BSC_CS6ABCR) & ~0x00000600) | 0x00000200,
 		  BSC_CS6ABCR);
 
-	/* I2C */
-	ctrl_outl(ctrl_inl(MSTPCR1) & ~0x00000200, MSTPCR1);
-
 	/* Touch Panel - Enable IRQ6 */
 	ctrl_outw(ctrl_inw(PORT_PZCR) & ~0xc, PORT_PZCR);
 	ctrl_outw((ctrl_inw(PORT_PSELA) | 0x8000), PORT_PSELA);
--- 0001/arch/sh/boards/se/7722/setup.c
+++ work/arch/sh/boards/se/7722/setup.c	2008-07-17 17:31:07.000000000 +0900
@@ -16,6 +16,7 @@
 #include <linux/input.h>
 #include <linux/smc91x.h>
 #include <asm/machvec.h>
+#include <asm/clock.h>
 #include <asm/se7722.h>
 #include <asm/io.h>
 #include <asm/heartbeat.h>
@@ -145,6 +146,8 @@ static struct platform_device *se7722_de
 
 static int __init se7722_devices_setup(void)
 {
+	clk_always_enable("mstp214"); /* KEYSC */
+
 	return platform_add_devices(se7722_devices,
 		ARRAY_SIZE(se7722_devices));
 }
@@ -154,11 +157,6 @@ static void __init se7722_setup(char **c
 {
 	ctrl_outw(0x010D, FPGA_OUT);    /* FPGA */
 
-	ctrl_outl(0x00051001, MSTPCR0);
-	ctrl_outl(0x00000000, MSTPCR1);
-	/* KEYSC, VOU, BEU, CEU, VEU, VPU, LCDC, USB */
-	ctrl_outl(0xffffb7c0, MSTPCR2);
-
 	ctrl_outw(0x0000, PORT_PECR);   /* PORT E 1 = IRQ5 ,E 0 = BS */
 	ctrl_outw(0x1000, PORT_PJCR);   /* PORT J 1 = IRQ1,J 0 =IRQ0 */
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-07-17 16:37:42.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/serial_sci.h>
 #include <linux/mm.h>
 #include <linux/uio_driver.h>
+#include <asm/clock.h>
 #include <asm/mmzone.h>
 
 static struct resource usbf_resources[] = {
@@ -158,8 +159,21 @@ static struct platform_device *sh7722_de
 
 static int __init sh7722_devices_setup(void)
 {
+	clk_always_enable("mstp031"); /* TLB */
+	clk_always_enable("mstp030"); /* IC */
+	clk_always_enable("mstp029"); /* OC */
+	clk_always_enable("mstp028"); /* URAM */
+	clk_always_enable("mstp026"); /* XYMEM */
+	clk_always_enable("mstp022"); /* INTC */
+	clk_always_enable("mstp020"); /* SuperHyway */
+	clk_always_enable("mstp109"); /* I2C */
+	clk_always_enable("mstp211"); /* USB */
+	clk_always_enable("mstp202"); /* VEU */
+	clk_always_enable("mstp201"); /* VPU */
+
 	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
 	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
+
 	return platform_add_devices(sh7722_devices,
 				    ARRAY_SIZE(sh7722_devices));
 }
--- 0001/include/asm-sh/migor.h
+++ work/include/asm-sh/migor.h	2008-07-17 17:24:54.000000000 +0900
@@ -16,10 +16,6 @@
 #include <asm/addrspace.h>
 
 /* GPIO */
-#define MSTPCR0 0xa4150030
-#define MSTPCR1 0xa4150034
-#define MSTPCR2 0xa4150038
-
 #define PORT_PACR 0xa4050100
 #define PORT_PDCR 0xa4050106
 #define PORT_PECR 0xa4050108
--- 0001/include/asm-sh/se7722.h
+++ work/include/asm-sh/se7722.h	2008-07-17 17:28:15.000000000 +0900
@@ -55,10 +55,6 @@
 
 #define PA_LAN		(PA_AREA6_IO + 0)		/* SMC LAN91C111 */
 /* GPIO */
-#define MSTPCR0         0xA4150030UL
-#define MSTPCR1         0xA4150034UL
-#define MSTPCR2         0xA4150038UL
-
 #define FPGA_IN         0xb1840000UL
 #define FPGA_OUT        0xb1840004UL
 
