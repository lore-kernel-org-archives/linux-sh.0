From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 Mar 2012 05:54:06 +0000
Subject: [PATCH 03/03] ARM: mach-shmobile: sh73a0 generic board support via DT
Message-Id: <20120307055406.20126.40319.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add generic DT board support for the sh73a0 SoC.

SCIF serial ports and timers are kept as regular
platform devices. Other on-chip and on-board devices
should be configured via the device tree.

Tested on the kota2 board via kexec using a zImage
kernel with an appended dtb.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh73a0.c |   41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--- 0037/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2012-03-07 13:34:29.000000000 +0900
@@ -37,6 +37,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
 
 static struct map_desc sh73a0_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
@@ -704,3 +705,43 @@ void __init sh73a0_add_early_devices(voi
 	/* override timer setup with soc-specific code */
 	shmobile_timer.init = sh73a0_earlytimer_init;
 }
+
+#ifdef CONFIG_USE_OF
+
+void __init sh73a0_add_early_devices_dt(void)
+{
+	shmobile_setup_delay(1196, 1, 3); /* Cortex-A9 @ 1196MHz */
+
+	early_platform_add_devices(sh73a0_early_devices,
+				   ARRAY_SIZE(sh73a0_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
+}
+
+void __init sh73a0_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	sh73a0_clock_init();
+
+	platform_add_devices(sh73a0_early_devices,
+			    ARRAY_SIZE(sh73a0_early_devices));
+}
+
+static const char *sh73a0_boards_compat_dt[] __initdata = {
+	"renesas,sh73a0",
+	NULL,
+};
+
+DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
+	.map_io		= sh73a0_map_io,
+	.init_early	= sh73a0_add_early_devices_dt,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= sh73a0_init_irq,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= sh73a0_add_standard_devices_dt,
+	.timer		= &shmobile_timer,
+	.dt_compat	= sh73a0_boards_compat_dt,
+MACHINE_END
+
+#endif /* CONFIG_USE_OF */
