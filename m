From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 28 Jun 2013 10:30:26 +0000
Subject: [PATCH 06/06] ARM: shmobile: Remove unused sh73a0 auxdata table
Message-Id: <20130628103026.31451.71277.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130628102930.31451.85334.sendpatchset@w520>
In-Reply-To: <20130628102930.31451.85334.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh73a0.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-06-28 19:16:07.000000000 +0900
@@ -958,10 +958,6 @@ void __init sh73a0_add_early_devices(voi
 
 #ifdef CONFIG_USE_OF
 
-static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
-	{},
-};
-
 void __init sh73a0_add_standard_devices_dt(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
@@ -971,8 +967,7 @@ void __init sh73a0_add_standard_devices_
 
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     sh73a0_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	/* Instantiate cpufreq-cpu0 */
 	platform_device_register_full(&devinfo);
