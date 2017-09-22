From: Allen Pais <allen.lkml@gmail.com>
Date: Fri, 22 Sep 2017 11:56:08 +0000
Subject: [PATCH 1/2] sh: push-switch: use setup_timer() helper.
Message-Id: <1506081360-6555-1-git-send-email-allen.lkml@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/sh/drivers/push-switch.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index 5bfb341..8e02851 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -78,11 +78,8 @@ static int switch_drv_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&psw->work, switch_work_handler);
-	init_timer(&psw->debounce);
-
-	psw->debounce.function = switch_timer;
-	psw->debounce.data = (unsigned long)psw;
 
+	setup_timer(&psw->debounce, switch_timer, (unsigned long)psw);
 	/* Workqueue API brain-damage */
 	psw->pdev = pdev;
 
-- 
2.7.4

