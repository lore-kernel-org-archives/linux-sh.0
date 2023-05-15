Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C19C7EE2E
	for <linux-sh@archiver.kernel.org>; Mon, 15 May 2023 18:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjEOSId (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 15 May 2023 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244967AbjEOSIE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 15 May 2023 14:08:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572F3189BA;
        Mon, 15 May 2023 11:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F73630B0;
        Mon, 15 May 2023 18:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CCFC4339C;
        Mon, 15 May 2023 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173906;
        bh=Nc25TSkVxVrXY64easAv0Dysj5N+r+hR4Ws0zUbzFD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRW6CInJgjG8+cmI0kd3CcKBng7hzDPiQvCBSuU00qVenRN/KsI79vh1n96c5+zXr
         gVt0FUs+349DdKPTpfWkIuWgBeKnnc2Vp3bsSeUv3SeBMgVNh1vHlq7AMM+e1RF5QZ
         2lIyqS83BQJIQTKxUV0JJMQ9NatEL7wZ7V6UJV44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5.4 245/282] sh: math-emu: fix macro redefined warning
Date:   Mon, 15 May 2023 18:30:23 +0200
Message-Id: <20230515161729.601904248@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

commit 58a49ad90939386a8682e842c474a0d2c00ec39c upstream.

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
Link: lore.kernel.org/r/202111121827.6v6SXtVv-lkp@intel.com
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20230306040037.20350-5-rdunlap@infradead.org
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/math-emu/sfp-util.h |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/sh/math-emu/sfp-util.h
+++ b/arch/sh/math-emu/sfp-util.h
@@ -67,7 +67,3 @@
   } while (0)
 
 #define abort()	return 0
-
-#define __BYTE_ORDER __LITTLE_ENDIAN
-
-


