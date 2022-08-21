Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599ADC00140
	for <linux-sh@archiver.kernel.org>; Sun, 21 Aug 2022 11:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiHULgt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 21 Aug 2022 07:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiHULgZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 21 Aug 2022 07:36:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB1B2656C
        for <linux-sh@vger.kernel.org>; Sun, 21 Aug 2022 04:36:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u14so10053277wrq.9
        for <linux-sh@vger.kernel.org>; Sun, 21 Aug 2022 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ktqp5nP81udpM1MG+l3gnY1pzvY8/PrjfTARX1xGZ74=;
        b=AW0FWHnYgwNCmESZ2n9ygpoNMqROFdVrXmoyjs1i/V3e6l8BazQwWJHi9XMO+O637d
         Df4riE6PC/V/IgPUH8moc0EAfx7R5nCWwvG8iSYiE51RO1IzaDNMxbVkluZz63D/jFsp
         sQfEu3LXgHPhM16VTmczW97sJwY69CLLTXVNAY8pZeDKe4dB8m3oCjol2mhGPp1ahO2V
         ComPKJXyP3hAynPugfvZ3yXbmXZ7FkJXWMP8Y43x82GZahVFA7F1jqsxQLkrc9fWCoJf
         P8nByGfCjdrtXVcb5dZ+jg18p6ejOPnoJLMHJlkjhG/J8lyAObKocbWp1a2AGk+RECcD
         /M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ktqp5nP81udpM1MG+l3gnY1pzvY8/PrjfTARX1xGZ74=;
        b=meUaOhMh6WGOSXDdwtsQWVdbeywiDvNUKDQFhpm2CjOv1GGIwnpgT5DfcLNotemgUa
         6I6tzwjui2FFeFYxP3VjG4U5xpeX4sqMhSsx2isoxoLBHXbMfHXnD5pORl9WU+Di238f
         9GgdqxiNtLiSWdxDIzQh6gTFSViby3UjCdSLn7SK4vSSMyyv+o05vxqBSQ2awpHSqHyc
         uD+9jPW6y2nCCo1Ny0ruS8GKyR8REVY9YUVm/7qKsmdoIL+SNvu42f27ixAO0vxAZlCb
         y+y6Eo+NZyWFJx+fTS4cr/0zkoViCp9jdVecXk9TQPqtQPwYctQFFAe5kQJoPbz+G6HY
         TzaA==
X-Gm-Message-State: ACgBeo1cOYn5fKgKBREcMq8vi4PXWjv/7YQ5PYMS8AwPmc8UcE34UTEn
        xFGiz0tK+0s7qU7U/Cfa7IDVlg==
X-Google-Smtp-Source: AA6agR6iyTE2UwdrwXTf+0eiBHvZb7pU8qO0Gz7AlF1LBKoiF+3yUIHGhx0/IDeGH85WpPOkmWdetw==
X-Received: by 2002:a05:6000:184c:b0:223:2c8b:c43c with SMTP id c12-20020a056000184c00b002232c8bc43cmr8659598wri.16.1661081782206;
        Sun, 21 Aug 2022 04:36:22 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm14071361wmc.29.2022.08.21.04.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:36:21 -0700 (PDT)
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
Subject: [PATCH 3/6] s390: use the asm-generic version of cpuinfo_op
Date:   Sun, 21 Aug 2022 12:35:10 +0100
Message-Id: <20220821113512.2056409-4-mail@conchuod.ie>
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
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index bd66f8e34949..48d2332a5899 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -41,6 +41,7 @@
 #include <asm/fpu/types.h>
 #include <asm/fpu/internal.h>
 #include <asm/irqflags.h>
+#include <asm-generic/processor.h>
 
 typedef long (*sys_call_ptr_t)(struct pt_regs *regs);
 
@@ -80,7 +81,6 @@ void s390_adjust_jiffies(void);
 void s390_update_cpu_mhz(void);
 void cpu_detect_mhz_feature(void);
 
-extern const struct seq_operations cpuinfo_op;
 extern void execve_tail(void);
 extern void __bpon(void);
 unsigned long vdso_size(void);
-- 
2.37.1

