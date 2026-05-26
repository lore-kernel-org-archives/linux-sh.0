Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED942884A
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818379; cv=none; b=CxZXvPhhedM32S5jaYIrT+piRKOXFBL1ZsVEJ0pQMdep7isv/OKqDcxHa24jCkSaOWOS/cEzC7IOKGJpq+vbQVYyMrjy3m0fcD9fpdU/jGnXx0gsNJCHwVCEVY789CgokkKg+hN81CWuSd1TLn/KCTdz8SGrfugETpozhxXMXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818379; c=relaxed/simple;
	bh=SPk/NWH8coVOt0tso4SER9c0QEdFsfo4KSqPkXnf6iA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=peTE29rblN988gcRJzJlx/69do45LzGutqGTQCH6VgJCd1hRZes033LbUkE9yjxnaKhzirHTbZe9mAHhlrU7/wAwxOxh/O51XFyVwjegLqCa+rgZ6Qk0rDxzhKK8Aqk3P8lWZjPec+xqATuWIrnYYJlUG1QNSqo44JFNlZpwrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIqFG50k; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIqFG50k"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-680f7441bf9so10026357a12.2
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818376; x=1780423176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqWf3aIh9jwoRDW7ej6OaYtUXPKSIApXmlGfcanpMS4=;
        b=ZIqFG50kSU6Ao0R4CWm24LIUGo13l6VOTLkLphI4vn+YUTGpVGlbzRosuz41OSxAtY
         nzxnhjZamDmDpN1lMsY5is91EuDEMp0T/ybV4gTHdK0BpkT8kfVqxhuUd1NoZicx7oeA
         6O94W3OA0IclPSO9PuTrbicoTkjKHCedvOrUQjjMHIb7WY5Gh3CO5TTgwO0mNz/zC9sV
         sbqe9TOzsGvchHm+m4SSGeKcweGSu7zdM6FfIjcTopTBGZL4WBYRMmQJHHlF0s33wwnL
         wQUWD2PcVNS9/gMPxchQRo9pXirYKFNj3YZuZdLJpErCRzHQFE1gWxSqgADgE9TBN8ve
         GYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818376; x=1780423176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqWf3aIh9jwoRDW7ej6OaYtUXPKSIApXmlGfcanpMS4=;
        b=VVLUsgB7+GlBlRjwU9OVA1Da+P5fdph1sNwu3MDdMVHg8CD6XEgYY1WVGiF2z8IWKF
         H+mfLeOUpMYqeSO2c8teMNYGN3qqTW5Itjn4Y1tQDg9l+2y2LeYYhrXcnXuLBiEe3NzJ
         htzAEqYfX9IgucCAFIWTMOt3VqdfGMdLWi+AlzMXyDMDY/vS1++m/29xDhVpitRFjwFj
         gUj2ljuctbY/CUz8s6U5vk2GOoKiRzV5wd5+gpXfeRESftkr6Vs52aBu7hSZwocxJp/R
         oMLX8+ypB//YM7vcHTLYAOOXnwgKXvOVjPFRACHIkfBAj+0q3H5/ss3RphDMXw4dGK9A
         lFJw==
X-Forwarded-Encrypted: i=1; AFNElJ9T2jjkGM3ay/kERXbLrNCP982HrgpbM4Oa8soh1po4Fy4YXp3iVak5YPpdAMDhdGgMNoLDdQnACA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDrKJTo0V1k7mM8Wymg7gmPjw0qz4KRQV7x4DAkqi9JKJW9QQ
	ykP1x4/px3VJhAd8sQGoO4FgUJFO28EH7jOh7xrbgUEZ4DbXyJqB3n6iRRmzgHWUSB7ZzHWcWA=
	=
