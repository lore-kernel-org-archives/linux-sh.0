From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 08 Jul 2012 21:37:44 +0000
Subject: Re: ARM: mach-shmobile: recent next build failure
Message-Id: <201207082337.44848.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sunday, July 08, 2012, Rafael J. Wysocki wrote:
> On Sunday, July 08, 2012, Rafael J. Wysocki wrote:
> > On Sunday, July 08, 2012, Guennadi Liakhovetski wrote:
> > > Hi
> > > 
> > > Got this build failure with Friday's next:
> > > 
> > > linux/arch/arm/mach-shmobile/pm-sh7372.c: In function 'sh7372_pm_init':
> > > linux/arch/arm/mach-shmobile/pm-sh7372.c:598: error: implicit declaration of function 'sh7372_suspend_init'
> > > linux/arch/arm/mach-shmobile/pm-sh7372.c:599: error: implicit declaration of function 'sh7372_cpuidle_init'
> > > make[2]: *** [arch/arm/mach-shmobile/pm-sh7372.o] Error 1
> > > 
> > > .config available on request.
> > 
> > Please attach.
> > 
> > Magnus, that appears to be a result of your recent wakeup changes.
> 
> Guennadi, does the appended patch fix the problem for you?

Well, scratch that, it's not so simple.

The patch below should help instead.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ARM: shmobile: Fix sh7372 build problem related to PM settings

The cpuidle code in pm-sh7372.c and sleep-sh7372.S has to depend on
CONFIG_SUSPEND as well as on CONFIG_CPU_IDLE, because cpu_suspend()
and cpu_resume() are not available if CONFIG_SUSPEND is unset.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/pm-sh7372.c    |   10 +++++-----
 arch/arm/mach-shmobile/sleep-sh7372.S |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -151,7 +151,7 @@ struct rmobile_pm_domain sh7372_pd_a3sg
 
 #endif /* CONFIG_PM */
 
-#if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
+#ifdef CONFIG_SUSPEND
 static void sh7372_set_reset_vector(unsigned long address)
 {
 	/* set reset vector, translate 4k */
@@ -303,8 +303,9 @@ static void sh7372_enter_a3sm_common(int
 	sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
 	sh7372_enter_sysc(pllc0_on, 1 << 12);
 }
+#endif /* CONFIG_SUSPEND */
 
-#ifdef CONFIG_CPU_IDLE
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_SUSPEND)
 static int sh7372_do_idle_core_standby(unsigned long unused)
 {
 	cpu_do_idle(); /* WFI when SYSTBCR = 0x10 -> Core Standby */
@@ -371,7 +372,7 @@ static void sh7372_cpuidle_init(void)
 }
 #else
 static void sh7372_cpuidle_init(void) {}
-#endif
+#endif /* CONFIG_CPU_IDLE && CONFIG_SUSPEND */
 
 #ifdef CONFIG_SUSPEND
 static void sh7372_enter_a4s_common(int pllc0_on)
@@ -441,8 +442,7 @@ static void sh7372_suspend_init(void)
 }
 #else
 static void sh7372_suspend_init(void) {}
-#endif
-#endif /* CONFIG_SUSPEND || CONFIG_CPU_IDLE */
+#endif /* CONFIG_SUSPEND */
 
 void __init sh7372_pm_init(void)
 {
Index: linux/arch/arm/mach-shmobile/sleep-sh7372.S
=================================--- linux.orig/arch/arm/mach-shmobile/sleep-sh7372.S
+++ linux/arch/arm/mach-shmobile/sleep-sh7372.S
@@ -34,7 +34,7 @@
 #include <asm/memory.h>
 #include <asm/assembler.h>
 
-#if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
+#ifdef CONFIG_SUSPEND
 	.align	12
 	.text
 	.global sh7372_resume_core_standby_sysc
