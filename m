From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 Aug 2010 09:24:05 +0000
Subject: [PATCH] clocksource: sh_cmt: Rate calculation fix
Message-Id: <20100802092405.30680.9349.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the rate calculation in the CMT driver.
Without this fix the clocksource runs way
too fast and we get a divide-by-zero error.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2010-08-02 16:52:29.000000000 +0900
@@ -445,7 +445,7 @@ static int sh_cmt_register_clocksource(s
 
 	/* clk_get_rate() needs an enabled clock */
 	clk_enable(p->clk);
-	p->rate = clk_get_rate(p->clk) / (p->width = 16) ? 512 : 8;
+	p->rate = clk_get_rate(p->clk) / ((p->width = 16) ? 512 : 8);
 	clk_disable(p->clk);
 
 	/* TODO: calculate good shift from rate and counter bit width */
