From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 12:37:04 +0000
Subject: [PATCH 01/06] ARM: mach-shmobile: sh7367 map_io and init_early update
Message-Id: <20120229123704.28584.77727.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7367 SoC and the G3EVM board to make use of the
functions sh7367_map_io() and sh7367_add_early_devices().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-g3evm.c         |   25 ++-----------------------
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/setup-sh7367.c        |   22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 23 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2012-02-29 17:31:57.000000000 +0900
@@ -37,7 +37,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
 /*
@@ -246,27 +245,6 @@ static struct platform_device *g3evm_dev
 	&irda_device,
 };
 
-static struct map_desc g3evm_io_desc[] __initdata = {
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
-static void __init g3evm_map_io(void)
-{
-	iotable_init(g3evm_io_desc, ARRAY_SIZE(g3evm_io_desc));
-
-	/* setup early devices and console here as well */
-	sh7367_add_early_devices();
-	shmobile_setup_console();
-}
-
 static void __init g3evm_init(void)
 {
 	sh7367_pinmux_init();
@@ -365,7 +343,8 @@ static struct sys_timer g3evm_timer = {
 };
 
 MACHINE_START(G3EVM, "g3evm")
-	.map_io		= g3evm_map_io,
+	.map_io		= sh7367_map_io,
+	.init_early	= sh7367_add_early_devices,
 	.init_irq	= sh7367_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g3evm_init,
--- 0007/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-02-29 17:31:47.000000000 +0900
@@ -14,6 +14,7 @@ extern void (*shmobile_cpuidle_modes[])(
 extern void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
 
 extern void sh7367_init_irq(void);
+extern void sh7367_map_io(void);
 extern void sh7367_add_early_devices(void);
 extern void sh7367_add_standard_devices(void);
 extern void sh7367_clock_init(void);
--- 0001/arch/arm/mach-shmobile/setup-sh7367.c
+++ work/arch/arm/mach-shmobile/setup-sh7367.c	2012-02-29 17:31:23.000000000 +0900
@@ -29,8 +29,27 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+static struct map_desc sh7367_io_desc[] __initdata = {
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
+void __init sh7367_map_io(void)
+{
+	iotable_init(sh7367_io_desc, ARRAY_SIZE(sh7367_io_desc));
+}
 
 /* SCIFA0 */
 static struct plat_sci_port scif0_platform_data = {
@@ -445,4 +464,7 @@ void __init sh7367_add_early_devices(voi
 
 	early_platform_add_devices(sh7367_early_devices,
 				   ARRAY_SIZE(sh7367_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
 }
