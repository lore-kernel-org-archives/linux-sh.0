Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF22CC61DA4
	for <linux-sh@archiver.kernel.org>; Mon,  6 Mar 2023 10:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCFKcR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCFKcC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 6 Mar 2023 05:32:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDD2231C9
        for <linux-sh@vger.kernel.org>; Mon,  6 Mar 2023 02:31:33 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p16so5277906wmq.5
        for <linux-sh@vger.kernel.org>; Mon, 06 Mar 2023 02:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678098687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBrHhQ+ENLcTDHZblgvw5cJviEIcUkQODsWe9Dpzcfk=;
        b=dMG398VnS6d7Sp/v2WHmOoLb1Pl0DUkmJwFGFlaFFE2NBSpl3bfx7goOgx/bA/e+eT
         JlGXkZ/YKC5/CAaUgrAgf2hwRlXoi/w09fk+d6JbzRsi1xEOvnET1ZtQw1GHTDzGO9Kc
         4tpVQXj5bbt90ZEPTxaGams7zZPu/WPnuP8OFNZQ10jn8lYY76GXgznimwmVX0LnUN36
         +jRh0o9oGjoo103N9nKFb3gVEbdh9sBKJ7FOEhJBNFyEiOBkSLl1OpmtwlekjwfER05t
         fJR2GSWXVNdO1/cuJA3g80GcEhaj/voiZrBUwN52fql9jSz5wH4gJd9Czzz14Ra75Rbq
         MY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBrHhQ+ENLcTDHZblgvw5cJviEIcUkQODsWe9Dpzcfk=;
        b=A6t3CnMq0hJwrtASmlMsjK9Cx0p+ps+YEe8O/nURplDangrJ2kEBXhFHN5bkqJjzIV
         dIrRdVhoq0FQLYckzPz2UfyTYNdI8pENruNIIzbO5kYFgEc9WySdVA5+l0clqKLwXiq9
         16KbFdxIGll8E9DLC3X9tRdz3hcPct08yKgdLi26L4hPBDdjI8i8Ob5WCW7Wg+1vX3bA
         jfFvqzB8eblPYaYZlWnCfBE4derXJbfQoQEhAQHLfadwG4qb90mSDi9Tm+Iniee9D56P
         nsVG0OZWh7YHH5rmoZNZaq+7cwSHwzUhCWfRekhGTG7HKezzAaKuOKX+RUb7VF2AUb21
         G77w==
X-Gm-Message-State: AO0yUKV6/ENA9tarIFVVzuPTUB7N9v/3DQWsW5o0smebd3MJOaTBU+wq
        wgFS1Utc89YD9aGuO0YXh+xo2Q==
X-Google-Smtp-Source: AK7set+mfsESm6FhCUVbPpBS4o2ZwfEIZrHS0GSjjE7LL6WnlaHBrOa5vkgBJgbjhYrNsG8jr1kFSQ==
X-Received: by 2002:a05:600c:3550:b0:3ea:bc27:6a64 with SMTP id i16-20020a05600c355000b003eabc276a64mr8765213wmq.10.1678098686828;
        Mon, 06 Mar 2023 02:31:26 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b003e4326a6d53sm14498645wmq.35.2023.03.06.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:31:26 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 25/26] s390: Remove empty <uapi/asm/setup.h>
Date:   Mon,  6 Mar 2023 11:05:07 +0100
Message-Id: <20230306100508.1171812-26-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 arch/s390/include/asm/setup.h      | 1 -
 arch/s390/include/uapi/asm/setup.h | 1 -
 2 files changed, 2 deletions(-)
 delete mode 100644 arch/s390/include/uapi/asm/setup.h

diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 177bf6deaa27..99c1cc97350a 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -7,7 +7,6 @@
 #define _ASM_S390_SETUP_H
 
 #include <linux/bits.h>
-#include <uapi/asm/setup.h>
 #include <linux/build_bug.h>
 
 #define PARMAREA		0x10400
diff --git a/arch/s390/include/uapi/asm/setup.h b/arch/s390/include/uapi/asm/setup.h
deleted file mode 100644
index 598d769e76df..000000000000
--- a/arch/s390/include/uapi/asm/setup.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-- 
2.37.2

