Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DE42848F
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818378; cv=none; b=TZnTVN4LCRwylUXkJ7GCPYbj/qNY8oacuYfhg0PBISkPpxfToC3kGG/cgL3Liedl3c3v2IcM6+R1VuutcWZxzpQWxkbyytXwzvVo2IxKp4KxIbVnz4mkdu/7R7hqBcjiQI2MU59/pdrNoFDtEGpq+WoTbOCxwtPz+XixcQXsvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818378; c=relaxed/simple;
	bh=knJFoS+4h4KHdDV3SxOHBSwzIjeDpJAyubTc8rLv7Hs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RH7mK4feUayL3Tgt0aMRdpXfDf7HdB1WhhoOQuHfadpSBNzxFFfPUmm9gWgtRRNsmWTDVfKR+DqYpyvxK0Pl98gjp+GVuj9r6yEildEx85+incdAXSiOqGBHe41XCUQQibttFUc3yL8LN4sK46Le8V1qE5gwQUuyJfvEuSNzj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+JRnHmB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+JRnHmB"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fe40b61a3so70767495e9.3
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818375; x=1780423175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hN7dKQgvYd9nbZsuBceB/G3FfRSci9s4lIdLcy6NsRQ=;
        b=e+JRnHmBuZ7l0QZ2mEHqmd8YODMGS/hrtWHFgQQ/C8IXTVspbdhSvPlZEFrQlFUwpQ
         ZbPZg0FTIBMUkcb/0Io8nrieOGlEhbYSbx/feepu7UYU80dmyIcdJvOJnKJ6X3sMpOan
         /UwlGWH7WxFgWj/nBPL4E8T6r0ylMfkgQe4OL0HuHg4oR9zVGj04uY8UZwhgr7K0R/AH
         AMhpkZ3gTmotAflnya1cIKDiSKZf408LBWxHDedDShP19AzEhJ7zBkftuEErHm6eLDAP
         jBY3XXGObk5Ps+qHKoIy9iM6NvuWBIKXr3dSAMzUxVf72U+zY4qWqKAH/u/+n3WXOUT4
         CyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818375; x=1780423175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN7dKQgvYd9nbZsuBceB/G3FfRSci9s4lIdLcy6NsRQ=;
        b=ShnlIRmWN1f7RHm+a6A0WPuVRXYkVSuM0rgjPnw4uU+KuTfsmSZy5Ccypo3ZU8lIBy
         mQPjsMA7Y8AsLQptflLODkAFeAre0+mbLHDrM929T94gwDgxjXJlni8FLwkAb0Moype6
         HTPcwBV77zewPEdcIzu+fnqlBXRpTQ+GCE0TUL2OBar080Wq5Kyox0MMOs4egNbHzB5v
         H2uWihuN7eqh6AMcY8A/ZakpIWiPWmR3Ns5/tI9cKZirNch2ROqakaaIQNWUHsVhZHqv
         zAOFVUCKoVqCAaPVKukli07xOVPR+Ip3SjeP5/GCTd1PiDPKRT6TuzwpfflhPC82MyTU
         XjDg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZbuFwjyde30pZz27ZlxuU3m4K3UpYSDhRl4RRNr5o4Xq/i64gLZOo8qx8E9tXUPDuNQWolbH1hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsL+eac/Wpm+KCXbhpe7CZBH6WAasahVlVmU/zIfMRy2L1blA
	RB6RA1KdozaCPMuCQYD0frfrhRUQTYyW942qw841QGRY4ciOFM0J/K0TTJUjorddQBdTQ0NJEg=
	=
X-Received: from wmrk9.prod.google.com ([2002:a05:600c:b49:b0:490:7e29:9cea])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a402:b0:490:3f7a:108b
 with SMTP id 5b1f17b1804b1-490426c5be8mr278139655e9.16.1779818375139; Tue, 26
 May 2026 10:59:35 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:58 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=ardb@kernel.org;
 h=from:subject; bh=bcrl0Dq8YQBZ2y6oSLTxv/uZS/MgfYTkD9gOirfShVU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fppn5XvTONsranx8M7mVQs+XJQdo2RuuSWq7JaMf9
 7fh7PqOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJEXcowMtw6WZR/exrN7YplZ
 UMhusfI9n1W/fnxWF5Br8bb/o5j6XUaG9kh5ycXzfXi7yhR03u2bYfF33raUQN5POWLfbh9Jdln ECgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-28-ardb+git@google.com>
Subject: [PATCH v6 11/15] arm64: mm: Map the kernel data/bss read-only in the
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

On systems where the bootloader adheres to the original arm64 boot
protocol, the placement of the kernel in the physical address space is
highly predictable, and this makes the placement of its linear alias in
the kernel virtual address space equally predictable, given the lack of
randomization of the linear map.

The linear aliases of the kernel text and rodata regions are already
mapped read-only, but the kernel data and bss are mapped read-write in
this region. This is not needed, so map them read-only as well.

Note that the statically allocated kernel page tables do need to be
modifiable via the linear map, so leave these mapped read-write.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b20c76b8381d..e7ca53d20b87 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1138,7 +1138,9 @@ static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
-	phys_addr_t kernel_end = __pa_symbol(__init_begin);
+	phys_addr_t init_begin = __pa_symbol(__init_begin);
+	phys_addr_t init_end = __pa_symbol(__init_end);
+	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
 	phys_addr_t start, end;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
@@ -1171,7 +1173,11 @@ static void __init map_mem(void)
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
 	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, flags);
+	__map_memblock(kernel_start, init_begin, PAGE_KERNEL, flags);
+
+	/* Map the kernel data/bss so it can be remapped later */
+	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
+		       flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1183,6 +1189,11 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
+
+	/* Map the kernel data/bss read-only in the linear map */
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
+	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
+			       (unsigned long)lm_alias(__bss_stop));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.794.g4f17f83d09-goog

