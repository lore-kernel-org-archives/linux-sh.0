From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 17 Jul 2013 23:31:55 +0000
Subject: [PATCH 16/22] ARM: shmobile: Remove unused sh73a0 auxdata table
Message-Id: <ea31597fe72245985e9d2521ea7e87acf2f14252.1374103272.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index bd9370f..516c239 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -944,10 +944,6 @@ void __init sh73a0_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
-	{},
-};
-
 void __init sh73a0_add_standard_devices_dt(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
@@ -957,8 +953,7 @@ void __init sh73a0_add_standard_devices_dt(void)
 
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     sh73a0_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	/* Instantiate cpufreq-cpu0 */
 	platform_device_register_full(&devinfo);
-- 
1.7.10.4

