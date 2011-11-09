From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 Nov 2011 11:02:49 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 A3SP no_suspend_console fix
Message-Id: <20111109110249.516.61239.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20110712082459.18930.51005.sendpatchset@t400s>
In-Reply-To: <20110712082459.18930.51005.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

If "no_suspend_irq" is used on the sh7372 Mackerel board
with v3.2-rc1 then Suspend-to-RAM fails because the serial
console tries to write to the SCIF driver even though the
power domain is turned off.

This patch checks the state of "console_suspend_enabled"
to see if A3SP should be forced enabled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm-sh7372.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-11-09 19:38:52.000000000 +0900
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/bitrev.h>
+#include <linux/console.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
@@ -469,6 +470,11 @@ void __init sh7372_pm_init(void)
 	/* do not convert A3SM, A3SP, A3SG, A4R power down into A4S */
 	__raw_writel(0, PDNSEL);
 
+	/* serial consoles make use of SCIF hardware located in A3SP,
+	 * keep such power domain on if "no_console_suspend" is set.
+	 */
+	sh7372_a3sp.stay_on = !console_suspend_enabled;
+
 	sh7372_suspend_init();
 	sh7372_cpuidle_init();
 }
