Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB9C77B78
	for <linux-sh@archiver.kernel.org>; Wed,  3 May 2023 12:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjECM62 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 May 2023 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjECM6T (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 May 2023 08:58:19 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A44365B6;
        Wed,  3 May 2023 05:57:55 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1puC3I-003aQd-LX; Wed, 03 May 2023 14:57:48 +0200
Received: from p5b13ada3.dip0.t-ipconnect.de ([91.19.173.163] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1puC3I-000HhE-Gm; Wed, 03 May 2023 14:57:48 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
        (envelope-from <glaubitz@physik.fu-berlin.de>)
        id 1puC3I-001OKV-0S;
        Wed, 03 May 2023 14:57:48 +0200
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: j2: Use ioremap() to translate device tree address into kernel memory
Date:   Wed,  3 May 2023 14:57:41 +0200
Message-Id: <20230503125746.331835-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.163
X-ZEDAT-Hint: PO
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Addresses the following warning when building j2_defconfig:

arch/sh/kernel/cpu/sh2/probe.c: In function 'scan_cache':
arch/sh/kernel/cpu/sh2/probe.c:24:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   24 |  j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
      |

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/kernel/cpu/sh2/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index d342ea08843f..70a07f4f2142 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -21,7 +21,7 @@ static int __init scan_cache(unsigned long node, const char *uname,
 	if (!of_flat_dt_is_compatible(node, "jcore,cache"))
 		return 0;
 
-	j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
+	j2_ccr_base = ioremap(of_flat_dt_translate_address(node), 4);
 
 	return 1;
 }
-- 
2.39.2

