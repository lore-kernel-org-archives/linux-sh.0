Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78321C0502C
	for <linux-sh@archiver.kernel.org>; Mon, 29 Aug 2022 12:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiH2M45 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiH2M4Y (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 29 Aug 2022 08:56:24 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E980696DC
        for <linux-sh@vger.kernel.org>; Mon, 29 Aug 2022 05:48:05 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id xc12-20020a170907074c00b007416699ea14so1121879ejb.19
        for <linux-sh@vger.kernel.org>; Mon, 29 Aug 2022 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=1tERDk4Y7XiUFi7foUICKHh8rrNwWwU5I8SMJsHxX4c=;
        b=LRs6v78+5zV31XmPhiGFaI8d9smXBgIGVT6nVR89fc5UTZbqJpASCbp8OzqwdJo0WN
         X50HlNQTkBztzM8bMAfsxW3ZMbXKbNqWzzhCmWXRtGLVM510jCvBX7oLyzzVuARxpNHm
         9AonX8Qd10NaBeiwtbKaFe5cBQckgAKnxEE71EwpUZFx/aNS5vw1FonUbiF01IytjObS
         n8Dh1GNK3dBickyio3mTRV1yiaGNRQ1VMvwcGi/v7qpfhZBgl6yuTCbsFZhh4yT5ilJo
         7vS+0TPd+ThWiAMA/rfOsW7qFg2fd7fhGjlipPHc/6KEppO4C/f7SNI637VFT7wvXhPX
         7UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=1tERDk4Y7XiUFi7foUICKHh8rrNwWwU5I8SMJsHxX4c=;
        b=c3FkwnTCM9lEKlu/s6FVckIg/EBEYjoE8Dl1fHR+ME295/MK8Nz+KS0NCbjmsIBOFD
         aqllKrgSsusPuM8xi8VjZImQ6zdEOSNTdMGz/uAfacvXx3rdbt2tfp64z3wBOiS2rfUd
         8zhK0EN12rTsTktOVKidkt8UDCdCwz710Ib5uOqRmYaXAO9a1ctmaUk2y/L9O5svOO3a
         ZmEUXhotWrtEDHKFc3LiyaVgbyJUdADG3/vBWQSAP0WfFhj9J89M7pDyDVymxLA65o8R
         x79Zrunv7JPuYQ+eGdjN3fCz6SyGeaLUJxhtiURx2MUAhk8P8CiGZ4uXclsfYKD54wuY
         A+cQ==
X-Gm-Message-State: ACgBeo0wxhwz1OvLSmxl002GusKp4My8IUZCZ9ARMFnl12u/vOHhWTL5
        oxpy4UNvYlC+JWN+/HikSl6enIoOHQ==
X-Google-Smtp-Source: AA6agR4xS4MVvlQxXwy93Y+GTWrZcSFKD+wMhZ6QqWvQdPyWAiU+olMFbA+DUyOWg5RwEscoM50Yu8cu3A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a05:6402:2707:b0:448:ad8e:39c1 with SMTP id
 y7-20020a056402270700b00448ad8e39c1mr265466edd.315.1661777284113; Mon, 29 Aug
 2022 05:48:04 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:07 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-3-elver@google.com>
Subject: [PATCH v4 02/14] perf/hw_breakpoint: Provide hw_breakpoint_is_used()
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
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Provide hw_breakpoint_is_used() to check if breakpoints are in use on
the system.

Use it in the KUnit test to verify the global state before and after a
test case.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
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
2.37.2.672.g94769d06f0-goog

