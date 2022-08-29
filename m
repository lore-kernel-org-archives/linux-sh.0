Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48372ECAAD4
	for <linux-sh@archiver.kernel.org>; Mon, 29 Aug 2022 12:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiH2M5W (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiH2M4b (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 29 Aug 2022 08:56:31 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CF4B44
        for <linux-sh@vger.kernel.org>; Mon, 29 Aug 2022 05:48:21 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id b13-20020a056402350d00b0043dfc84c533so5338329edd.5
        for <linux-sh@vger.kernel.org>; Mon, 29 Aug 2022 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=mMk84n4RwXUmdOHQie4vTMaJ1dE0ku+oL7Yd7vDc1Ps=;
        b=W7W/4jDzGQZPpWdKVVb3iyVFqESRjMIgUO/Wp66DnWVzBuac4gaS/+1d/8UGTZ19PO
         yNtk8YvzBHI+IABZPJpTnSP7zAh86D71lOIr3JNjBItKmnkUoHgHOUPUlxwxGnAm4oS5
         86BJQ/SK7KYzWOtLyDZjBernRUKqylcv/xvvA/bW3Q1BXcc+MCMG9JT0Igf39PMzbjua
         NcJLlRx2gSgtfzMG9Setvh6XnVCZ+mASJQamzHBKwMdP7yYZDkYPH8rxnXE9jJiadyEE
         k/PiCxKPnf4lA4uPuFTPjgJjOrcTc1ZRCS/25a2bUTBNJmAmEojBOeVuXhG7Ot0UUAKZ
         Y4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=mMk84n4RwXUmdOHQie4vTMaJ1dE0ku+oL7Yd7vDc1Ps=;
        b=rJi7c8qcXH8PGhwTGq3bnpU1MebhBtm2lIuNrBwk0LpqO+MLKfyXjOSZcuWFL1B42/
         QbmwcOmB8pFEFbCuh9GmqCU9sTJelVXFyn5aXS5h5WBYTJUP8L83+52tLUhB6wUfrCB2
         FLdLtK8dJdfDjkrCK9wVOZJTK5z5lYd0/QhgvcWZZpbZG0I+90x/jam8G7col01LV7ZS
         ab6voNDzhR45WnO0Exzj5Ttso9a+qwfv9pa6geR1PYoEKihbhvPI+jmovnU8MzZRrAV9
         wj0aEWbpQ/VEoo8mhl9LKntZMj/x8pYAtSgkVvlIVdJtMmL20RsgQHLf/g3AIUFT0Zpf
         CU8Q==
X-Gm-Message-State: ACgBeo0we+eeF0z8prbFH7ThnTitgoDaCyCqpFVuJ8mRqQX6n8TcBxyr
        1UuOJn9hCdXw1Rw7DJ8mE9850LKQvg==
X-Google-Smtp-Source: AA6agR6SxUOVw/+qKc286EXnhwyeQv/Uts/8z5qu8IaKngSGvfFuyE7tYrd41vyrdbuHS1CgREQPsDPnsA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a05:6402:5024:b0:440:e4ad:f7b6 with SMTP id
 p36-20020a056402502400b00440e4adf7b6mr16547207eda.358.1661777300281; Mon, 29
 Aug 2022 05:48:20 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:13 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-9-elver@google.com>
Subject: [PATCH v4 08/14] perf/hw_breakpoint: Remove useless code related to
 flexible breakpoints
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Flexible breakpoints have never been implemented, with
bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
flexible count in fetch_bp_busy_slots().

This again causes suboptimal code generation, when we always know that
`!!slots.flexible` will be 0.

Just get rid of the flexible "placeholder" and remove all real code
related to it. Make a note in the comment related to the constraints
algorithm but don't remove them from the algorithm, so that if in future
flexible breakpoints need supporting, it should be trivial to revive
them (along with reverting this change).

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
v2:
* Also remove struct bp_busy_slots, and simplify functions.
---
 kernel/events/hw_breakpoint.c | 57 +++++++++++------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 9c9bf17666a5..8b40fca1a063 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -45,8 +45,6 @@ struct bp_cpuinfo {
 #else
 	unsigned int	*tsk_pinned;
 #endif
-	/* Number of non-pinned cpu/task breakpoints in a cpu */
-	unsigned int	flexible; /* XXX: placeholder, see fetch_this_slot() */
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
@@ -67,12 +65,6 @@ static const struct rhashtable_params task_bps_ht_params = {
 
 static bool constraints_initialized __ro_after_init;
 
-/* Gather the number of total pinned and un-pinned bp in a cpuset */
-struct bp_busy_slots {
-	unsigned int pinned;
-	unsigned int flexible;
-};
-
 /* Serialize accesses to the above constraints */
 static DEFINE_MUTEX(nr_bp_mutex);
 
@@ -190,14 +182,14 @@ static const struct cpumask *cpumask_of_bp(struct perf_event *bp)
 }
 
 /*
- * Report the number of pinned/un-pinned breakpoints we have in
- * a given cpu (cpu > -1) or in all of them (cpu = -1).
+ * Returns the max pinned breakpoint slots in a given
+ * CPU (cpu > -1) or across all of them (cpu = -1).
  */
-static void
-fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
-		    enum bp_type_idx type)
+static int
+max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
 {
 	const struct cpumask *cpumask = cpumask_of_bp(bp);
+	int pinned_slots = 0;
 	int cpu;
 
 	for_each_cpu(cpu, cpumask) {
@@ -210,24 +202,10 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
 		else
 			nr += task_bp_pinned(cpu, bp, type);
 
-		if (nr > slots->pinned)
-			slots->pinned = nr;
-
-		nr = info->flexible;
-		if (nr > slots->flexible)
-			slots->flexible = nr;
+		pinned_slots = max(nr, pinned_slots);
 	}
-}
 
-/*
- * For now, continue to consider flexible as pinned, until we can
- * ensure no flexible event can ever be scheduled before a pinned event
- * in a same cpu.
- */
-static void
-fetch_this_slot(struct bp_busy_slots *slots, int weight)
-{
-	slots->pinned += weight;
+	return pinned_slots;
 }
 
 /*
@@ -298,7 +276,12 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
 }
 
 /*
- * Constraints to check before allowing this new breakpoint counter:
+ * Constraints to check before allowing this new breakpoint counter.
+ *
+ * Note: Flexible breakpoints are currently unimplemented, but outlined in the
+ * below algorithm for completeness.  The implementation treats flexible as
+ * pinned due to no guarantee that we currently always schedule flexible events
+ * before a pinned event in a same CPU.
  *
  *  == Non-pinned counter == (Considered as pinned for now)
  *
@@ -340,8 +323,8 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
  */
 static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 {
-	struct bp_busy_slots slots = {0};
 	enum bp_type_idx type;
+	int max_pinned_slots;
 	int weight;
 	int ret;
 
@@ -357,15 +340,9 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
 
-	fetch_bp_busy_slots(&slots, bp, type);
-	/*
-	 * Simulate the addition of this breakpoint to the constraints
-	 * and see the result.
-	 */
-	fetch_this_slot(&slots, weight);
-
-	/* Flexible counters need to keep at least one slot */
-	if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
+	/* Check if this new breakpoint can be satisfied across all CPUs. */
+	max_pinned_slots = max_bp_pinned_slots(bp, type) + weight;
+	if (max_pinned_slots > hw_breakpoint_slots_cached(type))
 		return -ENOSPC;
 
 	ret = arch_reserve_bp_slot(bp);
-- 
2.37.2.672.g94769d06f0-goog

