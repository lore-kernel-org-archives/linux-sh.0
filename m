From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:15:12 +0000
Subject: [RFC 1/6] shmobile: pm_runtime does not need idle callback
Message-Id: <1395054917-27390-2-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In the runtime_pm idle callback the code assumes that a NULL .runtime_idle
entry is the same as a .runtime_idle entry that returns 0 as a result. This
means the entry in drivers/sh/pm_runtime can be removed in favour of just
leaving the entry NULL.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/sh/pm_runtime.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 8afa5a4..5cfbd82 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -21,18 +21,10 @@
 #include <linux/slab.h>
 
 #ifdef CONFIG_PM_RUNTIME
-
-static int default_platform_runtime_idle(struct device *dev)
-{
-	/* suspend synchronously to disable clocks immediately */
-	return 0;
-}
-
 static struct dev_pm_domain default_pm_domain = {
 	.ops = {
 		.runtime_suspend = pm_clk_suspend,
 		.runtime_resume = pm_clk_resume,
-		.runtime_idle = default_platform_runtime_idle,
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
-- 
1.9.0

