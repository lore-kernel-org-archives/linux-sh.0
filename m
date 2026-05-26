Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86263AEF33
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818363; cv=none; b=qLRYHs746d09CeFpZRkVHiNMq03RDPPHOcvVEhAnKnc0HfgnC3HeXcJxdLl3xXTnX3Xt3BM0coosePyV3uJRj69ViUDnIbCc5TYthFNVOEjt196R+KHOwFhkNa8hUhoq1g79/KQ8ZiDDnW0WiNUdiMQrNyM6tpsJdvqMQfQwbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818363; c=relaxed/simple;
	bh=b10fy8VHjPYf1Gmq3LBWP4fHcyKTtOP6xQReBkpFN+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aXg7YV494dZ3hKgoFdxnWBT+zkzgtHmSMOnJbsggSBG/VapEMuIklFJQvgs9crxGgE3yfKhj7S1rPilnUCTXU/m1gCSTDn2nuomtifOcLDFZ1PxwXU7GQyMYQ4Aicwv2bl48r62GpReIJdwexq9JkM86b/gPeBEUocXhWIvrtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdJi/Hbw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdJi/Hbw"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49045243094so63727605e9.2
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818360; x=1780423160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0vWMvJYNWuq9BUtLKfBugHf8I5ifX5auG02Ilaszzw=;
        b=tdJi/Hbw0nUyM7/tatgnCffhOgQ3vI34vXawTfxg6SEWjUdsc2omEBeyNg01NehDux
         G/a3vmhlSuDbQJ7pD18Uutk0b8iDKuOC8Rh7XQPDfsJI9ez+giNGLn3OX3g+bpjRdlFd
         TPoarbPv/qltD5niIQ041rAG099cJwL0JQAiVkfKH+WWG/rwvmEjeUtJGnlfUOrRtbkG
         RvLWKZsen8sBmBW6EpFYp5Jqk9ZtWWSuXKCwKnU/R2DjsTZ355HFdUc8UBpONgCIejCH
         RKqZy5LjccwfJ1GUFb4w6twrSHWYhm1feIzbxJtsga1gRCjqTfufxdvvTZZiE5Zu5y5s
         swvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818360; x=1780423160;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0vWMvJYNWuq9BUtLKfBugHf8I5ifX5auG02Ilaszzw=;
        b=XowZ4cdM54AVmaK9YDA81wXAdZ03jY/wHMv4pMpzRmP2qPsfc9Sgn8sjsNEGnWpFGk
         hksrKeBIahKezkyss8VjgVfZCnFfYP5gTLuORLW3Xb60Asl6lcInu4/o6AmcSOQ/9/r3
         rEE51ln8JHpVecG3N1qHP2HCJjl/koRLIAWtlxMjhfQm4cpcWvUb3qqCGAMAx0XE9cHw
         GknfmS2icWlSKSDxfrPu5nWRFTKii5KBzxVoig9IxSgVDIGbhI8BJ7GLoOt/3zcyUvqg
         QQHBM84Ti38Ejc5mG2kNGEHKiW9CyXIddQG95l5i7JgB1ZEcDy4PZZTF/9JgnfpWOqcT
         Q4Dg==
X-Forwarded-Encrypted: i=1; AFNElJ/NgrVfS/FrATnEH8gzEuz1axet+dKSBMpnfrukZ0HC1WIzXoAYo/BiD8MSf6CQ42gmdbnCc91ijA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9Gwccb9ghFX8jbLGRKSITIsqS8aTBlYtk3fFV0yoR0oTjJWZ
	zjupNbRt2JKNaL4Nk1mRPrna5ZZw/gEIEapzxbhabkRskHGCU6Zi3CDX6cQhPqVbMzCKf+oyzA=
	=
X-Received: from wmbfj10.prod.google.com ([2002:a05:600c:c8a:b0:489:1f67:5a81])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3581:b0:490:482c:4391
 with SMTP id 5b1f17b1804b1-490482c4586mr347539725e9.23.1779818360071; Tue, 26
 May 2026 10:59:20 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:47 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5484; i=ardb@kernel.org;
 h=from:subject; bh=U8803ZhDPt8GJ8Atx6VTFHHmARjJ+nX3UDhXHVYH9xo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0frj6sbw7T/xOHgou4E0vMGDKO3VgAmdWo+XnCVG6T
 1oEOto7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERU7jL8L1Z3r3IPnBwlZzZh
 j9LEyREPWzJrNh55n6V8I1KW299LiZHhyvMT6w/KRn2cG6r8u+luO6dv1+6fH92Tg3pK51buVHT gBAA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-17-ardb+git@google.com>
Subject: [PATCH v6 00/15] arm64: Unmap linear alias of kernel data/bss
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
Cc; Kevin Brodsky <kevin.brodsky@arm.com>
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
  arm64: mm: Map the kernel data/bss read-only in the linear map
  powerpc/code-patching: Avoid r/w mapping of the zero page
  sh: cast away constness from the zero page when flushing it from the
    cache
  mm: Make empty_zero_page[] const
  arm64: mm: Unmap kernel data/bss entirely from the linear map

 arch/arm64/include/asm/mmu.h     |   2 +
 arch/arm64/include/asm/pgtable.h |   4 +
 arch/arm64/kernel/vmlinux.lds.S  |   8 +-
 arch/arm64/mm/fixmap.c           |   6 +-
 arch/arm64/mm/kasan_init.c       |   2 +-
 arch/arm64/mm/mmu.c              | 153 ++++++++++++--------
 arch/powerpc/lib/code-patching.c |  52 +------
 arch/sh/mm/init.c                |   2 +-
 include/linux/pgtable.h          |   2 +-
 mm/mm_init.c                     |   2 +-
 10 files changed, 111 insertions(+), 122 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.794.g4f17f83d09-goog

