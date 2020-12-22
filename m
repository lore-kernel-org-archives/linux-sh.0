Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8EBC433E0
	for <linux-sh@archiver.kernel.org>; Tue, 22 Dec 2020 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976F222AB9
	for <linux-sh@archiver.kernel.org>; Tue, 22 Dec 2020 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLVUyx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 22 Dec 2020 15:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgLVUyx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 22 Dec 2020 15:54:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1025C0613D6
        for <linux-sh@vger.kernel.org>; Tue, 22 Dec 2020 12:54:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a206so19424829ybg.0
        for <linux-sh@vger.kernel.org>; Tue, 22 Dec 2020 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/9QkJtGrDHYGlOeTvRf6aI/jOSpy3JILOtXVR8pD5Bg=;
        b=OdfKo0GyVnWedvMBm0zf561kxeucBXA18KqGvJwTxhnAVORS5IoBE/fCt5/BOUkzJx
         UTeEuaLfNgVW4XJXeduSaoPgr1Mw6zzqTJz4/XRaTqpHea0+ATsSFsurQ9Dqb2IJjqLN
         wGJ9MruXqUFOiQtI6nagP+VUFEPKLZ4FGKJJzX0137FlB172LXVRqQvrALDXEsSWkibl
         egQ9tbdyh5uh1E1/HK82+wbSm6f4f2afcWCK6T0FOxUeODHCSwup4BvU8PgVeAqkFtst
         Se+tdQeqfOHb9xPM54QctQKo4XNRvuEpaZEXWKgqUk4cStc/xJPXphYiME0eFayGvN8l
         0kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/9QkJtGrDHYGlOeTvRf6aI/jOSpy3JILOtXVR8pD5Bg=;
        b=L9XSIGLrc+dGy0Oq4npF3k5ai3ZJtbz+ltNARHKkFhgnGmGHzOLu2952e95g4UcN7F
         /X8nuddYlZ1sP5wmvCADNkd2ZQyyfC1Z0XpqXVz7MiC2eh4YzMfXnvG5o+U2aEVV/LcQ
         eG4m8ajv5sBz7XnRjQ5ZJp3phavGk29roGvQV2EcIZa+GFe18ZUNlyhL87+Es7YklRmm
         OYwTsi/pucOJkQl9u3uJQhnm5CDNimrjqetLqWcRRAT96I553F80lzhgGenbYkxSfZRJ
         C2w1z0De5I+fyIQN1/H84ZUrexpwvpU/OgfDs43hn8FBdJyPiU2SSVsNkT0FaW6l0XCt
         MhPw==
X-Gm-Message-State: AOAM532+/gW8XXafwRa0ebRTvwYHGQyOAbUdRRnVfVyU1g2Q8Rx+EOzT
        97ECT4q5u8y2hnY0mn5qpvRN1CvDlaBBI+1gtdI=
X-Google-Smtp-Source: ABdhPJyGzD8kYhSUj1EYwgmEauHr5nDb/sLbvusrTMRh3O6TYPvjVAfr82coan1uHwx9Q+puKngANzZ1nSavTD9pjrE=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:73c3:: with SMTP id
 o186mr31889461ybc.182.1608670452024; Tue, 22 Dec 2020 12:54:12 -0800 (PST)
Date:   Tue, 22 Dec 2020 12:54:01 -0800
In-Reply-To: <20201212161831.GA28098@roeck-us.net>
Message-Id: <20201222205402.2269377-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201212161831.GA28098@roeck-us.net>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] sh: check return code of request_irq
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Paul Mundt <lethal@linux-sh.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

request_irq is marked __must_check, but the call in shx3_prepare_cpus
has a void return type, so it can't propagate failure to the caller.
Follow cues from hexagon and just print an error.

Fixes: c7936b9abcf5 ("sh: smp: Hook in to the generic IPI handler for SH-X3 SMP.")
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sh/kernel/cpu/sh4a/smp-shx3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/smp-shx3.c b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
index f8a2bec0f260..1261dc7b84e8 100644
--- a/arch/sh/kernel/cpu/sh4a/smp-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
@@ -73,8 +73,9 @@ static void shx3_prepare_cpus(unsigned int max_cpus)
 	BUILD_BUG_ON(SMP_MSG_NR >= 8);
 
 	for (i = 0; i < SMP_MSG_NR; i++)
-		request_irq(104 + i, ipi_interrupt_handler,
-			    IRQF_PERCPU, "IPI", (void *)(long)i);
+		if (request_irq(104 + i, ipi_interrupt_handler,
+			    IRQF_PERCPU, "IPI", (void *)(long)i))
+			pr_err("Failed to request irq %d\n", i);
 
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
-- 
2.29.2.729.g45daf8777d-goog

