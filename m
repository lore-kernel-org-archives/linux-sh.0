Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C7C433FE
	for <linux-sh@archiver.kernel.org>; Fri, 21 Oct 2022 19:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJUThX (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 21 Oct 2022 15:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJUThU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 21 Oct 2022 15:37:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371727CFDE;
        Fri, 21 Oct 2022 12:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86745B80CC1;
        Fri, 21 Oct 2022 19:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259A9C433B5;
        Fri, 21 Oct 2022 19:37:16 +0000 (UTC)
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 21 Oct 2022 14:36:57 -0500
Subject: [PATCH v2 3/4] sh: remove unnecessary __BUILD_IOPORT_PFX()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221021-wip-bjorn-22-10-slow-down-io-v2-3-8b3692d12ea7@google.com>
References: <20221021-wip-bjorn-22-10-slow-down-io-v2-0-8b3692d12ea7@google.com>
In-Reply-To: <20221021-wip-bjorn-22-10-slow-down-io-v2-0-8b3692d12ea7@google.com>
To:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666381029; l=954;
 i=bhelgaas@google.com; s=20221014; h=from:subject:message-id;
 bh=g8yI3K1tEQUHXIZtqfYnrjQ/LhOpw33jP8MlI8rMc5Q=;
 b=xiCc/DhxkT2exYJzheQj814cfjt+cNbZWf+N85s0rV8FZq+oATOfUE4t7nB6vfZQNwsmv60HgBZh
 n/6TWEFwC9Jc3eXOPnlGpVEkLT01AouqYzntBYKrqfSgotRfawXw
X-Developer-Key: i=bhelgaas@google.com; a=ed25519;
 pk=bFjaHnNobtkUv3f7ErkQcm+PpbyCUUBlIfqMtNRJwQs=
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The only reason __BUILD_IOPORT_PFX() existed was to accept a "bus"
parameter, but nothing ever used that.  Remove __BUILD_IOPORT_PFX() and
collapse it into BUILDIO_IOPORT().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/include/asm/io.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 193640bd9563..e29e8870dc3b 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -161,13 +161,10 @@ static inline type in##bwlq##p(unsigned long port)			\
 	return __val;							\
 }
 
-#define __BUILD_IOPORT_PFX(bwlq, type)					\
+#define BUILDIO_IOPORT(bwlq, type)					\
 	__BUILD_IOPORT_SINGLE(bwlq, type,)				\
 	__BUILD_IOPORT_SINGLE(bwlq, type, _p)
 
-#define BUILDIO_IOPORT(bwlq, type)					\
-	__BUILD_IOPORT_PFX(bwlq, type)
-
 BUILDIO_IOPORT(b, u8)
 BUILDIO_IOPORT(w, u16)
 BUILDIO_IOPORT(l, u32)

-- 
b4 0.10.1
