Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9DC433EF
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F86610E5
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbhJFQpl (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:41 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35658 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbhJFQph (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:37 -0400
Received: by mail-oi1-f182.google.com with SMTP id n64so4890194oih.2;
        Wed, 06 Oct 2021 09:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN2tRnfV0nmrSbuDbyHoypag3neEaofRCNv6xL7Eiog=;
        b=BEgHC543RKZC7CqBo05WKnJagmM8YIIneNefpzsqjJRmQ2hoFkKPOsiZl1OdmEZrPw
         OojVSelb1RkV2fMbsnvreceDSxtpWe1OSddW/4iCh2gLB91D81XPywbKwdn3+lIPCVmx
         02v5MOrmhN88a8pWVPUD4r3GUg0cIW5ejbUerPYZr+YaaQbPXjc9SaZTKd/HPYQNoM52
         q6D4Yfdkw4GytF2NUuuF3eB85RPmaD5wsZsVcU3vauW62THts/G+E0C7ak3GVxLGVxgU
         2KtwbD6TNsvFRQyDRAJka6f7Amyx9CwqxeDwqie7M1df+K5klplIQ1WWHNOKuyCu/6aY
         nlxA==
X-Gm-Message-State: AOAM532wgalESwiX1Xs/oJCu86OZmpkETuBdUToxMtj6bd156aV6YXkI
        M1sdYMZ1Yt4ahJHsAMoVXQ==
X-Google-Smtp-Source: ABdhPJz/z+8TSD/WdWHkwOUMUF3/lnf5Mt7uWOPSGKwTcm1xutcPl6qw5jPqaYPZiNT3CeLWfPqlWg==
X-Received: by 2002:aca:30c9:: with SMTP id w192mr7839682oiw.93.1633538624646;
        Wed, 06 Oct 2021 09:43:44 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 05/12] csky: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:25 -0500
Message-Id: <20211006164332.1981454-6-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Replace open coded parsing of CPU nodes 'reg' property with
of_get_cpu_hwid().

Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/csky/kernel/smp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index e2993539af8e..6bb38bc2f39b 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -180,15 +180,13 @@ void __init setup_smp_ipi(void)
 void __init setup_smp(void)
 {
 	struct device_node *node = NULL;
-	int cpu;
+	unsigned int cpu;
 
 	for_each_of_cpu_node(node) {
 		if (!of_device_is_available(node))
 			continue;
 
-		if (of_property_read_u32(node, "reg", &cpu))
-			continue;
-
+		cpu = of_get_cpu_hwid(node, 0);
 		if (cpu >= NR_CPUS)
 			continue;
 
-- 
2.30.2

