Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30F34DCEB
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956036; cv=none; b=ASw/7nC9PsuytVdw/dru6cjYAfppftzll4JfdytL8FGPH5gUCM8N2FPydF8o7YlIbiKPCLyFbWsiwWUDYJa9skIYVzzj5J7VWeOVMq8DlAf3/Z+RqavKECHtlmUlQHOwwDE61nSdfnkSqjhlu+HVmueHa0bj3GKO6ZKLvoGEzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956036; c=relaxed/simple;
	bh=VqJMBtZ2w8kioKDXx2y0e8D8bODyt37lcec6JyOFNvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3TUbrFsULz+kv1f+gvafg5ZwQKGworNb/zB0A/E9mUmDLOa3+RDvfLs8gQ39EIHUv94ydYLh8TLEJnnABz/e7jgaS3ND/+kEwRNE/uAQJAGXHRFEcBNf6EfFMybXcuSvdDBeM3G8CYc875h920K/HFAXs6ErE2dDMjyZ36T3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qM+MtpM6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qM+MtpM6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776956022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rSjB2O/vFrGcnPKwIm650pmyGxb7QMYuEfUemAPvJpE=;
	b=qM+MtpM6rUspYApZwCCCxlM0gMbagSZ9vWeQflXhlgvvdG3JTuNb1kEPjQq38pprqCaz1+
	0QLWz1lYrS1/Uo2gHmcvPWNfBIZ19JOBkrkU+04RVv07ktWLrRaeRq0Ob8ftQ2jPsKLTLu
	EV75EaHofpePXGi1hfei2Ffi5bp3PVg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sh: cache: remove unused but set variables in sh4_flush_cache_range
Date: Thu, 23 Apr 2026 16:53:01 +0200
Message-ID: <20260423145301.245374-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=730; i=thorsten.blum@linux.dev; h=from:subject; bh=VqJMBtZ2w8kioKDXx2y0e8D8bODyt37lcec6JyOFNvM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvjHyFXr2YIxXIniChWuFZcDXb8INC0pnjcn5Hn85Yz GKundjYUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABMR+MjwT2XzRkWWAoZ89z2a BuonpuhO0dTsNNnAs+70hbvXLkmuPcrw3zW1KdtxR/U159wN57Un3csW+1pw+8UKZsU/QlHPq6N jOQA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove 'start' and 'end' to avoid two "variable set but not used"
warnings triggered by -Wunused-but-set-variable.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/mm/cache-sh4.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 83fb34b39ca7..9776027382cc 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -284,11 +284,8 @@ static void sh4_flush_cache_range(void *args)
 {
 	struct flusher_data *data = args;
 	struct vm_area_struct *vma;
-	unsigned long start, end;
 
 	vma = data->vma;
-	start = data->addr1;
-	end = data->addr2;
 
 	if (cpu_context(smp_processor_id(), vma->vm_mm) == NO_CONTEXT)
 		return;
