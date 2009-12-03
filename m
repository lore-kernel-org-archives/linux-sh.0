From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Dec 2009 12:31:45 +0000
Subject: [PATCH] sh: allow runtime pm without suspend/resume callbacks
Message-Id: <20091203123145.9997.81575.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the Runtime PM code for SuperH Mobile
to allow drivers to have NULL as pm or callback value.
With this in place there is no need for no-op functions.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/shmobile/pm_runtime.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- 0001/arch/sh/kernel/cpu/shmobile/pm_runtime.c
+++ work/arch/sh/kernel/cpu/shmobile/pm_runtime.c	2009-12-02 12:17:25.000000000 +0900
@@ -45,12 +45,14 @@ static int __platform_pm_runtime_resume(
 
 	dev_dbg(d, "__platform_pm_runtime_resume() [%d]\n", hwblk);
 
-	if (d->driver && d->driver->pm && d->driver->pm->runtime_resume) {
+	if (d->driver) {
 		hwblk_enable(hwblk_info, hwblk);
 		ret = 0;
 
 		if (test_bit(PDEV_ARCHDATA_FLAG_SUSP, &ad->flags)) {
-			ret = d->driver->pm->runtime_resume(d);
+			if (d->driver->pm && d->driver->pm->runtime_resume)
+				ret = d->driver->pm->runtime_resume(d);
+
 			if (!ret)
 				clear_bit(PDEV_ARCHDATA_FLAG_SUSP, &ad->flags);
 			else
@@ -73,12 +75,15 @@ static int __platform_pm_runtime_suspend
 
 	dev_dbg(d, "__platform_pm_runtime_suspend() [%d]\n", hwblk);
 
-	if (d->driver && d->driver->pm && d->driver->pm->runtime_suspend) {
+	if (d->driver) {
 		BUG_ON(!test_bit(PDEV_ARCHDATA_FLAG_IDLE, &ad->flags));
+		ret = 0;
 
-		hwblk_enable(hwblk_info, hwblk);
-		ret = d->driver->pm->runtime_suspend(d);
-		hwblk_disable(hwblk_info, hwblk);
+		if (d->driver->pm && d->driver->pm->runtime_suspend) {
+			hwblk_enable(hwblk_info, hwblk);
+			ret = d->driver->pm->runtime_suspend(d);
+			hwblk_disable(hwblk_info, hwblk);
+		}
 
 		if (!ret) {
 			set_bit(PDEV_ARCHDATA_FLAG_SUSP, &ad->flags);
