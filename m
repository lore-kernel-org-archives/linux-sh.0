From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 10 Aug 2015 09:52:25 +0000
Subject: [PATCH 68/74] sh/localtimer: Migrate to new 'set-state' interface
Message-Id: <1439200352-26767-68-git-send-email-daniel.lezcano@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-sh@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate sh driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: linux-sh@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/sh/kernel/localtimer.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sh/kernel/localtimer.c b/arch/sh/kernel/localtimer.c
index b880a7e..cbb7d46 100644
--- a/arch/sh/kernel/localtimer.c
+++ b/arch/sh/kernel/localtimer.c
@@ -39,11 +39,6 @@ void local_timer_interrupt(void)
 	irq_exit();
 }
 
-static void dummy_timer_set_mode(enum clock_event_mode mode,
-				 struct clock_event_device *clk)
-{
-}
-
 void local_timer_setup(unsigned int cpu)
 {
 	struct clock_event_device *clk = &per_cpu(local_clockevent, cpu);
@@ -54,7 +49,6 @@ void local_timer_setup(unsigned int cpu)
 				  CLOCK_EVT_FEAT_DUMMY;
 	clk->rating		= 400;
 	clk->mult		= 1;
-	clk->set_mode		= dummy_timer_set_mode;
 	clk->broadcast		= smp_timer_broadcast;
 	clk->cpumask		= cpumask_of(cpu);
 
-- 
1.9.1

