Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5101C54EE9
	for <linux-sh@archiver.kernel.org>; Mon, 29 Aug 2022 12:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiH2M45 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiH2M4Z (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 29 Aug 2022 08:56:25 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A7696FC
        for <linux-sh@vger.kernel.org>; Mon, 29 Aug 2022 05:48:08 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id q32-20020a05640224a000b004462f105fa9so5351779eda.4
        for <linux-sh@vger.kernel.org>; Mon, 29 Aug 2022 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=Xnrbr4NWXpH3ILMfaL+Hqy6Mh/173nAe6Rh4Ql+SwwA=;
        b=aoWdQSkdpteyXmYAo1c6eiVE2udp1iPCkTbGD3cqc5tyTEc5w9TDE5eQ2pH/aC5ONx
         wvITjNHuqGva9IIaS4Jy/kRGfM87daq+ZT24dKaI5knatHyVNPce7SKxJrvTIxK+jpRV
         T+oUK6JwmqGiqfWOw+qZfCjfKSncTUyCL/rTKrD/R/uwr1cZQDo2BiYCLIVtBSK8KpsZ
         CLE54Tvl9hptOey0GrB4CQxeXWFE0oHlZwm2u/7tiypSnfTXu/PJqf5/FBc4ceMvlGJj
         bS8z75PhngVBIBAZf6h+e4wkxi/WQq7RrV8yo3ue7h3N/zwN5y8SZVpJk5+wDM79X8yf
         2pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Xnrbr4NWXpH3ILMfaL+Hqy6Mh/173nAe6Rh4Ql+SwwA=;
        b=YSaQm167UVP+aH6HWP5XK3ZFfYxbxTKxImloB8Qum54ZXDcdRG3TE0nv+N+28hKSVB
         WmQ/G75ojlxfikNUgML5Aomdc87eu8OjwW0CQL56IUMdaIBUhbxl45oGKnLbIv4vElWP
         fSPLXmS+qGI6+e6H5k4+1UGjfpUZQZ9vU8RQJV7TEYUNBybB0KQvhFSSSymEBw0VgQm4
         ncSYu61Csg3gCyKaR4Yd5ZMJfqq3Sf6HgWwS81cd/fVSrSDm9gkvq/UEcVkbMIpDRPD4
         U8suQTe85Mpo9sUmqZBnHa0vDMITnrIfQARhTI1U/iTWOIZ2R7YpDAJDPL2w3KrIAgLX
         5p3A==
X-Gm-Message-State: ACgBeo30LsuHQ46ABvEpHP0EhEHiYAtoxyy3KRxREHBD9i3Iy7abx+ZI
        7bonomp1UKLGaw24OdBzZKwkIy8jzg==
X-Google-Smtp-Source: AA6agR42dMVaiS+cJuLOtzyugHi3iaDb9VrUvxxRA/60qGgLveidvAmI7LaoSF8LrpwtVNgvbP26lurGuA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:aa7:c946:0:b0:43d:3038:1381 with SMTP id
 h6-20020aa7c946000000b0043d30381381mr16380942edt.354.1661777286713; Mon, 29
 Aug 2022 05:48:06 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:08 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-4-elver@google.com>
Subject: [PATCH v4 03/14] perf/hw_breakpoint: Clean up headers
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

Clean up headers:

 - Remove unused <linux/kallsyms.h>

 - Remove unused <linux/kprobes.h>

 - Remove unused <linux/module.h>

 - Remove unused <linux/smp.h>

 - Add <linux/export.h> for EXPORT_SYMBOL_GPL().

 - Add <linux/mutex.h> for mutex.

 - Sort alphabetically.

 - Move <linux/hw_breakpoint.h> to top to test it compiles on its own.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
v2:
* Move to start of series.
---
 kernel/events/hw_breakpoint.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index fd5cd1f9e7fc..6076c6346291 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -17,23 +17,22 @@
  * This file contains the arch-independent routines.
  */
 
+#include <linux/hw_breakpoint.h>
+
+#include <linux/bug.h>
+#include <linux/cpu.h>
+#include <linux/export.h>
+#include <linux/init.h>
 #include <linux/irqflags.h>
-#include <linux/kallsyms.h>
-#include <linux/notifier.h>
-#include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
-#include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/list.h>
-#include <linux/cpu.h>
-#include <linux/smp.h>
-#include <linux/bug.h>
 
-#include <linux/hw_breakpoint.h>
 /*
  * Constraints data
  */
-- 
2.37.2.672.g94769d06f0-goog

