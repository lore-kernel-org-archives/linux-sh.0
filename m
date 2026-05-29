Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771A3F8EA7
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066955; cv=none; b=vGBCQI5e/2P3z77a8DQfL3m+inSHU+KUw3//wlnQI+feGJxIXI9Os28TB4C49PO9+ftq78v9/svAgGwiVkMMl+q7Jk8RBT+/BCxYmzljrAtBq/LXc8fYeE+qRPFJk9SoHUWe9Qy76Pu4+KW3y700OzljPcZAtiTpq1Z70IVWYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066955; c=relaxed/simple;
	bh=sj0WteKdkA3T9R04zZss5lRyyoVYcBLMURVAj4LFOWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RSV36SGH8XACh7S9VGBVLojz3a67FN5ovcD+KbsxwbAaigxt8Modzl9cOLgwXDJfSL+FAKhoqR2Tp85Ah9ZT9lqedRxorcHrNH/O2FTWFVoez9JKr0UGW/h4b66/cFqb2HeSe2X8xoYazh9aKVbDHXQbh087J36U0H4K5Su9NX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCtycVzQ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCtycVzQ"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bd50f081f72so203558366b.1
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066952; x=1780671752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ic2DGsrtEHhUHaDXXEd0q4Y8zWmRk/iCag+la1hIg4=;
        b=uCtycVzQb4pejKMX+XezqQG7BZ+vsZZHnEg+Ee+RSQYZ+IPb2ok7mwkoLzzaeQ3yBF
         uKZ82ERT10gII1MmL8nKuSLZyKozMC6VKMjnnZkY234sydBQsBdxCHUGldcvKGlmpYNh
         qhIqLn8LY3bH4jZYjE0Ai3EQZvW2zUIDrQAwmSoWaYcDH2bXS91+jDxJlfIXlSC2TAWn
         IscPVPf4BokxB+D7rGgbJoR+8bQfNOB92/IOZPJ4aIXOissf3bH5sUAjGTPzBYQboxnL
         ZqxDTY4BxSjhwZ6s1wf8t6iZAwHWkvqn5wPwlCdLQ0CS+K3yL8TJ9UBLFzGzx38Qs+b2
         QrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066952; x=1780671752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ic2DGsrtEHhUHaDXXEd0q4Y8zWmRk/iCag+la1hIg4=;
        b=ItZMV9npEQJla92S9vCYW4x3xn1zn6agR+fk0ar1F0lbc1DyMzFcL+ymU7Ds9ysLor
         hLUnBDGwbN0j43+E7TLVMqePELYl3dA1+86MU0nzCKZAcn/0+bTGYSXQUG7sHYHgR4/9
         fGv7d18+ib0Kw56TdA0QM12HZTnHUbeh+6PWaVURNVShzLkzHlWgqHNlcmv8vQg45nua
         /Pg9LwJ8ISXeveY6/oaLLIJmP7kWmQ2CUOhDSwjc036uwsiqyeO69WS1PfNbSJ9CvWFW
         uqMYrmeX5VJsG0CqQJcaqQ+2HRvK0tHfYWHtyye4YGkh7sE1ADmq0hj+yXn5nlEJw2vv
         PN4A==
X-Forwarded-Encrypted: i=1; AFNElJ+MTDi+xzvXnTmwJ8KJEY+7jpQ0Qn41rRXcVrSRo+VmMupbyvsT5aiENrEDTr5UT4qTcyDes4+inA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfELHIXKBkrNNHAGfFDNcvroLJYhL8oHeVmAMSr9C3bNpWZwyd
	z6do2uvE5R3VB+NY3nDrq7/Nk74DJ6VWRzJx25I04wfMVkcp7VwZ5Xe8FiaemnUz4Hm2glfNCQ=
	=
X-Received: from ejcdp16.prod.google.com ([2002:a17:906:c150:b0:bcc:71b:965d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:846:b0:bd5:7c2:7622
 with SMTP id a640c23a62f3a-be9cce79583mr206170566b.49.1780066950536; Fri, 29
 May 2026 08:02:30 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:02 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562; i=ardb@kernel.org;
 h=from:subject; bh=ubRBWkWn2UVZmjj/MlvsEvyHLMfMbEt4k4F760d5eRs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVY4k535dO+nZFlbOfzzdd/L8Kc16wKgvUGy0L8C+M
 NAkc31HKQuDGBeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmMji6YwM9xVOLdQXVDy63md1
 QcOOcqYQ72WntJ6eyrZNi+loev33MsP/3BPHG8Off7zik3rM8U/Y17jQr64tKe5X7+RwlEXo3Rb gAwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-28-ardb+git@google.com>
Subject: [PATCH v7 11/15] powerpc/code-patching: Avoid r/w mapping of the zero page
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
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
2.54.0.823.g6e5bcc1fc9-goog

