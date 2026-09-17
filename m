Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D87518142;
	Thu, 17 Sep 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663132; cv=none; b=L9a8owRfa6D8/K7Zr/XVXWy4IpGFnjb4R+5Ge+QJglFBYIzmPBlKw38/jDYh949EXGvtvZRirIHzNkoZk6AeilkDxNVaTtsseY6bH9mzI4H52mMXCiFHpjt6PMjL4WXwR+QCxVL163sMe7R/Uonp+AUasRy3nL6HiqFQhJdmdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663132; c=relaxed/simple;
	bh=yQbHi2/qjWQm7R28Ag7bKayxGrtMhrNYW+yci+1KRH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFZUqKyBQaxFjJtHwgS0ML9hL8Z5HYTSQZLRFlITsxZ81V6TvuyegGgh+FMVzWmGWSf5L0AA0Km81iJDe6B1Y7CESh3OtcjM5YM00pO+Ywf5bbd1/4mrzv7gClTssUMI4eJlZ/HkCO1m+bCeRae5hQX1F+vkA98slXyRZHx0uzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=fyB1YvSK; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=aqA1APFo; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="fyB1YvSK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="aqA1APFo"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663111; bh=ghYvDCJ6wWgl/DWKvRlZLjc
	r4JmsCO6Diem7VtlYvoo=; b=fyB1YvSKvGg1LWKCQZhUBc492tVVzKUf+KZBnI5LNuvCJ5g+ZU
	E6bkZfZWBE+ZQIYJNva6H1UqybZAs2u6MSsWz7m3aJKEZMUommjJq2vgXFTYVszJusLk7IevwrV
	3uAVll3tWQSPCu8psXyYvDa346sjiFeMpOTxP5FVJ2OXn8ivF7Ar9zMblkFo0Sc1qIgzQTEoMnz
	eECEFt8PMgT7hUncGGx7FjraHbNbzdqgoitO2DlTK+xF0xBeNMnkBZrDOGfDZLxGj/YwQIn8g2u
	k6hg6hp3BRJs3diJxFQC1cKrT8U/XjrLCX9avh/i1pVEwYhevJmc5z5MoF9+JtxIuPA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663111; bh=ghYvDCJ6wWgl/DWKvRlZLjc
	r4JmsCO6Diem7VtlYvoo=; b=aqA1APFosR9li9xYj4aOMoBwNnHa27+/AJWqeXDYbSCs4I8uW1
	aFOhtFdK/xx/jVETv72FWV94mClzvdy8f5Bg==;
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
Subject: [PATCH v3 4/5] sh: Emulate two-byte cmpxchg
Date: Thu, 17 Sep 2026 16:38:29 +0000
Message-ID: <20260917163830.3748-5-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917163830.3748-1-brads@mainlining.org>
References: <20260917163830.3748-1-brads@mainlining.org>
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

