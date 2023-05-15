Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6BFC77B75
	for <linux-sh@archiver.kernel.org>; Mon, 15 May 2023 16:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbjEOQ4b (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 15 May 2023 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbjEOQ43 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 15 May 2023 12:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D5B49D1;
        Mon, 15 May 2023 09:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A3F62A20;
        Mon, 15 May 2023 16:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28095C433A4;
        Mon, 15 May 2023 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169781;
        bh=Nc25TSkVxVrXY64easAv0Dysj5N+r+hR4Ws0zUbzFD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRSWXCh95R53OJM6SadulcdDc3Q6Bz3en5cdI6uFfqzKddWdiF9Z55vS+rggHvrQZ
         LqOHccjZP3nc/pGk1drKTqVyJFjJU+TM2EJ/yJ/WLQKl1jonyeCij5MCT08mv42UQi
         uJMBeQBGN4ytA/pvEY0shiq7kXK08gGocEXQUVqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6.3 151/246] sh: math-emu: fix macro redefined warning
Date:   Mon, 15 May 2023 18:26:03 +0200
Message-Id: <20230515161727.081528476@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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


