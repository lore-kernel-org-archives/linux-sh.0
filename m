Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A988426D2F
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818373; cv=none; b=b4TZRF2qhzJq2v5+zU7r6UW5xZ4dtywC4fbeDXhtRl5a7lICnG1vXKeQSTdekV0kuvX9Bn38GuKVl1RFyy3/20x6w25+hT6EIjlwCywv1xUZtXIRjdvYovPRmF0NM/wtn/gmmHZqREO/4/NVtH4DTJsSl4/hwnDXi5kSU7o9E/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818373; c=relaxed/simple;
	bh=cVEpJWPlb9+3lxdcLCIklwwAAIRNQ16kMW0XcS1SelU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pc2YdB9aTj7Co84duCzn6K9lNa2kSQx8+TT/NQD44nTdzSADYtgrHPRYeZuBZMPCmWS1yvSm3IpxfUv9QjC1PlSlFBqHs59S3YvDSv9ypVMGgyXR5TiQhY/susoeX/TqNodmF1I6+EF4BNbVZFl0kamtLqmSUejbp2Y98Ndt4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNYgCLkv; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNYgCLkv"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44a71109b94so7381055f8f.3
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818370; x=1780423170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVwVNe3cqI0RCHG1xJv3LRo5BwxDkOUdlieXkffr7Nw=;
        b=BNYgCLkvbZizC5WJEa2VPQqjW/L9o4X6Rh7oYvari0Gy+iuCnhWt6sEQtAjvFVXvwx
         toNO7AiwHMnU+cV/EAlX76wKZkV52xTdOyf9Cif4YijSHswaXkBiuZiWxQOLLSc1VPxE
         +HMgGT54VdW51VXenrh1Pfimau6cXFKNhefiuTP3atg1HXiB5u+Uo6Dtljp+mXlkLQnU
         LTzNPQ0MZYGfNHIMaCKcKdCQFeC962IR6fuP++kJFkK/3TCaGh1MrVD4mVzFZVaXtm53
         pOLUneRVo9LopfiXjuoKRe1LYbTJq4ltMBuCQkqD7CwwN4mg4JgKYO6XaaX06GHqo8Fj
         zlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818370; x=1780423170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVwVNe3cqI0RCHG1xJv3LRo5BwxDkOUdlieXkffr7Nw=;
        b=f2tQN+PXvzxggE2rh/kuloyDrjsYLrORfx2wB7/wyj1gjQlJ74LVJD+0fUpNoKKqd0
         rpQLZy0qBvaX0+Xy8PTYEpJWgulOy+bxvW5KM8IcLRyvVSXsqNECvwBArfuI428Xb771
         9f2oPXQ0iPu/LP7M6844L5HzFb3bqEknBJCWjzdF7EE5mh43lXLGl7f9uHoVl7kiM6AK
         Z+U23qoWt6Tc1vTX/aXOyoGgBQlc7qdAO00Jk1xEmRUFebLLvpwToflKWX+NLxR6rYk7
         +fjQNKWz1NOVXx3AWYy/gsi44/EdJt0823YtVw0lyEodKIlEPEI5DbqXbDuuiy3d+DhO
         5IBA==
X-Forwarded-Encrypted: i=1; AFNElJ+eVJt4F1E7rLUnfzBSIVYganVbtAiKeSE/4FUtqY+ZNLUl/CHCaU1KpSl6TwHHW1wfWYEexqsILQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9853YXh1RJGoPnJxkyk/go6dLrgE0NghkkklCgneh+5zYrds
	ZMKRVnDecg2aMshjbXkQ4xJo4faHY6vaFpUWhGsP8EGZBtYUTljxlALoKjvmRJ7lzs9tiozvzw=
	=
X-Received: from wmxb15-n2.prod.google.com ([2002:a05:600d:844f:20b0:48f:d328:60c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e14:b0:490:5cb3:e936
 with SMTP id 5b1f17b1804b1-4905cb3eb00mr223400195e9.4.1779818369475; Tue, 26
 May 2026 10:59:29 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:54 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123; i=ardb@kernel.org;
 h=from:subject; bh=p/GjcIFRscd8SARDtYvyFpPt1lS/DKkRLXn2dxWNXF4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fsKpx8vWnXp9PDbK7d7pQ5f7tV6IZt198fXxgbl3+
 RdMT7Zr6ShlYRDjYpAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQAT0bvEyHDiTj+j5qWAr0Y/
 aoUNp/5XU7S1WV4v/ue8Dkfu9tf7llszMqzS+fykyFm2qtwylU02r291afDEKR3P9d4q/j84eW/ EbjYA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-24-ardb+git@google.com>
Subject: [PATCH v6 07/15] arm64: kfence: Avoid NOMAP tricks when mapping the
 early pool
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the map_mem() routines respect existing page mappings and
contiguous granule sized blocks with the contiguous bit cleared, there
is no longer a reason to play tricks with the memblock NOMAP attribute.

Instead, the kfence pool can be allocated and mapped with page
granularity first, and this granularity will be respected when the rest
of DRAM is mapped later, even if block and contiguous mappings are
allowed for the remainder of those mappings.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++----------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d7a6991e1844..55bb40348a47 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1083,36 +1083,24 @@ static int __init parse_kfence_early_init(char *arg)
 }
 early_param("kfence.sample_interval", parse_kfence_early_init);
 
-static phys_addr_t __init arm64_kfence_alloc_pool(void)
+static void __init arm64_kfence_map_pool(void)
 {
 	phys_addr_t kfence_pool;
 
 	if (!kfence_early_init)
-		return 0;
+		return;
 
 	kfence_pool = memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
 	if (!kfence_pool) {
 		pr_err("failed to allocate kfence pool\n");
 		kfence_early_init = false;
-		return 0;
-	}
-
-	/* Temporarily mark as NOMAP. */
-	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
-
-	return kfence_pool;
-}
-
-static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool)
-{
-	if (!kfence_pool)
 		return;
+	}
 
 	/* KFENCE pool needs page-level mapping. */
 	__map_memblock(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
 			pgprot_tagged(PAGE_KERNEL),
 			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
 	__kfence_pool = phys_to_virt(kfence_pool);
 }
 
@@ -1144,8 +1132,7 @@ bool arch_kfence_init_pool(void)
 }
 #else /* CONFIG_KFENCE */
 
-static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
-static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
+static inline void arm64_kfence_map_pool(void) { }
 
 #endif /* CONFIG_KFENCE */
 
@@ -1155,7 +1142,6 @@ static void __init map_mem(void)
 	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 	phys_addr_t start, end;
-	phys_addr_t early_kfence_pool;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
 
@@ -1172,7 +1158,7 @@ static void __init map_mem(void)
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end) &&
 		     pgd_index(_PAGE_OFFSET(VA_BITS_MIN)) != PTRS_PER_PGD - 1);
 
-	early_kfence_pool = arm64_kfence_alloc_pool();
+	arm64_kfence_map_pool();
 
 	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
 
@@ -1210,7 +1196,6 @@ static void __init map_mem(void)
 	 */
 	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.794.g4f17f83d09-goog

