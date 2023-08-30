Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7A3C83F31
	for <linux-sh@archiver.kernel.org>; Wed, 30 Aug 2023 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbjH3SqF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbjH3I6g (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 04:58:36 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AFACDC
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 01:58:27 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id a7c9e80e-d437-4be9-a03d-24f3b9c4bab6;
        Wed, 30 Aug 2023 17:42:23 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 742991C0372;
        Wed, 30 Aug 2023 17:42:22 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH 09/12] of: FDT vaddr support for SH.
Date:   Wed, 30 Aug 2023 17:42:10 +0900
Message-Id: <fb76aed2eb920d4f6accb67774103eb478fe25fe.1693384846.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693384846.git.ysato@users.sourceforge.jp>
References: <cover.1693384846.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

sh using virt address in FDT.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/of/fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..846df856f258 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -643,6 +643,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
 		if (!size)
 			break;
+#ifdef CONFIG_SUPERH
+		base = virt_to_phys(base);
+#endif
 		memblock_reserve(base, size);
 	}
 
-- 
2.39.2

