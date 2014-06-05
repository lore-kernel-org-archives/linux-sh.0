From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:32:04 +0000
Subject: [PATCH 02/03] ARM: shmobile: Use shmobile_init_delay() on EMEV2
Message-Id: <20140605053204.19066.73736.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140224072956.3522.60446.sendpatchset@w520>
In-Reply-To: <20140224072956.3522.60446.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust EMEV2 to use shmobile_init_delay() together with
CPU Frequency settings from the DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2014-05-29 17:08:51.000000000 +0900
@@ -42,11 +42,6 @@ static void __init emev2_map_io(void)
 	iotable_init(emev2_io_desc, ARRAY_SIZE(emev2_io_desc));
 }
 
-static void __init emev2_init_delay(void)
-{
-	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
-}
-
 static void __init emev2_add_standard_devices_dt(void)
 {
 	of_clk_init(NULL);
@@ -63,7 +58,7 @@ extern struct smp_operations emev2_smp_o
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
-	.init_early	= emev2_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= emev2_add_standard_devices_dt,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
