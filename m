From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 07:30:18 +0000
Subject: [PATCH] ARM: mach-shmobile: Move sh7372 Mackerel external clk setup
Message-Id: <20120306073018.27853.20666.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the board specific external clock setting for sh7372 Mackerel
from machine_desc->sys_timer->init() to machine_desc->init_machine().

This is ground work for shmobile timer code consolidation.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-mackerel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0004/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2012-03-06 12:43:35.000000000 +0900
@@ -1348,6 +1348,9 @@ static void __init mackerel_init(void)
 	struct clk *clk;
 	int ret;
 
+	/* External clock source */
+	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
+
 	sh7372_pinmux_init();
 
 	/* enable SCIFA0 */
@@ -1555,9 +1558,6 @@ static void __init mackerel_timer_init(v
 {
 	sh7372_clock_init();
 	shmobile_timer.init();
-
-	/* External clock source */
-	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 }
 
 static struct sys_timer mackerel_timer = {
