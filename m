From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2009 10:19:21 +0000
Subject: [PATCH 07/07] sh: R-Standby CMT timer resume order workaround
Message-Id: <20091014101921.21842.29686.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Disable the CMT clocksource to work around a resume
order issue with non-sysdev timers. Without this
hack the clocksource is read before being resumed.

Not-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-10-14 18:08:37.000000000 +0900
@@ -261,7 +261,7 @@ static struct sh_timer_config cmt_platfo
 	.timer_bit = 5,
 	.clk = "cmt0",
 	.clockevent_rating = 125,
-	.clocksource_rating = 200,
+	//.clocksource_rating = 200,
 };
 
 static struct resource cmt_resources[] = {
