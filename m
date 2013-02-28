From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 28 Feb 2013 17:00:28 +0000
Subject: [PATCH v2 1/2] ARM: shmobile: Armadillo800EVA-reference: Remove usage of shmobile_timer
Message-Id: <1362074410-2960-1-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The struct sys_timer is gone since the patch "ARM: delete struct
sys_timer". Since then we can't use shmobile_timer any longer. Setting
.init_time directly to eva_earlytimer_init fixes the resulting compile
error and makes the code shorter as well.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: same. Just integrated into a 2 pieces patchset.

 .../board-armadillo800eva-reference.c              |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 623754d..6991fb1 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -210,23 +210,14 @@ static void __init eva_init(void)
 #endif
 }
 
-static void __init eva_earlytimer_init(void)
+static void __init eva_timer_init(void)
 {
 	r8a7740_clock_init(MD_CK0 | MD_CK2);
-	shmobile_earlytimer_init();
 
 	/* the rate of extal1 clock must be set before late_time_init */
 	eva_clock_init();
 }
 
-static void __init eva_add_early_devices(void)
-{
-	r8a7740_add_early_devices_dt();
-
-	/* override timer setup with board-specific code */
-	shmobile_timer.init = eva_earlytimer_init;
-}
-
 #define RESCNT2 IOMEM(0xe6188020)
 static void eva_restart(char mode, const char *cmd)
 {
@@ -241,13 +232,13 @@ static const char *eva_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
 	.map_io		= r8a7740_map_io,
-	.init_early	= eva_add_early_devices,
+	.init_early	= r8a7740_add_early_devices_dt,
 	.init_irq	= r8a7740_init_irq_of,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
-	.init_time	= shmobile_timer_init,
+	.init_time	= eva_timer_init,
 	.dt_compat	= eva_boards_compat_dt,
 	.restart	= eva_restart,
 MACHINE_END
-- 
1.7.9.5

