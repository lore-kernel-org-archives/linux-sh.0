Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA931ECAAD3
	for <linux-sh@archiver.kernel.org>; Wed,  7 Sep 2022 23:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiIGXnx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIGXnv (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Sep 2022 19:43:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64EC58D4
        for <linux-sh@vger.kernel.org>; Wed,  7 Sep 2022 16:43:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r17so2616103pgr.7
        for <linux-sh@vger.kernel.org>; Wed, 07 Sep 2022 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0j1lHitkKI8zv51OUe9458yaWImQE2hxQA4HJtTxYWo=;
        b=c9b5CpoWXlrs9X03b01sYu4lTuPjMHcbbZrSo5iSuZ5t9r3WDJItacptAyxC4dzWZ5
         AN9GNBvABvMYkaGq1We41VsnepNRSQ/9bhzJhJNIS9H0WrkJMLiJpYfH1PToCY4tDuvX
         jns87ldIbakoKv/wGO91Ib7yyTTR+NPaswaL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0j1lHitkKI8zv51OUe9458yaWImQE2hxQA4HJtTxYWo=;
        b=45njs1iYFLKMo9gENd038/PgzXBK127MjwDcwRCUSJcf9a16tfqkgzQnGSKDEPrGbi
         adQqq+wIrOtR42xC2rXGlXE1Iu5UHo3C/J1sFhB23TFkQ6+sz2kYSqEwpUjyYa61DkJ9
         j1T6sgoJnR0PdmHTDg9VIgIuxFXxNM/ZCqlpJL2noT17Cd01fy4NWYI5BkKAl+5ad4ID
         TUrjglkjyzke8VVVBjZEdwRb5KscZj6vqghj6uY6y7R5bKsIBaE9EvAJ6JqmzyTKz1tm
         mnh2ouKYPKmDs96L/ANrhktJuWx18Y0XJJ8wunIaEP3DxFf7lGjjgPmUgWvT29C2WKlL
         vDWw==
X-Gm-Message-State: ACgBeo2QywshTbDEbgNd466WwzF9fYiNImx8L3ExgpcXwtEX7C8X+LM8
        uoLPhuuKkuIrb1vdjecm5ZKl5Q==
X-Google-Smtp-Source: AA6agR7O73sdlbx3cf83+5ueyHxyw4n4CPWTHPjWl54z9+lXcdG4/C1MBOd5qJ8fa91F/+kZ65hVkQ==
X-Received: by 2002:a63:484b:0:b0:41d:9ddd:ade with SMTP id x11-20020a63484b000000b0041d9ddd0ademr5257628pgk.540.1662594229272;
        Wed, 07 Sep 2022 16:43:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9-20020aa79f09000000b005383a0d9699sm13685497pfr.144.2022.09.07.16.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:43:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Kees Cook <keescook@chromium.org>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] sh: machvec: Use char[] for section boundaries
Date:   Wed,  7 Sep 2022 16:43:45 -0700
Message-Id: <20220907234345.96798-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689; h=from:subject; bh=VZiYjvR44EJrL43OjO6/kVB+zyBxpEcmV4VSvS2gY7M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjGSyxwU78M7qHr/kbU1BnTKhKqsZPN/KhR7KHhdww LvoofFGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxkssQAKCRCJcvTf3G3AJsjWD/ 4z6YJ8958oetqjO+jDQOZ2cNv/kH8FvINrvfVQFDDaG6itCtm0ruTe//BckDtNgrIsE8RTbpqZqzz4 mvFqC8DXT/wcD5gOGJU7OHekgCcCdp3DaKc7a7Rn/LTBmF9HzGFMH8ADMhIyxjWjR3Uvlu8Jn8Qz4b ZCcML8jrACpc/GTQ1p7+PecKedfNWbgnQyxjG/6SOsm3IhAIMV57PJD8fu/0bmNBEy/0OxNGq0nmXW 35TfEPm7THDj40axqRfQUCz/gbdaq6xXwRRcP0lK07zlTJc6DvPBXOl2XyTvY9YJ4J0c6Pj3fZVCjs bdHEHwztvuGun0roSCrzLXYDfyaHr6X++J4eIEU4QjT0bECMNj+frRpkrov1532EdC+Tc/WpQFpuRp lHyBW4J039trGwcxkOIiOyrzVlbt1d5h7rjxdGf3RtXOmy9zh/mJ8Qs6sYPE5RxD5psD/vMuyCPH3G XBWsA2MPs+UEw/lVAvfoMFK41fSI2gk2n92oSx8syex76Rsn1VqSLsE5YNorGItHTVOlwSU+8TkgeG sf90gM9mgEgtNkt826mC5WBXRSz4dTb7DpXvUkBgd6am3EkwSMXKzMJppV/YxPXLXviBebWiGzjnxT ZO+k2/uOYd5d3mL2euZSYi7z9I0qR1ZZplqgFnxzqjaigMsiEJCkLiECxOXg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

As done for other sections, define the extern as a character array,
which relaxes many of the compiler-time object size checks, which would
otherwise assume it's a single long. Solves the following build error:

arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg/
Fixes: 9655ad03af2d ("sh: Fixup machvec support.")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sh/include/asm/sections.h |  2 +-
 arch/sh/kernel/machvec.c       | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/sections.h b/arch/sh/include/asm/sections.h
index 8edb824049b9..0cb0ca149ac3 100644
--- a/arch/sh/include/asm/sections.h
+++ b/arch/sh/include/asm/sections.h
@@ -4,7 +4,7 @@
 
 #include <asm-generic/sections.h>
 
-extern long __machvec_start, __machvec_end;
+extern char __machvec_start[], __machvec_end[];
 extern char __uncached_start, __uncached_end;
 extern char __start_eh_frame[], __stop_eh_frame[];
 
diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
index d606679a211e..57efaf5b82ae 100644
--- a/arch/sh/kernel/machvec.c
+++ b/arch/sh/kernel/machvec.c
@@ -20,8 +20,8 @@
 #define MV_NAME_SIZE 32
 
 #define for_each_mv(mv) \
-	for ((mv) = (struct sh_machine_vector *)&__machvec_start; \
-	     (mv) && (unsigned long)(mv) < (unsigned long)&__machvec_end; \
+	for ((mv) = (struct sh_machine_vector *)__machvec_start; \
+	     (mv) && (unsigned long)(mv) < (unsigned long)__machvec_end; \
 	     (mv)++)
 
 static struct sh_machine_vector * __init get_mv_byname(const char *name)
@@ -87,8 +87,8 @@ void __init sh_mv_setup(void)
 	if (!machvec_selected) {
 		unsigned long machvec_size;
 
-		machvec_size = ((unsigned long)&__machvec_end -
-				(unsigned long)&__machvec_start);
+		machvec_size = ((unsigned long)__machvec_end -
+				(unsigned long)__machvec_start);
 
 		/*
 		 * Sanity check for machvec section alignment. Ensure
@@ -102,7 +102,7 @@ void __init sh_mv_setup(void)
 		 * vector (usually the only one) from .machvec.init.
 		 */
 		if (machvec_size >= sizeof(struct sh_machine_vector))
-			sh_mv = *(struct sh_machine_vector *)&__machvec_start;
+			sh_mv = *(struct sh_machine_vector *)__machvec_start;
 	}
 
 	pr_notice("Booting machvec: %s\n", get_system_type());
-- 
2.34.1

