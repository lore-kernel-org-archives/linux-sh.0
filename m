From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 03 Sep 2014 10:52:27 +0000
Subject: [PATCH 11/15] ARM: exynos: Leave disabling of unused PM domains to genpd
Message-Id: <1409741551-16437-12-git-send-email-ulf.hansson@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Since genpd at late init, will try to disable unused PM domains we
don't need to do it from here as well.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-exynos/exynos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 6a24e11..b89e5f3 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -193,7 +193,6 @@ static void __init exynos_init_late(void)
 		/* to be supported later */
 		return;
 
-	pm_genpd_poweroff_unused();
 	exynos_pm_init();
 }
 
-- 
1.9.1

