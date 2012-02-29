From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 12:37:19 +0000
Subject: [PATCH 03/06] ARM: mach-shmobile: sh7372 map_io and init_early update
Message-Id: <20120229123719.28584.89828.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7372 SoC and the AP4EVB and Mackerel boards to make use
of the functions sh7372_map_io() and sh7372_add_early_devices().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c        |   25 ++-----------------------
 arch/arm/mach-shmobile/board-mackerel.c      |   25 ++-----------------------
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/setup-sh7372.c        |   22 ++++++++++++++++++++++
 4 files changed, 27 insertions(+), 46 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2012-02-29 17:03:11.000000000 +0900
@@ -61,7 +61,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/setup.h>
 
@@ -1190,27 +1189,6 @@ static struct i2c_board_info i2c1_device
 	},
 };
 
-static struct map_desc ap4evb_io_desc[] __initdata = {
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
-static void __init ap4evb_map_io(void)
-{
-	iotable_init(ap4evb_io_desc, ARRAY_SIZE(ap4evb_io_desc));
-
-	/* setup early devices and console here as well */
-	sh7372_add_early_devices();
-	shmobile_setup_console();
-}
-
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
 #define USCCR1		0xE6058144
@@ -1469,7 +1447,8 @@ static struct sys_timer ap4evb_timer = {
 };
 
 MACHINE_START(AP4EVB, "ap4evb")
-	.map_io		= ap4evb_map_io,
+	.map_io		= sh7372_map_io,
+	.init_early	= sh7372_add_early_devices,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= ap4evb_init,
--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2012-02-29 17:03:01.000000000 +0900
@@ -58,7 +58,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/mach/map.h>
 #include <asm/mach-types.h>
 
 /*
@@ -1337,27 +1336,6 @@ static struct i2c_board_info i2c1_device
 	},
 };
 
-static struct map_desc mackerel_io_desc[] __initdata = {
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
-static void __init mackerel_map_io(void)
-{
-	iotable_init(mackerel_io_desc, ARRAY_SIZE(mackerel_io_desc));
-
-	/* setup early devices and console here as well */
-	sh7372_add_early_devices();
-	shmobile_setup_console();
-}
-
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
 #define GPIO_PORT167CR	0xE60520A7
@@ -1587,7 +1565,8 @@ static struct sys_timer mackerel_timer  };
 
 MACHINE_START(MACKEREL, "mackerel")
-	.map_io		= mackerel_map_io,
+	.map_io		= sh7372_map_io,
+	.init_early	= sh7372_add_early_devices,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= mackerel_init,
--- 0003/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-02-29 16:57:21.000000000 +0900
@@ -30,6 +30,7 @@ extern struct clk sh7377_extalc1_clk;
 extern struct clk sh7377_extal2_clk;
 
 extern void sh7372_init_irq(void);
+extern void sh7372_map_io(void);
 extern void sh7372_add_early_devices(void);
 extern void sh7372_add_standard_devices(void);
 extern void sh7372_clock_init(void);
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2012-02-29 16:59:58.000000000 +0900
@@ -33,9 +33,28 @@
 #include <linux/pm_domain.h>
 #include <mach/hardware.h>
 #include <mach/sh7372.h>
+#include <mach/common.h>
+#include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static struct map_desc sh7372_io_desc[] __initdata = {
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
+void __init sh7372_map_io(void)
+{
+	iotable_init(sh7372_io_desc, ARRAY_SIZE(sh7372_io_desc));
+}
+
 /* SCIFA0 */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
@@ -1049,4 +1068,7 @@ void __init sh7372_add_early_devices(voi
 {
 	early_platform_add_devices(sh7372_early_devices,
 				   ARRAY_SIZE(sh7372_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
 }
