Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A838911B
	for <linux-sh@vger.kernel.org>; Sat, 26 Sep 2026 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447980; cv=none; b=ocZMXX/wSkiZHx2KAYTp6qfgtg6PSstmo3wFwDtkW2PA8bX8EZGwVkhRJiZ9xzV/xxFFb2QrIr4jhIi+FvFnk5abmGZ0DVt2c99NW3pzegvib7IrHrgUEe5BYq30zeBttuIfOKzrEwaSi2GHa1yiC1GJEKNZQ6qS53Tx3GmqyYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447980; c=relaxed/simple;
	bh=dvUR2BCbzH+bWShLv0ZI6EXBUDM3jl05qL5uLrNxRy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QGZK7Lm042Xs9P78gqZQf4NjE26eMB5siAS4cdPK1sK0jGVJ6LU/l/nGxKT2ud4qH+3zMnAC6HuE+WFW6Otwz7CMBr0pCeqVwXW1ZqB3DK6dM5WYNODlp5DxmGfcOCyIKbNXa1uwJq2hxlAv9Ds0Nn4473Pofets/p8gJr3TdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il/F5YOX; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il/F5YOX"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso16739695e9.3
        for <linux-sh@vger.kernel.org>; Sat, 26 Sep 2026 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790447975; x=1791052775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0enCh2MRlgPpYIWKl5Sr13FnH5bGjxfJsgRmd5nwro=;
        b=Il/F5YOX0voRLP8xg/qYvZIjwkCNu12OgH2YbsSJ7DR72qng/usISqluFxE+YEtwNn
         sb6PbaBqb/DR7q5Da5cyh250cDzWHFs4Nh9MYL8BsnznlpLe9qDVlRpP/a+0gqmie1CJ
         rLvVfGkuSyPceDYDGBBdq2cFG/no2Y9Zy7RsgFht5982+zyCMul8fFoCYbyqfqG7dPij
         O5k5H1DZdCoIYQvGurnwK1Sqn15qlfsgTQVPUJ6S1+o6m70LtDjW7UZYV5rXp1uCxvKT
         nGENoj91VDqLoYC3x8yynanSZFujFf6VVEeeMQK5vapjiUwNNp5/iTwPNkQGmESmX1EC
         gfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447975; x=1791052775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h0enCh2MRlgPpYIWKl5Sr13FnH5bGjxfJsgRmd5nwro=;
        b=ICUhxc29CdNbmYxch6qJaKGtMch16IEeXmZ7TSNiou6wTEuDXJU1ym+iFAX9+wMWg7
         CUGg4iq9y2zJzyMiPi++T03kCHbYqGiGEHhIBDTH2oNgVpeWxuyuXDE/NmQp43uaLbt/
         Q/5XrWQ6GvK1pkONhNQGL5Hrkd8l/Zg1ckl7fIlsT3OHMZ5VxbdjgVFNnkO1OiH2p0Kk
         6yO9g1p6TjT7Q9Jga0TB5YY9VuiMLR1xo9Xp+Nln97Bb4TMSEIBTnHievYaKkbRlMrIK
         BZQbboy1s5Bbbm/XwNy81ZXRMRPL2uosH8ie1kee0b0ryXuH9Xny4bWa7sE2EOKM9ggg
         lrWw==
X-Gm-Message-State: AFuF++k/H2oeIMJ9XFGWERbFlh3o+1jbzj4u1mX8t7k+G8oy2d/WGcCm
	Sht0kP7d4c++BXMyJPZrF4+ce5pfAvi68yAc+nchn6sZ+snPwjd+oB+k
X-Gm-Gg: AYBFou0oOdQhR3VtYsZevmtWhw9VwTfSw/HqdSyqI7UWmJiwNhGFlsNc/xzGfnhEAjG
	8Fu+Hs4jVpfiJWOznK2uDSN/xur9Jmh/9RdOMALVQwXj1+2zFynPfn/9VLLBu81axEeKr3xdkso
	iQFbSmgDFBRxJt4/SVhe/rTiB8iX84Fh8l8TMMpUmuy06Xgs58joxj+JVFwqFSZ8dIyXw2I8h1u
	fM3TtzgznL25Gqca7WBUUdQaOD4jgArvgjkaCEBt/HtJxuKZVhdN7gmtVAIvv8Vsfav/ofgC9MV
	+mviI5Zj9bqd01Um1lUgwL0DDAEgaTLsF8gKceu7Tq4xcSE2+EN6wSAPqy3ctYDkIYPaQ/fFh9g
	c/yzrTDqr2ujIMu41wmftkQxormVXRJ2covFynTlKfjKC9IWTYlbC8qK0YleqCJbu0f7N9L9VBT
	+y/RGlK9UHrDgUk4HNtjw1tyGdQovzsW0ccp1hsm+/eOWMWMp2uAxHlQxPqxZaK44AiOlpwPGed
	V8RlsACx40q5KO/poTzrYojCAk8xMBlAapzFQc0fW9aJ6q/vOIEcjPfaAxLBCAEjkMcen6nqUaV
	wJ+zKiyTln7D1Fm+ORxCvphATTYgwsT9YEHyq/Lsgo9AVFfvsBM/lm538B2xqE4oeMivt34/XVU
	apsz/wikt6daK
