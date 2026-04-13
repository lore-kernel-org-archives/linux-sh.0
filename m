Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF93BAD8F;
	Mon, 13 Apr 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077220; cv=none; b=JFNhWCL2hYVQeB1JF0RAfPUdBL/vYJbEJ5u/PFbdcWl8n8xn2eFF1cu3r9PKvgpqvzrHs+x3GNkkp1VneC3K+7NR3jeHdx/ZB7mm93uCXdsfzzQqqvQExhTUrU6Lft6/PKJ9oXurH2MQ6KC6/kuYkRe7J392okjLcJJC15InHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077220; c=relaxed/simple;
	bh=81EMB7S4o9tzdPXH5l/vEk9ZCs4EQ+KrdDzyhygI3S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtDFXMVPlD68wapfX92w47HIh9xAbBHEtPRjuVGTEnLOOVGHFSSgTvu/JG8w39YpQq1ypQ4dcQoqh4m+Zxm0gISAZyatHEAu25Nbg5J8YPQuaF01dnHV3JN00/XCqNcvVfCMUqJypF8XWmT9COd71uBDBUrt7odrfuIlEx9eY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8TniFZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8TniFZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDEDC116C6;
	Mon, 13 Apr 2026 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077220;
	bh=81EMB7S4o9tzdPXH5l/vEk9ZCs4EQ+KrdDzyhygI3S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8TniFZaI+x3/UeKRImAcLzg05X5Z/Niv8RknnIWDxRcj4apBbDyDrZqPHiLyC2hM
	 U5nRZpHixLzePeFPfOkZIFS9jqbM1ZGhwJsKfRvhHzXnduOofWD3AlNzC+DIefYJtr
	 DpCNBfeqasmeK/oZoxmqihOzmmqluyJvDXF2/f2nOYlBObqoYVDFpJG6EMjFIrkIYV
	 wWzTokZcPllpst35SXuHotxR2BD2ZVRc4H2XpF+8Cb4+tXKSeG+2qZOkyaitKPdBZU
	 B91GRHlveCunXlXYMFMdBhqUTArsa07KgyofEI0XZxk6WCLuCHF5PY4id6PsHSuMza
	 EbSKxzUI79cuA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/10] sh: mm: remove numa.c
Date: Mon, 13 Apr 2026 13:46:40 +0300
Message-ID: <20260413104649.852228-3-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104649.852228-1-rppt@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Since CONFIG_NUMA is removed, numa.c won't be ever compiled.

Remove it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/mm/Makefile |  1 -
 arch/sh/mm/numa.c   | 53 ---------------------------------------------
 2 files changed, 54 deletions(-)
 delete mode 100644 arch/sh/mm/numa.c

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

