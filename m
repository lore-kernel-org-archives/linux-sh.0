From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 08:26:53 +0000
Subject: [PATCH 05/12 v2] ARM: shmobile: r8a7740: add A4LC pm domain support
Message-Id: <87y5mypq9h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds basic A4LC pm domain support.
Now, below devices can be controled by PM

MERAM, LCDC, VOU, ICBS, SDENC-Link

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - based on pm-rmobile

 arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c           |    5 +++++
 arch/arm/mach-shmobile/setup-r8a7740.c        |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index a5691cf..7143147 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -609,6 +609,7 @@ enum {
 #ifdef CONFIG_PM
 extern struct rmobile_pm_domain r8a7740_pd_a4s;
 extern struct rmobile_pm_domain r8a7740_pd_a3sp;
+extern struct rmobile_pm_domain r8a7740_pd_a4lc;
 #endif /* CONFIG_PM */
 
 #endif /* __ASM_R8A7740_H__ */
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 0e54a11..e4d7d22 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -51,4 +51,9 @@ struct rmobile_pm_domain r8a7740_pd_a3sp = {
 	.suspend	= r8a7740_pd_a3sp_suspend,
 };
 
+struct rmobile_pm_domain r8a7740_pd_a4lc = {
+	.genpd.name	= "A4LC",
+	.bit_shift	= 1,
+};
+
 #endif /* CONFIG_PM */
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 59c79412..c006d8d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -675,6 +675,7 @@ void __init r8a7740_add_standard_devices(void)
 	/* PM domain */
 	rmobile_init_pm_domain(&r8a7740_pd_a4s);
 	rmobile_init_pm_domain(&r8a7740_pd_a3sp);
+	rmobile_init_pm_domain(&r8a7740_pd_a4lc);
 
 	rmobile_pm_add_subdomain(&r8a7740_pd_a4s, &r8a7740_pd_a3sp);
 
-- 
1.7.5.4

