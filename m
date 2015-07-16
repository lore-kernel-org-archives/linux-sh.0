From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 16 Jul 2015 11:38:28 +0000
Subject: [PATCH 16/23] sh/localtimer: Migrate to new 'set-state' interface
Message-Id: <c0e09c20a764c61a329e4f87d10f14b145d9931f.1437044517.git.viresh.kumar@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-sh@vger.kernel.org

Migrate sh driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: linux-sh@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/sh/kernel/localtimer.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sh/kernel/localtimer.c b/arch/sh/kernel/localtimer.c
index b880a7e2ace7..cbb7d4636ec0 100644
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
2.4.0

