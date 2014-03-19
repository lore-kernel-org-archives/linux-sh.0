From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2014 19:06:50 +0000
Subject: [PATCH 5/5] drivers: sh: Remove automatic sh_pm_runtime_init() if ARCH_SHMOBILE_LEGACY
Message-Id: <1395256010-12222-6-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Now all shmobile SoCs call sh_pm_runtime_init(), remove the core_initcall()
for ARCH_SHMOBILE_LEGACY, and the check to prevent double enabling.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/sh/pm_runtime.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 58c114464831..55d58153b1f7 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -46,14 +46,11 @@ static bool default_pm_on;
 
 int __init sh_pm_runtime_init(void)
 {
-	if (default_pm_on)
-		return 0;
-
 	default_pm_on = true;
 	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
-#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE_LEGACY)
+#ifdef CONFIG_SUPERH
 core_initcall(sh_pm_runtime_init);
 #endif
 
-- 
1.7.9.5

