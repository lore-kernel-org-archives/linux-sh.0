Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC00C433FE
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F6661131
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbhJFQps (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:48 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:37659 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbhJFQpl (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:41 -0400
Received: by mail-oo1-f42.google.com with SMTP id h11-20020a4aa74b000000b002a933d156cbso1032591oom.4;
        Wed, 06 Oct 2021 09:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lY59MK3rRpvbu1Z+VUSRhTP9oCogI9gtd3qobuL4xSE=;
        b=VrtFmor9aA0ypN/F0xXijVY6hfMS82MC7K1tVqot7IPidnHRp0iU6214DiS/mAQ3x9
         AQz30PPIlMfHHWesFBTh+9N5UHWm9EEWbMdrYAW2FgglvYd1f+WSr5rrbzrwu1VMhuuo
         ivIezeBHqRh0/nkYb5kONv+qJEZf8sb+nI4YyAkWRQuoMJRnakbKhiQyfOaXBXCYFW4m
         BIbqqiPSKCsHrcxt6dEazg6BVAeEpMNeLIS1T2VFuL/BN8waayiQ8tHX7vNK1Zp6r5rS
         uF7c3s7jV5bfVGd2X3ZCzx210kgQXzjtNqui4u5OFhfGER2wh3lPxjLs5QlMM0esU2Tk
         HpyQ==
X-Gm-Message-State: AOAM531Y5XbQJHgFYSYKnW2KDCRTyivpVj+D026havtY+t0Rjc7yXngr
        WGFKLTipU/adwfPk+mq0Cw==
X-Google-Smtp-Source: ABdhPJz0UBQruF1+4qwCrW51W9Ryn9cj8arPhEOykPX2X80Gkf6HFF4wZl1tVkLGt4TXGOWPUlKBPA==
X-Received: by 2002:a05:6820:1018:: with SMTP id v24mr19468852oor.27.1633538628646;
        Wed, 06 Oct 2021 09:43:48 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:47 -0700 (PDT)
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
Subject: [PATCH 07/12] powerpc: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:27 -0500
Message-Id: <20211006164332.1981454-8-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Replace open coded parsing of CPU nodes' 'reg' property with
of_get_cpu_hwid().

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/kernel/smp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9cc7d3dbf439..d96b0e361a73 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1313,18 +1313,13 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 int cpu_to_core_id(int cpu)
 {
 	struct device_node *np;
-	const __be32 *reg;
 	int id = -1;
 
 	np = of_get_cpu_node(cpu, NULL);
 	if (!np)
 		goto out;
 
-	reg = of_get_property(np, "reg", NULL);
-	if (!reg)
-		goto out;
-
-	id = be32_to_cpup(reg);
+	id = of_get_cpu_hwid(np, 0);
 out:
 	of_node_put(np);
 	return id;
-- 
2.30.2

