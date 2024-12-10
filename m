Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7C19D075
	for <linux-sh@vger.kernel.org>; Tue, 10 Dec 2024 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798486; cv=none; b=f4OIKrIpiyeMcWdSgHjPQq5Dwj1FUglKTTmYmMIECDKGTGtUUgOv+ySZvbjKfl6UGN95o9zZIDys87KiP4amP2Va7B/9DDfR7lNS2NLBV/Ii0VLqJSxnioluX555MvBCLs0Rcczgs4V2iCHmtFyE6JIQ2yxhm/B5RijOgVYZ2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798486; c=relaxed/simple;
	bh=ggOOMFEQ9uCyBPLNj8pMCOzsrPNAOhGLml70owUEuAQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qFjXYGB3Ae4+Lk8wA6Nwh1Byeyvihjvrus72kowsjwePvQ2dciZqmbATKtVcHx8n0qAX9mUKnD7swsy/xBW9hdTbnHvlY5STAzWljAugb6BMb2HADrzx1zJ0hkNqRioGl4jjBeUqPm/R82Y1xm/w6AvLbBukw+MIPvz4F3IgENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1D1tjxUu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1D1tjxUu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166855029eso7658995ad.0
        for <linux-sh@vger.kernel.org>; Mon, 09 Dec 2024 18:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798484; x=1734403284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bf22iGP6jf2y7qifILZ5XtpYUOy94hbxgtZW13umpxY=;
        b=1D1tjxUujPUi/Ia3tAgiZZGc99IJQI6LLokQ3clTqe/glu84xRweia9vkmAjAc1Rky
         x1x0AAY4CJcH0FIg6ESUBP6dvJu0JQZ2Wx3mUgD54mNzzKfh2emgVVcI4d0gO6hg2mrv
         yGFSi3nA7AiegHUrLZD7oxUUNvqIHOCi1ySqnGbDgI2Sk9zekBas83zd0Aex+Rv9u8lU
         SL3GQqi4mNMcOUH5gnCwBawMRaL41S2EHw70I4hS8oY5S8OASq8pLUgC8AZwjlkcxmMX
         bhj0wKcYnG6e5RpUkiJLB93u+hCqnLzBhdUXTuTFNgSMe5rZYcH4za/cSzG6SyJDoNp2
         a4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798484; x=1734403284;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf22iGP6jf2y7qifILZ5XtpYUOy94hbxgtZW13umpxY=;
        b=Xmch7KhpYeaxxvRR198ZaqSIWpDmR1vNmvR6y5kbaXCCGrFk+Yc/iZO6jrN+HuCeIZ
         nRY1NNLMu/swPMqcGkZN2o8QeRF74FB4FCkUNu36t9C9LShwkGsU4BEpnZQ3pon3LfF8
         ANmXHFaMKdQfK67EW4eEzXGVo5iLO9kxqhjdzC0IY2Ux2SkMbADFtgkmNkYSHLxZilH7
         PdctuKaTDUKUSrAUiq+cliVflZf8NfEJ6Eh1iJyGZgP9A59iwr4Z/K5JzsjL46rb4m4J
         sQMJ11kgJ0AyLvhIl2sHDHmaQm9rVTCWfCZNm67882+aYpSscv2dl7VA56/bOC0TYkhP
         wB6w==
X-Forwarded-Encrypted: i=1; AJvYcCVRCsZFJwZgLXXxrCG9sUWNbL6txKJu1TIq4aisDQniBuTRqk0NmNy1exujpK3kq9wexsuKxVIXMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygQ/xi5hShGFFCMFmM1bH/HaxIsTMsDuvM9LMAIdNpyjuMUUpZ
	dNz83OUbDI3HPgdMNs6rwXYP9bSu5ShWJkhT9Iy1T/wREyHbbRQa3Xg7PCQUAL76JUQBjXex9vX
	e65cO7x2X3odF1YeZRKC0bA==
