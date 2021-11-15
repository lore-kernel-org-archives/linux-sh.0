Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21D5C433F5
	for <linux-sh@archiver.kernel.org>; Mon, 15 Nov 2021 06:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1B861B3D
	for <linux-sh@archiver.kernel.org>; Mon, 15 Nov 2021 06:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhKOGoe (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhKOGo0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 15 Nov 2021 01:44:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFF2C061767;
        Sun, 14 Nov 2021 22:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dx/aD0RJ/nZ9g1JyChfFLuSF/mYtrdzE88kPrzmYV2Y=; b=i4dwlYHBEVNclVFNpAoQdYe9Vy
        v3u7zQhydJY8gan1yp1oB16LSePR69wYQR6r/C7fqxRhhrm14RBXuQm3LtH4WzM9znC2NlhmlF2Yu
        uG/Sicb+in0ntO0bYQx5dEZvdlaT3PmEBF/lPdX87iijdx6Atz/r4+5U5OFnW5cVX1vYdY6RuWHXV
        oePKq+4tEeSNATyRQKG7E5IN89I4JhTUP0ZpIZOLGsNZghN2EajKro8W92Ipyvvxhy0U1lq7qAcis
        NAWpj93VyRM+WCgDHrRANBQ8wo9ukkCxMohrAzaeeW2ee60cE578neB+TjLv26OwWlvluhtuRtKHJ
        43RX5tKg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmVgH-00ESk3-8q; Mon, 15 Nov 2021 06:41:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 1/2] sh: mcount.S: fix build error when PRINTK is not enabled
Date:   Sun, 14 Nov 2021 22:41:28 -0800
Message-Id: <20211115064128.9896-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Fix a build error in mcount.S when CONFIG_PRINTK is not enabled.
Fixes this build error:

sh2-linux-ld: arch/sh/lib/mcount.o: in function `stack_panic':
(.text+0xec): undefined reference to `dump_stack'

Fixes: e460ab27b6c3e ("sh: Fix up stack overflow check with ftrace disabled.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>
---
Possibly even more of this function should conditionally not be built...

 arch/sh/lib/mcount.S |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20211112.orig/arch/sh/lib/mcount.S
+++ linux-next-20211112/arch/sh/lib/mcount.S
@@ -257,9 +257,11 @@ return_to_handler:
 #ifdef CONFIG_STACK_DEBUG
 	.globl	stack_panic
 stack_panic:
+#ifdef CONFIG_PRINTK
 	mov.l	.Ldump_stack, r0
 	jsr	@r0
 	 nop
+#endif
 
 	mov.l	.Lpanic, r0
 	jsr	@r0
@@ -277,8 +279,10 @@ stack_panic:
 	.long	panic
 .Lpanic_s:
 	.long	.Lpanic_str
+#ifdef CONFIG_PRINTK
 .Ldump_stack:
 	.long	dump_stack
+#endif
 
 	.section	.rodata
 	.align 2
