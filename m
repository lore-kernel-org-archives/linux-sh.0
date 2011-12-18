From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 18 Dec 2011 17:03:06 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 A4S Mackerel debug hack
Message-Id: <20111218170306.20423.23533.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add some quick debugging code on top of the A4S power domain
patch to allow serial printouts before and soon after the power
has been cut/restored. Duplicates the context restore code
located in the SCIF driver in a board specific fashion. Will
only work on Mackerel. Not for upstream inclusion.

Not-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm-sh7372.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- 0004/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-12-19 01:50:11.000000000 +0900
@@ -7,7 +7,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
-
+#define DEBUG
 #include <linux/pm.h>
 #include <linux/suspend.h>
 #include <linux/cpuidle.h>
@@ -323,7 +323,9 @@ static int sh7372_sysc_valid(unsigned lo
 	mstpsr2 = __raw_readl(MSTPSR2);
 	if ((mstpsr2 & 0x000741ff) != 0x000741ff) {
 		pr_debug("sh7372 mstpsr2 0x%08lx\n", mstpsr2);
+#if 0 /* SCIF console clock will be on, ignore to debug low level A4S code */
 		return 0;
+#endif
 	}
 
 	mstpsr3 = __raw_readl(MSTPSR3);
@@ -475,11 +477,22 @@ static int sh7372_enter_suspend(suspend_
 		/* convert INTC mask and sense to SYSC mask and sense */
 		sh7372_setup_sysc(msk, msk2);
 
-		if (!sh7372_a3sp.stay_on &&
+		if (/*!sh7372_a3sp.stay_on && */
 		    sh7372_a4s.genpd.status = GPD_STATE_POWER_OFF) {
 			/* enter A4S sleep with PLLC0 off */
 			pr_debug("entering A4S\n");
 			sh7372_enter_a4s_common(0);
+
+			/* power up A3SP and setup SCIF console */
+			if (sh7372_a3sp.stay_on) {
+				sh7372_a3sp.stay_on = 0;
+				pd_power_up(&sh7372_a3sp.genpd);
+				sh7372_a3sp.stay_on = 1;
+				__raw_writew(0, 0xE6C40000); /* setup SCIF */
+				__raw_writeb(0x19, 0xE6C40004);
+				__raw_writew(0x0030, 0xE6C40008);
+				pr_debug("SCIF alive and kicking!\n");
+			}
 		} else {
 			/* enter A3SM sleep with PLLC0 off */
 			pr_debug("entering A3SM\n");