X-Google-Smtp-Source: AGHT+IGmbMdmRSsqJri2ZoaLC+TQ8CWMLTK/EMvjfytSTGvuy8K5dpGza4XliOvDgrJOHh+vT9vCZPym9dpOQZfD/Q==
X-Received: from plbmk12.prod.google.com ([2002:a17:903:2bcc:b0:215:5607:bc71])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64a:b0:216:2b14:b625 with SMTP id d9443c01a7336-2166a01e172mr48609585ad.31.1733798483773;
 Mon, 09 Dec 2024 18:41:23 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:02 -0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-1-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 00/17] mm: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
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

This series introduces aarch_mmap_hint() to handle allocating VA space
for the hint address.

Patches 1-16 introduce this new helper and Patch 17 uses it to fix the
issue of mmap hint being ignored in some cases due to THP alignment [1]

[1] https://lore.kernel.org/r/20241118214650.3667577-1-kaleshsingh@google.com/

Thanks,
Kalesh

Kalesh Singh (17):
  mm: Introduce generic_mmap_hint()
  mm: x86: Introduce arch_mmap_hint()
  mm: arm: Introduce arch_mmap_hint()
  mm: alpha: Introduce arch_mmap_hint()
  mm: arc: Use generic_mmap_hint()
  mm: csky: Introduce arch_mmap_hint()
  mm: loongarch: Introduce arch_mmap_hint()
  mm: mips: Introduce arch_align_mmap_hint()
  mm: parisc: Introduce arch_align_mmap_hint()
  mm: s390: Introduce arch_mmap_hint()
  mm: sh: Introduce arch_mmap_hint()
  mm: sparc32: Introduce arch_mmap_hint()
  mm: sparc64: Introduce arch_mmap_hint()
  mm: xtensa: Introduce arch_mmap_hint()
  mm: powerpc: Introduce arch_mmap_hint()
  mm: Fallback to generic_mmap_hint()
  mm: Respect mmap hint before THP alignment if allocation is possible

 arch/alpha/include/asm/pgtable.h           |  1 +
 arch/alpha/kernel/osf_sys.c                | 29 ++++++++++--
 arch/arc/mm/mmap.c                         | 12 ++---
 arch/arm/include/asm/pgtable.h             |  1 +
 arch/arm/mm/mmap.c                         | 54 ++++++++++++---------
 arch/csky/abiv1/inc/abi/pgtable-bits.h     |  1 +
 arch/csky/abiv1/mmap.c                     | 38 ++++++++++-----
 arch/loongarch/include/asm/pgtable.h       |  1 +
 arch/loongarch/mm/mmap.c                   | 40 ++++++++++------
 arch/mips/include/asm/pgtable.h            |  1 +
 arch/mips/mm/mmap.c                        | 39 +++++++++------
 arch/parisc/include/asm/pgtable.h          |  1 +
 arch/parisc/kernel/sys_parisc.c            | 37 ++++++++++-----
 arch/powerpc/include/asm/book3s/64/slice.h |  1 +
 arch/powerpc/mm/book3s64/slice.c           | 31 ++++++++++++
 arch/s390/include/asm/pgtable.h            |  1 +
 arch/s390/mm/mmap.c                        | 32 ++++++-------
 arch/sh/include/asm/pgtable.h              |  1 +
 arch/sh/mm/mmap.c                          | 48 ++++++++++---------
 arch/sparc/include/asm/pgtable_32.h        |  1 +
 arch/sparc/include/asm/pgtable_64.h        |  1 +
 arch/sparc/kernel/sys_sparc_32.c           | 21 +++++++--
 arch/sparc/kernel/sys_sparc_64.c           | 47 +++++++++++++-----
 arch/x86/include/asm/pgtable_64.h          |  1 +
 arch/x86/kernel/sys_x86_64.c               | 49 ++++++++++---------
 arch/xtensa/include/asm/pgtable.h          |  1 +
 arch/xtensa/kernel/syscall.c               | 26 +++++++++-
 include/linux/sched/mm.h                   |  8 ++++
 mm/huge_memory.c                           | 15 +++---
 mm/mmap.c                                  | 55 ++++++++++++++--------
 30 files changed, 401 insertions(+), 193 deletions(-)

-- 
2.47.0.338.g60cca15819-goog

