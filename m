Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD194C433EF
	for <linux-sh@archiver.kernel.org>; Mon, 15 Nov 2021 06:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAAA63217
	for <linux-sh@archiver.kernel.org>; Mon, 15 Nov 2021 06:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhKOGon (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhKOGoj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 15 Nov 2021 01:44:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C85C061766;
        Sun, 14 Nov 2021 22:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WnNwbWCzZw865ncltCWjPhJbVHCNSq+NmZj4Dv1J8GE=; b=r53xg180zWKwrturm3Gbgesizk
        Ck5yFlN7HY1POLabOGkau/Z6Ze11MESRXjJyYLe5CtUH1c1hLaEIpOMtIir8FEfuyLAikxXZax/8r
        YloT5Q55rFABlTSo4ObmuoCzQm19rG/XRttSvpNa1/6/1OkbIStjW/bFtag6TzbPAs4iDgKdcJPXs
        MKY4+hf2+KMIU8tiA5vbHoLowgywuLO36/Ej3kJPQrPepXnWrFoAmeT1WPhPCZCuaD+gb/Uv2DS5b
        9YtdWe90oHq+vDVNCpbS9ChlizogOSiUmRnvS2dF/LOX0Axpm47zPOAAVUqQ2GuUxuuFJurYhQt9a
        wbhFdeRw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmVgT-00ESkH-C9; Mon, 15 Nov 2021 06:41:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 2/2] sh: math-emu: fix macro redefined warning
Date:   Sun, 14 Nov 2021 22:41:39 -0800
Message-Id: <20211115064139.10338-1-rdunlap@infradead.org>
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
---
 arch/sh/math-emu/sfp-util.h |    4 ----
 1 file changed, 4 deletions(-)

--- linux-next-20211112.orig/arch/sh/math-emu/sfp-util.h
+++ linux-next-20211112/arch/sh/math-emu/sfp-util.h
@@ -67,7 +67,3 @@
   } while (0)
 
 #define abort()	return 0
-
-#define __BYTE_ORDER __LITTLE_ENDIAN
-
-
