Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303913F1ADA
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066942; cv=none; b=VE0GLo0IBI7EW1IrC90nqMk+JBnUSWNcu/UhVwF4ZYu4EpyZ1cBNyBuE2ZVVXhRVAaNXU2VLimdNlWKbOG8LVs2NUQPtfOI0ktnTQpnnBRnauBFi8M/ns1MmEsIqVEYsGgC0F4ZbUMswSN+IquaiB1sG8qmEoTd9OR6eeplNXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066942; c=relaxed/simple;
	bh=vxD7TlABQc5YNXy8IgLYLrozgSyvWqQX2jVCpPFJU8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l0/dunpSLPyUJJOjkoi8lxZkT61I6K4YKjyDL//D4OoMalclyjTU0xzJnAQyKR9ZAj4NoEfCp8RPTHJDRyeTMwenfwIUFptRZhf6L928wkdMX0LrMmZJvuxUkOz7H0bbyZTnyp63+gPNqQ+vmXT+n81MCtHd35foVn5EB48dCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbBIUmdp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbBIUmdp"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4905428aad6so54768845e9.1
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066940; x=1780671740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHwZV4K/OQyLo87ubxB2N7tui2RqyNeWqpTDKGM1mWQ=;
        b=VbBIUmdpZgOVz9yfJy0u03XE2GOK1RKhnCeBUphANyyrP9pEynPVnIdXDiF5WQNH7h
         JKb0rAiiAPuj0TTH5U1xBMBLk598jVsMpCVeQp/PGD9sRpCxPKxJBNmhDikJfrvkGyci
         EAUXqGMoLDOSSM5/Lo0N8I1kSvT4a0jasa0UB36G4JYjvCxVrVs5LIRtvUDZcDCx0KVy
         980hkTZSsv3enEj2YMXzCemGeIZuoeZfQu6WmABwx4/esuHBLpMv4QEFTbNNYgt3ff6I
         qGn7mxz5nUqHTdcKeSMzb0J7s9MqcXUhmy2lXOS8hPYFhPmeMLuwzdhn3dPo5vz89jKL
         jM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066940; x=1780671740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHwZV4K/OQyLo87ubxB2N7tui2RqyNeWqpTDKGM1mWQ=;
        b=QHSLCM2NySga0N2qf3lHa+fxjW64KOkWZ/faxEbSkSksrChr17Nplihl3hgLmY7RmM
         nSgda/Yp9+0lKLg+MwHxOOH7FXuaY0rIqSJLjBmhdIT9bhdj76s34UBmjqUGuY2KqxJB
         bl1epNopuqgepBhXyEVzmM1BStsUagcmm/isKPVYCjEYqQ7BHXpRv3idZ7LlpQxtcGta
         ZdqHjzHwiTzrB8dZbtIVjAlJEtbl8dUUuW6I8ThaGRDpMuh1T0WKmxZzZqHycKSLcmsB
         oeM5m2Y+hsDoXBrAAxA1kF1HwrCxt8+MIhxmx6Hp2ptr8Q6tUQvvsbPXYNnm/9Kp10IW
         DE2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+VV930JSK+rZ/VRVtjIyaTb8guiegaeu37trDQ4ce2JsmXEhVWq7tx8KLXPMuwkvHF0XKp5y4Ptg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8uzvSrsA4WjeGenBbcZ/kDGIuLDARBv6nxgB61LjQeBEh7RX
	QTu4rmwfQHsaPglk7e6v+EPB6K08o0hyn2hzvlNkXb0NFDFgP1Cw4i7O9tjwS4WI9TOml1xMIw=
	=
X-Received: from wmbz2.prod.google.com ([2002:a05:600c:c082:b0:490:3d2f:edc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:828d:b0:490:507c:bdb1
 with SMTP id 5b1f17b1804b1-490a291cbbemr329805e9.15.1780066939649; Fri, 29
 May 2026 08:02:19 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:53 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=ardb@kernel.org;
 h=from:subject; bh=RVK4+kwUNBzT2vP63qv/oNPK4oNSEDZX2ULcXiZameE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVeK1gth6p/IV1dd2mU+oVf+4YqKnwbIQxumu9bquP
 Yfu1HZ2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIncvMPIcGzv+x2vrDJc2eUk
 LtltCDno/Lq1Z7LA5Ge9k44qbfyXuZqR4dqGMNajx9vSleJns73yeprz3enQ4h9HLk24LK1xMO+ dISMA
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-19-ardb+git@google.com>
Subject: [PATCH v7 02/15] arm64: mm: Drop redundant pgd_t* argument from map_mem()
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

__map_memblock() and map_mem() always operate on swapper_pg_dir, so
there is no need to pass around a pgd_t pointer between them.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 112fa4a3b0eb..aa0e2c6435f7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1035,11 +1035,11 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 	flush_tlb_kernel_range(virt, virt + size);
 }
 
-static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
-				  phys_addr_t end, pgprot_t prot, int flags)
+static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
+				  pgprot_t prot, int flags)
 {
-	early_create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
-				 prot, early_pgtable_alloc, flags);
+	early_create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
+				 end - start, prot, early_pgtable_alloc, flags);
 }
 
 void __init mark_linear_text_alias_ro(void)
@@ -1087,13 +1087,13 @@ static phys_addr_t __init arm64_kfence_alloc_pool(void)
 	return kfence_pool;
 }
 
-static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp)
+static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool)
 {
 	if (!kfence_pool)
 		return;
 
 	/* KFENCE pool needs page-level mapping. */
-	__map_memblock(pgdp, kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
+	__map_memblock(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
 			pgprot_tagged(PAGE_KERNEL),
 			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
@@ -1129,11 +1129,11 @@ bool arch_kfence_init_pool(void)
 #else /* CONFIG_KFENCE */
 
 static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
-static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) { }
+static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
 
 #endif /* CONFIG_KFENCE */
 
-static void __init map_mem(pgd_t *pgdp)
+static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
@@ -1178,7 +1178,7 @@ static void __init map_mem(pgd_t *pgdp)
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
-		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
+		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
 
@@ -1192,10 +1192,9 @@ static void __init map_mem(pgd_t *pgdp)
 	 * Note that contiguous mappings cannot be remapped in this way,
 	 * so we should avoid them here.
 	 */
-	__map_memblock(pgdp, kernel_start, kernel_end,
-		       PAGE_KERNEL, NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool, pgdp);
+	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
@@ -1417,7 +1416,7 @@ static void __init create_idmap(void)
 
 void __init paging_init(void)
 {
-	map_mem(swapper_pg_dir);
+	map_mem();
 
 	memblock_allow_resize();
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