X-Received: by 2002:a05:600c:4754:b0:49d:1e09:694a with SMTP id 5b1f17b1804b1-49fe66d2ce2mr162026765e9.11.1790447974930;
        Sat, 26 Sep 2026 11:39:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a648895sm15430376f8f.28.2026.09.26.11.39.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 11:39:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 1/2] sh: mm: replace the page size bits in pte_mkhuge()
Date: Sat, 26 Sep 2026 20:39:03 +0200
Message-Id: <20260926183904.76186-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260926183904.76186-1-kmehltretter@gmail.com>
References: <20260926183904.76186-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pte_mkhuge() ORs _PAGE_SZHUGE into a PTE that already carries the base
page size from _PAGE_FLAGS_HARD, which every PAGE_* protection
includes. The PTEL size field is an encoding, not a set of flags: on
SH-4 with 4 KiB pages and 64 KiB huge pages, _PAGE_SZ0 | _PAGE_SZ1
selects a 1 MiB page. Every hugetlb mapping is therefore loaded into
the UTLB as a 1 MiB page whose physical base is the huge page's address
rounded down to 1 MiB, so user accesses land in unrelated kernel
memory.

In a QEMU r2d guest, after touching a MAP_HUGETLB mapping at
0x30000000, QEMU's "info tlb" shows

  vpn=c0000 ppn=32e00 sz=3 size=1048576

and writing the two huge pages overwrites kernel data, for example
page tables ("bad pgd 5a5a5a5a" on munmap) or a struct file:

  Fault in unaligned fixup: 0000 [#1]
  PC is at file_tty_write.isra.0+0x24/0x220
  R1  : 5a5a5a5a

The SH-X2 extended size field has the same problem: a 4 KiB base page
(ESZ0) combined with 64 KiB huge pages (ESZ2) encodes 256 KiB. Only the
configurations whose huge size encoding happens to contain the base
encoding, such as 1 MiB over 4 KiB on SH-4, have worked.

Clear the size field before setting the huge page size. All hugetlb
PTE constructors, including huge_pte_modify() on mprotect() and the
fork/COW paths, go through arch_make_huge_pte() and so pte_mkhuge().
With this change the same entry is loaded as

  vpn=c0000 ppn=32e00 sz=2 size=65536

and the mappings read back correctly after mprotect() and fork()/COW.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/sh/include/asm/pgtable_32.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 5f51af18997b..1e6821a23eac 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -145,6 +145,8 @@ static inline unsigned long copy_ptea_attributes(unsigned long x)
 # elif defined(CONFIG_HUGETLB_PAGE_SIZE_64MB)
 #  define _PAGE_SZHUGE	(_PAGE_EXT_ESZ2 | _PAGE_EXT_ESZ3)
 # endif
+# define _PAGE_SZHUGE_MASK	(_PAGE_EXT_ESZ0 | _PAGE_EXT_ESZ1 | \
+				 _PAGE_EXT_ESZ2 | _PAGE_EXT_ESZ3)
 # define _PAGE_WIRED	(_PAGE_EXT(_PAGE_EXT_WIRED))
 #else
 # if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
@@ -152,6 +154,7 @@ static inline unsigned long copy_ptea_attributes(unsigned long x)
 # elif defined(CONFIG_HUGETLB_PAGE_SIZE_1MB)
 #  define _PAGE_SZHUGE	(_PAGE_SZ0 | _PAGE_SZ1)
 # endif
+# define _PAGE_SZHUGE_MASK	(_PAGE_SZ_MASK)
 # define _PAGE_WIRED	(0)
 #endif
 
@@ -359,11 +362,11 @@ static inline pte_t pte_##fn(pte_t pte) { pte.pte_##h op; return pte; }
  */
 PTE_BIT_FUNC(high, wrprotect, &= ~(_PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE));
 PTE_BIT_FUNC(high, mkwrite_novma, |= _PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE);
-PTE_BIT_FUNC(high, mkhuge, |= _PAGE_SZHUGE);
+PTE_BIT_FUNC(high, mkhuge, = (pte.pte_high & ~_PAGE_SZHUGE_MASK) | _PAGE_SZHUGE);
 #else
 PTE_BIT_FUNC(low, wrprotect, &= ~_PAGE_RW);
 PTE_BIT_FUNC(low, mkwrite_novma, |= _PAGE_RW);
-PTE_BIT_FUNC(low, mkhuge, |= _PAGE_SZHUGE);
+PTE_BIT_FUNC(low, mkhuge, = (pte.pte_low & ~_PAGE_SZHUGE_MASK) | _PAGE_SZHUGE);
 #endif
 
 PTE_BIT_FUNC(low, mkclean, &= ~_PAGE_DIRTY);

base-commit: fddfc3ec31799a932bb92f1b8a84cb3d1f963be9
-- 
2.39.5 (Apple Git-154)

