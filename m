Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30254DAE6;
	Tue, 22 Sep 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098576; cv=none; b=b3UsdDr4X/kFev1VR0ZVclwSXxTBT0umam29/Ixg4mO6byoP3r0fg+2pKkbI5vNwOTfc95R8o5YmxYhfExQK4TKu/loXIxDrbpj2Dd+CrWkB+m5IPNDCJ5s2/WzvyKUgGcxsKWJYLjtutKjIuSLimVjlpX2WSCF+S9Q/Ky6rfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098576; c=relaxed/simple;
	bh=yQbHi2/qjWQm7R28Ag7bKayxGrtMhrNYW+yci+1KRH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9iTwG5vvOkcuXP9BBXDFGVNIhqcM1J8PAWzMusf7pZizq5i0AH0h5hIpRgdfSip2zsTrm6YoUyGIAKC3uh9VnF6rlUzIOHvtatCKiCl7rtw7uq3PzEkPw1WU9VPAzWyYu6rRn9X4Lbfm2M19GXd314LkciKj8LM/yn3i+Pqob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bZ38dyWM; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=jnZiJ1Qj; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bZ38dyWM";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="jnZiJ1Qj"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098434; bh=ghYvDCJ6wWgl/DWKvRlZLjc
	r4JmsCO6Diem7VtlYvoo=; b=bZ38dyWMgd/G/6OMhHggQwAi2Id4aT8IYufucK56A4wyGw4Iuj
	z2W5xwZGeASaGF/HHJf8ssq8z4PoylGq2B1t7R6ut/d8M3Ij2LG7BjwOviGy/uB0NVYDwscv1JD
	7kPkG1IQ6VVkHrlLt2lYDSGuvhjweGzQg3VXOPDtMA2RsQ6UWzausKwtTWqfJRhvMcA8RRPQNtO
	HTqLo1bFm7LJUzrUzxCrKuZJYb59yJZr/yDqMsOFU2kNCNhtPy0g0jAdHqhHquweKOujEeL+pJ4
	vuncC6fMYzfNZrwUChfQxtVt+ggSqaj/oGkEp0xUGYy7/Zp9Vf17BnKlLL2u3mAWDOQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098434; bh=ghYvDCJ6wWgl/DWKvRlZLjc
	r4JmsCO6Diem7VtlYvoo=; b=jnZiJ1QjwuyC2NRhs59khGUE4Z66oJnKO75veJ4E/0hcaljPvm
	ulv9bbDDiHprbgM5vKUmZm0jYzB24CcBNCDg==;
From: Bradley Morgan <brads@mainlining.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-snps-arc@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH 3/5] sh: Emulate two-byte cmpxchg
Date: Tue, 22 Sep 2026 17:33:52 +0000
Message-ID: <20260922173354.14404-4-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922173354.14404-1-brads@mainlining.org>
References: <20260922173354.14404-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SH has no byte or halfword atomic memory operations, so the __cmpxchg()
switch routes case 1 through cmpxchg_emu_u8() and lets case 2 fall
through to __cmpxchg_called_with_bad_pointer(), which is declared but
never defined, so a two-byte cmpxchg() fails at link time. Route case
2 through the new cmpxchg_emu_u16(), which takes the old and new
values as unsigned long, so the (unsigned long) casts move off the
call and into _old_ and _new_ declarations that type check the old
and new arguments against *ptr through (unsigned long)(0 ? *ptr : _o_),
the idiom David Laight suggested, so cmpxchg(&p, 4, 5) no longer
compiles silently.

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/sh/include/asm/cmpxchg.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 1e5dc5ccf7bf..b87f59107b4e 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 	switch (size) {
 	case 1:
 		return cmpxchg_emu_u8(ptr, old, new);
+	case 2:
+		return cmpxchg_emu_u16(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	}
@@ -70,8 +72,10 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
-     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
-				    (unsigned long)_n_, sizeof(*(ptr))); \
+     unsigned long _old_ = (unsigned long)(0 ? *ptr : _o_);	 \
+     unsigned long _new_ = (unsigned long)(0 ? *ptr : _n_);	 \
+     (__typeof__(*(ptr))) __cmpxchg((ptr), _old_,				 \
+				    _new_, sizeof(*(ptr)));	 \
   })
 
 #include <asm-generic/cmpxchg-local.h>
-- 
2.47.3

