Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A57DC433EF
	for <linux-sh@archiver.kernel.org>; Wed,  5 Jan 2022 08:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiAEI7Z (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 5 Jan 2022 03:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiAEI7Z (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 5 Jan 2022 03:59:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455EC061761
        for <linux-sh@vger.kernel.org>; Wed,  5 Jan 2022 00:59:24 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n528h-0005wh-Bz
        for linux-sh@vger.kernel.org; Wed, 05 Jan 2022 09:59:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2620E6D17A6
        for <linux-sh@vger.kernel.org>; Wed,  5 Jan 2022 08:59:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 803EE6D179F;
        Wed,  5 Jan 2022 08:59:21 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b9cd842b;
        Wed, 5 Jan 2022 08:59:21 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-sh@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] sh: make iounmap() a static inline again
Date:   Wed,  5 Jan 2022 09:57:47 +0100
Message-Id: <20220105085746.1116726-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sh@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The patch

| 98c90e5ea34e sh: remove __iounmap

removed the __iounmap macro for the NOMMU case, but also converted the
static inline no-op iounmap() to a macro, resulting in lots of unused
variable warnings.

This patch coverts the macro into a static inline function, similar to
previous patches in the sh arch:

| 4580ba4ad2e6 sh: Convert iounmap() macros to inline functions
| 733f0025f0fb sh: prevent warnings when using iounmap

Fixes: 98c90e5ea34e ("sh: remove __iounmap")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/sh/include/asm/io.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf9a3ec32406..4960b8ff1ad4 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -271,7 +271,9 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 #endif /* CONFIG_HAVE_IOREMAP_PROT */
 
 #else /* CONFIG_MMU */
-#define iounmap(addr)		do { } while (0)
+static inline void iounmap(void __iomem *addr)
+{
+}
 #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
 #endif /* CONFIG_MMU */
 
-- 
2.34.1


