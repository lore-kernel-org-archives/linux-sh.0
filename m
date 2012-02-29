From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 12:37:12 +0000
Subject: [PATCH 02/06] ARM: mach-shmobile: sh7377 map_io and init_early update
Message-Id: <20120229123712.28584.859.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7377 SoC and the G4EVM board to make use of the
functions sh7377_map_io() and sh7377_add_early_devices().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-g4evm.c         |   25 ++-----------------------
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/setup-sh7377.c        |   22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 23 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c	2012-02-29 17:08:51.000000000 +0900
@@ -38,7 +38,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
 /*
@@ -260,27 +259,6 @@ static struct platform_device *g4evm_dev
 	&sdhi1_device,
 };
 
-static struct map_desc g4evm_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
-	 * used by CPGA, INTC and PFC.
-	 */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 256 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init g4evm_map_io(void)
-{
-	iotable_init(g4evm_io_desc, ARRAY_SIZE(g4evm_io_desc));
-
-	/* setup early devices and console here as well */
-	sh7377_add_early_devices();
-	shmobile_setup_console();
-}
-
 #define GPIO_SDHID0_D0	0xe60520fc
 #define GPIO_SDHID0_D1	0xe60520fd
 #define GPIO_SDHID0_D2	0xe60520fe
@@ -408,7 +386,8 @@ static struct sys_timer g4evm_timer = {
 };
 
 MACHINE_START(G4EVM, "g4evm")
-	.map_io		= g4evm_map_io,
+	.map_io		= sh7377_map_io,
+	.init_early	= sh7377_add_early_devices,
 	.init_irq	= sh7377_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g4evm_init,
--- 0004/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-02-29 17:06:31.000000000 +0900
@@ -22,6 +22,7 @@ extern struct clk sh7367_extalb1_clk;
 extern struct clk sh7367_extal2_clk;
 
 extern void sh7377_init_irq(void);
+extern void sh7377_map_io(void);
 extern void sh7377_add_early_devices(void);
 extern void sh7377_add_standard_devices(void);
 extern void sh7377_clock_init(void);
--- 0001/arch/arm/mach-shmobile/setup-sh7377.c
+++ work/arch/arm/mach-shmobile/setup-sh7377.c	2012-02-29 17:08:45.000000000 +0900
@@ -30,9 +30,28 @@
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/common.h>
+#include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static struct map_desc sh7377_io_desc[] __initdata = {
+	/* create a 1:1 entity map for 0xe6xxxxxx
+	 * used by CPGA, INTC and PFC.
+	 */
+	{
+		.virtual	= 0xe6000000,
+		.pfn		= __phys_to_pfn(0xe6000000),
+		.length		= 256 << 20,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+void __init sh7377_map_io(void)
+{
+	iotable_init(sh7377_io_desc, ARRAY_SIZE(sh7377_io_desc));
+}
+
 /* SCIFA0 */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
@@ -466,4 +485,7 @@ void __init sh7377_add_early_devices(voi
 
 	early_platform_add_devices(sh7377_early_devices,
 				   ARRAY_SIZE(sh7377_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
 }
