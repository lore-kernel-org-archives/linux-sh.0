Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F7C433EF
	for <linux-sh@archiver.kernel.org>; Thu, 14 Apr 2022 08:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiDNIP0 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 14 Apr 2022 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbiDNIPZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 14 Apr 2022 04:15:25 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605C4DF62;
        Thu, 14 Apr 2022 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649923981;
  x=1681459981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CLq295oAsXnIsHw8UMvTWtIPmRb+uTeBAuAko4O5XGc=;
  b=KJDscdPurLYDSAY5NZhiahrrd4d7+lSYrMqmZ4yzIlT0TU1w9gCQz88S
   3gMfkD/deKwL/7Qj4TlfbU1jEv6XEuz6lyCtFKPovlX5Jxp+kiq27vleh
   0YQh7MsE7aYGFZn9LBvb1TrJY4P5Y17qb6CaLvbWmHgnjjX2ZB412+avP
   sx27xoVFGfeWt6d9NnDwM8BRSWrvmGl4XxKZtHb9+mLFJ66cmAaKEoVrX
   2t09rhMbjm9N7dTpi9J6BDa87Qm/qTmFz592gJUcov863FNKG+90Z8h5C
   +tmtvxMnHPScR+u8fQqGbBInHdr87xzNG0SRBzAkyaDazc3I0gysDovac
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
CC:     <kernel@axis.com>, <hch@lst.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel test robot <lkp@intel.com>,
        <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sh: make !MMU iounmap an inline function
Date:   Thu, 14 Apr 2022 10:12:57 +0200
Message-ID: <20220414081257.1487499-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The current definition of sh's !MMU iounmap makes it unusable in certain
kinds of code, such as this instance caught by 0day on a patch posted to
the mailing lists:

 In file included from include/linux/io.h:13,
                  from drivers/mtd/devices/phram.c:21:
 drivers/mtd/devices/phram.c: In function 'register_device':
 arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
   274 | #define iounmap(addr)           do { } while (0)
       |                                 ^~
 drivers/mtd/devices/phram.c:150:44: note: in expansion of macro 'iounmap'
   150 |         cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
       |                                            ^~~~~~~

Make it an inline function as it was earlier.

Link: https://lore.kernel.org/lkml/202204131446.omJ5mC54-lkp@intel.com/
Fixes: 13f1fc870dd747131 ("sh: move the ioremap implementation out of line")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/sh/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf9a3ec32406..6bb978cf2ece 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -271,7 +271,7 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 #endif /* CONFIG_HAVE_IOREMAP_PROT */
 
 #else /* CONFIG_MMU */
-#define iounmap(addr)		do { } while (0)
+static inline void iounmap(void __iomem *addr) {};
 #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
 #endif /* CONFIG_MMU */
 
-- 
2.34.1

