Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5956CCA479
	for <linux-sh@archiver.kernel.org>; Tue, 28 Jun 2022 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbiF1J72 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344576AbiF1J7O (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 28 Jun 2022 05:59:14 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBC52DAAA
        for <linux-sh@vger.kernel.org>; Tue, 28 Jun 2022 02:59:10 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id az40-20020a05600c602800b003a048edf007so2490505wmb.5
        for <linux-sh@vger.kernel.org>; Tue, 28 Jun 2022 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y3vu5QzrDjJQpXkXaz04N0mmbkIf31DuJdXr7A4d0cQ=;
        b=hlkFl0FCdKnwNSsiVqNE6ojnVcC41EA9ADb/MqxQgZ3EEjpsAS4LfktfOEmNvDPSqZ
         dmZmNXOzU2+LIZqyTaIxsel1lUyb55hWHXt+2renOHmO5qRZpKboceuta65c3TzCFQRF
         gg8arSOmwM0ZRg/YNEuCoz5CW6zOQWqHLih5nBqYprm7RMvlXFDADlerTNC/Itre6IZ+
         QYUjtbRdmIwlqVE5SAafUw2uWeUzizcgWWykwJCTqbjw64KNdurRIlwIMQLwVcH6qCCk
         /i7Syrf4oeLqxTPIJvKcbG0q+XbjNGtSbpoZrm4DT1tuFxr1A6JnO4kEKM7C3F7Qgk8c
         vvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y3vu5QzrDjJQpXkXaz04N0mmbkIf31DuJdXr7A4d0cQ=;
        b=GHb7dbHq19h8no7f+V+YvWjh+6cSZ3oumLZcs0hw+Pv5GfAWTI0hRcFGpphJ1aTnpT
         5u3OvGnGWCMQ++jpv3QLuU9D/RabL/meTr8g1vyVgCca5f2gYvqODgm9sMTFIo8DPvZ5
         VNTFm6y/wIvEiTwS/2VHiKyUNWzyoCqJvxRSnszCsSnpCIfcs+4edg30VxjytcYvYxR/
         F2EU459dttInyi5ORfYyBOEZnDBhnqZckxZAXKMCGtAy9qaEkINHraRXzfKM3TEFBc7E
         yxzXMlzp5nobyD9cW50J6GREwJ3Wx5sRZtCMbVnESZDFToqsTkjTz63yvCe7nS4w3oDO
         nHVQ==
X-Gm-Message-State: AJIora/sauqTfbKA5YXo2pmuHA56MKiQY+IHzNvZAky6S0TZwSut1ZlO
        2Orxj3ZCrBkC+zMOGlNExaSclQFQGw==
X-Google-Smtp-Source: AGRyM1sLXTcWzlDsYcztP6jIu7/NWN9CWyyELGCAm2BsUsBrvTjQx5jRDWtXYnCL+4E+uAB2Gm9w1LqV1A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a5d:4c8a:0:b0:21b:9f3a:c002 with SMTP id
 z10-20020a5d4c8a000000b0021b9f3ac002mr16723653wrs.182.1656410349259; Tue, 28
 Jun 2022 02:59:09 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:24 +0200
In-Reply-To: <20220628095833.2579903-1-elver@google.com>
Message-Id: <20220628095833.2579903-5-elver@google.com>
Mime-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 04/13] perf/hw_breakpoint: Mark data __ro_after_init
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

Mark read-only data after initialization as __ro_after_init.

While we are here, turn 'constraints_initialized' into a bool.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/events/hw_breakpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index add1b9c59631..270be965f829 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -46,7 +46,7 @@ struct bp_cpuinfo {
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
-static int nr_slots[TYPE_MAX];
+static int nr_slots[TYPE_MAX] __ro_after_init;
 
 static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 {
@@ -62,7 +62,7 @@ static const struct rhashtable_params task_bps_ht_params = {
 	.automatic_shrinking = true,
 };
 
-static int constraints_initialized;
+static bool constraints_initialized __ro_after_init;
 
 /* Gather the number of total pinned and un-pinned bp in a cpuset */
 struct bp_busy_slots {
@@ -710,7 +710,7 @@ int __init init_hw_breakpoint(void)
 	if (ret)
 		goto err;
 
-	constraints_initialized = 1;
+	constraints_initialized = true;
 
 	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

