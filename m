Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41073FE66D
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066958; cv=none; b=Ja27v708IwLuqdAIupYQ+fTrzFLJ4zbj7JI8qvQ/qetuTCXfX4ZzDEOcVMlsMvQD/csB1g8K00Zm95UM/5cKTWPX8emDy4L6hV3Jf6quHRQ3CGhkRe/VDhiojPFscHt2kiEURsb6U3cJkiL5vTFdXnn4AuE347rTNgMLCi+QU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066958; c=relaxed/simple;
	bh=4ltJ+tnV31+lI4WiO4qNd68D48W9zgCf68aVmdnq5Js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+C/JJaRXJtL3rznqCSXyYkgKWCh0C2MxNHm3gDxPHEmnJyflBFxnnyfEFfzqG+TxIoxJ10U6mAOJBj16CcabLZ9k0Ui27arvPQS3x0qDwaBFd4D0M4WMUQf8k+MgcfBhQUsTVzDzLz5V6gyf7sX6/o9+s4f4oPiemP2RoVmB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Et6lEwzX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Et6lEwzX"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so60809445e9.1
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066955; x=1780671755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUlY0Cb5F8XLpE5JfjwZ+7xlX215FRQLeW3ZifZ4LCc=;
        b=Et6lEwzXaJiFyiCAuNmI5fRp5Ank2ePStfJhoowDd6/MfbLJ6tnnxzrxd9i4ust8d4
         dU3T5syQJUvgDipigYkIu+eyRGC5BVjULmwOFVpeYOUewjD/jAdtk0Ezm6tIsVAVnpHF
         YApK460xg1nZUTF/ChLHCfX6f2aACdKBTdGQLucchxaGZzSTFaSMGCvo8raN6hpJrbM7
         +rTflUGTPnKtwgiblrAqfHRyO8EYcvgSvsdNW0dwdUZ+LLMMbhQrSuTGChzg85DJnnpQ
         w0JuURv+l3nRf3r11I/cvs+VbQ19HmeaonQzYIoZsA29tKcBtm93udbO1GOKzzpL5Mqm
         vDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066955; x=1780671755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUlY0Cb5F8XLpE5JfjwZ+7xlX215FRQLeW3ZifZ4LCc=;
        b=MYTqCsuKeAGbJMF8y4NARkLxE11GVJDJkSRvygnpCZOEmR++/KDXfQWpCXjkMz/PK5
         Gexl6qUCqRaZehBrseATOhbUdJuoClSycGgkzvEJRgq3adobLzr0zI05QrX9q9wso8UY
         WWLaYifA1d/E7B7Rz09A9USto19xwRylQrmHlmuvNdOzgsxfvApDfotkY616j6SxBu2q
         2jzIO1DSv9TcSAfMVESV0eswn2yT3Xn57u424opu+IVHIS2YH3yKSl97WRvXUN7uk/PQ
         XzlUELbi6sa0d41yMXHRIr4sX0lkluAAvnDE1+ehX92YrQc9DdoVIURdZFsq2JSFgdku
         F3sQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qbeNCPZyyuea5jp+HodxoLti2aI42e7QHrEW3XBhE1vFn4IXDMcLaQMemaOv15dDELP6+4EcFtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BIaQsuk8kggsuTuGMS38vr1nPcQ526/9xM8Y6tEyEjNENJAp
	wrQqb50mp8L588uIA3RYvwB35mPCmgF1BYbhpd68jhDpXQd0dGWFeafcGqs13nDGiyWyCJwsqw=
	=
X-Received: from wmte9.prod.google.com ([2002:a05:600c:8b29:b0:48f:de4f:a90])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b13:b0:490:44eb:c1d7
 with SMTP id 5b1f17b1804b1-4909c0f30c7mr58093455e9.30.1780066955148; Fri, 29
 May 2026 08:02:35 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:05 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=ardb@kernel.org;
 h=from:subject; bh=hrcFvMrty6wWPLsRojP9eqDUmoO4ZLfdaegUjBt5TKE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVT7LQrk5StrVnhW9eSm1/NNic7seSLefqruzq2ZDx
 bLLO9w6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQWTmP4Z9y4/eO0WW8mJKrq
 1MW9sj4c8WmpWkn/Y9030oYr+jdxWTH8DxJlLpd0i0/zDFP5wK+8gt14wjNV0eevVH96qbb/sHn BAwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-31-ardb+git@google.com>
Subject: [PATCH v7 14/15] arm64: mm: Map the kernel data/bss read-only in the
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

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dcfca5667e5c..7b18dc2f1721 100644
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
@@ -1173,7 +1175,11 @@ static void __init map_mem(void)
 	 * contents of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
 	 */
-	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
+	__map_memblock(kernel_start, init_begin, pgprot_tagged(PAGE_KERNEL),
+		       flags);
+
+	/* Map the kernel data/bss so it can be remapped later */
+	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
 		       flags);
 
 	/* map all the memory banks */
@@ -1186,6 +1192,11 @@ static void __init map_mem(void)
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
2.54.0.823.g6e5bcc1fc9-goog

