Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D403CA0EC7
	for <linux-sh@archiver.kernel.org>; Mon, 11 Sep 2023 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353334AbjIKVtm (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjIKJjJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 11 Sep 2023 05:39:09 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E2102
        for <linux-sh@vger.kernel.org>; Mon, 11 Sep 2023 02:39:03 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a989:d413:f41f:af52])
        by xavier.telenet-ops.be with bizsmtp
        id kZez2A00b43UkUk01Zez9u; Mon, 11 Sep 2023 11:39:01 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qfdNT-002zNf-F0;
        Mon, 11 Sep 2023 11:38:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qfdNj-006NE7-O5;
        Mon, 11 Sep 2023 11:38:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: mm: Re-add lost __ref to ioremap_prot() to fix modpost warning
Date:   Mon, 11 Sep 2023 11:38:50 +0200
Message-Id: <20230911093850.1517389-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

When __ioremap_caller() was replaced by ioremap_prot(), the __ref
annotation added in commit af1415314a4190b8 ("sh: Flag
__ioremap_caller() __init_refok.") was removed, causing a modpost
warning:

    WARNING: modpost: vmlinux: section mismatch in reference: ioremap_prot+0x88 (section: .text) -> ioremap_fixed (section: .init.text)

ioremap_prot() calls ioremap_fixed() (which is marked __init), but only
before mem_init_done becomes true, so this is safe.  Hence fix this by
re-adding the lost __ref.

Fixes: 0453c9a78015cb22 ("sh: mm: convert to GENERIC_IOREMAP")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/mm/ioremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index c33b3daa4ad1a3e6..33d20f34560fd5cb 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -72,8 +72,8 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
 #define __ioremap_29bit(offset, size, prot)		NULL
 #endif /* CONFIG_29BIT */
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+void __iomem __ref *ioremap_prot(phys_addr_t phys_addr, size_t size,
+				 unsigned long prot)
 {
 	void __iomem *mapped;
 	pgprot_t pgprot = __pgprot(prot);
-- 
2.34.1

