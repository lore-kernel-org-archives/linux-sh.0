From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 28 Mar 2013 08:48:30 +0000
Subject: [PATCH 2/4] ARM: shmobile: sh73a0: move global functions to sh73a0.h
Message-Id: <87wqsrlxk5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There is no reason each CPU's own function has to exist in common.h.
sh73a0_xxx() go to sh73a0.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/common.h |   16 ----------------
 arch/arm/mach-shmobile/include/mach/sh73a0.h |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index d01a551..48eeca9 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -19,22 +19,6 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
-extern void sh73a0_init_delay(void);
-extern void sh73a0_init_irq(void);
-extern void sh73a0_init_irq_dt(void);
-extern void sh73a0_map_io(void);
-extern void sh73a0_earlytimer_init(void);
-extern void sh73a0_add_early_devices(void);
-extern void sh73a0_add_standard_devices(void);
-extern void sh73a0_add_standard_devices_dt(void);
-extern void sh73a0_clock_init(void);
-extern void sh73a0_pinmux_init(void);
-extern void sh73a0_pm_init(void);
-extern struct clk sh73a0_extal1_clk;
-extern struct clk sh73a0_extal2_clk;
-extern struct clk sh73a0_extcki_clk;
-extern struct clk sh73a0_extalr_clk;
-
 extern void r8a7740_meram_workaround(void);
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index fbc1584..eb7a432 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -444,6 +444,21 @@ enum {
 #define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
 #define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
 
+extern void sh73a0_init_delay(void);
+extern void sh73a0_init_irq(void);
+extern void sh73a0_init_irq_dt(void);
+extern void sh73a0_map_io(void);
+extern void sh73a0_earlytimer_init(void);
+extern void sh73a0_add_early_devices(void);
+extern void sh73a0_add_standard_devices(void);
+extern void sh73a0_add_standard_devices_dt(void);
+extern void sh73a0_clock_init(void);
+extern void sh73a0_pinmux_init(void);
+extern void sh73a0_pm_init(void);
+extern struct clk sh73a0_extal1_clk;
+extern struct clk sh73a0_extal2_clk;
+extern struct clk sh73a0_extcki_clk;
+extern struct clk sh73a0_extalr_clk;
 extern struct smp_operations sh73a0_smp_ops;
 
 #endif /* __ASM_SH73A0_H__ */
-- 
1.7.9.5

