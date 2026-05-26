Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D442B753
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818383; cv=none; b=NFEHkhsATQjtob7pTHz5QxLYq9mOsziu6HPySS5QbEGXDrmdLuEPNq+ISAMxfY28oaLEk2/8T8ZC1FGz3gOy4RbV/xM73B2kHAfhQ5WtQNPGA4uU5a6abI7CUAO7VjVyA9DVC0CogcXx/8K1bAZs9sMlE8ysA5PL0y6QTi0olTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818383; c=relaxed/simple;
	bh=Bix0lMESrdQfOPiyFEdbITdZ4dbSHfscFezrIl5cdik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=blNVFyWeYk9kJpJYD3qam4sulr8A1zMvYC7BmzBJXwuQAtdKymP5DVjb2FtynwvMpsxYuJlhGsPnQysKSRTVqON2Cs9dPq9dkBYsgEKHHY4ptCt44o2LFQ3woRZCH2LGlkJsIEWUJnWtTsdZpR7NLm4y6ZAo9w93zcG8Mrfxh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usXleILj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usXleILj"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fd3dbd16aso89652575e9.0
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818380; x=1780423180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YW83U9WXzmuOgO+qiU2xntn4xO4oQspRqeeRLd3+Ago=;
        b=usXleILjLezU0hyAGD3fJPqWLRDq5Ip5L8meUtXpx5eLoRlJ+tAmp2bGGxRENJ4xI8
         a0hcBSKQl8oohcCv1jpOdCuFs3u+LUw5RrhkKfj8Vo7e4SiWQUA/JzAVjpQRK4lprQnM
         5TaH0GJ0yfFLPIPfYK3wmevq6mJ+65ZUeRHOfI5A7bheezvA/boKTUrrDq9RBcxuxAqz
         ytasL4wIcEsxfZvZ4aqWe0xMTk0RleO8RlAqmu9kXPi62H29SPCNTaaDBL0vHmRL6wJF
         T5B/K0XFJGbV/MTjt9obPJcdhag/t0CjlmvepOyDzfWp2w1Ang7uTYDb0EGVfDiW3LvW
         xzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818380; x=1780423180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YW83U9WXzmuOgO+qiU2xntn4xO4oQspRqeeRLd3+Ago=;
        b=W6WcEmnV6kbK8q/fwbxklRrVbz9zyoQ/mDM1M06KFKB2idHDHOdkomE7Pmp9lYELHP
         OGhCKvwMADS5q0ueNHumzbM6wrczc5s3r+McS7B1bBIbVSrhcLTStByuXy0hVKBx5asD
         83S4aF3DyUQ0EnNxyTRDeXA801Kdrk9DDCAiw8oiu+s47T2VeavYwDLujTSypsNExkqw
         Jcrzf1m8pjOXEAUurV+OdDOiQ651cuGJrDV9fSQ8OUPafsZam3O1giYZqVIpO/WvxWIm
         T1FdaCB5CtazxfdGqIt5X7oXDG4GBFZ5Z68tnql3gJheHWqlyKX9L/Nfkbv7QI9GQYXJ
         cVMw==
X-Forwarded-Encrypted: i=1; AFNElJ9atqaNYPUlYz79qNQ6LhB5OLAS8Ry38Xn0iHTyCNC4VCXQyBuogokVmy4ZH8KWdcZSViPsEnZ1fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzghJSW0eMJH8gU3jAvuolznIex+XSafOC9ny4g4XFMx07lEl63
	kuMRjNTIZH5IAWfMgr2tLB0LmyAnon00NYLdCjU/wBHcKrBGYa/EsFd2HJ4WFdi5AS+3axUb7w=
	=
X-Received: from wmbet15.prod.google.com ([2002:a05:600c:818f:b0:490:3dc3:e5bb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c4a1:b0:490:3fd9:e78b
 with SMTP id 5b1f17b1804b1-490426cef8bmr337552265e9.17.1779818379722; Tue, 26
 May 2026 10:59:39 -0700 (PDT)
Date: Tue, 26 May 2026 19:59:02 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; i=ardb@kernel.org;
 h=from:subject; bh=yy+qAKwWsZGAcScio201064FyPP//0qmouvkE8IJvkQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fnaITtnLMqdFLhxOPsKdSl/fzf8vyMu45VaardtDA
 beLD6d2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInYcDP8lc9eXJtj5vLqXm5w
 sP0Cd7YzPcsCnzf0M7wXrV0bcOh0CsN/58OffBc4fZ3FmC48Z1Xn1KPu098u1d/xmnenxq61z05 +ZQEA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-32-ardb+git@google.com>
Subject: [PATCH v6 15/15] arm64: mm: Unmap kernel data/bss entirely from the
 linear map
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

The linear aliases of the kernel text and rodata are mapped read-only in
the linear map as well. Given that the contents of these regions are
mostly identical to the version in the loadable image, mapping them
read-only and leaving their contents visible is a reasonable hardening
measure.

Data and bss, however, are now also mapped read-only but the contents of
these regions are more likely to contain data that we'd rather not leak.
So let's unmap these entirely in the linear map when the kernel is
running normally.

When going into hibernation or waking up from it, these regions need to
be mapped, so map the region initially, and toggle the valid bit so
map/unmap the region as needed. (While the hibernation snapshot logic
seems able to map inaccessible pages as needed, it currently disregards
non-present pages entirely.)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 39 +++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e7ca53d20b87..cb00e42abbe1 100644
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
 
+static void remap_linear_data_alias(bool unmap)
+{
+	set_memory_valid((unsigned long)lm_alias(__init_end),
+			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
+			 !unmap);
+}
+
+static int arm64_hibernate_pm_notify(struct notifier_block *nb,
+				     unsigned long mode, void *unused)
+{
+	switch (mode) {
+	default:
+		break;
+	case PM_POST_HIBERNATION:
+		remap_linear_data_alias(true);
+		break;
+	case PM_HIBERNATION_PREPARE:
+		remap_linear_data_alias(false);
+		break;
+	}
+	return 0;
+}
+
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
@@ -1064,6 +1088,16 @@ void __init mark_linear_text_alias_ro(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
+
+	remap_linear_data_alias(true);
+
+	if (IS_ENABLED(CONFIG_HIBERNATION)) {
+		static struct notifier_block nb = {
+			.notifier_call = arm64_hibernate_pm_notify
+		};
+
+		register_pm_notifier(&nb);
+	}
 }
 
 #ifdef CONFIG_KFENCE
@@ -1189,11 +1223,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/* Map the kernel data/bss read-only in the linear map */
-	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
-	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
-			       (unsigned long)lm_alias(__bss_stop));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.794.g4f17f83d09-goog

