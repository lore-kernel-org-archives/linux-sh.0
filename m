Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F3C3A59D
	for <linux-sh@archiver.kernel.org>; Fri, 21 Oct 2022 20:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJUUYo (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 21 Oct 2022 16:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJUUYm (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 21 Oct 2022 16:24:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0115D356D8;
        Fri, 21 Oct 2022 13:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19F7AB82CC6;
        Fri, 21 Oct 2022 20:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACDFC433D6;
        Fri, 21 Oct 2022 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666383876;
        bh=3P4X0zHHjLwNMrwF5wgbohXwTM8qZDpJ2Rla4uQRiBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtzF+mZeViSh19PnMi5v3vWASdHGMikvQMNj+uiMoDwu1BUJgSiq6aRFvOSlKN8d4
         rSZXCfwd97FNflLXEfPlArIwmyj12XSUCrMVAq9hDtW8yoG5avxJH+/i96IWGwYvCD
         oyzIMV8pojfCcKCJzOG6vvNsiXCy4ft9gxLpKH6ByQ5GvjojjENJ8rGBH0SssSIi4p
         45uPJKPa7b5h+XTVh8fpPn0ALxjRyuKv5wrs6i6wv6hyfk5gxWI/ItNB2WbwcOUePL
         uxbPRHMF4jgJ/A/Nv7BRNq5s0NszINzGJaaKSTgE7lIOROgkhynpi70lbHNZ/Hd9g1
         aHxaMRaztMf7A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/4] sh: remove unused SLOW_DOWN_IO
Date:   Fri, 21 Oct 2022 15:24:21 -0500
Message-Id: <20221021202424.307531-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021202424.307531-1-helgaas@kernel.org>
References: <20221021202424.307531-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

io.h defines SLOW_DOWN_IO only when CONF_SLOWDOWN_IO is defined, but
CONF_SLOWDOWN_IO is never defined and is in fact explicitly undefined.
Remove SLOW_DOWN_IO and related code.

N.B. 37b7a97884ba ("sh: machvec IO death.") went to some trouble to add
CONF_SLOWDOWN_IO and SLOW_DOWN_IO, for no obvious reason.  Maybe there was
some out-of-tree case that used this.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/io.h | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index fba90e670ed4..8043b7c235ca 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -121,11 +121,6 @@ __BUILD_MEMORY_STRING(__raw_, q, u64)
 
 #ifdef CONFIG_HAS_IOPORT_MAP
 
-/*
- * Slowdown I/O port space accesses for antique hardware.
- */
-#undef CONF_SLOWDOWN_IO
-
 /*
  * On SuperH I/O ports are memory mapped, so we access them using normal
  * load/store instructions. sh_io_port_base is the virtual address to
@@ -145,13 +140,7 @@ static inline void __set_io_port_base(unsigned long pbase)
 extern void __iomem *__ioport_map(unsigned long addr, unsigned int size);
 #endif
 
-#ifdef CONF_SLOWDOWN_IO
-#define SLOW_DOWN_IO __raw_readw(sh_io_port_base)
-#else
-#define SLOW_DOWN_IO
-#endif
-
-#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p, slow)			\
+#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p)			\
 									\
 static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 {									\
@@ -159,7 +148,6 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 									\
 	__addr = __ioport_map(port, sizeof(type));			\
 	*__addr = val;							\
-	slow;								\
 }									\
 									\
 static inline type pfx##in##bwlq##p(unsigned long port)			\
@@ -169,14 +157,13 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
 									\
 	__addr = __ioport_map(port, sizeof(type));			\
 	__val = *__addr;						\
-	slow;								\
 									\
 	return __val;							\
 }
 
 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)			\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type,)				\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
 	__BUILD_IOPORT_PFX(, bwlq, type)
-- 
2.25.1

