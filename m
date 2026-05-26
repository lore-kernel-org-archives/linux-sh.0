Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A142B733
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818382; cv=none; b=GENLWZaLeiDlbjUl/tWTfR2290Hz8n7I87f05NEB93oY3e1M27xpy7YrRZbzAYqBMv4F55xZcTtHc/5Rq5i213rPRlYhn4o9H2AFwXGNZvPWmjB5sWJb32XaeaF4xBU1DRjddvOCUCDmHEINpGD0gBymaEmEQPFy4Umc8PT6G48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818382; c=relaxed/simple;
	bh=kx6uPXi5Ha8BFgjXpuzN0TMPj4yTatVChoNZQ3O8Wjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aT24xF4zoEifvTJfJUk9rLnH6T4niEPbjDESqkCGnIEMI3nHde1ER/s+7CQAeO1EBTl0l9zD8JPf+dixwggu0MJYrlo65v8Ob07ETA6M1zSp19WKt5N/PgrPOwYpM2qSgHvNmoGj7PTIkpj/k4Gut4c1dj1Oz2/EJluxSA0aHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/4dY+Rz; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/4dY+Rz"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-447f2ce5556so8060262f8f.2
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818379; x=1780423179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9HdLIrtfTsrLcuMDzN3Kt0yw7TgIGpz80e87aySNQ=;
        b=u/4dY+Rz3VwT32/uv/cg5+eIUKD3Y2GiYnwJ4ujGUGZ62gwCkzX7szI5RKe0pjPbPI
         TpkOfwOZ4VgMNn2Zud2BxENjI2UA2CyW7CioBGChbANUKhXKpC1NJR/DcmDOh+mRz8iD
         zsAslbiNP6mQ9CVoxolg6Ki1EjSt/LrqwJQytm+5rVINPe3TMaHWUSBWnPI+scKszMa1
         GqpGmqZ4Ljsg8BcKC/hyYl4uVD120jx/stsL2MP66WJ4XahVIRD6QBheTXP6G4HSdvlr
         zKVV9aEnPIibUfFB/mvuGcifbsWJ42qyIDmK7IH858Le4C1ROFecv6g1RDpjhpQ1Qtqp
         f0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818379; x=1780423179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9HdLIrtfTsrLcuMDzN3Kt0yw7TgIGpz80e87aySNQ=;
        b=M3kLHUJXjreSvQoKSxZqouFcVX3GCFMHAAb0TY0FxBOtRbiaLVgupPrIEvCwMWKd0X
         9rBRRbjUhLQ8juxTe8oi0eV9WgD1tydihTAmRXUCH4XNfG63sJqcimk5md5WT1yZm5pZ
         1qf3Qm0FORjuYjcR9O+TAzumZMmG20DmIVmHmpLy6cUy+mUnx6yQsDsLhuoELtY8+WG4
         /a+slCXFtGwKgfWX8+Jle0G8SqJVhQ28gxtuE93SPpPOfxuA2VEOkZi1bfxcs9NGA05s
         j71PiO1Jqu8faBi9qNxlweMbFajz3JeaxbsxovL8yCRS+4aEMQy1SPCSe2midsvdLHiY
         vgIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MJ6t86jp3pTWWjna+QTdAYqZ4Q9+LevJr4sfBmBdHTrVreC3ihwcuGivXB6RjpHPWN6cQ9g4QEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ZiBtUDnWnNSmO83iBkRD6OTKsB1o7CAu0UIHH6qxPNn1+k/0
	2rHWAfppgKFT1aNa5KzqZ8bwwjBQNq2wAvbmzn9ue4Wf+tdGJ2bIdzsy24WGq+6R6gyG7f+AyQ=
	=
X-Received: from wmfv6.prod.google.com ([2002:a05:600c:15c6:b0:485:3f38:3dd2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35c8:b0:490:45bb:8dd9
 with SMTP id 5b1f17b1804b1-49045bb8efdmr348556125e9.8.1779818378710; Tue, 26
 May 2026 10:59:38 -0700 (PDT)
Date: Tue, 26 May 2026 19:59:01 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=mYtVYiSzRogY9cxOoJbyywYkU254ucBHoAXG9B3cPO8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fiZrSsLEz85Vxb/brc+ssGD6r5/EdCw1zi66VivRb
 5JYlGdHKQuDGBeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmEhzByPD0ky+XTe7StYuXrtA
 se7PPWVX9mMHpG+dm3iu/EHwtpNeExj+Cv4Q0JnTu+ZI3cG3t5OPxTdavzl3yvBbYsCGnriEHY2 z2AE=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-31-ardb+git@google.com>
Subject: [PATCH v6 14/15] mm: Make empty_zero_page[] const
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The empty zero page is used to back any kernel or user space mapping
that is supposed to remain cleared, and so the page itself is never
supposed to be modified.

So mark it as const, which moves it into .rodata rather than .bss: on
most architectures, this ensures that both the kernel's mapping of it
and any aliases that are accessible via the kernel direct (linear) map
are mapped read-only, and cannot be used (inadvertently or maliciously)
to corrupt the contents of the zero page.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pgtable.h | 2 +-
 mm/mm_init.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cdd68ed3ae1a..67aa23814010 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1993,7 +1993,7 @@ static inline unsigned long zero_pfn(unsigned long addr)
 	return zero_page_pfn;
 }
 
-extern uint8_t empty_zero_page[PAGE_SIZE];
+extern const uint8_t empty_zero_page[PAGE_SIZE];
 extern struct page *__zero_page;
 
 static inline struct page *_zero_page(unsigned long addr)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..46cf001238c5 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
 EXPORT_SYMBOL(zero_page_pfn);
 
 #ifndef __HAVE_COLOR_ZERO_PAGE
-uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
+const uint8_t empty_zero_page[PAGE_SIZE] __aligned(PAGE_SIZE);
 EXPORT_SYMBOL(empty_zero_page);
 
 struct page *__zero_page __ro_after_init;
-- 
2.54.0.794.g4f17f83d09-goog

