From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Apr 2011 18:05:27 +0000
Subject: [PATCH] sh: cosmetic improvement: use an existing pointer
Message-Id: <Pine.LNX.4.64.1104152004360.18593@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use an existing local variable, instead of calculating the pointer
multiple times explicitly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 arch/sh/kernel/cpu/shmobile/pm_runtime.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/pm_runtime.c b/arch/sh/kernel/cpu/shmobile/pm_runtime.c
index 6dcb816..db56e3a 100644
--- a/arch/sh/kernel/cpu/shmobile/pm_runtime.c
+++ b/arch/sh/kernel/cpu/shmobile/pm_runtime.c
@@ -157,7 +157,7 @@ int platform_pm_runtime_suspend(struct device *dev)
 	might_sleep();
 
 	/* catch misconfigured drivers not starting with resume */
-	if (test_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags)) {
+	if (test_bit(PDEV_ARCHDATA_FLAG_INIT, &ad->flags)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -170,8 +170,8 @@ int platform_pm_runtime_suspend(struct device *dev)
 
 	/* put device on idle list */
 	spin_lock_irqsave(&hwblk_lock, flags);
-	list_add_tail(&pdev->archdata.entry, &hwblk_idle_list);
-	__set_bit(PDEV_ARCHDATA_FLAG_IDLE, &pdev->archdata.flags);
+	list_add_tail(&ad->entry, &hwblk_idle_list);
+	__set_bit(PDEV_ARCHDATA_FLAG_IDLE, &ad->flags);
 	spin_unlock_irqrestore(&hwblk_lock, flags);
 
 	/* increase idle count */
-- 
1.7.2.5

