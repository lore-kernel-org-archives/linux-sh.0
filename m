From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:07:07 +0000
Subject: [PATCH] ARM: shmobile: sh73a0: Remove duplicate CPUFreq bits
Message-Id: <20140820130707.350.39869.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

The CPUFreq platform device is already registered by
shmobile_init_late(), so get rid of sh73a0 specific bits.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built of top of renesas-devel-20140820-v3.17-rc1

 arch/arm/mach-shmobile/setup-sh73a0.c |    5 -----
 1 file changed, 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-08-19 23:06:54.000000000 +0900
@@ -775,17 +775,12 @@ void __init sh73a0_add_early_devices(voi
 
 void __init sh73a0_add_standard_devices_dt(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
-
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	/* Instantiate cpufreq-cpu0 */
-	platform_device_register_full(&devinfo);
 }
 
 static const char *sh73a0_boards_compat_dt[] __initdata = {
