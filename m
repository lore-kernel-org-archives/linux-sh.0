From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:05 +0000
Subject: [PATCH v2 09/17] drivers: sh: Remove automatic sh_pm_runtime_init() if ARCH_SHMOBILE_LEGACY
Message-Id: <1397565253-22741-10-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now all shmobile SoCs call sh_pm_runtime_init(), remove the core_initcall()
for ARCH_SHMOBILE_LEGACY, and the check to prevent double enabling.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> [r8a7779 legacy]
---
v2:
  - Add Reviewed-by, Tested-by

 drivers/sh/pm_runtime.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 3ec047ac1ff4..f0c4a384d49f 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -79,14 +79,11 @@ static bool default_pm_on;
 
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

