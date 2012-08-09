From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 09 Aug 2012 22:02:40 +0000
Subject: [PATCH] ARM: shmobile: Remove the console check from sh7372_enter_suspend()
Message-Id: <201208100002.40911.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


The !console_suspend_enabled check in sh7372_enter_suspend() seems
to be reversed and the condition it is supposed to catch (console
clock enabled) should be detected by the sh7372_sysc_valid() check
anyway, so remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/pm-sh7372.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -424,16 +424,14 @@ static int sh7372_enter_suspend(suspend_
 	unsigned long msk, msk2;
 
 	/* check active clocks to determine potential wakeup sources */
-	if (sh7372_sysc_valid(&msk, &msk2)) {
-		if (!console_suspend_enabled && a4s_suspend_ready) {
-			/* convert INTC mask/sense to SYSC mask/sense */
-			sh7372_setup_sysc(msk, msk2);
+	if (sh7372_sysc_valid(&msk, &msk2) && a4s_suspend_ready) {
+		/* convert INTC mask/sense to SYSC mask/sense */
+		sh7372_setup_sysc(msk, msk2);
 
-			/* enter A4S sleep with PLLC0 off */
-			pr_debug("entering A4S\n");
-			sh7372_enter_a4s_common(0);
-			return 0;
-		}
+		/* enter A4S sleep with PLLC0 off */
+		pr_debug("entering A4S\n");
+		sh7372_enter_a4s_common(0);
+		return 0;
 	}
 
 	/* default to enter A3SM sleep with PLLC0 off */
