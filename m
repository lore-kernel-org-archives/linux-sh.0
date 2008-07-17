From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 10:13:34 +0000
Subject: [PATCH] sh: Use clk_always_enable() on sh7723 / ap325rxa
Message-Id: <20080717101334.19615.87712.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use clk_always_enable() on the sh7723 processor and in the ap325rxa
board code. Remove duplicate MSTPCR register definitions.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/ap325rxa/setup.c |   12 ------------
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c  |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 12 deletions(-)

--- 0001/arch/sh/boards/renesas/ap325rxa/setup.c
+++ work/arch/sh/boards/renesas/ap325rxa/setup.c	2008-07-17 12:43:05.000000000 +0900
@@ -97,20 +97,8 @@ static int __init ap325rxa_devices_setup
 }
 device_initcall(ap325rxa_devices_setup);
 
-#define MSTPCR0		(0xA4150030)
-#define MSTPCR1		(0xA4150034)
-#define MSTPCR2		(0xA4150038)
-
 static void __init ap325rxa_setup(char **cmdline_p)
 {
-	/* enable VEU0 + VEU1 */
-	ctrl_outl(ctrl_inl(MSTPCR2) & ~0x00000044, MSTPCR2);	/* bit 2 + 6 */
-
-	/* enable MERAM */
-	ctrl_outl(ctrl_inl(MSTPCR0) & ~0x00000001, MSTPCR0);	/* bit 0 */
-
-	/* I2C */
-	ctrl_outl(ctrl_inl(MSTPCR1) & ~0x00000200, MSTPCR1);
 }
 
 static struct sh_machine_vector mv_ap325rxa __initmv = {
--- 0007/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-07-17 13:05:10.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <asm/clock.h>
 #include <asm/mmzone.h>
 
 static struct uio_info vpu_platform_data = {
@@ -230,9 +231,24 @@ static struct platform_device *sh7723_de
 
 static int __init sh7723_devices_setup(void)
 {
+	clk_always_enable("mstp031"); /* TLB */
+	clk_always_enable("mstp030"); /* IC */
+	clk_always_enable("mstp029"); /* OC */
+	clk_always_enable("mstp024"); /* FPU */
+	clk_always_enable("mstp022"); /* INTC */
+	clk_always_enable("mstp020"); /* SuperHyway */
+	clk_always_enable("mstp000"); /* MERAM */
+	clk_always_enable("mstp109"); /* I2C */
+	clk_always_enable("mstp108"); /* RTC */
+	clk_always_enable("mstp211"); /* USB */
+	clk_always_enable("mstp206"); /* VEU2H1 */
+	clk_always_enable("mstp202"); /* VEU2H0 */
+	clk_always_enable("mstp201"); /* VPU */
+
 	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
 	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
 	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
+
 	return platform_add_devices(sh7723_devices,
 				    ARRAY_SIZE(sh7723_devices));
 }
