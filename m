Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E83FCB0B
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066957; cv=none; b=p8ER7m9RGuYXg7xO1NHnwAVLmijncQ6pRD5MDboZ2fVNN5Jbwk4oARPkKx3lks5htbYhPfJH+0yLfcCyrWOsWgt9CkjBfa/0a2RSgLaAk3lDQ2VUDTlrMf3bGRkWHvMhZp6NsnDh4DmqpiGUKUfWLUEN9MoeSnJnv+VDJ2hxsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066957; c=relaxed/simple;
	bh=0W8cmWeo/elCcQMUWDRnf0TD4aZw8wpUlwnXz0G5xws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NYlfZfoHTN5XWbhvB0GqGE5mZNCHQ3mPO0a5T4kLXEZVpYxaZ8IU7Pv5tisr8tgBYcGS9ps0ssuWBsVCDRn7b5/7J4KIGO5k0VkOKt4xQynVhryv2ERFH60if2pGDVyi9wcorO2sHipLsBakX9bhKuJuRgNiRgkXIHgcZJketIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1Je0QWo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1Je0QWo"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49050c44bcdso81471255e9.3
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066954; x=1780671754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuldBekegH9n0W4LLX2RtMOFJe4Z/6YrXjIgxtYQaL8=;
        b=k1Je0QWoyo2afIXfsSLAnPowe4ak+9hm77V84lf5tr3MPCTzPOnZGY6fNl/y7OHnb4
         MIru8IP38NIashBQc4jwa1EcyIjuTAaNqoYWYoGie9qWOB4z0AuvnxQzzqKZO3h0OfB0
         Iu5H0ZTkhgyE+OU0ygmw8aiwkOmI5r0/9OrnuzqZCGcMfq7cjH9jazq9XSTznUHnrihK
         BLI5ivIPLPGhCYfr1rWSnNVlCQW34w3Zilcj2azAeWvMFKrQfldI+ulX2vd+HETWkRMK
         IHR2No/BgDH3mHSs8cQYHqqOYwGRD5as++2nymrZBFkDawfCByzDlNtxgq7Yva/kzaKy
         /h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066954; x=1780671754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuldBekegH9n0W4LLX2RtMOFJe4Z/6YrXjIgxtYQaL8=;
        b=olM9IB206b9cjH1MHucXlos4QA2rgdA1sjw8SfUNhiEvN0B4/Bawl4eW02b6/dqejA
         yetBVl/rHmUU8RGJUUfiQ32u9SRgqFmS7EiYJo7SIGRjD+NUs6nkOo1qIF8kL4W6bhTu
         Sr+o2BxnJA6Iojl6kAvjxkUIQo3UOHPv79ITTPmIegNhMYxyO/G0Af81mBFQXOovkriK
         lsfyjVquHM3OH8uCkBrVgJcDrAfe5B6xCWWgNjeLyBflwTbGKiscbuVqSgltIJGw4uco
         GG2PWqAcs/rWV6qhl/TnnIWkrJ2cOFyiMLObL33Klf+rN8WI2rImcUu95wHNzIUFdIqo
         D5rA==
X-Forwarded-Encrypted: i=1; AFNElJ/SA7+4pNiAEbLPrZh30mFSqACY++WeRx1q3zGWoyRAHDsxrDnuHCgE05KWmMewwJWg7ZdPwpoH1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hBAvoyOE3W27H7Q5vdTSut1kcyUBdh/0qvuoB71TfRPwv6nW
	f5o1WaGvFhQuGDWB0WeKIJw5TIToytIqMw5gzLgc9kG9wwmhFp4sSXhwi44lDpUNlcr86/hxxA=
	=
X-Received: from wmbds9.prod.google.com ([2002:a05:600c:6289:b0:488:c686:2b56])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3552:b0:490:58f4:ba23
 with SMTP id 5b1f17b1804b1-4909c0ea669mr54166795e9.30.1780066953743; Fri, 29
 May 2026 08:02:33 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:04 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=dIgftrvtjy9n7J++AHRmcZhewFAl9rYaD0F4euqeHS8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVd47S5EVE1yUzEILxG4o87+S6v8hxD9hp5NyQ8ruu
 0eqhL90lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkcVGP4X3vEZYrpXP0XPhoq
 LB8n7Xn7w1MyccZGAxbjdtX1WbwLNjL89511yu9VgsV9/ZkbXeb/7X59yD7RKOaQzExH3lUBFrd CeQA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-30-ardb+git@google.com>
Subject: [PATCH v7 13/15] mm: Make empty_zero_page[] const
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Feng Tang <feng.tang@linux.alibaba.com>
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
2.54.0.823.g6e5bcc1fc9-goog

