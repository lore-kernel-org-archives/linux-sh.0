Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F1C38145
	for <linux-sh@archiver.kernel.org>; Sun, 21 Aug 2022 11:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiHULgu (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 21 Aug 2022 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiHULgb (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 21 Aug 2022 07:36:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50895205C3
        for <linux-sh@vger.kernel.org>; Sun, 21 Aug 2022 04:36:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n7so10068060wrv.4
        for <linux-sh@vger.kernel.org>; Sun, 21 Aug 2022 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=iRydGNWOVxx1HqAigFxDEMCuXoX5Io4IU5ztqyzaPAs=;
        b=Y1WaN5EAlXdoOlvAydRCG82PKL3F1frMO2Gueklv8Hl+oRlW3+ER52FQNA65qlT4ar
         Z7WCuQ1OFzwV34ttvUMnnPCxnyOST7zPOvFzJnEfB+4j9LdkZRYIp6/YyrcDINihXi58
         Mi56g3YyTvh3AlocFbuYHF9KLeRtMj+gJZRl7xjIB1eNlD6/JSYjnAvfIJHSWd6ub0ac
         OCinSVK1v+4gLgh4cdvz9HZxI3kVUH04Zi9qadv4lPjNlRfWpHjmC5O0WECWQc0OFyyR
         pCJxCnow4Yga7OV0QJIHOuik6NTHAoDHxEufFMcUkn3qy31H1Se8nChjkuwao431/pXh
         hafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iRydGNWOVxx1HqAigFxDEMCuXoX5Io4IU5ztqyzaPAs=;
        b=RDjuB/g3tjlSmx7Ydor4h6h95CzIePjiC8VVw9Fp0YCKKUNn+/D17Ssk90lq1vQ/Wi
         KLBbwokrGmLspdOjvzG8eWFLbML/vwFhQUR3QF/VFMgszLBWOnuGC2v+LGpFbsoQPbMb
         NtIJ0U04jWBc2pXsop1MOONAJe4f06igZj8o1beE6j4LHTKWzrj96EVv/w/1aNTFjApE
         +Kc542W1n78F81mr8jGl4IbpR3VnLlz+wZNjimZPJvdXOnJQLWezpXz6RnRQM2XhyeW+
         teDvD2eDqi4FySI+VJaLItFSBANibIf1r+2WUBEfs85GQ77ts3ZJbHhvFsyxHS/C+ygs
         9keA==
X-Gm-Message-State: ACgBeo1AEPLokaILnrNV0Us+QM0O+3UQ4LJD7u1imI3+F39KZWHv6nBG
        U954VsoZ/PdqyeXKWQrG9LSD9w==
X-Google-Smtp-Source: AA6agR5T0RaXBxKPuBVBjPGUHGtJfc4tSWj3x0g4PlWZixJIT3RipsnS2LEVMZyj6NI4Nvr7MxTB/A==
X-Received: by 2002:a05:6000:1545:b0:220:61fa:64a with SMTP id 5-20020a056000154500b0022061fa064amr8748201wry.174.1661081783798;
        Sun, 21 Aug 2022 04:36:23 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm14071361wmc.29.2022.08.21.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:36:23 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michal Simek <monstr@monstr.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 4/6] sh: use the asm-generic version of cpuinfo_op
Date:   Sun, 21 Aug 2022 12:35:11 +0100
Message-Id: <20220821113512.2056409-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220821113512.2056409-1-mail@conchuod.ie>
References: <20220821113512.2056409-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

There's little point in duplicating the declaration of cpuinfo_op now
that there's a shared version of it, so drop it & include the generic
header.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/sh/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 85a6c1c3c16e..4125494515c9 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -4,6 +4,7 @@
 
 #include <asm/cpu-features.h>
 #include <asm/cache.h>
+#include <asm-generic/processor.h>
 
 #ifndef __ASSEMBLY__
 /*
@@ -123,7 +124,6 @@ extern unsigned int mem_init_done;
 
 /* arch/sh/kernel/setup.c */
 const char *get_cpu_subtype(struct sh_cpuinfo *c);
-extern const struct seq_operations cpuinfo_op;
 
 /* thread_struct flags */
 #define SH_THREAD_UAC_NOPRINT	(1 << 0)
-- 
2.37.1

