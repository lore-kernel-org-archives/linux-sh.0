Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC137C636CC
	for <linux-sh@archiver.kernel.org>; Tue,  7 Feb 2023 16:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBGQ5o (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjBGQ5n (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 7 Feb 2023 11:57:43 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F5D3A594;
        Tue,  7 Feb 2023 08:57:41 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pPRHb-000vbW-9T; Tue, 07 Feb 2023 17:57:27 +0100
Received: from p57bd9464.dip0.t-ipconnect.de ([87.189.148.100] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pPRHb-001vtW-2f; Tue, 07 Feb 2023 17:57:27 +0100
Received: from glaubitz by z6.fritz.box with local (Exim 4.94.2)
        (envelope-from <glaubitz@physik.fu-berlin.de>)
        id 1pPRHa-0003od-Hj; Tue, 07 Feb 2023 17:57:26 +0100
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     linux-sh@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself as maintainer for arch/sh (SUPERH)
Date:   Tue,  7 Feb 2023 17:57:15 +0100
Message-Id: <20230207165715.14617-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.100
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Both Rich Felker and Yoshinori Sato haven't done any work on arch/sh
for a while. As I have been maintaining Debian's sh4 port since 2014,
I am interested to keep the architecture alive.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb1471cb5ed3..3c3696b68e93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20090,6 +20090,7 @@ F:	drivers/watchdog/sunplus_wdt.c
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
+M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 L:	linux-sh@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-sh/list/
-- 
2.30.2

