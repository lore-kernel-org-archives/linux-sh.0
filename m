Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F643F88BE
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066953; cv=none; b=EFgcrMCArE/5lhDQ9+haDLaEz3K7hICQEFB28JSdShlnN85XVgAdtWdMWUfxfzAY/OSx0lK0JBbyFDUL19jVRAWKezycqHt32uK7iFe74lYKIbHSdlZOhcTmuZdpWKMlQfMmlezU4xR4OeW/0ux/IEhnTGo/dWJ2ssuVPOKJ8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066953; c=relaxed/simple;
	bh=zUEDMcVLVWzw+LdeWwMF4VUJNwnJA7d0jtfgZ6DhRzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koUiyHnmG/6B4fGLH45+9ZvbbsEHtDZ47HsXjcmn0P8YlkhS4lsDO4uJkPqeqz/0oFKP891dmGpt1mDgBdvu6HseGUjS9wYmJ+nEkfx2/shpsQgOZPohdHNEKyo/qeusgeuXQYf52RhDVmPH41xjSMrQITDRXKou8IM/IGKadcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i73bJGK9; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i73bJGK9"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bd9b5ebb302so212279666b.2
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066950; x=1780671750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI2PiSwVSqs1DMfWl+ZXR2POFOtjIsRCGzcVsnmPBAE=;
        b=i73bJGK9+4ZAcWgJ6T868+xurYWh+/3YHlKi/XwaEyj+yXrdVBrwaHEz1ABmNzu4rv
         MSBlYFSaRE6Ln+nLu/bH55vEt8mcP4lmwLGiT/koarURRddTk0TJA8tNfthOM0saAH2h
         Wt8oWORAbEULXuHmGPkMcPdf3Hg28qN/Kbi+43DOMguS2dcVmRa3KnhJC5L78N6aRevH
         qduIXor2Bi7u0SuiFM64qjq7sZcbf1hGBNiAsAzbQd/uyaQ7DSL9rQx5buy6Hrwz8Dl7
         g+xqvSAvsaKRTG27SmgEcSOD2JitTixITL1XZ7wiSQtcob2cE9j1oruCC52ENdWFZQSg
         xdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066950; x=1780671750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OI2PiSwVSqs1DMfWl+ZXR2POFOtjIsRCGzcVsnmPBAE=;
        b=sqnTcB9DLjy/heM1c+iaBozwLs9dav/9URN0FfqNf5OLhpSkTKKuHUDpK3gGrBIq7h
         UYgsEiqxJnWbvs786r0qmYngGM7E4Y4QsdImLE1rqD6GSSo9UwFd+6CbkJxlEzBiunLe
         /jX2Tljj5TI64y3Cs2Sb2+FAm1hcdDC+IMDF3Sdi8uElD3Sc/F2iUAgpVB+zWO30vEvm
         TIgswKjHv6IYJVq69CkY2Xnb9LRdubraa9njPPKyxeMW7ocNZnGnTLJuEQxO/SK905Ef
         Qnn7ex9ZLkNupOt+ldYviDCwhOTjI37euEMO+1MetajzOwdODyq6m2xrHP6gKLmKM3AO
         e3mA==
X-Forwarded-Encrypted: i=1; AFNElJ9XU2Wz4xMF4VR5pVBYi/xbW8zxJpuaj5rzXLbwQZF7TaLeApPFS5JcVMEQ6JOTpBihU26DefYZcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEflauo8YAPUbsB+1tbxV1l94XC001Sxx2eZ+55OPrfs6V3TkA
	qNL0gTd/tflfgTpY96UVj4+jHDbqU2+tx8xDNIh1pCNSddwTlnNg+5ymn0zk06UcbVGDdjkA6g=
	=
X-Received: from wrmg9.prod.google.com ([2002:adf:e409:0:b0:45e:f392:2777])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:a07:b0:bd5:2e64:aef0
 with SMTP id a640c23a62f3a-be9cbdc6f6fmr179513966b.24.1780066949175; Fri, 29
 May 2026 08:02:29 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:01 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652; i=ardb@kernel.org;
 h=from:subject; bh=LBsPwtXISC3cDlPuViRIHN1SKeCiNO3w0g/LYP90bWk=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGoZqmug957hRslXLEFSHUmrg+wMpqdQu/ZaCQ6ZVNlpR/e6R
 Yh1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmoZqmsACgkQMG4JVi59LVw9CgD+Kz5r
 yC92Fjmy2/vY5E6VGL4/Nm1StvBfLlgn5WtMnkABAJz+h8RdmiKW2M9JyTSGnfE2SIklxmyurX5 hqMMXobkC
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-27-ardb+git@google.com>
Subject: [PATCH v7 10/15] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
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

Now that the linear region mapping routines respect existing table
mappings and contiguous block and page mappings, it is no longer needed
to fiddle with the memblock tables to set and clear the NOMAP attribute
in order to omit text and rodata when creating the linear map.

Instead, map the kernel text and rodata alias first with the desired
initial attributes and granularity, so that the loop iterating over the
memblocks will not remap it in a manner that prevents it from being
remapped with updated attributes later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 26 ++++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 971996e46fd1..dcfca5667e5c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1164,12 +1164,17 @@ static void __init map_mem(void)
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
-	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
-	 * So temporarily mark them as NOMAP to skip mappings in
-	 * the following for-loop
+	 * Map the linear alias of the [_text, __init_begin) interval first
+	 * so that its write permissions can be removed later without the need
+	 * to split any block mappings created by the loop below.
+	 *
+	 * Write permissions are needed for alternatives patching, and will be
+	 * removed later by mark_linear_text_alias_ro() above. This makes the
+	 * contents of the region accessible to subsystems such as hibernate,
+	 * but protects it from inadvertent modification or execution.
 	 */
-	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
+		       flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1181,17 +1186,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/*
-	 * Map the linear alias of the [_text, __init_begin) interval
-	 * as non-executable now, and remove the write permission in
-	 * mark_linear_text_alias_ro() below (which will be called after
-	 * alternative patching has completed). This makes the contents
-	 * of the region accessible to subsystems such as hibernate,
-	 * but protects it from inadvertent modification or execution.
-	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

