Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA08C7EE37
	for <linux-sh@archiver.kernel.org>; Thu,  2 Mar 2023 09:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCBJj7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 2 Mar 2023 04:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCBJj6 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 2 Mar 2023 04:39:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D43800F
        for <linux-sh@vger.kernel.org>; Thu,  2 Mar 2023 01:39:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so1239221wmb.3
        for <linux-sh@vger.kernel.org>; Thu, 02 Mar 2023 01:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677749989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CISuzHFPlWEL0+BckqkuDR3KPCbCkgyxsx0yLTYCfgQ=;
        b=mvAQ/sUJrMvToNIW3uBprlLipG+4xudOkl2mhckX4OGK/AVgwz7M+1kq0ZlSekul2H
         iaSpNk9XnBE22tux4aq7Fne4qp0NzaBr7LlrwIv1I6A0qSy8Q4dcmpjI/PtFkVzR97Dm
         PghgQ/vOyEJwZ7kbrNWriq0DWoth/L6Eehut3hd3Ds19f0guS5U3oCTWQ/b3hzIlx1fs
         vXNI2/gANNNDrq5U2tFQtDSval3OqcBF+RERjM9zaPdPy/rixAomiaxXKrVr1cthueQ6
         8/+7PQmlsjNA5nLMdQqswYp0A+SkM39sQo/CDqmLyzRweVtsXLTpjaf8YsMg4ng/WCD/
         asVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677749989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CISuzHFPlWEL0+BckqkuDR3KPCbCkgyxsx0yLTYCfgQ=;
        b=GyOkxp+txehpzSnDQKX1Cwoc3RGYaOaYGt398E3DkJRTg1G/At5LHNwnK9On9g1z4h
         Ae/lg0wBmDx9L8bdAsbro3QhQVmVFekRnqf8TjraH07pGHs03skDpO8db+3Xi7NwwLUY
         Af8sSqjfWFG3/cT5n4kzizXOu90xTXnEsROzBahNrr0/yVzlEBDXfPNe3EtQ6K+kDb0X
         AT+OQ63GRAHKKH0r4P6DrZOCRjAnyz96vtqh1KKz8w2yn1UVI0vPnSMa9G3K5ceU6e8e
         Lk7F39aWLPbFzmtHbvPasvczYwPvD3WcX2LeMHO1blKhqbVeESbI6TQmPHkzxA5ZoCQx
         BNCQ==
X-Gm-Message-State: AO0yUKXvUWS5suACYeiIleD5ftWdTJbQy0/GfbMdVGaMsBa0HLfYsKW4
        72ssEifmEQvopje3Rx9eVWtq0Q==
X-Google-Smtp-Source: AK7set9lFt0iZ9EjNkQqPCw9KEszf+VRfbLSHsjZXvUWE8D4h7d0r4CcIQXMv9OeGpfEOookMofTGg==
X-Received: by 2002:a1c:f30b:0:b0:3eb:29fe:fe19 with SMTP id q11-20020a1cf30b000000b003eb29fefe19mr8089251wmq.34.1677749989030;
        Thu, 02 Mar 2023 01:39:49 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b003dfe5190376sm2628855wms.35.2023.03.02.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:39:48 -0800 (PST)
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
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 04/24] ia64: Remove COMMAND_LINE_SIZE from uapi
Date:   Thu,  2 Mar 2023 10:35:19 +0100
Message-Id: <20230302093539.372962-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302093539.372962-1-alexghiti@rivosinc.com>
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/ia64/include/asm/setup.h      | 10 ++++++++++
 arch/ia64/include/uapi/asm/setup.h |  6 ++----
 2 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 arch/ia64/include/asm/setup.h

diff --git a/arch/ia64/include/asm/setup.h b/arch/ia64/include/asm/setup.h
new file mode 100644
index 000000000000..0b19338ea3ec
--- /dev/null
+++ b/arch/ia64/include/asm/setup.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __IA64_SETUP_H
+#define __IA64_SETUP_H
+
+#include <uapi/asm/setup.h>
+
+#define COMMAND_LINE_SIZE	2048
+
+#endif
diff --git a/arch/ia64/include/uapi/asm/setup.h b/arch/ia64/include/uapi/asm/setup.h
index 8d13ce8fb03a..bcbb2b242ded 100644
--- a/arch/ia64/include/uapi/asm/setup.h
+++ b/arch/ia64/include/uapi/asm/setup.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __IA64_SETUP_H
-#define __IA64_SETUP_H
-
-#define COMMAND_LINE_SIZE	2048
+#ifndef __UAPI_IA64_SETUP_H
+#define __UAPI_IA64_SETUP_H
 
 extern struct ia64_boot_param {
 	__u64 command_line;		/* physical address of command line arguments */
-- 
2.37.2

