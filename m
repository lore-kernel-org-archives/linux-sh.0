Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C17C77B73
	for <linux-sh@archiver.kernel.org>; Wed, 19 Apr 2023 11:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjDSLtS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Apr 2023 07:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDSLtR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Apr 2023 07:49:17 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BA6210B;
        Wed, 19 Apr 2023 04:49:15 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pp6J4-0046Nz-0z; Wed, 19 Apr 2023 13:49:02 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pp6J3-002VAU-Po; Wed, 19 Apr 2023 13:49:01 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
        (envelope-from <glaubitz@physik.fu-berlin.de>)
        id 1pp6J3-002DXP-1M;
        Wed, 19 Apr 2023 13:49:01 +0200
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: sq: Fix incorrect element size for allocating bitmap buffer
Date:   Wed, 19 Apr 2023 13:48:52 +0200
Message-Id: <20230419114854.528677-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.23
X-ZEDAT-Hint: PO
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The Store Queue code allocates a bitmap buffer with the size of
multiple of sizeof(long) in sq_api_init(). While the buffer size
is calculated correctly, the code uses the wrong element size to
allocate the buffer which results in the allocated bitmap buffer
being too small.

Fix this by allocating the buffer with kcalloc() with element size
sizeof(long) instead of kzalloc() whose elements size defaults to
sizeof(char).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/kernel/cpu/sh4/sq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 27f2e3da5aa2..6e0bb3f47fa5 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -382,7 +382,7 @@ static int __init sq_api_init(void)
 	if (unlikely(!sq_cache))
 		return ret;
 
-	sq_bitmap = kzalloc(size, GFP_KERNEL);
+	sq_bitmap = kcalloc(size, sizeof(long), GFP_KERNEL);
 	if (unlikely(!sq_bitmap))
 		goto out;
 
-- 
2.39.2

