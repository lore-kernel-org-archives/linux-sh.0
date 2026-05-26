Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49442668B
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818370; cv=none; b=CyB50K9E8CB9yFIipp+pu0igtiIL5VhxKt0aD3O07A6MN6nOXGp/WeqPzUB4BJold+ojZQ0zQEi7oSWjGleqhzawdWha6t7DD0E6VQ7N5xOyljX3+CWvPtXnViaCidaTPN15rX6RWBNRuiCmMivJF8jXMeurTYUXbbQcULqqIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818370; c=relaxed/simple;
	bh=bTvTY7THc5d7WTIDs3aH2OJ7lspQKDu8wsfUcID9dlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Geur7aRyZU+g+Nqw6hpOW1bQVm0GHoZaFsNECYynIzVDBqt7KCzyObcYMqmUJWo4yl2IlRs9bJ8KsYZL7Ytfh2GLXBUDjY3YXKL/p0+e20vlh+aI8CFB/Y5dA07SAdYF2QAsK3YGtK4jv5hfU5sHL5UnLBHM3QjlkQVUfVyt5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJuTOyhC; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJuTOyhC"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6884ab142c6so4019156a12.3
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818367; x=1780423167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVtRZrGktzRjCdUnH3kN7Vy8R0F1sW5LmttIAYz/k8A=;
        b=OJuTOyhC+6j9IsXOWQecMnCypGZohsJ8ODZBl9/d5oI0kBn2OeqkSbRu2OVoZBznqu
         gRr+wRnmUseXHodoy6Ip8B5DKRnBb+hBwPi8oTBaNR8f5wye7Bhehl/RQh+/q7HRBL7N
         ewHYzSzjh3zH6rKVCaI0eYgYrEZd6rm7zJTw9pGZZbdj/rzqPA3IajTPKtCI19QrKLfh
         g9C3LvtACsvJMp844W61jSQPKCuF0KCRFdyZJFO/cSsA5RinexdIOotnL7L2IXZ6vxn9
         u+ewOeSvfruXAf66QHZwVZydXY/PBnAM9X5AaEso4u/Revq/aE3udFHuzNncYSmWzqDR
         jKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818367; x=1780423167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVtRZrGktzRjCdUnH3kN7Vy8R0F1sW5LmttIAYz/k8A=;
        b=faLbPtYawmCMzraAjNi+4CD0rhJCBDvDD01/md0CbSqKhEWQRggE1D3qNFwoBREE5G
         gFFyd2lt/i630QvPsUjByOB3KnhUjPxwCTIARb0HaGtbnA+vNZdZ62ND6hxnerTmMdbL
         3R05NlEhVJw5g6SzKDwV1Qy8uH1V5YhLGcZWvcjIyWuaYFDzvLciHNOBU8ygpKqdNvoX
         xWzPazVWd+Qv07J0IsZLsK2/JRQZcfWoDwP5PWz1eKSsTJRiPkHsxB7UmvWv3GNpk5Rh
         WkMp1S3p69TEPpRuk0mNSV5jfFx693rr8PDJo5arsDWT5zfEGoaPhNwEoH10lHDlgu0p
         uu1A==
X-Forwarded-Encrypted: i=1; AFNElJ9dU7LckcVsca87mRIgrgvLuoEEyaidbSIOaFX73h+CXAedATj22vJQxn5WSUgvmaWKHhNPf//uHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/92jVQSx6OJpukBxPa5l75CPU157bJgUATdBw2Y35OxK3y0k
	j8E06u+AqNXS1sBB9Ff5dm1cAYo3hRpvQEpFChkDCLGWeIqE7U+6rG1aGaN56Wv+Ly1OAuxFhA=
	=
X-Received: from edgg7.prod.google.com ([2002:a05:6402:1ec7:b0:687:a46:a91a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3891:b0:683:1cc8:84b0
 with SMTP id 4fb4d7f45d1cf-6889c41ece7mr9857461a12.1.1779818366685; Tue, 26
 May 2026 10:59:26 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:52 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700; i=ardb@kernel.org;
 h=from:subject; bh=z6XqclO2VktRYngIWmFbVHfouJpd6sLXvnE8xwKtYlk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0flxH4ekTmyZ0HhJ9JL0wwCSxxnH9nteLX//dwO4dq
 58gueBoRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI3R2G36zF1sq/DnmIFKhu
 n6+5tapE4TVTQeM123nvlwhbO97ZVc/wV4jD64xshEfNl9JbBTcNtzWsVTgTNfuZcwu3tFeOvPJ UZgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-22-ardb+git@google.com>
Subject: [PATCH v6 05/15] arm64: mm: Preserve non-contiguous descriptors when
 mapping DRAM
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

Instead of blindly overwriting existing live entries regardless of the
value of their contiguous bit when mapping DRAM regions at
contiguous-hint granularity, check whether the contiguous region in
question contains any valid descriptors that have the contiguous bit
cleared, and in that case, leave the contiguous bit unset on the entire
region. This permits the logic of mapping the kernel's linear alias to
be simplified in a subsequent patch.

Note that this can only result in a misprogrammed contiguous bit (as per
ARM ARM RNGLXZ) if the region in question already contains a mix of
valid contiguous and valid non-contiguous descriptors, in which case it
was already misprogrammed to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h |  4 ++++
 arch/arm64/mm/mmu.c              | 22 ++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4dfa42b7d053..a1c5894332d9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -181,6 +181,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
  * Returns true if the pte is valid and has the contiguous bit set.
  */
 #define pte_valid_cont(pte)	(pte_valid(pte) && pte_cont(pte))
+/*
+ * Returns true if the pte is valid and has the contiguous bit cleared.
+ */
+#define pte_valid_noncont(pte)	(pte_valid(pte) && !pte_cont(pte))
 /*
  * Could the pte be present in the TLB? We must check mm_tlb_flush_pending
  * so that we don't erroneously return false for pages that have been
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5c827fa3cd38..6b42d724bd1b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -187,6 +187,14 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
 }
 
+static bool pte_range_has_valid_noncont(pte_t *ptep)
+{
+	for (int i = 0; i < CONT_PTES; i++)
+		if (pte_valid_noncont(__ptep_get(&ptep[i])))
+			return true;
+	return false;
+}
+
 static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 			       unsigned long end, phys_addr_t phys,
 			       pgprot_t prot,
@@ -224,7 +232,8 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_range_has_valid_noncont(ptep))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pte(ptep, addr, next, phys, __prot);
@@ -283,6 +292,14 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	return 0;
 }
 
+static bool pmd_range_has_valid_noncont(pmd_t *pmdp)
+{
+	for (int i = 0; i < CONT_PMDS; i++)
+		if (pte_valid_noncont(pmd_pte(READ_ONCE(pmdp[i]))))
+			return true;
+	return false;
+}
+
 static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 			       unsigned long end, phys_addr_t phys,
 			       pgprot_t prot,
@@ -324,7 +341,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pmd_range_has_valid_noncont(pmdp))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
-- 
2.54.0.794.g4f17f83d09-goog

