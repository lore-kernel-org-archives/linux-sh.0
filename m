From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 May 2014 18:00:04 +0000
Subject: [PATCH v4 1/3] drivers: sh: pm_runtime does not need idle callback
Message-Id: <1400781606-18601-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

In the runtime_pm idle callback the code assumes that a NULL .runtime_idle
entry is the same as a .runtime_idle entry that returns 0 as a result. This
means the entry in drivers/sh/pm_runtime can be removed in favour of just
leaving the entry NULL.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> [r8a7779 legacy]
---
v4:
  - No changes
v3:
  - No changes
v2:
  - Add Reviewed-by, Tested-by
---
 drivers/sh/pm_runtime.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 10c65eb51f85..00b82ec94442 100644
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
1.9.1

