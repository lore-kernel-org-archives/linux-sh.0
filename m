Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB321F2C42
	for <linux-sh@vger.kernel.org>; Wed, 11 Dec 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959681; cv=none; b=T0gLgNF7/N6e4P/bv6mohcTo4TYBJrtK6PI1a98wO2tmYFNLOs2Oc+50nrAxxx9AenXemQgiezJPjFKbvXh+rocosx2tf7A8mmevBhcYAu9n7Xn4APOW7gHYFfkzGQJbv5duXMiUNgsG2L6/8gJ8GqlVTE43VvauhihpZ5jy4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959681; c=relaxed/simple;
	bh=tkYUgsJNBXav1rnN7mRsWNxCkvx1+/sVfFghfRuojcE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tWMUjWioRd1BPKLfCjVYLa60E5vgzoAedjrjtPBnMrgwin1ViGfr5t/flMKrpO2drtq0vvZn6TiGKqfUi89D7K9eX1WK3UkEyRluR8u2RfizuOJhbep1UsPWP6tOk0XM4f/korIVhLOHJTjXtBz7owHj6ltyshLPel71ySy44os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iU7GxywT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iU7GxywT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso18909a91.1
        for <linux-sh@vger.kernel.org>; Wed, 11 Dec 2024 15:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959678; x=1734564478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Y13tezS9osfEyeZZhDu0hB4QwVrkWFM3vdAGWXDL0s=;
        b=iU7GxywTPRhv00BP/fgEg0NmrmdoZvsb18J0qNknuA9FMsK90V2SUmf3EHvcZEMqxJ
         2K0leJKkuL/h0g5LyguBhaAzdCwf/ixV35hU2N28UlRo3iDCexPyZJlZ8ADVsUbzQdSu
         36f6fBihpDkgrvms7FyRKG90XrZdvglESUBx38od50WwLvZKwzAq1mdoFtMhJK5InUC2
         2maZR+72rUQpReNpLsRqs44RtGvHjZvqOxXIt3BomWgB01Pu7FsM0OeM7kooK/j+MkHg
         7sUfGhlRaKTjZr3YSiu0HnafSMsqeck/TWmmYHeBvKSEXWEpIpYD65lm/dCdHhJMAwbD
         3fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959678; x=1734564478;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Y13tezS9osfEyeZZhDu0hB4QwVrkWFM3vdAGWXDL0s=;
        b=eVEGasOWpeACxc1PXFIYAZd4R4sZKMu33pZ6SQ682w0cjLl+w4ABGgpCIcLg35oF1E
         NUw0/XJRJRii3YpEW/XIZw4PSRNafk8UCJqjuN5UxXRTC2xYZ1TvXTA1OqHAUym0sAkm
         NF942X6sHMASx1aed8wuc83gmU5i0ThMyD0tYrZD2sMkdNer99nJaWsliBbXmlMat7GG
         jPCu8KAJ0XOeBg1PCMuB5nrz9yYj74LtWCkz+WFQ2na8etun2J76gY5ntxY6kv1tkto+
         6taHQ315MWXK/DJUrP4/x5iLVhyuEGyhBfCtldClTHpI32TDyBHNbdKFNOokmXkbifP8
         f8OA==
X-Forwarded-Encrypted: i=1; AJvYcCWUKtTdLAIxB+rNmzhJwBg8/JOBFm24zAQgQnY4SJuzh6Pl76id9xrBXdFw7Z+XUrVlILGMbcZNrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqAprYBjIDRuNTsDgCGskONaXdIHHX1qA0ho4dIHaAEhTlYwM
	ptrBPBQBjP4JI7t876e3vS7JXDste/Om841dGUH+rqA3x7bZq95JT2rYONbZsAQ6gmuq88IU2W4
	hQR7AeTveZlfhDEb4gx742Q==
X-Google-Smtp-Source: AGHT+IH+hxwnbTejsd5rMe6ZdiiLsQVYXh76CpSNZ1O0EO7ZME4Z+uiov/c6u6U8sBeYTnWqfHb7LFZNMZjeMUedcw==
X-Received: from pjj11.prod.google.com ([2002:a17:90b:554b:b0:2ef:9866:6155])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f81:b0:2e2:c2b0:d03e with SMTP id 98e67ed59e1d1-2f13abc6e43mr1624666a91.5.1733959677870;
 Wed, 11 Dec 2024 15:27:57 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:38 -0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-1-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 00/16] mm: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, minchan@kernel.org, jyescas@google.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

