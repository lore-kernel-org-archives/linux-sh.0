From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jul 2012 08:10:02 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7377 generic board support via DT
Message-Id: <20120706081002.25502.18375.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add generic DT board support for the sh7377 SoC.

SCIF serial ports and timers are kept as regular
platform devices. Other on-chip and on-board devices
should be configured via the device tree.

At this point there is no interrupt controller support
in place but such code will be added over time when
proper IRQ domain support has been added to INTC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/sh7377.dtsi         |   21 ++++++++++++++
 arch/arm/mach-shmobile/setup-sh7377.c |   47 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

--- /dev/null
+++ work/arch/arm/boot/dts/sh7377.dtsi	2012-07-06 17:00:55.000000000 +0900
@@ -0,0 +1,21 @@
+/*
+ * Device Tree Source for the sh7377 SoC
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
+	compatible = "renesas,sh7377";
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a8";
+		};
+	};
+};
--- 0001/arch/arm/mach-shmobile/setup-sh7377.c
+++ work/arch/arm/mach-shmobile/setup-sh7377.c	2012-07-06 17:00:29.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/uio_driver.h>
 #include <linux/delay.h>
 #include <linux/input.h>
@@ -500,3 +501,49 @@ void __init sh7377_add_early_devices(voi
 	/* override timer setup with soc-specific code */
 	shmobile_timer.init = sh7377_earlytimer_init;
 }
+
+#ifdef CONFIG_USE_OF
+
+void __init sh7377_add_early_devices_dt(void)
+{
+	shmobile_setup_delay(600, 1, 3); /* Cortex-A8 @ 600MHz */
+
+	early_platform_add_devices(sh7377_early_devices,
+				   ARRAY_SIZE(sh7377_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
+}
+
+static const struct of_dev_auxdata sh7377_auxdata_lookup[] __initconst = {
+	{ }
+};
+
+void __init sh7377_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	sh7377_clock_init();
+
+	platform_add_devices(sh7377_early_devices,
+			    ARRAY_SIZE(sh7377_early_devices));
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     sh7377_auxdata_lookup, NULL);
+}
+
+static const char *sh7377_boards_compat_dt[] __initdata = {
+	"renesas,sh7377",
+	NULL,
+};
+
+DT_MACHINE_START(SH7377_DT, "Generic SH7377 (Flattened Device Tree)")
+	.map_io		= sh7377_map_io,
+	.init_early	= sh7377_add_early_devices_dt,
+	.init_irq	= sh7377_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
+	.init_machine	= sh7377_add_standard_devices_dt,
+	.timer		= &shmobile_timer,
+	.dt_compat	= sh7377_boards_compat_dt,
+MACHINE_END
+
+#endif /* CONFIG_USE_OF */
