Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE8EC19437
	for <linux-sh@archiver.kernel.org>; Tue,  8 Dec 2020 18:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AABF23B46
	for <linux-sh@archiver.kernel.org>; Tue,  8 Dec 2020 18:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgLHSWH (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 8 Dec 2020 13:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgLHSWH (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 8 Dec 2020 13:22:07 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796BC0613D6
        for <linux-sh@vger.kernel.org>; Tue,  8 Dec 2020 10:21:26 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w13so12566034lfd.5
        for <linux-sh@vger.kernel.org>; Tue, 08 Dec 2020 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvKnwrGKUiG8MWkoBqizB7LEOH8tGZTY85W7ZgAwtYs=;
        b=iGDxAYzWDwjF9jYcM/DCD9VVsjJkY5WluPpidJ+BBrGedwM6InKiWwjq3Bq9RoJN4s
         q/JdX5oFp0CGEyf7Vlb0n1JnlYZayZ6I8x3FpqcbAb1ANvjy895IY/mBBIsnLZUhxWdH
         KgA5ZUvYYyxnTE8KqN/f8OuiuAaJLmyAqfRjPeQyIKhATiyNoO83gT9zjeaCecjEuON+
         aXTRdZq3rGaLRIfXqQKKMHgHbZovFoxkOfnjf4vXi2uf172IFXch9XLEjiUqbOBUrYUe
         qo5f8w4cGyaJba66O2ZCLBIF9A/J3DREx4mva3ip/w34xcHcIU3NciBcOgBJXfYEEEr0
         RC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nvKnwrGKUiG8MWkoBqizB7LEOH8tGZTY85W7ZgAwtYs=;
        b=ab/m8MLcNyNL7B8794Go1j2bAuOI1ebRNtYQ0Hj2V1LHWd+gJX3vvn4YXuq218SGLy
         0Vq7pn1Llg2gUZR9JnL7uCVOGhdbuhVJrhkmeCkK54PUEBMpgeaRE01TRo8Xls5QgJwK
         Ij8wy8Zh8la1Xr7b4EQZlnHd4DvTkv31zSr7Y2bPDIJC0UdtN0HZ7I8DEsAMnDJE3FIu
         vFnF0Z5kX85wAeR2blkVHSd03DGw351SRvlP514aM4B0qs3Fq6amiorr8ZauRB4VFz7m
         z1sP5VQJhelE/3wq1TFf8Tqd2H+hO6NBs3LtwqzWPhP9GiizyH2aMu1uGm8fXt6EzQhn
         UtaQ==
X-Gm-Message-State: AOAM532oegyZ7eUbQ85wDrH/l+RBjn8RuA+q9wsLRdIwCxvuGI4Z326X
        92BpTumi3enrw+/mGZ8CySPIBr+09rh7uQ==
X-Google-Smtp-Source: ABdhPJyauMGklnCc4yQAVtZjPcOLg3jK4YgqVbZewKssgfG6BDochU7DLggkrxL5/kVnM2tKrO4gcA==
X-Received: by 2002:a05:6512:10d3:: with SMTP id k19mr5786877lfg.362.1607451685057;
        Tue, 08 Dec 2020 10:21:25 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:ebc8:8af6:c516:9561])
        by smtp.gmail.com with ESMTPSA id w2sm3342859lfe.40.2020.12.08.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:21:24 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] sh: Fix set but not used warnings with !CONFIG_MMU
Date:   Tue,  8 Dec 2020 19:21:17 +0100
Message-Id: <20201208182117.163642-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201208182117.163642-1-sam@ravnborg.org>
References: <20201208182117.163642-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Building fbdev drivers for sh with W=1 produces the following warning:

    tmiofb.c: In function ‘tmiofb_remove’:
    tmiofb.c:805:21: warning: variable ‘par’ set but not used

This is with allmodconfig and ARCH=sh

This boiled down to iounmap() defined as empty for !CONFIG_MMU.
Fix this by by adding "(void)addr;" to tell the compiler the
argument to iounmap() should be considered used.

v4:
  - Fix build error of ethernet driver (kernel test robot)
    Added missing () around macro parameter

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: kernel test robot <lkp@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/sh/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 6d5c6463bc07..45082bcbd9aa 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -271,7 +271,7 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 #endif /* CONFIG_HAVE_IOREMAP_PROT */
 
 #else /* CONFIG_MMU */
-#define iounmap(addr)		do { } while (0)
+#define iounmap(addr)		do { (void)(addr); } while (0)
 #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
 #endif /* CONFIG_MMU */
 
-- 
2.27.0

