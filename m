From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 12:37:43 +0000
Subject: [PATCH 06/06] ARM: mach-shmobile: r8a7779 map_io and init_early update
Message-Id: <20120229123743.28584.65308.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7779 SoC and the Marzen board to make use of
the functions r8a7779_map_io() and r8a7779_add_early_devices().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen.c        |   48 +-------------------------
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/setup-r8a7779.c       |   39 +++++++++++++++++++++
 3 files changed, 42 insertions(+), 46 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2012-02-29 17:25:26.000000000 +0900
@@ -33,7 +33,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
 #include <asm/traps.h>
@@ -72,49 +71,6 @@ static struct platform_device *marzen_de
 	&eth_device,
 };
 
-static struct map_desc marzen_io_desc[] __initdata = {
-	/* 2M entity map for 0xf0000000 (MPCORE) */
-	{
-		.virtual	= 0xf0000000,
-		.pfn		= __phys_to_pfn(0xf0000000),
-		.length		= SZ_2M,
-		.type		= MT_DEVICE_NONSHARED
-	},
-	/* 16M entity map for 0xfexxxxxx (DMAC-S/HPBREG/INTC2/LRAM/DBSC) */
-	{
-		.virtual	= 0xfe000000,
-		.pfn		= __phys_to_pfn(0xfe000000),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init marzen_map_io(void)
-{
-	iotable_init(marzen_io_desc, ARRAY_SIZE(marzen_io_desc));
-}
-
-static void __init marzen_init_early(void)
-{
-	r8a7779_add_early_devices();
-
-	/* Early serial console setup is not included here due to
-	 * memory map collisions. The SCIF serial ports in r8a7779
-	 * are difficult to entity map 1:1 due to collision with the
-	 * virtual memory range used by the coherent DMA code on ARM.
-	 *
-	 * Anyone wanting to debug early can remove UPF_IOREMAP from
-	 * the sh-sci serial console platform data, adjust mapbase
-	 * to a static M:N virt:phys mapping that needs to be added to
-	 * the mappings passed with iotable_init() above.
-	 *
-	 * Then add a call to shmobile_setup_console() from this function.
-	 *
-	 * As a final step pass earlyprint=sh-sci.2,115200 on the kernel
-	 * command line.
-	 */
-}
-
 static void __init marzen_init(void)
 {
 	r8a7779_pinmux_init();
@@ -147,8 +103,8 @@ struct sys_timer marzen_timer = {
 };
 
 MACHINE_START(MARZEN, "marzen")
-	.map_io		= marzen_map_io,
-	.init_early	= marzen_init_early,
+	.map_io		= r8a7779_map_io,
+	.init_early	= r8a7779_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq,
 	.handle_irq	= gic_handle_irq,
--- 0006/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-02-29 17:23:50.000000000 +0900
@@ -66,6 +66,7 @@ extern void r8a7740_clock_init(u8 md_ck)
 extern void r8a7740_pinmux_init(void);
 
 extern void r8a7779_init_irq(void);
+extern void r8a7779_map_io(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_clock_init(void);
--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2012-02-29 17:25:28.000000000 +0900
@@ -33,6 +33,29 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+static struct map_desc r8a7779_io_desc[] __initdata = {
+	/* 2M entity map for 0xf0000000 (MPCORE) */
+	{
+		.virtual	= 0xf0000000,
+		.pfn		= __phys_to_pfn(0xf0000000),
+		.length		= SZ_2M,
+		.type		= MT_DEVICE_NONSHARED
+	},
+	/* 16M entity map for 0xfexxxxxx (DMAC-S/HPBREG/INTC2/LRAM/DBSC) */
+	{
+		.virtual	= 0xfe000000,
+		.pfn		= __phys_to_pfn(0xfe000000),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+void __init r8a7779_map_io(void)
+{
+	iotable_init(r8a7779_io_desc, ARRAY_SIZE(r8a7779_io_desc));
+}
 
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffe40000,
@@ -236,4 +259,20 @@ void __init r8a7779_add_early_devices(vo
 {
 	early_platform_add_devices(r8a7779_early_devices,
 				   ARRAY_SIZE(r8a7779_early_devices));
+
+	/* Early serial console setup is not included here due to
+	 * memory map collisions. The SCIF serial ports in r8a7779
+	 * are difficult to entity map 1:1 due to collision with the
+	 * virtual memory range used by the coherent DMA code on ARM.
+	 *
+	 * Anyone wanting to debug early can remove UPF_IOREMAP from
+	 * the sh-sci serial console platform data, adjust mapbase
+	 * to a static M:N virt:phys mapping that needs to be added to
+	 * the mappings passed with iotable_init() above.
+	 *
+	 * Then add a call to shmobile_setup_console() from this function.
+	 *
+	 * As a final step pass earlyprint=sh-sci.2,115200 on the kernel
+	 * command line in case of the marzen board.
+	 */
 }
