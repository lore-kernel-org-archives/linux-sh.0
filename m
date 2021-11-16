Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB6C433EF
	for <linux-sh@archiver.kernel.org>; Tue, 16 Nov 2021 05:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A3C63218
	for <linux-sh@archiver.kernel.org>; Tue, 16 Nov 2021 05:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhKPFtK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhKPFsK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 16 Nov 2021 00:48:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A375BC0F26E6;
        Mon, 15 Nov 2021 19:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rGZoRjzS8OBQ0BoAwguUyjRpfqfXQyes581vJP1YZuE=; b=KPKPk5ddbXfl5cxeY7OUQV+o4G
        nnGfEOXBimJgjfIlhsiaVkTuQw61DM4PBxQZKDebVZVQlcgCbn5NfxD+7rQWSCUxLtxTk9LMmBMS+
        T6Ianpg4pk9O7WLPF6Im0/o4zPDpX4rh5O8bzgV7BAJDeAxHZjPnGIXknFiE4fcyNhnCDDfqrjf3d
        QEzrusefcHOwUx98k2WNgbqlQNZ7Tnhy6iMub1j2SrIsna0dAX8Lm1AekD0qL8GD8W1hMryCbv4IY
        boQ3EZA4fKSg38ukt2vgzy3FxmygXupD4d8q8g7jS0aRsIV3g1v6e/MQw/un+Vk1MCxFyu68slG8n
        QVhF5R7Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmpHO-000DhI-0K; Tue, 16 Nov 2021 03:37:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 2/2 v2] sh: math-emu: fix macro redefined warning
Date:   Mon, 15 Nov 2021 19:37:05 -0800
Message-Id: <20211116033705.10418-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Fix a warning that was reported by the kernel test robot:

In file included from ../include/math-emu/soft-fp.h:27,
                 from ../arch/sh/math-emu/math.c:22:
../arch/sh/include/asm/sfp-machine.h:17: warning: "__BYTE_ORDER" redefined
   17 | #define __BYTE_ORDER __BIG_ENDIAN
In file included from ../arch/sh/math-emu/math.c:21:
../arch/sh/math-emu/sfp-util.h:71: note: this is the location of the previous definition
   71 | #define __BYTE_ORDER __LITTLE_ENDIAN

Fixes: b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be
---
v2: add Reviewed-by Geert,
    rebase to linux-next-20211115

 arch/sh/math-emu/sfp-util.h |    4 ----
 1 file changed, 4 deletions(-)

--- linux-next-20211115.orig/arch/sh/math-emu/sfp-util.h
+++ linux-next-20211115/arch/sh/math-emu/sfp-util.h
@@ -67,7 +67,3 @@
   } while (0)
 
 #define abort()	return 0
-
-#define __BYTE_ORDER __LITTLE_ENDIAN
-
-
