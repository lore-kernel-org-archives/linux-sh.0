From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 07:31:55 +0000
Subject: [PATCH] ARM: mach-shmobile: Move sh7372 AP4EVB external clk setup
Message-Id: <20120306073155.27860.13406.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20120306073018.27853.20666.sendpatchset@w520>
In-Reply-To: <20120306073018.27853.20666.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the board specific external clock setting for sh7372 AP4EVB
from machine_desc->sys_timer->init() to machine_desc->init_machine().

This is ground work for shmobile timer code consolidation.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0004/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2012-03-06 12:45:52.000000000 +0900
@@ -1197,6 +1197,9 @@ static void __init ap4evb_init(void)
 	u32 srcr4;
 	struct clk *clk;
 
+	/* External clock source */
+	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
+
 	sh7372_pinmux_init();
 
 	/* enable SCIFA0 */
@@ -1437,9 +1440,6 @@ static void __init ap4evb_timer_init(voi
 {
 	sh7372_clock_init();
 	shmobile_timer.init();
-
-	/* External clock source */
-	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 }
 
 static struct sys_timer ap4evb_timer = {