This is v2 othe the arch_mmap_hint() series.

Changes in v2:
  - MAP_FIXED case is also handled in arch_mmap_hint() since this is just a
    special case of the hint addr being "enforced", per Yang Shi.
  - Consolidate most of the error handling in arch_mmap_hint().
  - Patch 16 ("mm: Fallback to generic_mmap_hint()") was folded into
    Patch 2 ("mm: x86: Introduce arch_mmap_hint()")

v1: https://lore.kernel.org/r/20241210024119.2488608-1-kaleshsingh@google.com/

=======

This series introduces arch_mmap_hint() to handle allocating VA space
for the hint address.

Patches 1-16 introduce this new helper and Patch 17 uses it to fix the
issue of mmap hint being ignored in some cases due to THP alignment [1]

[1] https://lore.kernel.org/r/20241118214650.3667577-1-kaleshsingh@google.com/

Thanks,
Kalesh


Kalesh Singh (16):
  mm: Introduce generic_mmap_hint()
  mm: x86: Introduce arch_mmap_hint()
  mm: arm: Introduce arch_mmap_hint()
  mm: alpha: Introduce arch_mmap_hint()
  mm: arc: Use generic_mmap_hint()
  mm: csky: Introduce arch_mmap_hint()
  mm: loongarch: Introduce arch_mmap_hint()
  mm: mips: Introduce arch_align_mmap_hint()
  mm: parisc: Introduce arch_align_mmap_hint()
  mm: s390: Use generic_mmap_hint()
  mm: sh: Introduce arch_mmap_hint()
  mm: sparc32: Introduce arch_mmap_hint()
  mm: sparc64: Introduce arch_mmap_hint()
  mm: xtensa: Introduce arch_mmap_hint()
  mm: powerpc: Introduce arch_mmap_hint()
  mm: Respect mmap hint before THP alignment if allocation is possible

 arch/alpha/include/asm/pgtable.h           |   1 +
 arch/alpha/kernel/osf_sys.c                |  31 +++---
 arch/arc/include/asm/pgtable.h             |   1 +
 arch/arc/mm/mmap.c                         |  43 +++++----
 arch/arm/include/asm/pgtable.h             |   1 +
 arch/arm/mm/mmap.c                         | 107 +++++++++------------
 arch/csky/abiv1/inc/abi/pgtable-bits.h     |   1 +
 arch/csky/abiv1/mmap.c                     |  68 +++++++------
 arch/loongarch/include/asm/pgtable.h       |   1 +
 arch/loongarch/mm/mmap.c                   |  49 +++++-----
 arch/mips/include/asm/pgtable.h            |   1 +
 arch/mips/mm/mmap.c                        |  50 +++++-----
 arch/parisc/include/asm/pgtable.h          |   1 +
 arch/parisc/kernel/sys_parisc.c            |  53 +++++-----
 arch/powerpc/include/asm/book3s/64/slice.h |   1 +
 arch/powerpc/mm/book3s64/slice.c           |  31 ++++++
 arch/s390/include/asm/pgtable.h            |   1 +
 arch/s390/mm/mmap.c                        |  51 +++++-----
 arch/sh/include/asm/pgtable.h              |   1 +
 arch/sh/mm/mmap.c                          |  83 ++++++----------
 arch/sparc/include/asm/pgtable_32.h        |   1 +
 arch/sparc/include/asm/pgtable_64.h        |   1 +
 arch/sparc/kernel/sys_sparc_32.c           |  33 ++++---
 arch/sparc/kernel/sys_sparc_64.c           |  96 +++++++-----------
 arch/x86/include/asm/pgtable_64.h          |   1 +
 arch/x86/kernel/sys_x86_64.c               |  64 ++++++------
 arch/xtensa/kernel/syscall.c               |  31 ++++--
 include/linux/sched/mm.h                   |   9 ++
 mm/huge_memory.c                           |  17 ++--
 mm/mmap.c                                  |  86 +++++++++++------
 30 files changed, 491 insertions(+), 424 deletions(-)

-- 
2.47.0.338.g60cca15819-goog

