From: Vince Weaver <vincent.weaver@maine.edu>
Date: Sun, 15 Jun 2014 06:06:15 +0000
Subject: [PATCH 6/6] sh,perf: Use common PMU interrupt disabled code
Message-Id: <alpine.DEB.2.10.1406150205300.16738@vincent-weaver-1.umelst.maine.edu>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, linux-sh@vger.kernel.org


Transition to using the new generic PERF_PMU_CAP_NO_INTERRUPT method for
failing a sampling event when no PMU interrupt is available.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>

diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
index 0233167..7cfd7f1 100644
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -129,14 +129,6 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -ENODEV;
 
 	/*
-	 * All of the on-chip counters are "limited", in that they have
-	 * no interrupts, and are therefore unable to do sampling without
-	 * further work and timer assistance.
-	 */
-	if (hwc->sample_period)
-		return -EINVAL;
-
-	/*
 	 * See if we need to reserve the counter.
 	 *
 	 * If no events are currently in use, then we have to take a
@@ -392,6 +384,13 @@ int register_sh_pmu(struct sh_pmu *_pmu)
 
 	pr_info("Performance Events: %s support registered\n", _pmu->name);
 
+	/*
+	 * All of the on-chip counters are "limited", in that they have
+	 * no interrupts, and are therefore unable to do sampling without
+	 * further work and timer assistance.
+	 */
+	pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+
 	WARN_ON(_pmu->num_events > MAX_HWEVENTS);
 
 	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
