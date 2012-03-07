From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 Mar 2012 05:53:58 +0000
Subject: [PATCH 02/03] ARM: mach-shmobile: sh7372 generic board support via DT
Message-Id: <20120307055358.20126.99003.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094710.10442.59532.sendpatchset@t400s>
In-Reply-To: <20110630094710.10442.59532.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add generic DT board support for the sh7372 SoC.

SCIF serial ports and timers are kept as regular
platform devices. Other on-chip and on-board devices
should be configured via the device tree.

Tested on the mackerel board via kexec using a zImage
kernel with an appended dtb.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7372.c |   39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- 0034/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2012-03-06 14:04:36.000000000 +0900
@@ -1082,3 +1082,42 @@ void __init sh7372_add_early_devices(voi
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
+void __init sh7372_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	sh7372_clock_init();
+
+	platform_add_devices(sh7372_early_devices,
+			    ARRAY_SIZE(sh7372_early_devices));
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
+	.init_irq	= sh7372_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
+	.init_machine	= sh7372_add_standard_devices_dt,
+	.timer		= &shmobile_timer,
+	.dt_compat	= sh7372_boards_compat_dt,
+MACHINE_END
+
+#endif /* CONFIG_USE_OF */
