From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jun 2011 00:35:26 +0000
Subject: [PATCH 01/05] ARM: mach-shmobile: sh7372 A4LC cleanups
Message-Id: <20110628003526.11399.86920.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use &sh7372_a4lc instead of SH7372_A4LC to reduce the amount of
code needed to add new power domains.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-mackerel.c      |    6 +++---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    8 ++------
 2 files changed, 5 insertions(+), 9 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-06-28 09:16:29.000000000 +0900
@@ -1582,9 +1582,9 @@ static void __init mackerel_init(void)
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
 
-	sh7372_init_pm_domain(SH7372_A4LC);
-	sh7372_add_device_to_domain(SH7372_A4LC, &lcdc_device);
-	sh7372_add_device_to_domain(SH7372_A4LC, &hdmi_lcdc_device);
+	sh7372_init_pm_domain(&sh7372_a4lc);
+	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
+	sh7372_add_device_to_domain(&sh7372_a4lc, &hdmi_lcdc_device);
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
--- 0002/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-06-28 09:18:46.000000000 +0900
@@ -485,17 +485,13 @@ static inline struct sh7372_pm_domain *t
 
 #ifdef CONFIG_PM
 extern struct sh7372_pm_domain sh7372_a4lc;
-#define SH7372_A4LC	(&sh7372_a4lc)
 
 extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
 extern void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
 					struct platform_device *pdev);
 #else
-#define SH7372_A4LC	NULL
-
-static inline void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd) {}
-static inline void sh7372_add_device_to_domain(struct sh7372_pm_domain *pd,
-					       struct platform_device *pdev) {}
+#define sh7372_init_pm_domain(pd) do { } while (0)
+#define sh7372_add_device_to_domain(pd, pdev) do { } while (0)
 #endif /* CONFIG_PM */
 
 #endif /* __ASM_SH7372_H__ */
