Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16005C43334
	for <linux-sh@archiver.kernel.org>; Mon,  4 Jul 2022 15:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiGDPGG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiGDPGE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 4 Jul 2022 11:06:04 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5436FD10
        for <linux-sh@vger.kernel.org>; Mon,  4 Jul 2022 08:06:02 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id s1-20020a056402520100b00439658fad14so7491558edd.20
        for <linux-sh@vger.kernel.org>; Mon, 04 Jul 2022 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0mVGJO2my8t1HZTqH29Koygvc/XGcDZ6vWpb1jdDT4o=;
        b=c7LZpgpHCMEBj4kEkGYT6bIghj7rNP9OT0wV7natbn5wuqgLWU/zG9DSmlQ3UoI0nM
         MI4O6Yh+OcLIuk2ut/UkMTguYgLY7CRzA22Nl6fr3P2zFMYeTmGQmVqsEFwVmEbhQ6OK
         fzW4NNfl1lbwaGdyJPbQTgrp78RaKY7f6kZBMtyl+6RXzcPxksBXHu63hC9eFKG/bMPV
         RaIopRqFLF6DUEH5O1JW3to4T/kOCMvFYMeqTdSydrxqLwRnWOFUO0Df8H0K5KNdjHHJ
         tfKLT8izTPB0q+KzUVb+TsNCU3Ae+1Iq/NAZaHYQYOFNSHtTznzKAwdaMHkQ3wSbp6QS
         l/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0mVGJO2my8t1HZTqH29Koygvc/XGcDZ6vWpb1jdDT4o=;
        b=6T41CGoMkIEjq8dWoFC99T0GVk01VFKu6q+ekuaFnU58cR9GOS7id9hCGl/zOgiBzz
         ByQ28wQiKfQLACcYQ0LmZ6FuvBnpRUApTaczLgtCrPznOE5nU4/nT7SJTiEYMLBxnd1u
         6vUgZJXZkcEZoNHQtKBLKONAT6pUS7Ww3qd3/Syanbo6mh7diIRRrMXXXn9BM4tAeDsp
         MEUM9QBdCzHy1UysjlrrmFGsoFIuZscLk4nHC7uanfw+wirVFcyOBCxBTtjQXmKDRvyv
         7BZ6MP/5pIJMXf5KGydgPN++PAdD2DAifuKMbM8WoRpI7Oj3s/lOG3xp2o5viwMY1+1B
         WKqQ==
X-Gm-Message-State: AJIora/byqJSfNdrkUBMGAM352YDMfWv6Iu52YoUbAeQyoBx316vym0l
        i5v0EGq9kBWlVQHZhL2tXnVbo8sm/g==
X-Google-Smtp-Source: AGRyM1u1tV984VAUKT5L9i/jwt0YX43hTGCtQ8Dkdr+VsujPNvT+0VKdHYhVoQYNC2BBRUvkHBjcbLjtmw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6edf:e1bc:9a92:4ad0])
 (user=elver job=sendgmr) by 2002:aa7:cd17:0:b0:435:bd7e:2efb with SMTP id
 b23-20020aa7cd17000000b00435bd7e2efbmr40768145edw.180.1656947161289; Mon, 04
 Jul 2022 08:06:01 -0700 (PDT)
Date:   Mon,  4 Jul 2022 17:05:02 +0200
In-Reply-To: <20220704150514.48816-1-elver@google.com>
Message-Id: <20220704150514.48816-3-elver@google.com>
Mime-Version: 1.0
References: <20220704150514.48816-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 02/14] perf/hw_breakpoint: Provide hw_breakpoint_is_used()
 and use in test
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
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Provide hw_breakpoint_is_used() to check if breakpoints are in use on
the system.

Use it in the KUnit test to verify the global state before and after a
test case.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* New patch.
---
 include/linux/hw_breakpoint.h      |  3 +++
 kernel/events/hw_breakpoint.c      | 29 +++++++++++++++++++++++++++++
 kernel/events/hw_breakpoint_test.c | 12 +++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index 78dd7035d1e5..a3fb846705eb 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -74,6 +74,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
+extern bool hw_breakpoint_is_used(void);
 
 extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
@@ -121,6 +122,8 @@ register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
 unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)	{ }
+static inline bool hw_breakpoint_is_used(void)		{ return false; }
+
 static inline int
 reserve_bp_slot(struct perf_event *bp)			{return -ENOSYS; }
 static inline void release_bp_slot(struct perf_event *bp) 		{ }
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index f32320ac02fd..fd5cd1f9e7fc 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -604,6 +604,35 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * hw_breakpoint_is_used - check if breakpoints are currently used
+ *
+ * Returns: true if breakpoints are used, false otherwise.
+ */
+bool hw_breakpoint_is_used(void)
+{
+	int cpu;
+
+	if (!constraints_initialized)
+		return false;
+
+	for_each_possible_cpu(cpu) {
+		for (int type = 0; type < TYPE_MAX; ++type) {
+			struct bp_cpuinfo *info = get_bp_info(cpu, type);
+
+			if (info->cpu_pinned)
+				return true;
+
+			for (int slot = 0; slot < nr_slots[type]; ++slot) {
+				if (info->tsk_pinned[slot])
+					return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 static struct notifier_block hw_breakpoint_exceptions_nb = {
 	.notifier_call = hw_breakpoint_exceptions_notify,
 	/* we need to be notified first */
diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
index 433c5c45e2a5..5ced822df788 100644
--- a/kernel/events/hw_breakpoint_test.c
+++ b/kernel/events/hw_breakpoint_test.c
@@ -294,7 +294,14 @@ static struct kunit_case hw_breakpoint_test_cases[] = {
 static int test_init(struct kunit *test)
 {
 	/* Most test cases want 2 distinct CPUs. */
-	return num_online_cpus() < 2 ? -EINVAL : 0;
+	if (num_online_cpus() < 2)
+		return -EINVAL;
+
+	/* Want the system to not use breakpoints elsewhere. */
+	if (hw_breakpoint_is_used())
+		return -EBUSY;
+
+	return 0;
 }
 
 static void test_exit(struct kunit *test)
@@ -308,6 +315,9 @@ static void test_exit(struct kunit *test)
 		kthread_stop(__other_task);
 		__other_task = NULL;
 	}
+
+	/* Verify that internal state agrees that no breakpoints are in use. */
+	KUNIT_EXPECT_FALSE(test, hw_breakpoint_is_used());
 }
 
 static struct kunit_suite hw_breakpoint_test_suite = {
-- 
2.37.0.rc0.161.g10f37bed90-goog

