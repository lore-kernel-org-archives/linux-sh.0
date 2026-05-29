Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71F3F1656
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066940; cv=none; b=Tt1Cod6lyO0UcyJ+nIUQRKnE8ffQHRlXcwat9rv+XK4b1Dq57Be0FN0+aMz5AAbMNwGpcmkg8UAsYivoibfc3YT//rWPr4qX2l39AuQME1cYiv/qfoI4fcC3jwIL3BVgnUDskz+mhcMXLMQWSifWzl9kQge7B4iqVBkKgMTmMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066940; c=relaxed/simple;
	bh=uxAZDqEtvqzwdBVS8pfgqbMrELB3mHJCts2Qh9zIXVc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=itcomy0IiWYCxsISx9gjayjrhBKkrGOEAJa6aXTskagQ287xYyKmfv4jN2gsX/d+vO0f+FV3uKNrcyvNaX70CYIShRLvht3C6uoVyalY+A2w/cwk1S3MDzKENTv2nB3GCU8cD2cx0jq6lrs8fVyvuG+xK0GWKDHkxcO509vS8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxCUe8OF; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxCUe8OF"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bd86cf9d900so1012288466b.2
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066937; x=1780671737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HpQ+gbfLV3ep0KH+7DICYy7iPk4t74I7YHv+Lp6qVhM=;
        b=UxCUe8OFlM4SC6KNkfSCTkM8ZYLHFYhL/U6nQzFPoPdCpxdhElhXpvkaDN17YEPtrd
         P+x3DcPjAFnvaBFHz7CiGHQIE6cwUvqtOd+zbt/iXOk4SvgFMfgkLz6QWSkjy8NWQDzo
         /yUbZ7JmfytaTvn1mP9p0uoyR22dznn+8C4w7fBQoPgvtBMj9frjSkTYmPkePS/Wg7es
         ORSL7TQ5s9W+RnbK+U5XnFsiyfTPYRubn96iAJkyxgdy8S1C8ttqiAdoK9ZOmW7V3FJe
         /qSl1xCclmBOvD0wos3KsHVn2T2eCPfvzsFSyltk66NFVDbdF0CppXzKLb6DhIMJJC+C
         rEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066937; x=1780671737;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpQ+gbfLV3ep0KH+7DICYy7iPk4t74I7YHv+Lp6qVhM=;
        b=EQ22YQ+SLkZotyI/4ko34gOaLpCRI4SWJgwcxf1rHhyDkeoY5/hIXcZ/dFvnFpEyS0
         9Er7Q7rHp3Q3rqps4kTpIvpOcaFWlcOJP6dOURNt/7gw1sXxreuYng7rPmQDpITd9TcS
         KXRFv0oi26/pzog7IGAjm/7jgCI7g33QeGBKZaPiXZWehdji2nKG844cLAFI0Wc6MO9p
         xONJ952/rseJm1xxVF+sOzTZGcD+pT5xdmrIQQnHMTfwATydcmi5+H8vRn/WjwDhRSu8
         1PNelPeIPA5/FVPEojUwXoVaLa0rZrZ8DAN4DOrOauD4vnJ5QWqLxKLaoEQA2P3hHzJw
         zXRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZjjWho9hTpmJXzVjhofbvm2FPUgGE4Ise3S5hIAjiU8RELFZ4UxxJumCCElVaEQlLqDmFKFsQ/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxogEakuPOry84aZylOL1plw+DT1fyWM1hNqnVPvCTTeAiA9pC
	lZ+rCugM1fEB2fzJjSEhAZnacGspA/B6d21C6s0t8Vcbu35yNVlI7V+JDJi7VkRmXdwtJJO+7A=
	=
X-Received: from wrub1.prod.google.com ([2002:a5d:4d81:0:b0:43d:77d4:5f14])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:7945:b0:bce:a1fc:6877
 with SMTP id a640c23a62f3a-be9cad0b276mr172778166b.24.1780066936607; Fri, 29
 May 2026 08:02:16 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6016; i=ardb@kernel.org;
 h=from:subject; bh=1J4/eBxWUzNbzISy66s5wYlPFITBFouUFXFgBmOizGU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVbx/uurJFp+7lxfraxzxO+j8qpt7ylXD8r3Oblc1D
 1q97K/sKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZzcnwPzZyX86SrtObDbx+
 z714VZhZY8c1Kb2LJRHXPl3UVlXMUGL4X+DuW1oyQ1zWb99Z/cx301JrXATZI7vYmbc++evbL/u BEwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-17-ardb+git@google.com>
Subject: [PATCH v7 00/15] arm64: Unmap linear alias of kernel data/bss
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

One of the reasons the lack of randomization of the linear map on arm64
is considered problematic is the fact that bootloaders adhering to the
original arm64 boot protocol (i.e., a substantial fraction of all
Android phones) may place the kernel at the base of DRAM, and therefore
at the base of the non-randomized linear map. This puts a writable alias
of the kernel's data and bss regions at a predictable location, removing
the need for an attacker to guess where KASLR mapped the kernel.

Let's unmap this linear, writable alias entirely, so that knowing the
location of the linear alias does not give write access to the kernel's
data and bss regions.

