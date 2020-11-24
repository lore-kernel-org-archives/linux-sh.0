Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE7C2D0E4
	for <linux-sh@archiver.kernel.org>; Tue, 24 Nov 2020 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC49B2076E
	for <linux-sh@archiver.kernel.org>; Tue, 24 Nov 2020 13:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbgKXNHD (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387739AbgKXNHC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 24 Nov 2020 08:07:02 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EE6C0617A6
        for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2020 05:07:01 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id wD6y2300S4C55Sk06D6yDK; Tue, 24 Nov 2020 14:06:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1khY26-005R7c-7n; Tue, 24 Nov 2020 14:06:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1khY25-00BVGQ-Qd; Tue, 24 Nov 2020 14:06:57 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh/irq: Add missing closing parentheses in arch_show_interrupts()
Date:   Tue, 24 Nov 2020 14:06:56 +0100
Message-Id: <20201124130656.2741743-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

    arch/sh/kernel/irq.c: In function ‘arch_show_interrupts’:
    arch/sh/kernel/irq.c:47:58: error: expected ‘)’ before ‘;’ token
       47 |   seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
	  |                                                          ^

Fixes: fe3f1d5d7cd3062c ("sh: Get rid of nmi_count()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 5addcb2c2da0cc63..ab5f790b0cd27784 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
+		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j));
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
-- 
2.25.1

