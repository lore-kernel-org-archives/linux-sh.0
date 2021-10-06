Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A09C433FE
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715D661131
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbhJFQpn (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:43 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37615 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbhJFQpj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:39 -0400
Received: by mail-ot1-f54.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so3859905otv.4;
        Wed, 06 Oct 2021 09:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E46c5KotLBJJxu4fxLSa91xNqDqPq5a/10Op+mtdz/c=;
        b=7a/a5xV9WpA2+5JPBQQwIp7Xji11STygmFR/tXP06Y+odK/1qCniygFlvhES6nMKQk
         942NVqTkBTaDyTKQzeAxKojmIGht6SHpSMDoqa+RJYD/kwwXfxZkJDpFFmpbZPhdPT4R
         K0Tg15tyLJX2yYPy5uZrls5qDd7y9gGDn8hl7CaUn/9AFbOOU7+izjS+JJe8e7A9gToE
         SUJk1WXqujCbfKUcZFjiauIJ2EKvKDUtfbaNBgbhLIvLP77OD9SblK/OPWwBkMnEVdOf
         TsSb5oS3nRNQvgZ0i1Dfsf9PbWWDQIa6aQN5W0FgUazCZYdTFroDp1/B2MNWpuyHiGIw
         MvwA==
X-Gm-Message-State: AOAM5309hVNSeMvfe3hpLw7Ciqn7C5cQJuoUYszRmKOsL45vLFY54ULt
        3aL+SMst8suuE54W4bwBTA==
X-Google-Smtp-Source: ABdhPJxehVSGYvZXtuNP7Z+wFAXu0A1JJQzA5MrGIRkKPVwBp+gSYiQNHX06q+RB97zQgpf/RwBd+A==
X-Received: by 2002:a05:6830:1d8b:: with SMTP id y11mr20406228oti.291.1633538626550;
        Wed, 06 Oct 2021 09:43:46 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:45 -0700 (PDT)
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
Subject: [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:26 -0500
Message-Id: <20211006164332.1981454-7-robh@kernel.org>
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

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/openrisc/kernel/smp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 415e209732a3..7d5a4f303a5a 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -65,11 +65,7 @@ void __init smp_init_cpus(void)
 	u32 cpu_id;
 
 	for_each_of_cpu_node(cpu) {
-		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
-			pr_warn("%s missing reg property", cpu->full_name);
-			continue;
-		}
-
+		cpu_id = of_get_cpu_hwid(cpu);
 		if (cpu_id < NR_CPUS)
 			set_cpu_possible(cpu_id, true);
 	}
-- 
2.30.2

