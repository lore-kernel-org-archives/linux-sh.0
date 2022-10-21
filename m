Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD6C433FE
	for <linux-sh@archiver.kernel.org>; Fri, 21 Oct 2022 19:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJUThe (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 21 Oct 2022 15:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJUThV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 21 Oct 2022 15:37:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA7A27CFEF;
        Fri, 21 Oct 2022 12:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56128B82D21;
        Fri, 21 Oct 2022 19:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7F2C433D7;
        Fri, 21 Oct 2022 19:37:17 +0000 (UTC)
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 21 Oct 2022 14:36:58 -0500
Subject: [PATCH v2 4/4] sh: remove unnecessary __BUILD_MEMORY_STRING() 'pfx'
 parameter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221021-wip-bjorn-22-10-slow-down-io-v2-4-8b3692d12ea7@google.com>
References: <20221021-wip-bjorn-22-10-slow-down-io-v2-0-8b3692d12ea7@google.com>
In-Reply-To: <20221021-wip-bjorn-22-10-slow-down-io-v2-0-8b3692d12ea7@google.com>
To:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666381029; l=2013;
 i=bhelgaas@google.com; s=20221014; h=from:subject:message-id;
 bh=Qvs4sw9QI5s7PTMZeS/IoQOgMgdD770AFoUMOnTvmTg=;
 b=OSW6VGjEHusyDpMk9rCWr6S87GCeNAW46TYFyKnDsUsxyJ2JCKKTPs1vHlxhU1q7y3vMe3L36Wm8
 vHhPHK/VCoebwAt94fs2PwMIhCSyXXn3bBo4piNqiURzj2NolKva
X-Developer-Key: i=bhelgaas@google.com; a=ed25519;
 pk=bFjaHnNobtkUv3f7ErkQcm+PpbyCUUBlIfqMtNRJwQs=
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Previously __BUILD_MEMORY_STRING() accepted a "pfx" parameter, to which all
users passed "__raw_".  Simplify this by dropping the parameter and
encoding "__raw_" in the function name explicitly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/include/asm/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index e29e8870dc3b..179420fc4053 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -86,11 +86,11 @@ __BUILD_UNCACHED_IO(w, u16)
 __BUILD_UNCACHED_IO(l, u32)
 __BUILD_UNCACHED_IO(q, u64)
 
-#define __BUILD_MEMORY_STRING(pfx, bwlq, type)				\
+#define __BUILD_MEMORY_STRING(bwlq, type)				\
 									\
 static inline void							\
-pfx##writes##bwlq(volatile void __iomem *mem, const void *addr,		\
-		  unsigned int count)					\
+__raw_writes##bwlq(volatile void __iomem *mem, const void *addr,	\
+		   unsigned int count)					\
 {									\
 	const volatile type *__addr = addr;				\
 									\
@@ -100,8 +100,8 @@ pfx##writes##bwlq(volatile void __iomem *mem, const void *addr,		\
 	}								\
 }									\
 									\
-static inline void pfx##reads##bwlq(volatile void __iomem *mem,		\
-				    void *addr, unsigned int count)	\
+static inline void __raw_reads##bwlq(volatile void __iomem *mem,	\
+				     void *addr, unsigned int count)	\
 {									\
 	volatile type *__addr = addr;					\
 									\
@@ -111,13 +111,13 @@ static inline void pfx##reads##bwlq(volatile void __iomem *mem,		\
 	}								\
 }
 
-__BUILD_MEMORY_STRING(__raw_, b, u8)
-__BUILD_MEMORY_STRING(__raw_, w, u16)
+__BUILD_MEMORY_STRING(b, u8)
+__BUILD_MEMORY_STRING(w, u16)
 
 void __raw_writesl(void __iomem *addr, const void *data, int longlen);
 void __raw_readsl(const void __iomem *addr, void *data, int longlen);
 
-__BUILD_MEMORY_STRING(__raw_, q, u64)
+__BUILD_MEMORY_STRING(q, u64)
 
 #ifdef CONFIG_HAS_IOPORT_MAP
 

-- 
b4 0.10.1
