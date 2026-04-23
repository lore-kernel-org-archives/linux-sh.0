Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF23806C2
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962635; cv=none; b=GjuqKPc0olR7Hr645gIZKzVN1U2vyOtFABzYKrdq6ObAQ5/t/uHQMkywAJs/TrXaQkcqZaFOoyt/q+cc9AzXR+Ij08kqQC3DW/vkznsm9opBjexZ2BBYLgHQAfwhxmiIEUPrvL4aHr77mf/2NRKfqXgJtd2hOT0VkS3VnCucHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962635; c=relaxed/simple;
	bh=7XjLvOApxZhX2gxFpJysmmPtGUkq8o8AKprYz/2NFII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcplzM7y+tIrgGCAemAUKVDHvUT9xKgzuv4n+1NPPMN3fitD6kEG0LgI9cqWyh4yGhXBxbz01XKySFDi9sVWpYahKzYwlcVmWu0RLVEuqiceHOe7mN+UXFaaoJQG9I7+lsvkxQkH0bMbhLKEDt5tvViRPrAKSMHhKqwGE7K4j1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nIxJlQFI; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nIxJlQFI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776962629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tq36KGadaqw0c1BG3VjFijsY9XtO67dEjIMLY95uDvA=;
	b=nIxJlQFI0Ft3ofx3aZGp4I8eNvIe+gxmxe263xn7Pcnt87MoY1D6dLox0d+jMwk4j+yacR
	PxolEImw9Z2ZcPJXxmQEkqPOp2bZPzVdBScXqQQJzZ5ro4oAtIXy4Xh+s0Nnv1zaZr0r63
	GgSn+MB3S1Aa78vub+nktLV6Nvf9dE0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] sh: cache: remove unused but set variables in sh4_flush_cache_range
Date: Thu, 23 Apr 2026 18:43:23 +0200
Message-ID: <20260423164324.273220-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=thorsten.blum@linux.dev; h=from:subject; bh=7XjLvOApxZhX2gxFpJysmmPtGUkq8o8AKprYz/2NFII=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvfHQuShskfO35spqH8VLKFv56P6kdmw6dTPa6sWnH9 8Jd/V/NO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAivuKMDG/d0rc/e3bh2p7m lz9UfwuKBix4tLBDtkZI+giP3XqNfAGG/75e8Q2tcSGrnrZ7da8uYjpS1d1w3MeGeVvIuuVcyad PcQEA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove 'start' and 'end' to avoid two "variable set but not used"
warnings triggered by -Wunused-but-set-variable. Update the function
comment accordingly.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Update the comment as suggested by Zi Yan (thanks!)
- v1: https://lore.kernel.org/lkml/20260423145301.245374-4-thorsten.blum@linux.dev/
---
 arch/sh/mm/cache-sh4.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 83fb34b39ca7..c7635beb4f1f 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -274,8 +274,6 @@ static void sh4_flush_cache_page(void *args)
 /*
  * Write back and invalidate D-caches.
  *
- * START, END: Virtual Address (U0 address)
- *
  * NOTE: We need to flush the _physical_ page entry.
  * Flushing the cache lines for U0 only isn't enough.
  * We need to flush for P1 too, which may contain aliases.
@@ -284,11 +282,8 @@ static void sh4_flush_cache_range(void *args)
 {
 	struct flusher_data *data = args;
 	struct vm_area_struct *vma;
-	unsigned long start, end;
 
 	vma = data->vma;
-	start = data->addr1;
-	end = data->addr2;
 
 	if (cpu_context(smp_processor_id(), vma->vm_mm) == NO_CONTEXT)
 		return;
