From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 13 Jun 2011 04:42:15 +0000
Subject: [PATCH] drivers: sh: resume enabled clocks fix
Message-Id: <20110613044215.13907.39264.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the SH / SH-Mobile ARM clock framework to only
resume clocks that has been enabled.

Without this fix divide-by-zero is triggering on sh7372
FSIDIV during system wide resume of Suspend-to-RAM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 This is a rewrite of the patch recently posted as:
 "[PATCH] ARM: mach-shmobile: sh7372 divide-by-zero FSIDIV fix"

 drivers/sh/clk/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/sh/clk/core.c
+++ work/drivers/sh/clk/core.c	2011-06-13 13:32:10.000000000 +0900
@@ -635,7 +635,7 @@ static void clks_core_resume(void)
 	struct clk *clkp;
 
 	list_for_each_entry(clkp, &clock_list, node) {
-		if (likely(clkp->ops)) {
+		if (likely(clkp->usecount && clkp->ops)) {
 			unsigned long rate = clkp->rate;
 
 			if (likely(clkp->ops->set_parent))
