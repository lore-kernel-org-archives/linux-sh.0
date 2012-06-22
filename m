From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 22 Jun 2012 04:34:54 +0000
Subject: [PATCH] PM / shmobile: sh7372: remove unused sh7372_a3sp_init() on !CONFIG_PM
Message-Id: <87a9zwt15h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

767c0f3aed74be56f268709f5347e6c86d52b408
(PM / shmobile: Remove the stay_on flag from SH7372's PM domains)
commit removed sh7372_a3sp_init().
Now, there is no user for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/pm-sh7372.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index a3bdb12..44daaee 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -290,12 +290,7 @@ struct sh7372_pm_domain sh7372_a3sg = {
 	.genpd.name = "A3SG",
 	.bit_shift = 13,
 };
-
-#else /* !CONFIG_PM */
-
-static inline void sh7372_a3sp_init(void) {}
-
-#endif /* !CONFIG_PM */
+#endif /* CONFIG_PM */
 
 #if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
 static int sh7372_do_idle_core_standby(unsigned long unused)
-- 
1.7.5.4