X-Received: from edqv21.prod.google.com ([2002:aa7:d815:0:b0:67b:7c67:1fa3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4348:b0:674:5b2c:d42c
 with SMTP id 4fb4d7f45d1cf-6889c406b3cmr9914567a12.3.1779818376178; Tue, 26
 May 2026 10:59:36 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:59 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562; i=ardb@kernel.org;
 h=from:subject; bh=UEzDYeArIhcNSC2frPncytSQGHg972cpOAqaWBBxbIk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fnq9X+pUBo2wreeSOJ9dXiQeemVxk13k2m0KUYbfu
 fQXzIvuKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPRzGRkWNkdW18r/eqia85v
 tUMNMXXf3V+K+oQl+nh/av96UvTZBEaGFv6biY3/V70q4frOvkbMYcPfR2skZm6tkJiyR9TynUs ZOwA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-29-ardb+git@google.com>
Subject: [PATCH v6 12/15] powerpc/code-patching: Avoid r/w mapping of the zero page
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The only remaining use of map_patch_area() is mapping the zero page, and
immediately unmapping it again so that the intermediate page table
levels are all guaranteed to be populated.

The use of the zero page here is completely arbitrary, and not harmful
per se, but currently, it creates a writable mapping, and does so in a
manner that requires that the empty_zero_page[] symbol is not
const-qualified.

Given that this is about to change, and that map_patch_area() now never
maps anything other than the zero page, let's simplify the code and
- remove the helpers and call [un]map_kernel_page() directly
- take the PA of empty_zero_page directly
- create a read-only temporary mapping.

This allows empty_zero_page[] to be repainted as const u8[] in a
subsequent patch, without making substantial changes to this code
patching logic.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Link: https://lore.kernel.org/all/20260520085423.485402-1-ardb@kernel.org/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/powerpc/lib/code-patching.c | 52 +-------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index f84e0337cc02..44ff9f684bef 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -60,9 +60,6 @@ struct patch_context {
 
 static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
 
-static int map_patch_area(void *addr, unsigned long text_poke_addr);
-static void unmap_patch_area(unsigned long addr);
-
 static bool mm_patch_enabled(void)
 {
 	return IS_ENABLED(CONFIG_SMP) && radix_enabled();
@@ -117,11 +114,11 @@ static int text_area_cpu_up(unsigned int cpu)
 
 	// Map/unmap the area to ensure all page tables are pre-allocated
 	addr = (unsigned long)area->addr;
-	err = map_patch_area(empty_zero_page, addr);
+	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
 	if (err)
 		return err;
 
-	unmap_patch_area(addr);
+	unmap_kernel_page(addr);
 
 	this_cpu_write(cpu_patching_context.area, area);
 	this_cpu_write(cpu_patching_context.addr, addr);
@@ -233,51 +230,6 @@ static unsigned long get_patch_pfn(void *addr)
 		return __pa_symbol(addr) >> PAGE_SHIFT;
 }
 
-/*
- * This can be called for kernel text or a module.
- */
-static int map_patch_area(void *addr, unsigned long text_poke_addr)
-{
-	unsigned long pfn = get_patch_pfn(addr);
-
-	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
-}
-
-static void unmap_patch_area(unsigned long addr)
-{
-	pte_t *ptep;
-	pmd_t *pmdp;
-	pud_t *pudp;
-	p4d_t *p4dp;
-	pgd_t *pgdp;
-
-	pgdp = pgd_offset_k(addr);
-	if (WARN_ON(pgd_none(*pgdp)))
-		return;
-
-	p4dp = p4d_offset(pgdp, addr);
-	if (WARN_ON(p4d_none(*p4dp)))
-		return;
-
-	pudp = pud_offset(p4dp, addr);
-	if (WARN_ON(pud_none(*pudp)))
-		return;
-
-	pmdp = pmd_offset(pudp, addr);
-	if (WARN_ON(pmd_none(*pmdp)))
-		return;
-
-	ptep = pte_offset_kernel(pmdp, addr);
-	if (WARN_ON(pte_none(*ptep)))
-		return;
-
-	/*
-	 * In hash, pte_clear flushes the tlb, in radix, we have to
-	 */
-	pte_clear(&init_mm, addr, ptep);
-	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-}
-
 static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
 {
 	int err;
-- 
2.54.0.794.g4f17f83d09-goog

