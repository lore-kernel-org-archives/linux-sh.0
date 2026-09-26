Received: from mail-wr2-f24.google.com (mail-wr2-f24.google.com [74.125.225.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C03939B0
	for <linux-sh@vger.kernel.org>; Sat, 26 Sep 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447984; cv=none; b=CVcIHP2Tu0QqHS1fPfADXTd/nnR827dIJyZxZ4yB6DTMFefHQfnobJDpE3tcQNqKWIYTGn+5eWATIdMNyS9+gAiC+ktxD+SoJB5/UcCgKS7cg8ZQ42vGHhIyVZ9Wp2mQrh0lBz1X16LAxvIbMKZnQYhLLzmDj/doH1M8lu+osvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447984; c=relaxed/simple;
	bh=LcwF7zVNiLm08Sb/WHKFhLpdvT9/kw7C54o+FBoO4v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6sxZMfHQUwjEBb6umyTwKRjHF5P/UpaiqdL0REZaUHBXW0HelNO2KEO9gbEI/BdPiwJ+c/VFtmMKEiOea+7LW1X2wtc5kNQC6s2GPBdkSMwbpbIx8c/uYBP2/lDK+pYltQTIhxq5t2jmtNXf2p6gXzrXrzVRWTPn2dgsCSTfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7anAAdo; arc=none smtp.client-ip=74.125.225.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7anAAdo"
Received: by mail-wr2-f24.google.com with SMTP id ffacd0b85a97d-482f63546c3so1481517f8f.1
        for <linux-sh@vger.kernel.org>; Sat, 26 Sep 2026 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790447978; x=1791052778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6Ei7iaMC8FezBDOc40UN+3dnzVcKepmpa+3tte5LhY=;
        b=C7anAAdomIEvauBcMjxaAm8afE31r68OW2InWTkjAoiSBvDDIeHJulWPS1Xyoi+NUH
         hKVD4CgDUYmtasmPm9jVzLYhnTGebmfSkv6L6CnYO+AtFyiTejnr/WzretdZU56SHMRE
         apeL0ZW9d77wvvvbk18rzM8kNwgXrY3srvcXQwwoxKIAjgk+CGBQVXhlYpHAyTKNOy86
         gD4g9EkOo3CppCTdouXpYFLNOTr1kyIXL9Bm5TJP7Pnk5yeQs2nNeV/+TUw4nifkaa95
         j39mWW1MJKmF3m9sx9ej/rGmHOxuSeMPxqLUv1hsP+PmprK0TN37biIqfDg/O01xIKBn
         guzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447978; x=1791052778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6Ei7iaMC8FezBDOc40UN+3dnzVcKepmpa+3tte5LhY=;
        b=jcl9d3hbfNFfb6/2YeCdROUdBiuqMteEHfRZHB6dl7ewVv6XNNBExH+2bdn1wdeuFL
         x8qgD0Vm+wXAco6+M3Xb4n4So63bDjo1d01lQ0UAtJNIbV3wbO1moF+gYSLLhyVk/veg
         Z7z2oKhyriwfPx6ghgqWOdEbmktiaOrONHykdvL65EcyntgI6O9ymNhq0hGgd6X0Vi7m
         VcsA1nHkTPUwC6JYS5xzHmm/gsdz0NoUkwJIaOc4yuLQoTtfrWiyxHXokFxAIw40lZ0r
         l1CulVOORBUAGaguHdJ6sKiwLTnAKJYtxXl/tC7OXrpl3Mhdkx6SPY9X9HSWYkuYFBEZ
         U11g==
X-Gm-Message-State: AFq9FYILRwnGnKUC7mpVXmQeLG4+cxGYEn2BfNtI9PPZl3D4MWQrxjGZ
	PVsFz3czYJ4meCfw6KAP6XXKDmwsgiy+Uu10PkFr6H4VSEIXx3zTYJIT
X-Gm-Gg: AYBFou0NF2K177kvlLWVLF5QL1D1Oe+q/zBQtJdYNy4nBxpuexBhOFnBJKEHS68CKYt
	4SrQ/SLgNRZZ4QbvKWaENQ+N8WaXq0TnazyMXuZIMMgt7VHxVGZN9iIfu5/qdTr83u0MVP70vEn
	fvDIT4fwT1A0G0A3cS4HtQmNV9ZSWiHxl3Yr4yeLov5faq8cJqv3zKjGB6cAdjGNKNJbQkOR4cR
	dEtnhamIhLUgnfNWK9qRi0KuNaWG40906snOEVkTCSdofXTSbvAw2/hsRRRXN8xokkVXKHP7N5P
	y+bBmEnpmnOWmFFNgNwltfBe8YY8W4hz4A80Rxv8UNAUi2Nq+hN1TinLGFfDwI94DQ2MsZI5dVB
	Dg3bDTNtPc0bDRS+bpnAU9TvKUQN+8KXSkt9hW6l4n5cuHS/hw0oOkfxXiez9G4PCRKukA2TvVo
	hmOWhzB5N+LRFA7RTz3ho5QwIr+tKL4NPsXMZyX/ctb+8M9t44kBidqMSEhJm3bM8SfJupZ00CS
	vf21sheMKPaNYcnsRBDdjtdYrLavpb5pM9702FjohIHx5Tw4zvGulHRVGYG95w3joJRhJhjK+fP
	QLcZ7TU67J5/Sp0Ny/kUNHuqD/6lMfWIyiLrof70wKqbJ7kb7g/fV+4VaC+XXOA/MELCJLr9lXS
	6SVo=
X-Received: by 2002:a05:6000:420d:b0:487:14b6:b1be with SMTP id ffacd0b85a97d-4887172e3ffmr17724486f8f.25.1790447977972;
        Sat, 26 Sep 2026 11:39:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a648895sm15430376f8f.28.2026.09.26.11.39.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 11:39:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 2/2] sh: mm: align hugetlb mappings to the huge page size
Date: Sat, 26 Sep 2026 20:39:04 +0200
Message-Id: <20260926183904.76186-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260926183904.76186-1-kmehltretter@gmail.com>
References: <20260926183904.76186-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmap(MAP_HUGETLB) on SH4 can return an address which is not aligned to
the huge page size. In a QEMU r2d guest with 64 KiB huge pages, a
two-page mapping placed after a single 4 KiB mapping lands at
0x29558000, and process exit then hits the alignment check in
__unmap_hugepage_range():

  kernel BUG at mm/hugetlb.c:5215!
  Kernel BUG: 003e [#1]
  PC is at __unmap_hugepage_range+0x3a4/0x424
  PR is at __zap_vma_range+0xa28/0xa80

Commit 7bd3f1e1a9ae ("mm: make hugetlb mappings go through
mm_get_unmapped_area_vmflags") made hugetlb mappings use the
architecture's arch_get_unmapped_area(). The generic implementations
handle hugetlb alignment, but the SH implementations only account for
the cache-colouring constraint in shm_align_mask, so the mapping ends
up aligned to at most the D-cache alias size.

Set the alignment mask from the file's hstate for hugetlb mappings in
both SH implementations, as LoongArch did in commit 3109d5ff484b
("LoongArch: Set hugetlb mmap base address aligned with pmd size").
Huge-page alignment also satisfies the colouring constraint. SH only
uses the bottom-up layout today, but the top-down variant gets the same
change so the two stay in sync.

Fixes: 7bd3f1e1a9ae ("mm: make hugetlb mappings go through mm_get_unmapped_area_vmflags")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/sh/mm/mmap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index c442734d9b0c..4df807e0df36 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -7,6 +7,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/hugetlb.h>
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
@@ -92,7 +93,10 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = TASK_SIZE;
-	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
+	else
+		info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
@@ -142,7 +146,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
-	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
+	else
+		info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
-- 
2.39.5 (Apple Git-154)

