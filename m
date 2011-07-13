From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Jul 2011 07:59:48 +0000
Subject: [PATCH] clocksource: sh_cmt: wait for CMCNT on init V2
Message-Id: <20110713075948.17998.57425.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630091258.10263.21421.sendpatchset@t400s>
In-Reply-To: <20110630091258.10263.21421.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add code to the CMT driver to wait for CMCNT V2. This to let
the register value settle before starting the timer channel.
Makes the driver more robust.

Needed for CMT2 on sh7372 and certain CMT channels on sh73a0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - added timeout
 - updated comment

 drivers/clocksource/sh_cmt.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2011-07-13 16:47:34.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/irq.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/sh_timer.h>
@@ -150,13 +151,13 @@ static void sh_cmt_start_stop_ch(struct
 
 static int sh_cmt_enable(struct sh_cmt_priv *p, unsigned long *rate)
 {
-	int ret;
+	int k, ret;
 
 	/* enable clock */
 	ret = clk_enable(p->clk);
 	if (ret) {
 		dev_err(&p->pdev->dev, "cannot enable clock\n");
-		return ret;
+		goto err0;
 	}
 
 	/* make sure channel is disabled */
@@ -174,9 +175,39 @@ static int sh_cmt_enable(struct sh_cmt_p
 	sh_cmt_write(p, CMCOR, 0xffffffff);
 	sh_cmt_write(p, CMCNT, 0);
 
+	/*
+	 * According to the sh73a0 user's manual, as CMCNT can be operated
+	 * only by the RCLK (Pseudo 32 KHz), there's one restriction on
+	 * modifying CMCNT register; two RCLK cycles are necessary before
+	 * this register is either read or any modification of the value
+	 * it holds is reflected in the LSI's actual operation.
+	 *
+	 * While at it, we're supposed to clear out the CMCNT as of this
+	 * moment, so make sure it's processed properly here.  This will
+	 * take RCLKx2 at maximum.
+	 */
+
+	for (k = 0; k < 100; k++) {
+		if (!sh_cmt_read(p, CMCNT))
+			break;
+		udelay(1);
+	}
+
+	if (sh_cmt_read(p, CMCNT)) {
+		dev_err(&p->pdev->dev, "cannot clear CMCNT\n");
+		ret = -ETIMEDOUT;
+		goto err1;
+	}
+
 	/* enable channel */
 	sh_cmt_start_stop_ch(p, 1);
 	return 0;
+ err1:
+	/* stop clock */
+	clk_disable(p->clk);
+
+ err0:
+	return ret;
 }
 
 static void sh_cmt_disable(struct sh_cmt_priv *p)
