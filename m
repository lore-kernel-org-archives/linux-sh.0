Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E6EC678D4
	for <linux-sh@archiver.kernel.org>; Thu,  2 Mar 2023 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjCBJoM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 2 Mar 2023 04:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBJoA (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 2 Mar 2023 04:44:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0DE1EFD1
        for <linux-sh@vger.kernel.org>; Thu,  2 Mar 2023 01:43:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h14so15877576wru.4
        for <linux-sh@vger.kernel.org>; Thu, 02 Mar 2023 01:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677750236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbz3qPh8Vf4E5t0N0jLkvnNCTDzRiNZiABy0E7ku09A=;
        b=FjcjeTZjTFaxH4VHm9vqzy6q58OH/HkCkp4eeNdmlVQohDZjtISKbQ1rDciJiVlhMb
         Lizr950uCsVfkEKNzL+/Ylk6nUWJLw7DQMP12nWoF6kjfP2umysCluiKZTHYQjZoEsI2
         Nhobim8XluTR4y0sVzGtdOJuXAA9BpfOFm0DgA0ygsO8UPqEpSpBMutzyggFWOmflinv
         BSFYwW3JULWxccPAPxFTRvX1TdQiZwPkgTlKoLqvH5F8ChwjZPSaggp1/t0Rnh/ejd5/
         iYy+4kl9dd2bd8ubZ+wAubF9VKZ2j6jItvpDWAgN8xfGg3XJbrjYv5byilTM87U+vsII
         czqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbz3qPh8Vf4E5t0N0jLkvnNCTDzRiNZiABy0E7ku09A=;
        b=lq33ORz1eK8yiA0n9RngDkCqaSkzY0VjbQxiUB0DvG60AL4UaS6KQvNkHuYaX/7ZVI
         m/7kCaRuJGx8TlwgM1L9fO4DfjeSrd2dZ1qBkdqDAqzOQGd2i2Slf/DWuzpmzwJwi9xN
         jW9L7TrcuEg7h4i+DCJnoBoGJMPIyjNFBQyV8QpMSAAsen7sUHhFvSV+Tx5RTT/9VACV
         SH45NC4L72lHpV62v5TTo/uFpGDtBXPSREmMbx/MOCfOYHRi+YN1HI2Y1qFtJZ+KPa1e
         d5Y37eATPxcN0jeX2aZ7wX6yYTQww6EdG0zPSonhqFHYTHEusPQPuO74+tV49ZnwcEQM
         REoQ==
X-Gm-Message-State: AO0yUKVCz7W8hjsI8R+jg4vuKqdDLhbfi2rThIZUpuR8Z1Y3RCxeqXAQ
        qCeG494FGwmgAbCZuYOoJj4FRA==
X-Google-Smtp-Source: AK7set+lZ7FSC2o4iKI8nuwF9t+GAc77tohtNIx45MEJkzo78fuSiMTvrDatTRm4UxHWNwZvRfNOQg==
X-Received: by 2002:a5d:6805:0:b0:2ca:6442:c817 with SMTP id w5-20020a5d6805000000b002ca6442c817mr6839399wru.57.1677750235863;
        Thu, 02 Mar 2023 01:43:55 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6691000000b002c54e26bca5sm14674065wru.49.2023.03.02.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:43:55 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
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
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 08/24] parisc: Remove COMMAND_LINE_SIZE from uapi
Date:   Thu,  2 Mar 2023 10:35:23 +0100
Message-Id: <20230302093539.372962-9-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302093539.372962-1-alexghiti@rivosinc.com>
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
---
 arch/parisc/include/asm/setup.h      | 7 +++++++
 arch/parisc/include/uapi/asm/setup.h | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 arch/parisc/include/asm/setup.h

diff --git a/arch/parisc/include/asm/setup.h b/arch/parisc/include/asm/setup.h
new file mode 100644
index 000000000000..78b2f4ec7d65
--- /dev/null
+++ b/arch/parisc/include/asm/setup.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _PARISC_SETUP_H
+#define _PARISC_SETUP_H
+
+#define COMMAND_LINE_SIZE	1024
+
+#endif /* _PARISC_SETUP_H */
diff --git a/arch/parisc/include/uapi/asm/setup.h b/arch/parisc/include/uapi/asm/setup.h
index 78b2f4ec7d65..bfad89428e47 100644
--- a/arch/parisc/include/uapi/asm/setup.h
+++ b/arch/parisc/include/uapi/asm/setup.h
@@ -2,6 +2,4 @@
 #ifndef _PARISC_SETUP_H
 #define _PARISC_SETUP_H
 
-#define COMMAND_LINE_SIZE	1024
-
 #endif /* _PARISC_SETUP_H */
-- 
2.37.2

