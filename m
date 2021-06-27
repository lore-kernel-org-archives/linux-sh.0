Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53930C49EA6
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B3A361A1D
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 22:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhF0WIS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 27 Jun 2021 18:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhF0WIN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 27 Jun 2021 18:08:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35BAC061574;
        Sun, 27 Jun 2021 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=j0XkrxRvHc/VaxdANbJaIjnwsytplhiS0+Rky+R+ERQ=; b=l14dJ5EHuxiAfvyZzrEwBoDudm
        S7PtgV9wFGDnIxNL2QBYZdLI2UO4FtsmVTmoTLQ5wZlMhsUqw/8in2A3hvvDqE8ML/ep+dGw2D7gD
        gVMiipuH49xBFK3b6IeFL9vKLa9Kb90ojCDRxhy0irjCGv0AFXRTpMzWaV2N0zhWhT3Me8FZf5mMS
        pjU3Q+ksR3qY3xpVYUAO56hOnAMvLcOAMOqK5no+hOtxUmdsieB8GHog5w5J6GGuJz2tb1V7TrKlX
        cUoyGAlP8UHuhVTeGhSNu6DbqhMOY7yNihP6WqdTJPHzGlj0phe/2BxfcCPvmc/sUe/Ns2Sw8cbWt
        H7BzZtgQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxcuP-006CHh-Uh; Sun, 27 Jun 2021 22:05:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matt Fleming <matt@console-pimps.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH 1/3 v2] sh: fix kconfig unmet dependency warning for FRAME_POINTER
Date:   Sun, 27 Jun 2021 15:05:42 -0700
Message-Id: <20210627220544.8757-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210627220544.8757-1-rdunlap@infradead.org>
References: <20210627220544.8757-1-rdunlap@infradead.org>
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2: drop Paul Mundt from Cc: list;
    add this previously sent patch to the series;
    add more Cc's;

 arch/sh/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210625.orig/arch/sh/Kconfig.debug
+++ linux-next-20210625/arch/sh/Kconfig.debug
@@ -57,6 +57,7 @@ config DUMP_CODE
 
 config DWARF_UNWINDER
 	bool "Enable the DWARF unwinder for stacktraces"
+	depends on DEBUG_KERNEL
 	select FRAME_POINTER
 	default n
 	help
