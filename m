Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067893FF8A5
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066959; cv=none; b=AF49cIdIDQI4VJmthiTIF3JXRxz5WrXomAV0i1xLh2RrwYAaRR4fAhp3zRBSRqNwgeOhSBluVM/ywuIqP0CBUZR6w7E+9enahP6JMyF8e5ItRgzH1QO/t/zl6ZI34xxTUoJ1mYLLj2UxU8ahWKx5dVV7l5UNQd9QxZrj5OC/E3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066959; c=relaxed/simple;
	bh=wk/GXhyQgaR0CIaJVu8tmQnleFEAH/nc1GEBzpfXZ3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u7sDGdTFLicUzp0ix94OSsbJWV/ORibeDexZtw9sG+Tq1l03w9KdlIo/y4HEOZcspUbWn2xrZ8MEpnmxApeMIlGWUIu3nyfV1Jo8H9ZCaDiAKnMzaAMutuKRG0MqMepaq/KR+ZuHbZlUfld67b8GGDC3wUtmfiTQ1JUVa0qNQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gU4m+XxN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gU4m+XxN"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so60809565e9.1
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066956; x=1780671756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQKx64xQcW6ZDY2ZWUkqEvIbYSGgY2Fsos5YN6YfoOU=;
        b=gU4m+XxNynAKLwkB+53YrtWiImthrECP9W2VAJTeQV42+ip7ww8TMgZloFXFdqJHGF
         iBbfs2gMGoHC4XEuba8QN0qLLzi9E2KUAi80dhGGZsxbbRFSY+VxvXAVbYO/wv70a8Cx
         R58nSzLDIZn/XSgHygaZNuOLbsGlGCkprRZ+k4MZsSRZOrKyxgqpDs+iTn/z4v0ab0R6
         S3aOi3GMRRJbvYFMHyvfOuax06jJDrLFFnNFNLMT8CeBFzp73iB8uazV53OtKuKB6xqk
         cDErSkOSfpCeEvyP3yz/iAHwQm8QtmYsG4OP1KPPG7iy+Pwk/PQujWMmWU4I5RoaUPcH
         O0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066956; x=1780671756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQKx64xQcW6ZDY2ZWUkqEvIbYSGgY2Fsos5YN6YfoOU=;
        b=On/pUgE9abFElB6SKs1jQ6RcbXS8V9HemE8ug9TqX/iP7I0A2mmK+r993+kx6zatH5
         vu5PS8Wou/ZzcYVbTJ/BSuSqqA2u+uN1gVwE6NNcz/c1nlG0gv+1Qa3kdAgh9mG4vLDB
         yl0xf1tlUPaicSNlh0KmDe2Q7a/myWM5FY81ZlNOcxWtK0mclxxNbNKMFm7SwhI9KMxP
         6cRiL/qpkgOWVPUxproFSwIvri0/XhPLV58FWuvWd7vJfWjE23NqYbEJPqsgUtr8eBEX
         1XXwySj3ZFGFKc8Ejcd0/MHeYE3PEmGmBNDJUJ8+lC26hRBP6t/d0ExPinzaLQHTvCAh
         s06w==
X-Forwarded-Encrypted: i=1; AFNElJ+YhBgnfn5ZuFAjAqoZUPR7GEjLOWRpoRyYJEO2VKeJqv9nFUIE42wCmzSTB5vjLObw/Fw+BCb+/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJqOQvwPXz4awESbW5kRMYRWNv0DCXYpm9YI2ILPd7fQQHOyI
	Ft8YuP+3YpY1VsE2MXkKwJp7fE6qb+b/r21KneLnTNH29UeZy0IvCV/fF7T1Zs3Z+ww9Se95MQ=
	=
X-Received: from wmbez9.prod.google.com ([2002:a05:600c:83c9:b0:48f:e3fc:d858])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fd6:b0:490:5655:8d3f
 with SMTP id 5b1f17b1804b1-4909c0ed167mr56446625e9.28.1780066956218; Fri, 29
 May 2026 08:02:36 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:06 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3406; i=ardb@kernel.org;
 h=from:subject; bh=XSavLFKj4RYiFTOsx9dpbIASgaMnJejevEPNl4lZqhM=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGoZqnCghcJA5fPW2Z72X9X37eu+fqYYMOTvKUc5VemCkE+q7
 oh1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmoZqnAACgkQMG4JVi59LVy8pQEA6HlB
 3WUW3N8HA9+DidOWBYQI1frKFGwVYEQ7O27c8DUBAJEH2JVQ9ldiz63/YvZsdSlPfdvNDLvL7Jf SNW10NGsD
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-32-ardb+git@google.com>
Subject: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from the
 linear map
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

The linear aliases of the kernel text and rodata are also mapped
read-only in the linear map. Given that the contents of these regions
are mostly identical to the version in the loadable image, mapping them
read-only and leaving their contents visible is a reasonable hardening
measure.

Data and bss, however, are now also mapped read-only but the contents of
these regions are more likely to contain data that we'd rather not leak.
So let's unmap these entirely in the linear map when the kernel is
running normally.

When going into hibernation or waking up from it, these regions need to
be mapped, so map the region initially, and toggle the valid bit so
map/unmap the region as needed.

Doing so is required because pages covering the kernel image are marked
as PageReserved, and therefore disregarded for snapshotting by the
hibernate logic unless they are mapped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 45 ++++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7b18dc2f1721..07a6fa210171 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/suspend.h>
 #include <linux/kfence.h>
 #include <linux/pkeys.h>
 #include <linux/mm_inline.h>
@@ -1056,6 +1057,29 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
 				 end - start, prot, early_pgtable_alloc, flags);
 }
 
+static void mark_linear_data_alias_valid(bool valid)
+{
+	set_memory_valid((unsigned long)lm_alias(__init_end),
+			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
+			 valid);
+}
+
+static int arm64_hibernate_pm_notify(struct notifier_block *nb,
+				     unsigned long mode, void *unused)
+{
+	switch (mode) {
+	default:
+		break;
+	case PM_POST_HIBERNATION:
+		mark_linear_data_alias_valid(false);
+		break;
+	case PM_HIBERNATION_PREPARE:
+		mark_linear_data_alias_valid(true);
+		break;
+	}
+	return 0;
+}
+
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
@@ -1064,6 +1088,21 @@ void __init mark_linear_text_alias_ro(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
+
+	/*
+	 * Register a PM notifier to remap the linear alias of data/bss as
+	 * valid read-only before hibernation. This is needed because the
+	 * snapshot logic disregards PageReserved pages (such as the ones
+	 * covering the kernel image) unless they are mapped in the linear
+	 * map.
+	 */
+	if (IS_ENABLED(CONFIG_HIBERNATION)) {
+		static struct notifier_block nb = {
+			.notifier_call = arm64_hibernate_pm_notify
+		};
+
+		register_pm_notifier(&nb);
+	}
 }
 
 #ifdef CONFIG_KFENCE
@@ -1193,10 +1232,8 @@ static void __init map_mem(void)
 			       flags);
 	}
 
-	/* Map the kernel data/bss read-only in the linear map */
-	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
-	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
-			       (unsigned long)lm_alias(__bss_stop));
+	/* Map the kernel data/bss as invalid in the linear map */
+	mark_linear_data_alias_valid(false);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

