From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 08 Jul 2012 21:17:11 +0000
Subject: Re: ARM: mach-shmobile: recent next build failure
Message-Id: <201207082317.11890.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sunday, July 08, 2012, Rafael J. Wysocki wrote:
> On Sunday, July 08, 2012, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > Got this build failure with Friday's next:
> > 
> > linux/arch/arm/mach-shmobile/pm-sh7372.c: In function 'sh7372_pm_init':
> > linux/arch/arm/mach-shmobile/pm-sh7372.c:598: error: implicit declaration of function 'sh7372_suspend_init'
> > linux/arch/arm/mach-shmobile/pm-sh7372.c:599: error: implicit declaration of function 'sh7372_cpuidle_init'
> > make[2]: *** [arch/arm/mach-shmobile/pm-sh7372.o] Error 1
> > 
> > .config available on request.
> 
> Please attach.
> 
> Magnus, that appears to be a result of your recent wakeup changes.

Guennadi, does the appended patch fix the problem for you?

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ARM: shmobile: Fix build problem in pm-sh7372.c for unusual .config

If neither CONFIG_SUSPEND nor CONFIG_CPU_IDLE is set in the kernel
configuration file, build error occurs in
arch/arm/mach-shmobile/pm-sh7372.c.

Fix it by rearranging #ifdefs in that file to make the
definition of sh7372_suspend_init() depend only on
CONFIG_SUSPEND and the definition of sh7372_cpuidle_init()
depend only on CONFIG_CPU_IDLE.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/pm-sh7372.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -303,6 +303,7 @@ static void sh7372_enter_a3sm_common(int
 	sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
 	sh7372_enter_sysc(pllc0_on, 1 << 12);
 }
+#endif /* CONFIG_SUSPEND || CONFIG_CPU_IDLE */
 
 #ifdef CONFIG_CPU_IDLE
 static int sh7372_do_idle_core_standby(unsigned long unused)
@@ -442,7 +443,6 @@ static void sh7372_suspend_init(void)
 #else
 static void sh7372_suspend_init(void) {}
 #endif
-#endif /* CONFIG_SUSPEND || CONFIG_CPU_IDLE */
 
 void __init sh7372_pm_init(void)
 {
