From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 28 Mar 2013 08:48:19 +0000
Subject: [PATCH 1/4] ARM: shmobile: sh7372: move global functions to sh7372.h
Message-Id: <87y5d7lxkg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There is no reason each CPU's own function has to exist in common.h. 
sh7372_xxx() go to sh7372.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/common.h |   15 ---------------
 arch/arm/mach-shmobile/include/mach/sh7372.h |   12 ++++++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 03f73de..d01a551 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -19,21 +19,6 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
-extern void sh7372_init_irq(void);
-extern void sh7372_map_io(void);
-extern void sh7372_earlytimer_init(void);
-extern void sh7372_add_early_devices(void);
-extern void sh7372_add_standard_devices(void);
-extern void sh7372_add_early_devices_dt(void);
-extern void sh7372_add_standard_devices_dt(void);
-extern void sh7372_clock_init(void);
-extern void sh7372_pinmux_init(void);
-extern void sh7372_pm_init(void);
-extern void sh7372_resume_core_standby_sysc(void);
-extern int sh7372_do_idle_sysc(unsigned long sleep_mode);
-extern struct clk sh7372_extal1_clk;
-extern struct clk sh7372_extal2_clk;
-
 extern void sh73a0_init_delay(void);
 extern void sh73a0_init_irq(void);
 extern void sh73a0_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 7ded4eb..fd7cba0 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -449,6 +449,18 @@ extern struct clk sh7372_dv_clki_clk;
 extern struct clk sh7372_dv_clki_div2_clk;
 extern struct clk sh7372_pllc2_clk;
 
+extern void sh7372_init_irq(void);
+extern void sh7372_map_io(void);
+extern void sh7372_earlytimer_init(void);
+extern void sh7372_add_early_devices(void);
+extern void sh7372_add_standard_devices(void);
+extern void sh7372_add_early_devices_dt(void);
+extern void sh7372_add_standard_devices_dt(void);
+extern void sh7372_clock_init(void);
+extern void sh7372_pinmux_init(void);
+extern void sh7372_pm_init(void);
+extern void sh7372_resume_core_standby_sysc(void);
+extern int  sh7372_do_idle_sysc(unsigned long sleep_mode);
 extern void sh7372_intcs_suspend(void);
 extern void sh7372_intcs_resume(void);
 extern void sh7372_intca_suspend(void);
-- 
1.7.9.5

