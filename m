Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BC3F23CC
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066944; cv=none; b=uEskOReI+U+t9Ps7eNOR5GUOvCHTzgGRxJOoTSjm2MfOsQT8iih2idv2vzm11whdb6NF1XonaczKDVitB5o0VSKui1/K4otMDa5JdqKie9thKTMe26OD/zzn7miuEb6Eltt/jfsdjzbNFT2J+zr9GGXS7xElHbElexumChia2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066944; c=relaxed/simple;
	bh=emiPSkc5kq8Ky8pUT11zWkfNXnzxzu2xwOZVFKgqaqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNqHnPk0ocggjw23M9WVg4rkeAUbBrtNmpI3zu0mzaXjDZguDOAH9794oJKl5lPlsz1tNESr7Q5fw42RiL84m0A4tSxfrG6cwrIRj0hNGIQVedLQrxIIXY7FlGzeBIBaPR0TCErNvD2PQ0slzI5DxmZEGPknEklkINiiExrsxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LchDk342; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LchDk342"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fdacf2616so73376875e9.3
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066941; x=1780671741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/mwSEvShIHWF2QZpE0iwPRub+uC5Pg2lSQX62+z6MM=;
        b=LchDk342FT5+TG0vRfl7lYPAibY+1oTeN2E7mUMWToHrc916Dj4NTAmVmxhl1hT1h8
         kDwK+hZr4alasKBsCqOlMvqLRbCVDs7qKesTQVz60rIgh5aSLVvAIe3QEsvZSzLJDT0B
         Ry/bZWYKY91d9XDfdbzy+gwSyKxHJPLqqpg0/LH5K5M7zhnSIXouNGKV2StnTMPlv9lL
         cC1XexNBWldyCkl/4gOFa2G4vf/Qyyc6+RAIGaUEXVQjen1YYoETPSau7qQ77VjKVGgj
         LTEpzgR5oAjBWwaJuD//gGcXNuW0aOAhTltFGxvPq1rz90kfI4ckduLWEOVNxK6O4x9+
         nweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066941; x=1780671741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/mwSEvShIHWF2QZpE0iwPRub+uC5Pg2lSQX62+z6MM=;
        b=Pt9z8OVUzuQN5qtkLHCkYOF/4Z11oPW6YOHbTxtQzO9J9UHg7On63aX32ItHxTQ8Aa
         jZ22FyTiKMKX7hAdYIeC7Ex/zXOQ+3eFpzPmypxA6IoGQlHjBCr7A3znXlmsEMPckHn6
         Riq/XgEBo47K20I+P7EKPsNQtileaabNm/BvJ2JNqdjvVCjFwK+a2Qywfgu6G6sXzT8V
         eEWM4zk9YRPzNgNtrQKUolQm/lOc5EnomurCWC1HiMN2QocOoK5LElGL5cuaD8FYSD43
         S5HTNu3WJ7rutW6tGkkTuY7toI4qUvI67GzEP+ckrbFWOQNKR1JO83fi0EoTTcsxxhoN
         WAJw==
X-Forwarded-Encrypted: i=1; AFNElJ//TT7FGh78OvCoy+4pQXLfZKuyXSkmBNp740Jnf9/jYU/MREthPvCq6+ax+arDbmdy2aNv/sVHhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGLa9mnNMnW/jS2XSRrsUHXgNk2RkylFJuiFYBRF9dREyqlLJ
	y9riW4FAj9QG/x2uF1ZJrmAyoiP0zT+/uhlHdyJR9BhWv3Sswd9f7wR1+bsQ875fC5JMt9ClHA=
	=
X-Received: from wmos19.prod.google.com ([2002:a05:600c:45d3:b0:48a:6a1b:6c3b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:e489:20b0:490:6869:46c6
 with SMTP id 5b1f17b1804b1-4909c0c3aa4mr45310045e9.31.1780066940967; Fri, 29
 May 2026 08:02:20 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:54 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=ardb@kernel.org;
 h=from:subject; bh=bTKeTgp6cCkzZ1W18Sd9Cjl54RAT9moCkecsCk8B5PI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVRLb9epvd/g6Z6nXCMU1XxDqFp7StynL770hk8KPC
 3fVkv52lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm42DP8T+QPDuZ5kJNY4Fq0
 fndHhtCalPXbZGdn3574zC/PNP3pckaG3SKqFZWbT0T+XSk3T86mOHw7v2nxfgWXR9PW1P5ftia AFQA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-20-ardb+git@google.com>
Subject: [PATCH v7 03/15] arm64: mm: Check for pud_/pmd_set_huge() failures on
 kernel mappings
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
2.54.0.823.g6e5bcc1fc9-goog

