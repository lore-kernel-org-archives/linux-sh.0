Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FDE47DD43;
	Thu,  2 Jul 2026 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985085; cv=none; b=EQqK+rgDBhMl+K3czrvMbFEYh3qv9pq3u80uzxlXMpLtZ0F0nBizHFwADb2OgY80aAuS66sIZVcoNShoZv78iC6k8N9E6g3j23w5GwCXjmBk4T5aSO2Uj2DkwTLTlzWxg0jY6ZaLVVyUqFGaYHsNfLmYwBnJAGQT76BUMYhNvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985085; c=relaxed/simple;
	bh=/MhZhrCKOpiCaDzjf5dHkcSJpuDahoaX1MKdCGFEs+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIre41JTmuhbUlPU84+CgLfbhsvDoh68frQs0ign7pfDcxgHQ9ox7586RjDloIMJ/4OhFddzMe1URioplvXjbxnnLXd7wn3x6XbYz5CP0T+PNOrH+iJXZ+GZN342Xuv9rLdGGPIyd5FEPlix8za75qZm17chlpXzDEckwy2MDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGtHZost; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGtHZost"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1E81F000E9;
	Thu,  2 Jul 2026 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985084;
	bh=LrpGSzkebyRoftqxwiVWzBaNDevQuXrPGCTzKZQff20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lGtHZostTemB6LvowT+RGCSgQRIV/vqHHKY2+GvfUKpBJ2m8ICjNfKPziI4XrGkBG
	 2AITdlwdrgyOpRGngMne8FGcFtWOqtkl1cZv2XMFqFTmGVYp7SvIaTRp71cnZJCrqj
	 DiKSibd0vinNTIE+m5ewbbAmsMydZ+5tAYET8Q4eh+0WJCKyh9UaaokOKK1tDsIyz5
	 x8vaZq6oT3QNGOTGjDuNtfD542NsN/xTVo6+0RZKPEvXczMNo+x4xoGphBZKO5x7dv
	 hUzGsYKBqBE2jyTieFRdqkrvZ9/0iqSYc8nR675njYFtKg2Xa5pGXNnoAW3+8KZJuo
	 Crbz8MoiIuHkA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:51 +0300
Subject: [PATCH v3 02/10] sh: mm: remove numa.c
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-2-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

Since CONFIG_NUMA is removed, numa.c won't be ever compiled.

Remove it.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/mm/Makefile |  1 -
 arch/sh/mm/numa.c   | 53 -----------------------------------------------------
 2 files changed, 54 deletions(-)

diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index f69ddc70b146..7033947955d6 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -37,7 +37,6 @@ endif
 obj-$(CONFIG_DEBUG_FS)		+= $(debugfs-y)
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PMB)		+= pmb.o
-obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_IOREMAP_FIXED)	+= ioremap_fixed.o
 obj-$(CONFIG_UNCACHED_MAPPING)	+= uncached.o
 obj-$(CONFIG_HAVE_SRAM_POOL)	+= sram.o
diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
deleted file mode 100644
index 9bc212b5e762..000000000000
--- a/arch/sh/mm/numa.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * arch/sh/mm/numa.c - Multiple node support for SH machines
- *
- *  Copyright (C) 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/module.h>
-#include <linux/memblock.h>
-#include <linux/mm.h>
-#include <linux/numa.h>
-#include <linux/pfn.h>
-#include <asm/sections.h>
-
-/*
- * On SH machines the conventional approach is to stash system RAM
- * in node 0, and other memory blocks in to node 1 and up, ordered by
- * latency. Each node's pgdat is node-local at the beginning of the node,
- * immediately followed by the node mem map.
- */
-void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
-{
-	unsigned long start_pfn, end_pfn;
-
-	/* Don't allow bogus node assignment */
-	BUG_ON(nid >= MAX_NUMNODES || nid <= 0);
-
-	start_pfn = PFN_DOWN(start);
-	end_pfn = PFN_DOWN(end);
-
-	pmb_bolt_mapping((unsigned long)__va(start), start, end - start,
-			 PAGE_KERNEL);
-
-	memblock_add(start, end - start);
-
-	__add_active_range(nid, start_pfn, end_pfn);
-
-	/* Node-local pgdat */
-	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
-					     SMP_CACHE_BYTES, nid);
-	if (!NODE_DATA(nid))
-		panic("%s: Failed to allocate %zu bytes align=0x%x nid=%d\n",
-		      __func__, sizeof(struct pglist_data), SMP_CACHE_BYTES,
-		      nid);
-
-	NODE_DATA(nid)->node_start_pfn = start_pfn;
-	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
-
-	/* It's up */
-	node_set_online(nid);
-}

-- 
2.53.0

