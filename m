Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78124266B1
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818371; cv=none; b=UN/FflbVe0gKlTbdD2c5X1ac61apVGuu5Y7y/6JH4StrWFVMIW7rXQbkueCVtYV42UJ9a5/OylFE8pxfNjQQFTsi8dtnnCHlTX/f56J6YwNc8qRFcZogpAs6AJrKGQr8SoL/6eayp9BkUsbhJSCYVrd8l7LFlxGFKPV+L1VpXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818371; c=relaxed/simple;
	bh=X2BtPkz0m6On3LJePhaEPBMybWT3ReRxX78S/Z3E1Tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iHfLE0sQ+15axVeDNfmaMwx+hW6R8r3TRiPF+PQElqJp8Y7fjGEl271iP1FyP8F9P4J6MKw6lZV085FEutU/FEnrCwOZUJy6Cm+YwhWirDagBNbqN9HQKMuspjoR+MVUQDhXXMTS081KONK8qmE8Dy3Is1GjGfyfOqWexjJ9iGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMWU1BpP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMWU1BpP"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49050c44bcdso44502175e9.3
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818368; x=1780423168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNZ6xElfqK3A4SE3F9P829uWscll1GihYVBHckeq6A0=;
        b=NMWU1BpPKkvro0jmCWXTu386hXiF08MauOubrfPycNwgjYYL96IGYoRjF1UTuNwgIz
         N0tyY7OUdOCNUA+Oz/WstbIzM+qqQD+83EoqYDx5t95fh08w0GNgKlOg7YlLXL+fc9ZH
         SHeB+HGKyTDik4dD/gN3JHj6LbY/OPosKxbL0HElkBzfdJiXVoB/OWZBcpVVc5ZGHjkT
         otaKRDnbOL8vo8pHDcthInV+/+tWXqLJwlRx7ZsVGimiV27bn1YL7e9USQlBLFVZmBYH
         CbvCPgrH0FZMhluFvXqQ4STBDzbdJhnS3aok/XIqha34YwmXGqvbHQrDtgNebONY2Amn
         leXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818368; x=1780423168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNZ6xElfqK3A4SE3F9P829uWscll1GihYVBHckeq6A0=;
        b=QnoWIjox+Lh0NH9nd2lAdWLFbqy+Gq6b49FmjrdNbs+haOSZfvQESTpVVAX1iNKPYm
         S1/6lUwU/WijxFyZSPTsM9n0mTjxJQUvURRhO5bLYW9kuD2caPabx3plHVgPDD3ZFTtV
         dGeWNAEhNnhQfk8WFxZkKL1nfttbyrxb6ytEZ9YSkWlhsNorhZ6ABjNQ1FMat8NqH3w5
         Mx7rmDH9BcwYDf5AbVj53vYcq/ZVda5oisyUQZBgjlxPAA8DNZ6/EmgCnm6SkFEHk4ie
         KnB8SJrhuCLiSnHK5/lkfIVSCspCYh+GioouOUhgypvew+HDiTCaocTvo5sjA5K66DVf
         D4sw==
X-Forwarded-Encrypted: i=1; AFNElJ8x03FJsYVHIonA+4kApu9nrfkriYcYZmvZmeBeW366b5F4Z6UDzzHtg5ryHBwEI5+gJtWBh/RWWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxDgYgUPPPvX9ydzl8vPfiapzsZ+1cJVlrvtmWBzQ+wplaZn3
	jSSyehAHvHDkpAsBjOPJMPji7c/eQLAT2BfMdMXyosxygTupYTTnT4KtQp848xRsyAMblyBruA=
	=
X-Received: from wmbje7.prod.google.com ([2002:a05:600c:1f87:b0:48a:5970:2007])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b97:b0:490:52fb:12dd
 with SMTP id 5b1f17b1804b1-49052fb14fdmr292012705e9.10.1779818367951; Tue, 26
 May 2026 10:59:27 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:53 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=ardb@kernel.org;
 h=from:subject; bh=0Wnsvtw0Z2vu8jTM+plTHkuWXyq+RnVgc0hID3nHEQ0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fnxSZsWx12f761qXqC0qS65U2ZVyr3Slf87jmSwTV
 KRvvbncUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSLsjIsFvkWXjX0hVFJxZW
 Ldt97vPXdU3PRc8XH9GZ8UZlg9pB7T+MDA9i+Q/xn5Hz+Zl1U29m5LMYieUfPCfvSXROOpI/3bA ngBUA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-23-ardb+git@google.com>
Subject: [PATCH v6 06/15] arm64: mm: Permit contiguous descriptors to be manipulated
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

Currently, pgattr_change_is_safe() is overly pedantic when it comes to
descriptors with the contiguous hint attribute set, as it rejects
assignments even if the old and the new value are the same.

In fact, as per ARM ARM RJQQTC, manipulating descriptors with the
contiguous bit set is safe as long as the bit itself does not change
value, in the sense that no TLB conflict aborts or other exceptions may
be raised as a result. Inconsistent permission attributes within the
contiguous region may result in any of the alternatives to be taken to
apply to the entire region, which might be a programming error, but it
does not constitute an unsafe manipulation in terms of what
pgattr_change_is_safe() is intended to detect.

So drop the special PTE_CONT check, but still omit PTE_CONT from 'mask'
so that modifying the bit is still regarded as unsafe.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6b42d724bd1b..d7a6991e1844 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -134,10 +134,6 @@ bool pgattr_change_is_safe(pteval_t old, pteval_t new)
 	if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
 		return false;
 
-	/* live contiguous mappings may not be manipulated at all */
-	if ((old | new) & PTE_CONT)
-		return false;
-
 	/* Transitioning from Non-Global to Global is unsafe */
 	if (old & ~new & PTE_NG)
 		return false;
-- 
2.54.0.794.g4f17f83d09-goog

