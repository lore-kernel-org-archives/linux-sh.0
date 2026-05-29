Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE353F870F
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066951; cv=none; b=ZttnvVqLsOcLrZBsM5CjQ4YEO1fpjPv6j1uZxQRxkM/tpG8zis8ycrub1dinDeHluwZfoEjo6OlYoAHm3LskWqdhy6nRP1Qj6FyQIxoojbkiiQyPvrhG/QUCJ9WM04ndqJ9Mdf9GV/tuAkKedJsAJWJlyQUePyJLEHQnC2e9Ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066951; c=relaxed/simple;
	bh=QaYtjQKKU2ZFCKXwSNKUI8NOyp6rR9SInNzJZhhzRuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FcSf0TECQk8bMNmFkRHYGNUjrUknQdqlbzrzis96v/3g5Uy6fP0vgDLK8kC2geLUX2NV40r5YnLS+3hZLDmdqijf6HsN/om6pmSWdtEuJheXQyENU3WLA7ychgFvP8MK3IlJOLslGo9pc3pgWXNqFRjxn3uqTsyJIC6S95EKRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ds7+tOe7; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ds7+tOe7"
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-396623d338fso775681fa.0
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066948; x=1780671748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xs8UZJaaGpDG2dm36q3rutkvNlrSNXe/Bj9mb4oSyno=;
        b=Ds7+tOe7u6LqidVF9uUrVbA5TmrJvkRrC/FeXq9I/qqB9kpwJdt8chI2z8vDpT69nN
         SRKPRfwIUg9faZmumhtR9W3q8t3xmrRKYp6I7Iq9rR2udFNSoBLhWBRvTC8wvmaZVkWG
         zmXM+TPyol0EiUPJOfWz/55kNLBQRfcrJU52H+w+a8ShvCwbQJ4EJKItJOF7QuuMN8dG
         cNoRT6Um1/QZQCgrXSJFrrjNJHYciFCYuMcYe5N+IMAKX9snhD80mNGl6iEN0hvsSShC
         DpeR7WhS4qH58LmtxqR6vOeVGpsai1QGYykAA1MusogjG1xYOkboPmfFJks4V9yqRuGi
         mXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066948; x=1780671748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs8UZJaaGpDG2dm36q3rutkvNlrSNXe/Bj9mb4oSyno=;
        b=YP4DHh/D1tIsYpQHLPfIfpnF+O9s/+UnTl34UZiEZD/EHDEYkaB7SjPGVFCynEq49u
         eTZogbrU3+jMclBw6AHnfwmH//xDlVG2xP9+CzN9ZvhNCt9G4aRYix0puZQ7bJIXBkmO
         IMY8oF33dk0Su3RqCdqAujTOTzb9WPk4zG+3tvJAAhYZ9ITk972bdVwp/HzffrLl3u5n
         g/2MKihd3Lxt7QUbKvsmBZbT/ioHq9NcBRGYyxC5eXktgEDK5hJ/8KnecTOSHNclyq2B
         O6G4QdeF7UmIExAV5cxNzuePb5A/5UYizABaweecuzwt6c2TM9Uc5DBou8xzJbqdxHGF
         noVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lC/Tc6URGi7+qORwWbiz3GSNoJMYBMoQWxlZyfLo0mj5i9CYCEfPvqAvrqCoDEvl/T1qccA4RHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwouuoCtjRSY5ZgpmfUHgk5vuvugDW1t0WxLNEIvQvTLJfsLxrb
	X2nK5nZRetNtIpgqDbG3XHEwEifbSk0a5wvI8FZ6AFcZhYMr97zBk3lNWWbkzPXYI3ZjAkgOig=
	=
X-Received: from wrjb2.prod.google.com ([2002:adf:e302:0:b0:45e:f542:3761])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:990d:0:b0:395:ae3b:3375
 with SMTP id 38308e7fff4ca-39664e981c0mr41301fa.2.1780066948187; Fri, 29 May
 2026 08:02:28 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:00 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=ardb@kernel.org;
 h=from:subject; bh=QwDzTM46GdUE+NivIT38dC1HutxUWa2GWKTenTtP7nY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVWb2gvjDypnblG6ZO3Wv1Bft/jrhexd79oV7t577u
 RU+EnfqKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZI8zw36neUKL4j/F/nsar
 u7+2BlcevsMd8uPEywc1ppJzt9RzHGb4K8J9S++osuTMJf0rlUt33Z06V/Xzwox9+yqmH1l/Qee ZAysA
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-26-ardb+git@google.com>
Subject: [PATCH v7 09/15] arm64: Move fixmap and kasan page tables to end of
 kernel image
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

Move the fixmap and kasan page tables out of the BSS section, and place
them at the end of the image, right before the init_pg_dir section where
some of the other statically allocated page tables live.

These page tables are currently the only data objects in vmlinux that
are meant to be accessed via the kernel image's linear alias, and so
placing them together allows the remainder of the data/bss section to be
remapped read-only or unmapped entirely.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu.h    | 2 ++
 arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
 arch/arm64/mm/fixmap.c          | 6 +++---
 arch/arm64/mm/kasan_init.c      | 2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 5e1211c540ab..fb95754f2876 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -13,6 +13,8 @@
 
 #ifndef __ASSEMBLER__
 
+#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
+
 #include <linux/refcount.h>
 #include <asm/cpufeature.h>
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e1ac876200a3..2b0ebfb30c63 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -349,9 +349,15 @@ SECTIONS
 	_edata = .;
 
 	/* start of zero-init region */
-	BSS_SECTION(SBSS_ALIGN, 0, 0)
+	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
 	__pi___bss_start = __bss_start;
 
+	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
+	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
+		*(.pgdir.bss)
+	}
+	ASSERT(ADDR(.pgdir.bss) == __bss_stop, ".pgdir.bss must follow BSS")
+
 	. = ALIGN(PAGE_SIZE);
 	__pi_init_pg_dir = .;
 	. += INIT_DIR_SIZE;
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index c5c5425791da..1a3bbd67dd76 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -31,9 +31,9 @@ static_assert(NR_BM_PMD_TABLES == 1);
 
 #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
 
-static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
+static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __pgtbl_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __pgtbl_bss __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __pgtbl_bss __maybe_unused;
 
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index abeb81bf6ebd..dbf22cae82ee 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -214,7 +214,7 @@ asmlinkage void __init kasan_early_init(void)
 		 * shadow pud_t[]/p4d_t[], which could end up getting corrupted
 		 * when the linear region is mapped.
 		 */
-		static pte_t tbl[PTRS_PER_PTE] __page_aligned_bss;
+		static pte_t tbl[PTRS_PER_PTE] __pgtbl_bss;
 		pgd_t *pgdp = pgd_offset_k(KASAN_SHADOW_START);
 
 		set_pgd(pgdp, __pgd(__pa_symbol(tbl) | PGD_TYPE_TABLE));
-- 
2.54.0.823.g6e5bcc1fc9-goog

