Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96125C83F15
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbjHaBMN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbjHaBMM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 21:12:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C88ECDD
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 18:12:08 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 2eb0135f-c3ca-4e19-aa96-48f2f86ce4f7;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
Received: from SIOS1075.flets-east.jp (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 93ECF1C0015;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RESEND RFC PATCH 09/12] of: FDT vaddr support for SH.
Date:   Thu, 31 Aug 2023 10:11:56 +0900
Message-Id: <fb76aed2eb920d4f6accb67774103eb478fe25fe.1693444193.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693444193.git.ysato@users.sourceforge.jp>
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
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

