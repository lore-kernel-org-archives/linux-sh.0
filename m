Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB927C433F5
	for <linux-sh@archiver.kernel.org>; Sat,  2 Oct 2021 19:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B9A619EC
	for <linux-sh@archiver.kernel.org>; Sat,  2 Oct 2021 19:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhJBTOO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 2 Oct 2021 15:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhJBTON (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 2 Oct 2021 15:14:13 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B78C0613EC
        for <linux-sh@vger.kernel.org>; Sat,  2 Oct 2021 12:12:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e144so15568478iof.3
        for <linux-sh@vger.kernel.org>; Sat, 02 Oct 2021 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZOaBNnj00pLFecEyXMl/Bc8m8pDlS6WA4HjIdytrTag=;
        b=zhN0XDnNCJBpY1D3hPToCfjH2bhPplASw0R4KJMNzbUokyknPi0c94QDBpYyAjr26e
         JhrWvaC8zKC+1rBy0GUamNWZf4X/erCyjWrSmpLTUZ/z8pv7dt+GolUHzqwVZrgyNio7
         Yeerl0Y3kmNkQ9T5o/jEaW19xCQqpUK9dG6ThBCeTXBNF3qtOL5BBx3IDVgRKCq7Dknq
         +jVZabbTcvYihOxIp3YTINs8J6gETSUBEZAMIs+IrE8LBjIIAdbILRYPJAEHlbHaMDCH
         DGCUYjERsWoGAcZK7UFDveHkoy7ND6h3dicsBLMnXAIQQmB7uP53Fi6/j11HBfrS6aJc
         VMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZOaBNnj00pLFecEyXMl/Bc8m8pDlS6WA4HjIdytrTag=;
        b=FsIvolGNZ7QwcSEm+jJoOjdPbn1eEITu4ajbTGDVamfV7NwDRVvreif3nQzxyaTEPH
         /vBsWRNA4seudIoM5kaXFMBrJdN1YkI0aa9lmLKevI9On2iUV81afIX9xO0tkc1nK1Ii
         ItuidsSnQirIGp5iFPbnKqqXdTeivLvxdxzPPP/XC+xdgyix6JsgyOnbVfLV8pMudjBO
         8Dz3fdYLcdRVd4r3U3/FHbTKQ4Z3gy6+FA13tF7PvundqT5kY8cE/BsLlzM/izpIMCbk
         GrODJw6AuWFhdS2PcNg5TicEUL9iHOJOdbCGl51Q29wJQV9p2skIlflVyUobmv6CWWq9
         i2mQ==
X-Gm-Message-State: AOAM531x+sBahIvhg+MlL7//Mz/HOGpJ/D70eZqWC2OWLv4Iydm2B3FS
        trKtWpxIXK8vwORP8FgIAx9fV3cwlWRZw2xc
X-Google-Smtp-Source: ABdhPJyM1v3PS/zsTR9IJTj4KikH4MpwADZsZlJA02xmXh15intnIkT5F7IQgyCEdMzUJyXEzZKJcw==
X-Received: by 2002:a6b:b714:: with SMTP id h20mr3455675iof.9.1633201946795;
        Sat, 02 Oct 2021 12:12:26 -0700 (PDT)
Received: from [192.168.221.11] ([172.58.143.248])
        by smtp.gmail.com with ESMTPSA id v63sm5809888ioe.17.2021.10.02.12.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 12:12:26 -0700 (PDT)
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] Fix the j-core SOC build.
To:     Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
Message-ID: <7d559bd1-1f9c-124f-ad4d-c805c049971a@landley.net>
Date:   Sat, 2 Oct 2021 14:32:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Rob Landley <rob@landley.net>

Commit b67177ecd956 broke the j-core SOC build with a link failure, because
mm/percpu.c function pcpu_post_unmap_tlb_flush() calls flush_tlb_kernel_range()
which is defined under #ifdef CONFIG_MMU.

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/sh/kernel/smp.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 65924d9ec245..3ec8f32aad85 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -468,4 +468,9 @@ void flush_tlb_one(unsigned long asid, unsigned long vaddr)
 	local_flush_tlb_one(asid, vaddr);
 }

+#else
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	local_flush_tlb_all();
+}
 #endif
