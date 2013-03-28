From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 28 Mar 2013 08:49:27 +0000
Subject: [PATCH 4/4] ARM: shmobile: r8a7779: move global functions to r8a7779.h
Message-Id: <87txnvlxik.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There is no reason each CPU's own function has to exist in common.h. 
r8a7779_xxx() go to r8a7779.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/common.h  |   14 --------------
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   13 +++++++++++++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 4d5410d..e002cfd 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -19,20 +19,6 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
-extern void r8a7779_init_delay(void);
-extern void r8a7779_init_irq(void);
-extern void r8a7779_init_irq_extpin(int irlm);
-extern void r8a7779_init_irq_dt(void);
-extern void r8a7779_map_io(void);
-extern void r8a7779_earlytimer_init(void);
-extern void r8a7779_add_early_devices(void);
-extern void r8a7779_add_standard_devices(void);
-extern void r8a7779_add_standard_devices_dt(void);
-extern void r8a7779_clock_init(void);
-extern void r8a7779_pinmux_init(void);
-extern void r8a7779_pm_init(void);
-extern void r8a7779_register_twd(void);
-
 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
 #else
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 5896922..945299e 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -22,6 +22,19 @@ static inline struct r8a7779_pm_ch *to_r8a7779_ch(struct generic_pm_domain *d)
 	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
 }
 
+extern void r8a7779_init_delay(void);
+extern void r8a7779_init_irq(void);
+extern void r8a7779_init_irq_extpin(int irlm);
+extern void r8a7779_init_irq_dt(void);
+extern void r8a7779_map_io(void);
+extern void r8a7779_earlytimer_init(void);
+extern void r8a7779_add_early_devices(void);
+extern void r8a7779_add_standard_devices(void);
+extern void r8a7779_add_standard_devices_dt(void);
+extern void r8a7779_clock_init(void);
+extern void r8a7779_pinmux_init(void);
+extern void r8a7779_pm_init(void);
+extern void r8a7779_register_twd(void);
 extern int r8a7779_sysc_power_down(struct r8a7779_pm_ch *r8a7779_ch);
 extern int r8a7779_sysc_power_up(struct r8a7779_pm_ch *r8a7779_ch);
 
-- 
1.7.9.5