Changes since v6:
- Improve commits logs and comments
- Add acks from Kevin
- Reorder patches so remapping data/bss R/O occurs after moving the zero
  page into .rodata
- Drop zero page cache flush from SuperH rather than casting away the
  constness
- Map kfence pool with NO_EXEC_MAPPINGS

Note that Sashiko had some comments on patch 15/15 [1] but none of those
seem accurate. (I have tested both suspend/resume and hibernate under
QEMU and both work as expected)

Changes since v5:
- Reorder series in ascending order of impact, so that the first few can
  be merged earlier if desired. This also makes the patch that remaps
  the data/bss linear alias as tagged redundant, which is therefore
  dropped.
- Add patch #3 to address an existing issue spotted by Sashiko
- Fix thinko in contiguous region check (#5), where the whole region
  needs to be considered and not only the first entry (dropped Rb as
  well) - this addresses the kfence issue Sashiko reported on v5 [0]
- Update commit log on #6 to clarify that changing permission bits on
  PTE_CONT entries is safe as long as PTE_CONT itself does not change
- Likewise, drop hunk that adds the PTE_CONT bit to the 'permitted' mask
  in pgattr_change_is_safe(), as changing it is not safe. (#8)
- Move kasan's additional page table to pgdir BSS as well
- Use (NOLOAD) on the .pgdir.bss section so it does not get emitted into
  vmlinux
- Add powerpc and SuperH patches to deal with empty_zero_page[] being
  made const

Changes since v4:
- Update the correct [early] mapping in patch #1
- Make empty_zero_page[] const instead of __ro_after_init
- Drop patches that remap the fixmap page tables r/o for now
- Don't force page mappings for the data/bss linear alias, as it is no
  longer needed for set_memory_valid()
- Add acks

Changes since v3:
- Drop bogus patch adding hierarchical PXN to the fixmap mapping, which
  breaks the KPTI trampoline (thanks to Sashiko)
- Add generic patch to move the empty_zero_page to __ro_after_init, as
  it now lives in generic code.
- Add patches to remap the linear aliases of the fixmap page tables
  read-only too - these live at an a priori known offset in the linear
  map if physical KASLR was omitted, and control a priori known
  addresses in the virtual kernel space.
- Rebase onto v7.1-rc1

Changes since v2:
- Keep bm_pte[] in the region that is remapped r/o or unmapped, as it is
  only manipulated via its kernel alias
- Drop check that prohibits any manipulation of descriptors with the
  CONT bit set
- Add Ryan's ack to a couple of patches
- Rebase onto v7.0-rc4

Changes since v1:
- Put zero page patch at the start of the series
- Tweak __map_memblock() API to respect existing table and contiguous
  mappings, so that the logic to map the kernel alias can be simplified
- Stop abusing the MEMBLOCK_NOMAP flag to initially omit the kernel
  linear alias from the linear map
- Some additional cleanup patches
- Use proper API [set_memory_valid()] to (un)map the linear alias of
  data/bss.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liz Prucka <lizprucka@google.com>
Cc: Seth Jenkins <sethjenkins@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: linux-mm@kvack.org
Cc: linux-hardening@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org

[0] https://sashiko.dev/#/patchset/20260519151616.2557018-15-ardb%2Bgit%40google.com
[1] https://sashiko.dev/#/patchset/20260526175846.2694125-17-ardb%2Bgit%40google.com

Ard Biesheuvel (15):
  arm64: mm: Remove bogus stop condition from map_mem() loop
  arm64: mm: Drop redundant pgd_t* argument from map_mem()
  arm64: mm: Check for pud_/pmd_set_huge() failures on kernel mappings
  arm64: mm: Preserve existing table mappings when mapping DRAM
  arm64: mm: Preserve non-contiguous descriptors when mapping DRAM
  arm64: mm: Permit contiguous descriptors to be manipulated
  arm64: kfence: Avoid NOMAP tricks when mapping the early pool
  arm64: mm: Permit contiguous attribute for preliminary mappings
  arm64: Move fixmap and kasan page tables to end of kernel image
  arm64: mm: Don't abuse memblock NOMAP to check for overlaps
  powerpc/code-patching: Avoid r/w mapping of the zero page
  sh: Drop cache flush of the zero page at boot
  mm: Make empty_zero_page[] const
  arm64: mm: Map the kernel data/bss read-only in the linear map
  arm64: mm: Unmap kernel data/bss entirely from the linear map

 arch/arm64/include/asm/mmu.h     |   2 +
 arch/arm64/include/asm/pgtable.h |   4 +
 arch/arm64/kernel/vmlinux.lds.S  |   8 +-
 arch/arm64/mm/fixmap.c           |   6 +-
 arch/arm64/mm/kasan_init.c       |   2 +-
 arch/arm64/mm/mmu.c              | 164 ++++++++++++--------
 arch/powerpc/lib/code-patching.c |  52 +------
 arch/sh/mm/init.c                |   3 -
 include/linux/pgtable.h          |   2 +-
 mm/mm_init.c                     |   2 +-
 10 files changed, 121 insertions(+), 124 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.823.g6e5bcc1fc9-goog

