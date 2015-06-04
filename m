From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:25 +0000
Subject: [PATCH 01/11] ARM: shmobile: R-Mobile: Move to_rmobile_pd from header to source file
Message-Id: <1433442155-19492-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

to_rmobile_pd() is only used inside pm-rmobile.c

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 6 ++++++
 arch/arm/mach-shmobile/pm-rmobile.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index a4208e47afafe534..5003602921a18dd0 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -36,6 +36,12 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
+static inline
+struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
+{
+	return container_of(d, struct rmobile_pm_domain, genpd);
+}
+
 static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
index 53219786f539fa24..3992b619c1278dcc 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.h
+++ b/arch/arm/mach-shmobile/pm-rmobile.h
@@ -26,12 +26,6 @@ struct rmobile_pm_domain {
 	bool no_debug;
 };
 
-static inline
-struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
-{
-	return container_of(d, struct rmobile_pm_domain, genpd);
-}
-
 struct pm_domain_device {
 	const char *domain_name;
 	struct platform_device *pdev;
-- 
1.9.1

