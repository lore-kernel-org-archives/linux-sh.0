From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Jul 2012 03:55:46 +0000
Subject: [PATCH 4/7] ARM: shmobile: r8a7740: add A4LC pm domain support
Message-Id: <87k3yktc1s.wl%kuninori.morimoto.gx@renesas.com>
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
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c           |    5 +++++
 arch/arm/mach-shmobile/setup-r8a7740.c        |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 0bc8266..0f8321b 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -624,6 +624,7 @@ struct r8a7740_pm_domain *to_r8a7740_pd(struct generic_pm_domain *d)
 }
 
 #ifdef CONFIG_PM
+extern struct r8a7740_pm_domain r8a7740_a4lc;
 extern struct r8a7740_pm_domain r8a7740_a4s;
 extern struct r8a7740_pm_domain r8a7740_a3sp;
 
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index faa0254..82d330e 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -173,6 +173,11 @@ static int r8a7740_a4s_suspend(void)
 	return -EBUSY;
 }
 
+struct r8a7740_pm_domain r8a7740_a4lc = {
+	.genpd.name	= "A4LC",
+	.bit_shift	= 1,
+};
+
 struct r8a7740_pm_domain r8a7740_a4s = {
 	.genpd.name	= "A4S",
 	.bit_shift	= 10,
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 1c95067..b723469 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -675,6 +675,7 @@ void __init r8a7740_add_standard_devices(void)
 	/* PM domain */
 	r8a7740_init_pm_domain(&r8a7740_a4s);
 	r8a7740_init_pm_domain(&r8a7740_a3sp);
+	r8a7740_init_pm_domain(&r8a7740_a4lc);
 
 	r8a7740_pm_add_subdomain(&r8a7740_a4s, &r8a7740_a3sp);
 
-- 
1.7.5.4

