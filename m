Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E434CC32789
	for <linux-sh@archiver.kernel.org>; Sun, 21 Aug 2022 11:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiHULgZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 21 Aug 2022 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiHULgW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 21 Aug 2022 07:36:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422492655C
        for <linux-sh@vger.kernel.org>; Sun, 21 Aug 2022 04:36:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d16so4760303wrr.3
        for <linux-sh@vger.kernel.org>; Sun, 21 Aug 2022 04:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XFcC8WCeCDvxB/v+0OTyUBSnoJfVKZTiHSkk+ggPSsY=;
        b=I9p8YQn3K62FrSJWSUFKpOt0UsIp+9bsVsD+oJfNVAcT5h+CZYJtepbN0KIrbvEqWC
         CfN+volyR9bkDOtWlZbTynhimAFp9312moQA2S0Vze0jmih9oIcwdFW38pAOKUPJseBw
         vMXObcP9ocBcIkaAz6g2imqEU6D0lOnKb5CehLfpmxYG+VEplogLacfxwfy+ksZUG/ba
         fWhm3yt3q55nHleahnjNEgTQWqs0O1LDRCrwF1Bfp0r4mcW8zfpLSVE+W3F607TvX0XO
         myClgiQ90dkmpbgSGL1SbcfaCzOiSRAATApsyLCyMyd3sSauWoR6ic4v0/7cwRhrog46
         TWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XFcC8WCeCDvxB/v+0OTyUBSnoJfVKZTiHSkk+ggPSsY=;
        b=wzK7OBxYwE+QDpcnaapbRNz3nYzWx2oimLTeTfuORB658vu2ERv6LT0wrYQ0F9P4Rj
         sDWKyfyuEVopLuafi1mu9pb73Yd1/HBzWWhXwt5kLCu7mxxA3bXKHZFbwbIXWzZZ6Tr7
         Sp0KeFL64/OrPlCNqyH6WkPd8b9QctF3N6dzqVodEfc5ZxAdOHWNzLfPpZDF9kSvst4c
         S8dQBgVpx7jr0gMQY5FPOrsuuy/VKnSO/r4ngKv8ArosSmJQ7nH753puKntmqPo5s/oF
         ty5DUo4cyilXEP/KdSYG3ko4yrdslydC5pc7pcY4vpnzC2gMNOHFE6vtOmRKdPyKgLeD
         kXvQ==
X-Gm-Message-State: ACgBeo0IHE94Zr8y9bZg4R04lHq6+ZD+O/A23v8gb3bq8+k2liOCPo7v
        Ydr6YPy4ZXxpqNHC9f0qvjAxcg==
X-Google-Smtp-Source: AA6agR7yQJr2EFqeBiX7zFLHOZnS6xuQZ2CSX2d2szPgHhQ8PkJnM5BxqWwAIlAcnq3r7wGuyd1j6Q==
X-Received: by 2002:a05:6000:381:b0:221:7540:b1ee with SMTP id u1-20020a056000038100b002217540b1eemr8123300wrf.307.1661081780659;
        Sun, 21 Aug 2022 04:36:20 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm14071361wmc.29.2022.08.21.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:36:19 -0700 (PDT)
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
Subject: [PATCH 2/6] microblaze: use the asm-generic version of cpuinfo_op
Date:   Sun, 21 Aug 2022 12:35:09 +0100
Message-Id: <20220821113512.2056409-3-mail@conchuod.ie>
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
 arch/microblaze/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 7e9e92670df3..45a86692e90f 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -13,10 +13,10 @@
 #include <asm/registers.h>
 #include <asm/entry.h>
 #include <asm/current.h>
+#include <asm-generic/processor.h>
 
 # ifndef __ASSEMBLY__
 /* from kernel/cpu/mb.c */
-extern const struct seq_operations cpuinfo_op;
 
 # define cpu_relax()		barrier()
 
-- 
2.37.1

