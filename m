From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 09 Nov 2011 18:23:23 +0000
Subject: [PATCH v2] ARM: mach-shmobile: sh7372 A4R suspend/resume order fix
Message-Id: <Pine.LNX.4.64.1111091914120.4188@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Update the sh7372 A4R code to make sure the suspend
callback gets to be called before the resume callback.

Without this fix the A4R resume callback is called before
suspend. The resume callback restores the INTCS hardware
registers with incorrect data which results in interrupts
being masked when they shouldn't be. The user will notice
this issue as IIC0 timing out during boot.

Thanks to Magnus Damm for tracking this problem down and providing the 
initial fix and the commit description text.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

I took the liberty to reimplement the original fix by Magnus in a 
different way. I didn't quite like the idea of rewriting platform data, 
which could and, probably, should actually be const, on each 
domain-suspend. Instead, checking in resume, whether a valid state 
snapshot is available seemed a bit prettier to me:-) The maintainer is, of 
course, free to choose whichever version he prefers, they both

"Fix issue in v3.2-rc1 on the sh7372 Mackerel board."

diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index 29cdc05..eeeb16b 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -627,6 +627,7 @@ void __init sh7372_init_irq(void)
 
 static unsigned short ffd2[0x200];
 static unsigned short ffd5[0x100];
+static bool intcs_state_saved = false;
 
 void sh7372_intcs_suspend(void)
 {
@@ -646,12 +647,17 @@ void sh7372_intcs_suspend(void)
 
 	for (k = 0x80; k <= 0x9c; k += 4)
 		ffd5[k] = __raw_readb(intcs_ffd5 + k);
+
+	intcs_state_saved = true;
 }
 
 void sh7372_intcs_resume(void)
 {
 	int k;
 
+	if (!intcs_state_saved)
+		return;
+
 	for (k = 0x00; k <= 0x30; k += 4)
 		__raw_writew(ffd2[k], intcs_ffd2 + k);
 
