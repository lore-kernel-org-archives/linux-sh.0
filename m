From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 06:53:40 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 generic board support via DT V2
Message-Id: <20120328065340.17262.85488.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20110707134813.22370.25948.sendpatchset@t400s>
In-Reply-To: <20110707134813.22370.25948.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add generic DT board support for the sh7372 SoC V2.

SCIF serial ports and timers are kept as regular
platform devices. Other on-chip and on-board devices
should be configured via the device tree.

Tested on the mackerel board via kexec using a zImage
kernel with an appended dtb.

At this point there is no interrupt controller support
in place but such code will be added over time when
proper IRQ domain support has been added to INTC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V2:
 - added sh7372.dtsi
 - make use of of_platform_populate
 - set ->nr_irqs to NR_IRQS_LEGACY

 Depends on the recently posted series:
 "[PATCH 00/06] mach-shmobile device tree preparation patches"

 arch/arm/boot/dts/sh7372.dtsi         |   21 ++++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c |   48 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

--- /dev/null
+++ work/arch/arm/boot/dts/sh7372.dtsi	2012-03-28 15:44:09.000000000 +0900
@@ -0,0 +1,21 @@
+/*
+ * Device Tree Source for the sh7372 SoC
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
+	compatible = "renesas,sh7372";
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a8";
+		};
+	};
+};
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2012-03-28 10:44:37.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/uio_driver.h>
 #include <linux/delay.h>
 #include <linux/input.h>
@@ -1082,3 +1083,50 @@ void __init sh7372_add_early_devices(voi
 	/* override timer setup with soc-specific code */
 	shmobile_timer.init = sh7372_earlytimer_init;
 }
+
+#ifdef CONFIG_USE_OF
+
+void __init sh7372_add_early_devices_dt(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
+
+	early_platform_add_devices(sh7372_early_devices,
+				   ARRAY_SIZE(sh7372_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
+}
+
+static const struct of_dev_auxdata sh7372_auxdata_lookup[] __initconst = {
+	{ }
+};
+
+void __init sh7372_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	sh7372_clock_init();
+
+	platform_add_devices(sh7372_early_devices,
+			    ARRAY_SIZE(sh7372_early_devices));
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     sh7372_auxdata_lookup, NULL);
+}
+
+static const char *sh7372_boards_compat_dt[] __initdata = {
+	"renesas,sh7372",
+	NULL,
+};
+
+DT_MACHINE_START(SH7372_DT, "Generic SH7372 (Flattened Device Tree)")
+	.map_io		= sh7372_map_io,
+	.init_early	= sh7372_add_early_devices_dt,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= sh7372_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
+	.init_machine	= sh7372_add_standard_devices_dt,
+	.timer		= &shmobile_timer,
+	.dt_compat	= sh7372_boards_compat_dt,
+MACHINE_END
+
+#endif /* CONFIG_USE_OF */
