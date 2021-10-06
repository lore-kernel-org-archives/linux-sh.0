Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A392DC433EF
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D01261130
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbhJFQpd (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:33 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:37661 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhJFQpb (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:31 -0400
Received: by mail-oo1-f51.google.com with SMTP id h11-20020a4aa74b000000b002a933d156cbso1032380oom.4;
        Wed, 06 Oct 2021 09:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lH5lm9ZJrN75WHjiktQyDKNUxUp68MdS3scEafa+VH8=;
        b=lH59hLRG3AlfJK9hDLWg+PQLN2leBjtou5Ky52t6amZl+zMcOnJS2FoXmutZnU4JZc
         S2lx4NPJmDORm6wUxYOwp9Id6HPO1OkkNIN5GPQCcMYjfnbwsVLEWL9MVTIcZA+V2HF+
         1LS8VBSdGyBtAlM1uLhopI3IbqZTVWKNnnSyijxd98yrb2MR76/lwIaxuDQjJzULPtTq
         N/NkRespD05daTz7OuFTXZ6MPPWUV7bdhBHvywcHuw06NB+QllcQdGwFe2cMA909t6eU
         41EO+G4+TQMBBG6sd9hd/p2BVVOvZ61s5OShB5GnKQf3n+O7LkNmUmO2S37pVeXEDKFL
         TsgQ==
X-Gm-Message-State: AOAM532omC/5eXyTGo/6Ew/pC5o2D/QK94I8TSEsuSDAWSpx6A9yGmFi
        9jxl+6+XzZDmIwMuTb0GEg==
X-Google-Smtp-Source: ABdhPJwDQxYuha7mztXncei2FBwje0uHQ2qAvAT0rAc8M1CEq47s46mQjlS2vX0JBLAJhljiutK9EA==
X-Received: by 2002:a4a:d108:: with SMTP id k8mr19009146oor.47.1633538619135;
        Wed, 06 Oct 2021 09:43:39 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:38 -0700 (PDT)
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
Subject: [PATCH 02/12] ARM: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:22 -0500
Message-Id: <20211006164332.1981454-3-robh@kernel.org>
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

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/kernel/devtree.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 28311dd0fee6..02839d8b6202 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -84,33 +84,15 @@ void __init arm_dt_init_cpu_maps(void)
 		return;
 
 	for_each_of_cpu_node(cpu) {
-		const __be32 *cell;
-		int prop_bytes;
-		u32 hwid;
+		u32 hwid = of_get_cpu_hwid(cpu, 0);
 
 		pr_debug(" * %pOF...\n", cpu);
-		/*
-		 * A device tree containing CPU nodes with missing "reg"
-		 * properties is considered invalid to build the
-		 * cpu_logical_map.
-		 */
-		cell = of_get_property(cpu, "reg", &prop_bytes);
-		if (!cell || prop_bytes < sizeof(*cell)) {
-			pr_debug(" * %pOF missing reg property\n", cpu);
-			of_node_put(cpu);
-			return;
-		}
 
 		/*
 		 * Bits n:24 must be set to 0 in the DT since the reg property
 		 * defines the MPIDR[23:0].
 		 */
-		do {
-			hwid = be32_to_cpu(*cell++);
-			prop_bytes -= sizeof(*cell);
-		} while (!hwid && prop_bytes > 0);
-
-		if (prop_bytes || (hwid & ~MPIDR_HWID_BITMASK)) {
+		if (hwid & ~MPIDR_HWID_BITMASK) {
 			of_node_put(cpu);
 			return;
 		}
-- 
2.30.2

