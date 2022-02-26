Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BADEC433F5
	for <linux-sh@archiver.kernel.org>; Sat, 26 Feb 2022 16:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiBZQBo (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 26 Feb 2022 11:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiBZQBn (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 26 Feb 2022 11:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B178179259
        for <linux-sh@vger.kernel.org>; Sat, 26 Feb 2022 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645891267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qCqINOQynquBVH+X40kSOhFUiEBHFu+5I+8mTF3ybnI=;
        b=aQiPQTnLeKE+KBuhzyrtocszbdvNahyRN3sQd2gQQSI3eSYAyudttYq6NewERZJ0pXi4bK
        mcsnAVVnk8nMCDNN+L0jHRbbd7A80l+26+uAQHiuZvpKPq5kRmheS8oOlpYmiT0xVTC4HQ
        A7fl+E8rZbg50SVm7X4Pgmx8pH2ogeo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-XPnppinYPSqhbkXB-a0Blw-1; Sat, 26 Feb 2022 11:01:06 -0500
X-MC-Unique: XPnppinYPSqhbkXB-a0Blw-1
Received: by mail-qv1-f71.google.com with SMTP id jr12-20020a0562142a8c00b0042d7901650cso8006378qvb.17
        for <linux-sh@vger.kernel.org>; Sat, 26 Feb 2022 08:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCqINOQynquBVH+X40kSOhFUiEBHFu+5I+8mTF3ybnI=;
        b=Z4BKopbotkmbsZPSXcFCVRdaeFcsjWvIJ4OsXW5qPgSTCmjGukrWxk4cYwAqd7OgRM
         jB0P5/4ANcVBglUWYiR+JCevQw6rKo8jsvznQcbgAxbASWsmCEYKpvo/C0ESDYJd+4cy
         YPfKQDq7lNIxAqbAPP9OeKOjx4V1gxKbOTw1Q9Xgu6boimjl20QzyDJjm2Q2nIdAFnIU
         wGi2ZXLHagTE+6NX5JrJ8NO1p285kudPhdhyBPh048CnaooAoDqsduEusYjF0CbpQSSP
         OxY2wlxxNL6roSNbORLkXwm7j9GHunT4b66n0dKXOsvsEOBwULRPCE8agO8LnWWjiu5P
         YcmQ==
X-Gm-Message-State: AOAM5331oTfCtkwnCUAF72whXRYTFl4DzV/8UTDCy5wTYGuTZsBSj1v+
        LTC3jODzF2kdDmns8mFIwvSB5Ge5bfHkSbodFGFrGamflKrtj78U21wqX/6MvNKEOZ2AEvBaQ8H
        ec2NtZX6hVNYYHR8mmD4=
X-Received: by 2002:a05:6214:20a1:b0:42d:6f51:46e2 with SMTP id 1-20020a05621420a100b0042d6f5146e2mr9319664qvd.67.1645891265740;
        Sat, 26 Feb 2022 08:01:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrZuGlgdj4kgPM9qty3y9swpN5H03h3zppYgwnC6NM/6p/yilQ2qHIOt9Qulnvxtp1Jow/uw==
X-Received: by 2002:a05:6214:20a1:b0:42d:6f51:46e2 with SMTP id 1-20020a05621420a100b0042d6f5146e2mr9319649qvd.67.1645891265477;
        Sat, 26 Feb 2022 08:01:05 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a245300b0047c5aec8cabsm2964991qkn.123.2022.02.26.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 08:01:05 -0800 (PST)
From:   trix@redhat.com
To:     ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org,
        rmk+kernel@armlinux.org.uk, peterz@infradead.org,
        keescook@chromium.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] sh: cleanup comments
Date:   Sat, 26 Feb 2022 08:00:54 -0800
Message-Id: <20220226160054.4176509-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Tom Rix <trix@redhat.com>

spdx, remove the extra '-'

Replacements
Defitions to Definitions
highger to higher
mechanizm to mechanism
useable to usable
presision to precision

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/sh/include/asm/addrspace.h      | 2 +-
 arch/sh/include/asm/fixmap.h         | 6 +++---
 arch/sh/include/asm/platform_early.h | 2 +-
 arch/sh/include/asm/processor_32.h   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 468fba333e896..1fba671326890 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -2,7 +2,7 @@
  *
  * Copyright (C) 1999 by Kaz Kojima
  *
- * Defitions for the address spaces of the SH CPUs.
+ * Definitions for the address spaces of the SH CPUs.
  */
 #ifndef __ASM_SH_ADDRSPACE_H
 #define __ASM_SH_ADDRSPACE_H
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index b07fbc7f7bc6a..5bb7e60ccc7b0 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -26,7 +26,7 @@
  *
  * these 'compile-time allocated' memory buffers are
  * fixed-size 4k pages. (or larger if used with an increment
- * highger than 1) use fixmap_set(idx,phys) to associate
+ * higher than 1) use fixmap_set(idx,phys) to associate
  * physical memory with fixmap indices.
  *
  * TLB entries of such buffers will not be flushed across
@@ -34,7 +34,7 @@
  */
 
 /*
- * on UP currently we will have no trace of the fixmap mechanizm,
+ * on UP currently we will have no trace of the fixmap mechanism,
  * no page table allocations, etc. This might change in the
  * future, say framebuffers for the console driver(s) could be
  * fix-mapped?
@@ -53,7 +53,7 @@ enum fixed_addresses {
 #ifdef CONFIG_IOREMAP_FIXED
 	/*
 	 * FIX_IOREMAP entries are useful for mapping physical address
-	 * space before ioremap() is useable, e.g. really early in boot
+	 * space before ioremap() is usable, e.g. really early in boot
 	 * before kmalloc() is working.
 	 */
 #define FIX_N_IOREMAPS	32
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
index fc802137c37d4..00b6e6dc4ac4a 100644
--- a/arch/sh/include/asm/platform_early.h
+++ b/arch/sh/include/asm/platform_early.h
@@ -1,4 +1,4 @@
-/* SPDX--License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef __PLATFORM_EARLY__
 #define __PLATFORM_EARLY__
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index 45240ec6b85a4..0ca85637c3b99 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -158,7 +158,7 @@ static __inline__ void enable_fpu(void)
 			     : "r" (~SR_FD));
 }
 
-/* Double presision, NANS as NANS, rounding to nearest, no exceptions */
+/* Double precision, NANS as NANS, rounding to nearest, no exceptions */
 #define FPSCR_INIT  0x00080000
 
 #define	FPSCR_CAUSE_MASK	0x0001f000	/* Cause bits */
-- 
2.26.3

