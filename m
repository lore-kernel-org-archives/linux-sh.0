Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613813F58EA
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066948; cv=none; b=GmjhZ+306JaZS/Teoct8xMHPV0ZAEPLC7LqieLhiVMPgbuAyTTn6q74aHNeCCxIO60CJiUNyu5hgDl9RLiE6Uoy/xIRTEXJI7eaY7dsH/NKkvqEYRyoMqzxebMFTGpxgRrh6FXiATZ5C6i1a93182/50zh7QQJ3RLhDaxrWojLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066948; c=relaxed/simple;
	bh=QZHO0pZD18AYfEmFI8vyJkxjLAGI+yqhpM3OrcSDWYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVeA1+UuS5CwEggDBx0MqR/I3CpJW66wNmbAWDOywXxxWXVvHiH+elzkc03prX38nLr8RfKRiFyPpSh17obxnYOgsJDBeQdFCvaQVDTYsyulKN5A10cCCbV1LfJvXddD2MMvPO6O+2PfJ6LuoOHhUmEc9i0yIn+SRw6IlHFMws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0NHYy62; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0NHYy62"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490479c2911so83324845e9.2
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066946; x=1780671746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCoU+OqdPKjZv36ACGpsB/y/JO/SUTxBEuaSym4ONwQ=;
        b=p0NHYy62+8E3RqeR7HSqzjcW99UD32/y8oacNwdSGWDVFcbhjdds5dNw/mZHLX4kAw
         wUlER/VHaheUPO+SvsGJNN/MuO0r35SChkBIc62xXwtMEuvAaFK+RkFPZZ9KGwpnT5tN
         FHprFTDI+IoylwBuC/sgiT9WSnKuBGC90QqO6vnXLB2ozqLnID8QmBxSk3gOVclSIlxc
         l5DxsBRK/s4DUll3ESK3BeyYwlah9VVMQyoi1yiV7reXsRyQP9hB9B0s2/Ap8SH+0bHr
         qEvt8SwxrRNgxfUiZ8FaklVGUNdzPbJnXu3G0b7GAflCIs/zkYQ1nUvGop87fxsBVwky
         BKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066946; x=1780671746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCoU+OqdPKjZv36ACGpsB/y/JO/SUTxBEuaSym4ONwQ=;
        b=r/7U27LlhLl72xqg0zsr3O0uj7pCzjT/MzKvj0ShgfPb5WEjKusD7wqHNIGdyfG+vl
         It2jAo7iYsW+GuJa74v0H8bGD74E6T3Mp2cUxWiQJPOmgeDVsqAhKsq358A5cPWIlZNV
         hCF2UbYY+Hrin46/HsQfT/k9NSUExVKn5OGH1oySEjpGDBY099mPJiarNWa34LJw4rq8
         yxGQsxwLT5UEPWwHCumKRhzaa+dpt4ghUonTRgosDx+UDK4a8KezmTGYKCLX62aWvJgT
         CseajyxtWCienxf9avRZZPQjjZCCk9fTxMTIvLdKCBUBBtolMuJdn4jH/0czTt+ObORG
         ncyw==
X-Forwarded-Encrypted: i=1; AFNElJ8M6zlrsn9ug/9FF8O56nMhhv3RjKM40wK3vA/ZOg+T9oK8xDvCzPDThQwqZNVsQXIz9smtfr7nTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRfal9nqxYzfgsFt4FIauh/1uTYlxuiQU9461n8BCSyHUXTUR
	B6GsWjc6HfksF3PnH7iU8MMbTWo22ipKCKD9j3d5wPmDFhCFx4MQCD2YZPA2rGtrmpjVPrkjMA=
	=
X-Received: from wrmj18.prod.google.com ([2002:adf:e512:0:b0:45e:e492:5442])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c3cc:20b0:48f:d5b2:7c42
 with SMTP id 5b1f17b1804b1-4909c0b3407mr46324775e9.17.1780066945605; Fri, 29
 May 2026 08:02:25 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:58 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=ardb@kernel.org;
 h=from:subject; bh=rMwJ7nJEkWuFVb2g2PkvQNTUrTu6Td3Xh3QWQo7SqgA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVXqXnoyd+bugGevMve7XfXSUYDy66PR9M/aLkzVbX
 p2pPhPVUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyMoGR4ftyuXTZZXPnLH8h
 GixVcqWVUTT36gvPhyW+7FMbBCYlHmdkmHBv/+orSg1td3qYcmOUt24wv3i7fwlXUYFT1dq0heu t2AE=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-24-ardb+git@google.com>
Subject: [PATCH v7 07/15] arm64: kfence: Avoid NOMAP tricks when mapping the
 early pool
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
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

Add the NO_EXEC_MAPPINGS flag to ensure that hierarchical XN attributes
are set on the intermediate page tables that are allocated when mapping
the pool.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 27 +++++---------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d7a6991e1844..cdf8b3510229 100644
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
-			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
+			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS | NO_EXEC_MAPPINGS);
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
2.54.0.823.g6e5bcc1fc9-goog

