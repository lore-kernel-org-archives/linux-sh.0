From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 May 2009 08:27:19 +0000
Subject: [PATCH] sh: enable TMU clocksource on sh7722
Message-Id: <20090508082719.30262.93811.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch enables the TMU clocksource on sh7722.
To prioritize TMU over CMT we also adjust the CMT
clock source rating.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-05-08 15:35:02.000000000 +0900
@@ -183,7 +183,7 @@ static struct sh_timer_config cmt_platfo
 	.timer_bit = 5,
 	.clk = "cmt0",
 	.clockevent_rating = 125,
-	.clocksource_rating = 200,
+	.clocksource_rating = 125,
 };
 
 static struct resource cmt_resources[] = {
@@ -245,7 +245,7 @@ static struct sh_timer_config tmu1_platf
 	.channel_offset = 0x10,
 	.timer_bit = 1,
 	.clk = "tmu0",
-	.clocksource_rating = 0, /* disabled for now */
+	.clocksource_rating = 200,
 };
 
 static struct resource tmu1_resources[] = {
