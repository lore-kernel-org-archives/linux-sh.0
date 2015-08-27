From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 27 Aug 2015 20:05:06 +0000
Subject: [PATCH] drivers: sh: Get rid of CONFIG_SHMOBILE_MULTI
Message-Id: <1440705906-3230-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Shmobile is all multiplatform these days, so get rid of the reference to
CONFIG_ARCH_SHMOBILE_MULTI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This must not be applied to a branch that still has
CONFIG_SHMOBILE_LEGACY.

 drivers/sh/pm_runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 25abd4eb7d102113..91a003011acfacb2 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -34,7 +34,7 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init sh_pm_runtime_init(void)
 {
-	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
+	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
 		if (!of_find_compatible_node(NULL, NULL,
 					     "renesas,cpg-mstp-clocks"))
 			return 0;
-- 
1.9.1

