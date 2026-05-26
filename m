Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BA421A19
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818374; cv=none; b=FVfBAz+PDGFYcwvJrYqufB28oVX2fJB0l8MvcrX9bsmU3ti091TP4UZmDveuGflIJrPbITOkjestrTvekPHOFvtx0OH4YYUrNPyc9TUxp1ky/CdHaFyskODIcoGEUlAfvDNvxBjIDLgOzk9JuriF8FEBmKw9nBFbTXVEX3iP460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818374; c=relaxed/simple;
	bh=L5SP3ynx6v29Pg3poBNMmeI60r8Qx4J8iiZZMS51BC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fpnrfxfDQyLBLgj7u0+8zd3ZXpuI+GehiTlf6Dp4RUReDyx/SwcvgsUOJxJ8teCmXBHMXL1aiCHbi6VL7p2wnm489SZvW1h0UNNvqzB5OGLu1srcu3/+68BG/g3UDocMnjbc9fWfugfvc4A6Q4nsYJ6rL2e5QKR1zGWm3SYSRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAt/t0kr; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAt/t0kr"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bcc22a042b1so1139257466b.2
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818371; x=1780423171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QGcTo9f84jQQ3RURqBOJp1vLQa/oONqz3vOx7niDYc=;
        b=RAt/t0krw9In7Rl1yhBiwVXkZN7xVVmXZVQJ5hhnU+xjsW7mS7Xc/VzJEdD9M82gYm
         M4s/GUEKLDXdxd6AneqSJBRwjwEzLfmfxoLDZOeWOi9gKCsqr3t9K3p89AQvOzmXJgPD
         AOWVSDx3uK7Jrt0T6qkXzyxDKEVwymsZEWgHCVNjXlQrhavZUI0xP19CWlMHbEKWWFyB
         IB+msfoKc4MSNoOM/JtKItQdEEhWIMRFQCsZDhTY5ed4M+1E89fxovzJLfUADiYM7ZWT
         3u58vcU+B0SMANN5n0s2LGPFTLy3Pm6ZcGKathNdbEYkx7jL1INSG0Zy4lGQ+CmrNJDq
         fqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818371; x=1780423171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QGcTo9f84jQQ3RURqBOJp1vLQa/oONqz3vOx7niDYc=;
        b=cs5X969xkdqLIVHkCWYJyJAkCx+G5YFt+7dQD0557DIAuOmVjp8pIJ+XpgznuonDWB
         AI30PdLEfkYlMqGW4cYRtKJIvPQORKH/D6AYKszYofQNpsktDvGLRKsD1/Fd+SC8+GbF
         o5Qw30DjmqxpedpiPlOHR+DRL0mRREh3fuJNkAdfb1b2Dqupn3kQEBj5NheCM8pZU6Ei
         msEjr8IHzb2BL15E9MywMgDWy5pcJPq3ibsKjzMjAZm6AY5S8AEAVOD8UD0nNXmALkte
         vc1GOIbnTuo22RcXpLEBBK3q0eqhCB10dKwOYS/8yBHdyO4RSDZiv6/eOxfF0hS+Brve
         TObg==
X-Forwarded-Encrypted: i=1; AFNElJ+p7WTmyzFZQhTb8JQadi7UCPPL/mHD1/UmrVK1N68x1WQpWAGGlS1gTujc2k0vypyxBXq7k7/TiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzycqwEzTZ9+IVe4GzAaB8ETVBxgQnhYsd1kIfvw9YQr1JDxusu
	bmJPu/UbXub+HcUQIcKVxPu6KjaYEO3ts5oDnAdcY+EbmZK3l8CcAU1kXY8Vqb6clRWICf26eA=
	=
X-Received: from edyn13.prod.google.com ([2002:a05:6402:6cd:b0:687:e30e:62a9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:ca84:b0:bd2:e940:db25
 with SMTP id a640c23a62f3a-bdd22e30cc2mr1206557666b.13.1779818370675; Tue, 26
 May 2026 10:59:30 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:55 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2937; i=ardb@kernel.org;
 h=from:subject; bh=xB9oKBi8uLt+1POTvwyFN4ig92BBqhDsXz5+cc7USWw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fhKj4MmKF6L9vM+ex9Rs9b0+/d9Nq+XeXuXTJwrky
 3esF1nfUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACby6AzD/9Dd3yeIi89KKpkZ
 tS7DjyPAYY6GxZyveRIHIpY9rS1/zc3wV6BhbVqFXb6I0JNF9ifsanP6XEOzznS/b/x27JQXe9l 0VgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-25-ardb+git@google.com>
Subject: [PATCH v6 08/15] arm64: mm: Permit contiguous attribute for
 preliminary mappings
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

There are a few cases where we omit the contiguous hint for mappings
that start out as read-write and are remapped read-only later, on the
basis that manipulating live descriptors with the PTE_CONT attribute set
is unsafe. When support for the contiguous hint was added to the code,
the ARM ARM was ambiguous about this, and so we erred on the side of
caution.

In the meantime, this has been clarified [0], and regions that will be
remapped in their entirety, retaining the contiguous bit on all entries,
can use the contiguous hint both in the initial mapping as well as the
one that replaces it. Note that this requires that the logic that may be
called to remap overlapping regions respects existing valid descriptors
that have the contiguous bit cleared.

So omit the NO_CONT_MAPPINGS flag in places where it is unneeded.

Thanks to Ryan for the reference.

[0] RJQQTC

For a TLB lookup in a contiguous region mapped by translation table entries that
have consistent values for the Contiguous bit, but have the OA, attributes, or
permissions misprogrammed, that TLB lookup is permitted to produce an OA, access
permissions, and memory attributes that are consistent with any one of the
programmed translation table values.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 55bb40348a47..04cc579c7a15 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1016,8 +1016,7 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-				 NO_CONT_MAPPINGS);
+	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
@@ -1044,8 +1043,7 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-				 NO_CONT_MAPPINGS);
+	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
 
 	/* flush the TLBs after updating live kernel mappings */
 	flush_tlb_kernel_range(virt, virt + size);
@@ -1191,10 +1189,8 @@ static void __init map_mem(void)
 	 * alternative patching has completed). This makes the contents
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
-	 * Note that contiguous mappings cannot be remapped in this way,
-	 * so we should avoid them here.
 	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
-- 
2.54.0.794.g4f17f83d09-goog

