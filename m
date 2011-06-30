From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Jun 2011 09:12:58 +0000
Subject: [PATCH] clocksource: sh_cmt: wait for CMCNT on init
Message-Id: <20110630091258.10263.21421.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add code to the CMT driver to wait for CMCNT to settle before
starting the timer channel. Makes the driver more robust.

Needed for CMT2 on sh7372 and certain CMT channels on sh73a0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2011-06-29 20:41:22.000000000 +0900
@@ -174,6 +174,20 @@ static int sh_cmt_enable(struct sh_cmt_p
 	sh_cmt_write(p, CMCOR, 0xffffffff);
 	sh_cmt_write(p, CMCNT, 0);
 
+	/*
+	 * According to the user's manual, as CMCNT can be operated only
+	 * by the RCLK (Pseudo 32 KHz), there's one restrictions on
+	 * modifying CMCNT register; two RCLK cycles are necessary before
+	 * this register is either read or any modification of the value
+	 * it holds is reflected in the LSI's actual operation.
+	 *
+	 * While at it, we're supposed to clear out the CMCNT as of this
+	 * moment, so make sure it's processed properly here.  This will
+	 * take RCLKx2 at maximum.
+	 */
+	while (sh_cmt_read(p, CMCNT) != 0)
+		cpu_relax();
+
 	/* enable channel */
 	sh_cmt_start_stop_ch(p, 1);
 	return 0;
