Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5783421EED
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818368; cv=none; b=Zm2gI0JDcl81Ad82TyNkdF5YkA5Y3vQDSGkwVOQ0tSAxWDNKww1fmtVwXyP2ebO87cxg7BWgWKxAFXxaeButG1bnkhWxmghuGmp6oALOOqA7HoGLJ7PE5lXK7nC8OJX6ExFZVfjGRRoxGhSnVyoctRG8mz7wehcXo/42s/bBv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818368; c=relaxed/simple;
	bh=4/+Et9+8M/9XRBpvIOadBWxJIjJHwMIcMP8jy/wEGGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=poMXchO75nj2B9+ZO2W1bZP1J1edYXIYci7dzNxpVlZjSBL+vgPSdrjIZJ0fPDwXl3Cs23vFy4D44sYfhpfHhQLoa190o2GEEhAz8PjGlfSRF/YmnlT6Giaiys3ETwXUx2NYxJ7glTFcX2xEPFj1eXGeY7x2xA0EztpD6yNdlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXkJ0zFh; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXkJ0zFh"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-68751570301so6069324a12.3
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818364; x=1780423164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtBeFQlOADPYK4gJNp1okGIhaF4i6t2Ouexf2+2MrWs=;
        b=YXkJ0zFhtozYojxxx7riz+o5C/AtqKMm55r9+yQVH7MxFbEHK8AbPlr1ivjFRJd2i7
         XIjDqdwZHFCZO7vdcI0XKwUDkbvp2FAOYFbBpHdbTTrf0CWfo03SyZZNmZcmR3pAvjm4
         PF6bHtEf7VB6RX+tW+fjnbJcfKr+YTGy35JpI1fp0k9NY/bKxvjhKOpin4cUqxsexhYa
         CuxWcL48AuH95IAlHib377zJgAn/YbccToova5zCPSpmLrOm65XTyaL3Twq6Jc3A2cva
         RXk2cD34cNdKg60YbgQtZRTiV+mEgYMMxSz+PoF/8hJ0hJNad/DtyvzW8lNbgf1vTyQ0
         lGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818364; x=1780423164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtBeFQlOADPYK4gJNp1okGIhaF4i6t2Ouexf2+2MrWs=;
        b=I4gOTd6qmfkNp0jIys4dMGzUO95TaVVwbdVoybr5rNjhBNcszONKIOBwuMte7a42rC
         Tu28vDwtZsqbe+Uc2OiOCKeu3ZC9+vBzxcBsHLFDq2pWDWO8XCXf7c6huAK8Ybxt6+fT
         ahA/aFN1pGUxZYiXManKkOzmC3RpxcOoh3boEMW55ERSwnbygG/di7y5W9F9T/K8jKMy
         4ldNcz1SLwi1Uwk2DWZeDO1PTJTaumjB6hI01F6z03+qmYj6h4SMebWZbFLLnMtDVNnL
         +mtf5e474audC30fXqKJzVEmvlWJU6guk5jNFTdZhA5R/gAE2BqmclbPQw+w5UxfEJHK
         ivBg==
X-Forwarded-Encrypted: i=1; AFNElJ+5+F9SxDnbYVi5wvh3qLZqv6VvDyYd+ynxBxvi18VNZboMyy0G6Zau1KKGPuKSWiKftSDykjCzHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3QPjKRDR9H969JjQuq2+yAvfUJ0hlbvSGskrZqwiQr+2qiRf
	HPaP2BFnvXSTBDYZ03Eg9r/GWeYovhWE3KQSk5fob/j5ujyB9QrwHCclEUGzDaRw3y8HZj4RJg=
	=
X-Received: from edye18.prod.google.com ([2002:a05:6402:892:b0:67c:573d:d3a0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:40d4:b0:67b:cd1f:9cc1
 with SMTP id 4fb4d7f45d1cf-6889c445088mr10125279a12.6.1779818363764; Tue, 26
 May 2026 10:59:23 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:50 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=ardb@kernel.org;
 h=from:subject; bh=UYuabKAGVqw/38U/k7XQfrNPG5ThRXq/7mqnsjcGnSk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fvTm0BsvTTTaUheFf26uWyada7zXR7A5ui2rSTZi1
 o2FJrwdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKHcxj+Cl+U+L3mz31fZxuh
 tHcrzdsEq/i1War/p2x78yRMa8USUUaGzw8WujlZRJw7v672d9asvI8f57TITLjpqnwn3Gp2wO5 +NgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-20-ardb+git@google.com>
Subject: [PATCH v6 03/15] arm64: mm: Check for pud_/pmd_set_huge() failures on
 kernel mappings
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

Sashiko reports:

| If pmd_set_huge() rejects an unsafe page table transition (such as
| mapping a different physical address over an existing block mapping),
| it returns 0 and leaves the page table entry unmodified.
|
| Because *pmdp remains unmodified, READ_ONCE(pmd_val(*pmdp)) will equal
| pmd_val(old_pmd). The transition from old_pmd to old_pmd is evaluated
| as safe by pgattr_change_is_safe(), so the BUG_ON never triggers.
|
| This allows invalid and unsafe mapping updates to be silently dropped
| instead of panicking, leaving stale memory mappings active while the
| caller assumes the update was successful.

The same applies to pud_set_huge() in alloc_init_pud().

Given how it is generally preferred to limp on rather than blow up the
system if an unexpected condition such as this one occurs, and the fact
that there are no known cases where this disparity results in real
problems, let's WARN on these failures rather than BUG, allowing the
system to survive to the point where it can actually report them.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index aa0e2c6435f7..b2ba5b35c35f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -257,7 +257,7 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
-			pmd_set_huge(pmdp, phys, prot);
+			WARN_ON(!pmd_set_huge(pmdp, phys, prot));
 
 			/*
 			 * After the PMD entry has been populated once, we
@@ -380,7 +380,7 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
-			pud_set_huge(pudp, phys, prot);
+			WARN_ON(!pud_set_huge(pudp, phys, prot));
 
 			/*
 			 * After the PUD entry has been populated once, we
-- 
2.54.0.794.g4f17f83d09-goog

