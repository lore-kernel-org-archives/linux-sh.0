Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB3AEB64D9
	for <linux-sh@archiver.kernel.org>; Tue, 13 Jun 2023 15:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbjFMPw6 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbjFMPw6 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 13 Jun 2023 11:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E21AC;
        Tue, 13 Jun 2023 08:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60D3761F1E;
        Tue, 13 Jun 2023 15:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C635C433D9;
        Tue, 13 Jun 2023 15:52:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] microblaze: Move the ARCH_{DMA,SLAB}_MINALIGN definitions to asm/cache.h
Date:   Tue, 13 Jun 2023 16:52:44 +0100
Message-Id: <20230613155245.1228274-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230613155245.1228274-1-catalin.marinas@arm.com>
References: <20230613155245.1228274-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The microblaze architecture defines ARCH_DMA_MINALIGN in asm/page.h.
Move it to asm/cache.h to allow a generic ARCH_DMA_MINALIGN definition
in linux/cache.h without redefine errors/warnings.

While at it, also move ARCH_SLAB_MINALIGN to asm/cache.h for
consistency.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/cache.h | 5 +++++
 arch/microblaze/include/asm/page.h  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/include/asm/cache.h b/arch/microblaze/include/asm/cache.h
index a149b3e711ec..1903988b9e23 100644
--- a/arch/microblaze/include/asm/cache.h
+++ b/arch/microblaze/include/asm/cache.h
@@ -18,4 +18,9 @@
 
 #define SMP_CACHE_BYTES	L1_CACHE_BYTES
 
+/* MS be sure that SLAB allocates aligned objects */
+#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+
+#define ARCH_SLAB_MINALIGN	L1_CACHE_BYTES
+
 #endif /* _ASM_MICROBLAZE_CACHE_H */
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index 7b9861bcd458..337f23eabc71 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -30,11 +30,6 @@
 
 #ifndef __ASSEMBLY__
 
-/* MS be sure that SLAB allocates aligned objects */
-#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
-
-#define ARCH_SLAB_MINALIGN	L1_CACHE_BYTES
-
 /*
  * PAGE_OFFSET -- the first address of the first page of memory. With MMU
  * it is set to the kernel start address (aligned on a page boundary).
