Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74223C433FE
	for <linux-sh@archiver.kernel.org>; Thu, 10 Dec 2020 12:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2962C23B85
	for <linux-sh@archiver.kernel.org>; Thu, 10 Dec 2020 12:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgLJMpP (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 10 Dec 2020 07:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732303AbgLJMpI (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 10 Dec 2020 07:45:08 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D912C061793
        for <linux-sh@vger.kernel.org>; Thu, 10 Dec 2020 04:44:26 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t22so6540213ljk.0
        for <linux-sh@vger.kernel.org>; Thu, 10 Dec 2020 04:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXISkJRfuu29yjZKwNcwIYWwxoidthXqPj4iaxzKDlc=;
        b=Fz8/+pHJLyY0S6eIVmi7KN83r5sa2zEd+2fV9GFcAdBbY/A5VTUhlzKFQgXgA+3MjL
         bcCILtKcRi/c4GFV9iif2seMC3bJe5ExwfFFzODPnVcCgFxSmGkfhn8nZSl2xv9JDzEf
         0VQdIb3MZPmod0JAUZ4i9dz3dZE+rUCEvbNRUqGxPSMOMC4upWNHFho+uDGvtMdYHr6s
         c+mCRuUxxREqNPFasZ+aktHEHECgvuZJenlS5S4sPRtE5aH9ZWV/pMqZaS4m80xo2so4
         mTe1qMoIO0CBwBOkiRK87fBvmofjsAoOHt3xEh/MxZBHjm+AZnWlPPRJ8l867VrkTOU3
         lKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXISkJRfuu29yjZKwNcwIYWwxoidthXqPj4iaxzKDlc=;
        b=s74o1cTwVOs4TfPXwSUtvR2TOXHU1AaTf5gtJYJOoap/H1LedysTwE7KDhltKP1xYc
         vDNiErPAyJgDmPJcVS59tpz1Nka+M9YLQkwInDXEXx9i8o4BwWDiKRD+rMvwwol8ieqF
         YpARkunG67HOFV1aXoH48SN/dOYSrHPIWvoLMKfomeI8/pDbs92CbhHlHKWabP+UT66i
         Ke0/ha8eWkv0iOndEsh5jdf1qi1v7ishGIsd7XEvQuBf032okCR1qFchQa2ihHhFp29c
         4hkFqEpGtsV8phbHg3udsV8kBdxvMZ0CVFxq/wmP4QA4arGMikq4Jm5zd/Khdts1jn6L
         VHsA==
X-Gm-Message-State: AOAM530cRQ2aKHxhecTIs4W8uiNh5UV9sVxshwABvSLAev7KKcu+KcyU
        y4cBugv3VY3b+0/8EgdxTvqhKQ==
X-Google-Smtp-Source: ABdhPJyeTzvL/BAx+p7eJgSGOi/kKBb47wPWWLFHxAznS7LBli9DuRslR/mTlbFqG9Sx4biauKJtkg==
X-Received: by 2002:a2e:1657:: with SMTP id 23mr2951196ljw.12.1607604264913;
        Thu, 10 Dec 2020 04:44:24 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id z20sm592544ljh.86.2020.12.10.04.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:44:24 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] sh: kernel: traps: remove unused variable
Date:   Thu, 10 Dec 2020 13:44:22 +0100
Message-Id: <20201210124422.3858524-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

When building defconfig the following warning shows up:

arch/sh/kernel/traps.c: In function 'nmi_trap_handler':
arch/sh/kernel/traps.c:183:15: warning: unused variable 'cpu' [-Wunused-variable]
  unsigned int cpu = smp_processor_id();
               ^~~

Remove an unused variable 'cpu'.

Fixes: fe3f1d5d7cd3 ("sh: Get rid of nmi_count()")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/sh/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index f5beecdac693..e76b22157099 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -180,7 +180,6 @@ static inline void arch_ftrace_nmi_exit(void) { }
 
 BUILD_TRAP_HANDLER(nmi)
 {
-	unsigned int cpu = smp_processor_id();
 	TRAP_HANDLER_DECL;
 
 	arch_ftrace_nmi_enter();
-- 
2.29.2

