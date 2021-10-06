Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05268C4332F
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E456117A
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhJFQpg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:36 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:41971 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbhJFQpd (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:33 -0400
Received: by mail-oo1-f50.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso1022241ooq.8;
        Wed, 06 Oct 2021 09:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdvZjQ/BWS45GZwLPJ4dVbNMr/Wj7uXKHO/Bl7X5Es4=;
        b=oU55qGR6BHceUgiewU1iBrshR/CxA3A9igLkdkXMmtO5+kFjEQcJVZoUvP9rFh7XHE
         /+U2bTaQDZevTs0Dh5mWc0IYfhGY0ke6qSdsr2ZsgLETkpwkow8jzBKKdkSTBJAZZfTA
         d3UG0CKOsVd/yAvkDvKpNK94QZbvaZsJL7Rhr3q4EKqFtIQIPS63sgvpoGL3k49zNMFG
         zFFuyK0CLOCzemTQ8rRxqBMKLNSqY0R2HBvXDe5lS9TUQeMRxdpE7GwaKzv/bqTCDGqc
         7wY7cWM66PXzWvG5jIORTVl+KkHUMo5DT0KaBtoRBd8z23GT2WQpWcxsuMWaXVLJUWR2
         ASJw==
X-Gm-Message-State: AOAM530SdEENQYPczjZ7XJWdg7qpyXpIizsimlPvs6KzIFbBOoR+Ddse
        3yjzuS6q5+N3HDPCtXxUhw==
X-Google-Smtp-Source: ABdhPJy1h3H+xIThEc/Bx5W+PW+QqHTa7nGnBvK2axsTz6MHYy0vHuhJmmz3xzrXGNxNysUcAEgxdA==
X-Received: by 2002:a4a:4c46:: with SMTP id a67mr18657206oob.72.1633538621020;
        Wed, 06 Oct 2021 09:43:41 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:40 -0700 (PDT)
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
Subject: [PATCH 03/12] ARM: broadcom: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:23 -0500
Message-Id: <20211006164332.1981454-4-robh@kernel.org>
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

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-bcm/bcm63xx_pmb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm63xx_pmb.c b/arch/arm/mach-bcm/bcm63xx_pmb.c
index 0e5a05bac3ea..003f1472ab45 100644
--- a/arch/arm/mach-bcm/bcm63xx_pmb.c
+++ b/arch/arm/mach-bcm/bcm63xx_pmb.c
@@ -91,10 +91,10 @@ static int bcm63xx_pmb_get_resources(struct device_node *dn,
 	struct of_phandle_args args;
 	int ret;
 
-	ret = of_property_read_u32(dn, "reg", cpu);
-	if (ret) {
+	*cpu = of_get_cpu_hwid(dn, 0);
+	if (*cpu == ~0U) {
 		pr_err("CPU is missing a reg node\n");
-		return ret;
+		return -ENODEV;
 	}
 
 	ret = of_parse_phandle_with_args(dn, "resets", "#reset-cells",
-- 
2.30.2

