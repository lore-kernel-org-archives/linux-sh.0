From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jul 2012 08:08:07 +0000
Subject: [PATCH] ARM: mach-shmobile: r8a7740 generic board support via DT
Message-Id: <20120706080807.25490.53587.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add generic DT board support for the r8a7740 SoC.

SCIF serial ports and timers are kept as regular
platform devices. Other on-chip and on-board devices
should be configured via the device tree.

At this point there is no interrupt controller support
in place but such code will be added over time when
proper IRQ domain support has been added to INTC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7740.dtsi         |   21 ++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c |   47 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

--- /dev/null
+++ work/arch/arm/boot/dts/r8a7740.dtsi	2012-07-06 16:44:11.000000000 +0900
@@ -0,0 +1,21 @@
+/*
+ * Device Tree Source for the r8a7740 SoC
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "renesas,r8a7740";
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+};
--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2012-07-06 16:51:47.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
@@ -694,3 +695,49 @@ void __init r8a7740_add_early_devices(vo
 	/* override timer setup with soc-specific code */
 	shmobile_timer.init = r8a7740_earlytimer_init;
 }
+
+#ifdef CONFIG_USE_OF
+
+void __init r8a7740_add_early_devices_dt(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+
+	early_platform_add_devices(r8a7740_early_devices,
+				   ARRAY_SIZE(r8a7740_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
+}
+
+static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
+	{ }
+};
+
+void __init r8a7740_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	r8a7740_clock_init(0);
+
+	platform_add_devices(r8a7740_early_devices,
+			    ARRAY_SIZE(r8a7740_early_devices));
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     r8a7740_auxdata_lookup, NULL);
+}
+
+static const char *r8a7740_boards_compat_dt[] __initdata = {
+	"renesas,r8a7740",
+	NULL,
+};
+
+DT_MACHINE_START(SH7372_DT, "Generic R8A7740 (Flattened Device Tree)")
+	.map_io		= r8a7740_map_io,
+	.init_early	= r8a7740_add_early_devices_dt,
+	.init_irq	= r8a7740_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
+	.init_machine	= r8a7740_add_standard_devices_dt,
+	.timer		= &shmobile_timer,
+	.dt_compat	= r8a7740_boards_compat_dt,
+MACHINE_END
+
+#endif /* CONFIG_USE_OF */
