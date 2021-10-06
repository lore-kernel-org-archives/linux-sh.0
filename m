Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88BEC4321E
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A070E61131
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbhJFQpk (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:40 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44582 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhJFQpg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:36 -0400
Received: by mail-ot1-f45.google.com with SMTP id o27-20020a9d411b000000b005453f95356cso2937157ote.11;
        Wed, 06 Oct 2021 09:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nz2VNzL+ydy4chpa3d7bE/r1R6JeAbCb1Q1l6nn9BO4=;
        b=7kHkpTbRlj/Vf9sv2yc65QC96Q/cOPyHMyMqdZYVbDm8TEbOGv9xCeOHVn7lN3Mats
         c0Nhc2itkn347UWtG/javVV71VKm952HnqtqGJP/UWf/80S1PXjt4WjzuLocBOOdIBcZ
         ps0hLIgpdUFnlS3mjoqIqsNBdkmDbPCiFkoShj3Nl+PvLPdgxoVlpF1ORuC1YCgL4yMZ
         xmf8tQBvE1V/kRpZXfwVkxpteS82JavSyk1xbFtEtJT9CTg5uSmaR0uTuZOosUHBeZh+
         EXT08CyO+1rI3MIxdiU7ehv/12XZ3LvvyNeE3qTAo0RtgupENtKIZ8GMTGAzFw3m2e3N
         v8AQ==
X-Gm-Message-State: AOAM5311zfuKi/5NPBPaRcOr6hfjH2CYQGPOl7etXyrUndiao78Hp92e
        TsuJHchT/2IwHRYlN/MzCw==
X-Google-Smtp-Source: ABdhPJzkVUe2NQ95hrntc6XfGtsZUf11mFfAeFqW0+ilFUDkOjdRegXB0ef4DYKZYBjYmsjM+kfXAg==
X-Received: by 2002:a9d:6ac7:: with SMTP id m7mr20566678otq.49.1633538622946;
        Wed, 06 Oct 2021 09:43:42 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:42 -0700 (PDT)
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
Subject: [PATCH 04/12] arm64: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:24 -0500
Message-Id: <20211006164332.1981454-5-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Replace the open coded parsing of CPU nodes' 'reg' property with
of_get_cpu_hwid().

This change drops an error message for missing 'reg' property, but that
should not be necessary as the DT tools will ensure 'reg' is present.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/smp.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6f6ff072acbd..c5cebc406d24 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -466,33 +466,6 @@ void __init smp_prepare_boot_cpu(void)
 	kasan_init_hw_tags();
 }
 
-static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-{
-	const __be32 *cell;
-	u64 hwid;
-
-	/*
-	 * A cpu node with missing "reg" property is
-	 * considered invalid to build a cpu_logical_map
-	 * entry.
-	 */
-	cell = of_get_property(dn, "reg", NULL);
-	if (!cell) {
-		pr_err("%pOF: missing reg property\n", dn);
-		return INVALID_HWID;
-	}
-
-	hwid = of_read_number(cell, of_n_addr_cells(dn));
-	/*
-	 * Non affinity bits must be set to 0 in the DT
-	 */
-	if (hwid & ~MPIDR_HWID_BITMASK) {
-		pr_err("%pOF: invalid reg property\n", dn);
-		return INVALID_HWID;
-	}
-	return hwid;
-}
-
 /*
  * Duplicate MPIDRs are a recipe for disaster. Scan all initialized
  * entries and check for duplicates. If any is found just ignore the
@@ -656,9 +629,9 @@ static void __init of_parse_and_init_cpus(void)
 	struct device_node *dn;
 
 	for_each_of_cpu_node(dn) {
-		u64 hwid = of_get_cpu_mpidr(dn);
+		u64 hwid = of_get_cpu_hwid(dn, 0);
 
-		if (hwid == INVALID_HWID)
+		if (hwid & ~MPIDR_HWID_BITMASK)
 			goto next;
 
 		if (is_mpidr_duplicate(cpu_count, hwid)) {
-- 
2.30.2

