Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5D3F6616
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066950; cv=none; b=QWQZqjG4k33g9GpF6nOLqURGSxOdxG8KHWnQnZlOI2uiDT2KPKtxz5aHnNO5oIUZcy3xi3TqdJFsftd/gQQNGz7ZNth7o9gSU/AfPsRgAz4etegqtNahxZqh5H6t9n1wY8o9CpehuWkndvkoaeQNP0MFP72Cgi4ZFju9zJ9CuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066950; c=relaxed/simple;
	bh=EBI6q+g2E8/hvK4yQT+JWioaVrhIZ2lWVOkuVaQK5mw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nnKaECdGoHbi6tlZ1SPQCLf8pn3xggtFJYdg8jpcP3mJrXnIdWCEcM3Ysy0ZFg77YAq2W+ic/NIxzqgT1AcxsulUvdsQDX9TuZ6TJtz/v/RQ7oV12lDympXb8Jcgblkd8FJ8lzYlFgAHuOY4cXsALVqCwKXxQSb6bYFcQFhD9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1HGHI7P; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1HGHI7P"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49058295985so41886135e9.2
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066947; x=1780671747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9tlxHwsxA6eqo2SKmJcmasVfNUkIRzlQyYjktT989Y=;
        b=G1HGHI7PiYgkVDW1trNA7BV0Hu8fco8MZPyK2M16vfuKhco1r+xAl+svCG15rAjskg
         StbNAUm02Qb+ntDkHBNgb9IJkGtLaN0a2Og1cK7CrIjJOevRtSTVcdqmj2ZTBK24eTpa
         xGKyRhh2XDPGBy2oIF1gpq0KQNRLYI7n30hkWQBp5HUkJHA89rH9fiA3oRO89cxpOK3o
         GVNY/G79niwpvEqv9WManMF+9obV9BZNlNrlfstHITRMFY8DWqfqMaAOpvSNB3rVk85Q
         BrZ4s7OkkzHdYpfbglgx1JolS+Ei99H6YMeNnEFLHKAtp+UBjKV75LOUNoevMXR/WMCZ
         ZsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066947; x=1780671747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9tlxHwsxA6eqo2SKmJcmasVfNUkIRzlQyYjktT989Y=;
        b=siv92y5JrjPKU3UUoPGgwXSbodFqrmfCAXwrTsTFoIaimReppmbvHfShyDUm6gQvcd
         JN7s863TNwmaNdL8mOIAcWZCRIf0zleqbCyrxxsjEjs/j6M4NqjI5F+38WMQ6s6DiT6m
         mdMcCdmwu6h2F1iTyZk4s8VVKP3/XZxz0nrkOjwf/F5Ui1dkpFXcih77C2lOXWA0Hg73
         SPpZzp3UaMKqxo18tE4iRwWy7nwH7CX8pV0vloEf5k4D749rpJQN4yDZGS08L7E4gvz/
         nycI8j0xKMOF6+o9D5671wFEtNmoZRPBydzh3DG0oO67h2gVqiO6KYCaSg+//JeMVJ0C
         sDzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jniLiPrfz/KCqS0mjntdS4bitWx+tYBRvX3sxX4YwffyKTP8pgUjJlQ9+2zHgQJUj+ZeWorN02Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/XV4/NII+O4TUuSKy3mYNcwqsOzqXRqOxhkIvwD1tSbX+nwL
	kH3YZhPZgPsEClUCktUmMBtp0jCVjjs9MaJkyDmrrSvDLgqJLdcBmxgXmrsgr7bv7hSXFIuFeg=
	=
X-Received: from wmaq22.prod.google.com ([2002:a05:600c:6c96:b0:48f:dc9f:6f14])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b14:b0:490:4b89:5361
 with SMTP id 5b1f17b1804b1-490a2904d7fmr303015e9.7.1780066946805; Fri, 29 May
 2026 08:02:26 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:59 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2952; i=ardb@kernel.org;
 h=from:subject; bh=TyyULer9eaKHyQ1BOINcFoCv1vvnMukGL48REtJhPzs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVUboiS16Xkfr8iLbWErOKcytU4vuVJk0+76BcO5Hz
 rb1+sUdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKqGxgZNjU07DG6GaTpezdh
 zbZrEwzidjxa865atLfK9/GeO2emyzH8d7MLuK/p3ZH8ib3z+D7vti6R81b7wgsSZrk1v7x+zKK WEQA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-25-ardb+git@google.com>
Subject: [PATCH v7 08/15] arm64: mm: Permit contiguous attribute for
 preliminary mappings
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

[0] RJQQTC

For a TLB lookup in a contiguous region mapped by translation table entries that
have consistent values for the Contiguous bit, but have the OA, attributes, or
permissions misprogrammed, that TLB lookup is permitted to produce an OA, access
permissions, and memory attributes that are consistent with any one of the
programmed translation table values.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cdf8b3510229..971996e46fd1 100644
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
2.54.0.823.g6e5bcc1fc9-goog

