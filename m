From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Nov 2009 08:12:45 +0000
Subject: [PATCH 01/02] clocksource: Add argument to resume callback
Message-Id: <20091125081245.25416.88929.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20091125081235.25416.32481.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091125081235.25416.32481.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, johnstul@us.ibm.com, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, akpm@linux-foundation.org, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Pass the clocksource as an argument to the clocksource
resume callback. Needed so we can point out which CMT
channel the sh_cmt.c driver shall resume.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to linux-next 20091124
 Compile tested on x86.

 arch/ia64/kernel/time.c     |    2 +-
 arch/x86/kernel/hpet.c      |    2 +-
 arch/x86/kernel/tsc.c       |    2 +-
 include/linux/clocksource.h |    2 +-
 kernel/time/clocksource.c   |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- 0001/arch/ia64/kernel/time.c
+++ work/arch/ia64/kernel/time.c	2009-11-25 15:45:01.000000000 +0900
@@ -61,7 +61,7 @@ unsigned long long sched_clock(void)
 
 #ifdef CONFIG_PARAVIRT
 static void
-paravirt_clocksource_resume(void)
+paravirt_clocksource_resume(struct clocksource *cs)
 {
 	if (pv_time_ops.clocksource_resume)
 		pv_time_ops.clocksource_resume();
--- 0001/arch/x86/kernel/hpet.c
+++ work/arch/x86/kernel/hpet.c	2009-11-25 15:45:01.000000000 +0900
@@ -264,7 +264,7 @@ static void hpet_resume_device(void)
 	force_hpet_resume();
 }
 
-static void hpet_resume_counter(void)
+static void hpet_resume_counter(struct clocksource *cs)
 {
 	hpet_resume_device();
 	hpet_restart_counter();
--- 0001/arch/x86/kernel/tsc.c
+++ work/arch/x86/kernel/tsc.c	2009-11-25 15:45:01.000000000 +0900
@@ -740,7 +740,7 @@ static cycle_t __vsyscall_fn vread_tsc(v
 }
 #endif
 
-static void resume_tsc(void)
+static void resume_tsc(struct clocksource *cs)
 {
 	clocksource_tsc.cycle_last = 0;
 }
--- 0001/include/linux/clocksource.h
+++ work/include/linux/clocksource.h	2009-11-25 15:45:01.000000000 +0900
@@ -172,7 +172,7 @@ struct clocksource {
 	u64 max_idle_ns;
 	unsigned long flags;
 	cycle_t (*vread)(void);
-	void (*resume)(void);
+	void (*resume)(struct clocksource *cs);
 #ifdef CONFIG_IA64
 	void *fsys_mmio;        /* used by fsyscall asm code */
 #define CLKSRC_FSYS_MMIO_SET(mmio, addr)      ((mmio) = (addr))
--- 0001/kernel/time/clocksource.c
+++ work/kernel/time/clocksource.c	2009-11-25 15:45:01.000000000 +0900
@@ -449,7 +449,7 @@ void clocksource_resume(void)
 
 	list_for_each_entry(cs, &clocksource_list, list)
 		if (cs->resume)
-			cs->resume();
+			cs->resume(cs);
 
 	clocksource_resume_watchdog();
 }
