From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2014 09:42:24 +0000
Subject: [PATCH v2 02/05] ARM: shmobile: sh73a0: Introduce generic setup callback
Message-Id: <20141217094224.7039.64925.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a generic sh73a0 machine setup callback for the upcoming
sh73a0 multiplatform case. Cache needs to be configured, and
legacy clocks must be omitted.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh73a0.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-12-16 19:10:22.000000000 +0900
@@ -30,6 +30,7 @@
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
@@ -777,8 +778,6 @@ void __init sh73a0_add_early_devices(voi
 	shmobile_setup_console();
 }
 
-#ifdef CONFIG_USE_OF
-
 void __init sh73a0_add_standard_devices_dt(void)
 {
 	/* clocks are setup late during boot in the case of DT */
@@ -794,6 +793,17 @@ static void sh73a0_restart(enum reboot_m
 	writel((1 << 31), RESCNT2);
 }
 
+#ifdef CONFIG_USE_OF
+
+static void __init sh73a0_generic_init(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	/* Shared attribute override enable, 64K*8way */
+	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
+#endif
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 static const char *sh73a0_boards_compat_dt[] __initdata = {
 	"renesas,sh73a0",
 	NULL,
@@ -803,7 +813,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH7
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= shmobile_init_delay,
-	.init_machine	= sh73a0_add_standard_devices_dt,
+	.init_machine	= sh73a0_generic_init,
 	.init_late	= shmobile_init_late,
 	.restart	= sh73a0_restart,
 	.dt_compat	= sh73a0_boards_compat_dt,
