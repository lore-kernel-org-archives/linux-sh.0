Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27132C433EF
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BF561154
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhJFQpw (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:52 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34784 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbhJFQpo (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:44 -0400
Received: by mail-ot1-f48.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so3952950otb.1;
        Wed, 06 Oct 2021 09:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhacG1oflfweV+ZMxYJrdhD3dQtCOWEVKc3UA01qLrg=;
        b=kSh3oWroS+XO4aAllMH2APeg/Nwl+0EPsAkgwZhzHyw1FdEoYAzcJhtLit8Fypi9RB
         OYxIx34PzchUjqLWSQB93JDoA7xZqUwOXZ7iryr5cWs/8hdH+xYlvt+coPwV7ymRSiU7
         YvSEgEWvU5Cj0LTc75yrz/D9IP7yHa3ELgpYrhk5LhTci2GSuGjNdJUpGSmC8rz/FsR/
         5ppcpKCbHA4bdTnwKEBHrWWoCCXnwcMh9gz1jNxMqE1YPTvYLWmn5BCyUWmaZJEbGQQd
         SnZ7gawf70T7LHlUbqfrIOpqFvA+Ql+WlDi2RHFD4M7ki8VUU+bKlStmAs7TdhWI10yu
         xkVw==
X-Gm-Message-State: AOAM532nlfwwrfW5o/Ptp54MJsnVuKeBiN7JfF2zayimLfBCdTgh4UXy
        uvkUu14rM2+p5SHX+3RvRA==
X-Google-Smtp-Source: ABdhPJzJQ2R5CEfp/bAtXtoCRQDaDF5B6RqZA1flXSsxFu0kVfpgeNfjZq0OKrhuVdseg2/0PDqWlg==
X-Received: by 2002:a05:6830:455:: with SMTP id d21mr20503877otc.300.1633538631080;
        Wed, 06 Oct 2021 09:43:51 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:49 -0700 (PDT)
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
Subject: [PATCH 08/12] riscv: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:28 -0500
Message-Id: <20211006164332.1981454-9-robh@kernel.org>
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

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/riscv/kernel/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 6d59e6906fdd..f13b2c9ea912 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -22,7 +22,8 @@ int riscv_of_processor_hartid(struct device_node *node)
 		return -ENODEV;
 	}
 
-	if (of_property_read_u32(node, "reg", &hart)) {
+	hart = of_get_cpu_hwid(node, 0);
+	if (hart == ~0U) {
 		pr_warn("Found CPU without hart ID\n");
 		return -ENODEV;
 	}
-- 
2.30.2

