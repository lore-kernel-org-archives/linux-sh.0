From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 07 Jul 2011 02:30:19 +0000
Subject: [PATCH 2/2 v2] ARM: mach-shmobile: sh7372 A4MP support
Message-Id: <87aacqddqf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for the sh7372 A4MP power domain
and hook up the FSI/SPU2 device.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Thanks Magnus

v1 -> v2

- A3MP -> A4MP

 arch/arm/mach-shmobile/board-ap4evb.c        |    1 +
 arch/arm/mach-shmobile/board-mackerel.c      |    1 +
 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 +
 arch/arm/mach-shmobile/pm-sh7372.c           |    4 ++++
 arch/arm/mach-shmobile/setup-sh7372.c        |    3 +++
 5 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 4226db6..b473b8e 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1410,6 +1410,7 @@ static void __init ap4evb_init(void)
 
 	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc1_device);
 	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
+	sh7372_add_device_to_domain(&sh7372_a4mp, &fsi_device);
 
 	hdmi_init_pm_clock();
 	fsi_init_pm_clock();
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 362b883..5b36b6c 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1584,6 +1584,7 @@ static void __init mackerel_init(void)
 
 	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
 	sh7372_add_device_to_domain(&sh7372_a4lc, &hdmi_lcdc_device);
+	sh7372_add_device_to_domain(&sh7372_a4mp, &fsi_device);
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 1aed9da..f3ceced 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -485,6 +485,7 @@ static inline struct sh7372_pm_domain *to_sh7372_pd(struct generic_pm_domain *d)
 
 #ifdef CONFIG_PM
 extern struct sh7372_pm_domain sh7372_a4lc;
+extern struct sh7372_pm_domain sh7372_a4mp;
 extern struct sh7372_pm_domain sh7372_a3rv;
 extern struct sh7372_pm_domain sh7372_a3ri;
 extern struct sh7372_pm_domain sh7372_a3sg;
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 474a15a..f3bd95f 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -125,6 +125,10 @@ struct sh7372_pm_domain sh7372_a4lc = {
 	.bit_shift = 1,
 };
 
+struct sh7372_pm_domain sh7372_a4mp = {
+	.bit_shift = 2,
+};
+
 struct sh7372_pm_domain sh7372_a3rv = {
 	.bit_shift = 6,
 };
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index b219cea..9b0cd43 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -842,6 +842,7 @@ static struct platform_device *sh7372_late_devices[] __initdata = {
 void __init sh7372_add_standard_devices(void)
 {
 	sh7372_init_pm_domain(&sh7372_a4lc);
+	sh7372_init_pm_domain(&sh7372_a4mp);
 	sh7372_init_pm_domain(&sh7372_a3rv);
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
@@ -853,6 +854,8 @@ void __init sh7372_add_standard_devices(void)
 			    ARRAY_SIZE(sh7372_late_devices));
 
 	sh7372_add_device_to_domain(&sh7372_a3rv, &vpu_device);
+	sh7372_add_device_to_domain(&sh7372_a4mp, &spu0_device);
+	sh7372_add_device_to_domain(&sh7372_a4mp, &spu1_device);
 }
 
 void __init sh7372_add_early_devices(void)
-- 
1.7.4.1

