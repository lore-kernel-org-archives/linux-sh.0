Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A9CA551C
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjIMJYM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbjIMJYJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:09 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF751999
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:05 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 55942fa6-d31c-4566-a0a9-8e2f1bf2e354;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 0ED9B1C005D;
        Wed, 13 Sep 2023 18:24:02 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 01/30] arch/sh: head_32.S passing FDT address to initialize function.
Date:   Wed, 13 Sep 2023 18:23:26 +0900
Message-Id: <8004923e733fcc4adb930c7dfb6b0ca3fff42177.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

R4 is caller saved in SH ABI.
Save it so it doesn't get corrupted until it's needed for initialization.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/compressed/head_32.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
index 7bb168133dbb..c5227ef636c3 100644
--- a/arch/sh/boot/compressed/head_32.S
+++ b/arch/sh/boot/compressed/head_32.S
@@ -15,7 +15,8 @@ startup:
 	/* Load initial status register */
 	mov.l   init_sr, r1
 	ldc     r1, sr
-
+	/* Save FDT address */
+	mov	r4, r13
 	/* Move myself to proper location if necessary */
 	mova	1f, r0
 	mov.l	1f, r2
@@ -84,7 +85,7 @@ l1:
 	/* Jump to the start of the decompressed kernel */
 	mov.l	kernel_start_addr, r0
 	jmp	@r0
-	nop
+	  mov	r13,r4
 	
 	.align	2
 bss_start_addr:
-- 
2.39.2

