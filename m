From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 28 Mar 2013 08:49:15 +0000
Subject: [PATCH 3/4] ARM: shmobile: r8a7740: move global functions to r8a7740.h
Message-Id: <87vc8blxiw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There is no reason each CPU's own function has to exist in common.h. 
r8a7740_xxx() go to r8a7740.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/common.h  |    9 ---------
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 48eeca9..4d5410d 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -19,15 +19,6 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
-extern void r8a7740_meram_workaround(void);
-extern void r8a7740_init_irq(void);
-extern void r8a7740_map_io(void);
-extern void r8a7740_add_early_devices(void);
-extern void r8a7740_add_standard_devices(void);
-extern void r8a7740_clock_init(u8 md_ck);
-extern void r8a7740_pinmux_init(void);
-extern void r8a7740_pm_init(void);
-
 extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq(void);
 extern void r8a7779_init_irq_extpin(int irlm);
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index c258361..abdc4d4 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -532,6 +532,15 @@ enum {
 	SHDMA_SLAVE_USBHS_RX,
 };
 
+extern void r8a7740_meram_workaround(void);
+extern void r8a7740_init_irq(void);
+extern void r8a7740_map_io(void);
+extern void r8a7740_add_early_devices(void);
+extern void r8a7740_add_standard_devices(void);
+extern void r8a7740_clock_init(u8 md_ck);
+extern void r8a7740_pinmux_init(void);
+extern void r8a7740_pm_init(void);
+
 #ifdef CONFIG_PM
 extern void __init r8a7740_init_pm_domains(void);
 #else
-- 
1.7.9.5

