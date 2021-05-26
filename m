Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67680C2B9F7
	for <linux-sh@archiver.kernel.org>; Wed, 26 May 2021 07:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F09613EC
	for <linux-sh@archiver.kernel.org>; Wed, 26 May 2021 07:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhEZHEo (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 26 May 2021 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhEZHEo (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 26 May 2021 03:04:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C206C061574;
        Wed, 26 May 2021 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3RoQLchR2cbyw0/2wuiE3Zffqq9JJ1dc6kMjvyC+jWI=; b=utxXLRzPUjwcw88emkZnDx4IM+
        Y0I+HB1FF/RK5RlVlU8IfoXKet/7H+dgymlIUX5RHnRbVhB7DNVIdB9PKqEMtNAqhHpNx7nGJDrX0
        i5w9EfG9wo6hnIVZSXKQFEXSiFowkHaHAQbf1vsL3DPtInXlX3+kMDVjX0SAD7ctqn8bdxJ1f4XKR
        rMLQ1qZB7K6Us3wTz+bKNKzEigZpnHnwMGtu2RoTO+O1phXsjUUszOh1a9non/Ft/Vdez1nlEbqzY
        Hov1FvfSL9k9iUISEJmf9S/0CIp8M0sSQf0utAo7RvJfFTiGq1HoDTM/otTEZmjsfOb2YTA9qdiK5
        N4M7jL3w==;
Received: from [2601:1c0:6280:3f0::1c1d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llnZN-00Breu-JA; Wed, 26 May 2021 07:03:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Matt Fleming <matt@console-pimps.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Paul Mundt <lethal@linux-sh.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH] SH: fix kconfig unmet dependency warning for FRAME_POINTER
Date:   Wed, 26 May 2021 00:03:05 -0700
Message-Id: <20210526070305.20502-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

FRAME_POINTER depends on DEBUG_KERNEL so DWARF_UNWINDER should
depend on DEBUG_KERNEL before selecting FRAME_POINTER.

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=n] && (M68K || UML || SUPERH [=y]) || ARCH_WANT_FRAME_POINTERS [=n]
  Selected by [y]:
  - DWARF_UNWINDER [=y]

Fixes: bd353861c735 ("sh: dwarf unwinder support.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210525.orig/arch/sh/Kconfig.debug
+++ linux-next-20210525/arch/sh/Kconfig.debug
@@ -57,6 +57,7 @@ config DUMP_CODE
 
 config DWARF_UNWINDER
 	bool "Enable the DWARF unwinder for stacktraces"
+	depends on DEBUG_KERNEL
 	select FRAME_POINTER
 	default n
 	help
