Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E405BC433EF
	for <linux-sh@archiver.kernel.org>; Tue, 28 Jun 2022 09:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbiF1J7s (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344621AbiF1J7W (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 28 Jun 2022 05:59:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9972ED64
        for <linux-sh@vger.kernel.org>; Tue, 28 Jun 2022 02:59:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r6-20020a5b06c6000000b006693f6a6d67so10483049ybq.7
        for <linux-sh@vger.kernel.org>; Tue, 28 Jun 2022 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ar0tQaDtQRVxSK1L64O5LGBBBeYgKP9H/0S8vYb7eY0=;
        b=QDaFAZbFppsXaGKVqzfkonMpccyr1cbOroDVbmeHjzV5Y5PKhzNM4NZ4HtvM2w6F5X
         qS3uJLF/cnyo+Y9dbZmY4O4l/xiGaBWPD8yy9soRQ0MVn8obJY7/4CupDFChWXOS0d4M
         g9Z7akfK1xChH19AZzJG+bP+GG6rojDxrnmRwxICTwa939HvKZYiSQWXLQK58qOGEFJ6
         07lg8mVua/7rqrL/A4yl+GSFL7zEk/c1UsOEDsSQgQ5QaXVHZByNl65yUJvgGyM8f5uI
         D49G3Zf6ZhA+eiMN2aMH510qgfvOXQCX3lEL9qzEBWpg1nt8B7Xc+oXqvgghD5d51qlK
         3LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ar0tQaDtQRVxSK1L64O5LGBBBeYgKP9H/0S8vYb7eY0=;
        b=513ErVTSwoD9sz8Z69CxhPoJ4YRhBTWkb8Zy512qXP7018wDAAH8Fnb3hu+yzwD+JV
         nrC/duYrlSPhT71MKU4TrsubUH+6rlEzQbK9pMp+u49bOxvbRNp87IrPenVLyZd3QXAK
         T/Efw3q0AjZ+Ly/Aa8kIxUBSJqPwgULFimnD1YS1buSt8epwN3FO/hysy6kt9wCmiFcT
         PIEkObOT8B1ynWRK+thUX4b2TOuCGBvmiixfBtkDExYt+Mr1uKZq1s5JyxoPt4shpXx0
         fI2MJw4okaDfGBElST07QmvdVppgdEGqsT+Aox3asiP0rVyOU4uJR+J80b5GjgqS411p
         CpbQ==
X-Gm-Message-State: AJIora/NROw3ZRUSNXvVjxZYAXp0ZjJUA2Pu3/9xsasK95eZM3QQmehq
        +sWn81OEFfObXsbPnK5CYzNi6kIrCg==
X-Google-Smtp-Source: AGRyM1tI+zmY9bXD9lPsRaWsu6mvsAtKuZuIuC7/08NiJKMQvXlU/prcjNa4TCejWigh16YxBHUIR7IxOg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a81:6603:0:b0:317:8d2f:e255 with SMTP id
 a3-20020a816603000000b003178d2fe255mr20169767ywc.166.1656410355202; Tue, 28
 Jun 2022 02:59:15 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:26 +0200
In-Reply-To: <20220628095833.2579903-1-elver@google.com>
Message-Id: <20220628095833.2579903-7-elver@google.com>
Mime-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 06/13] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
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

Due to being a __weak function, hw_breakpoint_weight() will cause the
compiler to always emit a call to it. This generates unnecessarily bad
code (register spills etc.) for no good reason; in fact it appears in
profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:

    ...
    0.70%  [kernel]       [k] hw_breakpoint_weight
    ...

While a small percentage, no architecture defines its own
hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
which makes the fact it is currently __weak a poor choice.

Change hw_breakpoint_weight()'s definition to follow a similar protocol
to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
hw_breakpoint_weight(), we'll use it instead.

The result is that it is inlined and no longer shows up in profiles.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/hw_breakpoint.h | 1 -
 kernel/events/hw_breakpoint.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index 78dd7035d1e5..9fa3547acd87 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -79,7 +79,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
 extern int reserve_bp_slot(struct perf_event *bp);
 extern void release_bp_slot(struct perf_event *bp);
-int hw_breakpoint_weight(struct perf_event *bp);
 int arch_reserve_bp_slot(struct perf_event *bp);
 void arch_release_bp_slot(struct perf_event *bp);
 void arch_unregister_hw_breakpoint(struct perf_event *bp);
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index a089302ddf59..a124786e3ade 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -124,10 +124,12 @@ static __init int init_breakpoint_slots(void)
 }
 #endif
 
-__weak int hw_breakpoint_weight(struct perf_event *bp)
+#ifndef hw_breakpoint_weight
+static inline int hw_breakpoint_weight(struct perf_event *bp)
 {
 	return 1;
 }
+#endif
 
 static inline enum bp_type_idx find_slot_idx(u64 bp_type)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

