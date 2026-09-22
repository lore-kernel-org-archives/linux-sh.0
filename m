Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55954563FC3;
	Tue, 22 Sep 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098590; cv=none; b=kM+2BwmlFODQryA0grLh1xd3dnVIGQOuQZxoMjBSbypJzdgvn5oss2vRHc8GC7m0hy+afnhmA2op1+XyT2Fl7OOWrq5GDxvArZCVL7qAme3dOw7NHA4yAgHRAgn1yUsVMuiDrbANMhgFFIjs2baLjlEHQ4w+SgumjNAvvrDYIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098590; c=relaxed/simple;
	bh=Zzf1rbgihCrOyP1/qqfesaFc+2OZGZF5hAiHzrg6Xrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+oQ1CsNpwq9K+dHgN5k39hua2+QdCX89T8h3uT9UF5lQXye0o4yvFjzpjPiMmcaZOnToLcMnRgopvokTwtGPKQgCJlPt/wght4brj7O1jmECFk5tQaMOKm4xAen0O2pW5xGk15WecowjV8jnkShm51mxqYuuFuePaQFKtfrDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=hxyhNKhp; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=mIt3IqqS; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="hxyhNKhp";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="mIt3IqqS"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098435; bh=4wVfAlEcovYJiLRAiW1UExN
	eq/b3xEK1OUjxcP/7QYQ=; b=hxyhNKhpHnG4LHB+IQytsfxPMEf6YigYhmBGZ6P1fc8JdTpofF
	6/G3CK5eZbESW1khN3Oxuk3tTVRtyjIbZxXm7V/HRQMWqDGh17DVaXZRIj+dplFovWqMFx6Qd/N
	HYEuhDiGM8wwpRWslxqJozCj/owYlqjVph49yfKRkBOvKGP/olaRr80OLt3TX6jlUFhNPfXQASk
	UQuRL00HYhzZ/jl7YWoEfFoMh0jYwokqxLaO14TRt4zS0R4tL5JIgaJwdbMzvfPphucuTBMnKFP
	jjNQE9iV8ZIxOPszyZmfCQkHSxGLynC1RjC3MsaMYSL/3LD5RIP4ZC1boH5HOoZSaVw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098435; bh=4wVfAlEcovYJiLRAiW1UExN
	eq/b3xEK1OUjxcP/7QYQ=; b=mIt3IqqSgxeINDfPOkt7tdWMzH4kExoyXkiMgmIYJl8N/S4dZ9
	2BgUIRlcxsvR2j6OPj3KfJzB0NPulRzvSkDg==;
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
Subject: [PATCH 5/5] xtensa: Emulate two-byte cmpxchg
Date: Tue, 22 Sep 2026 17:33:54 +0000
Message-ID: <20260922173354.14404-6-brads@mainlining.org>
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

Xtensa has no two-byte atomic compare and swap, so the __cmpxchg()
switch lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
which is declared but never defined, so a two-byte cmpxchg() fails at
link time. Route case 2 through the new cmpxchg_emu_u16(), which takes
the old and new values as unsigned long, so the (unsigned long) casts
on _o_ and _n_ move off the call and into _old_ and _new_ declarations
that type check the old and new arguments against *ptr through
(unsigned long)(0 ? *ptr : (o)), the idiom David Laight suggested,
so cmpxchg(&p, 4, 5) no longer compiles silently.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/xtensa/include/asm/cmpxchg.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index b6db4838b175..f6bed4221b43 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -76,6 +76,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
 	case 1:  return cmpxchg_emu_u8(ptr, old, new);
+	case 2:  return cmpxchg_emu_u16(ptr, old, new);
 	case 4:  return __cmpxchg_u32(ptr, old, new);
 	default: __cmpxchg_called_with_bad_pointer();
 		 return old;
@@ -83,10 +84,10 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 }
 
 #define arch_cmpxchg(ptr,o,n)						      \
-	({ __typeof__(*(ptr)) _o_ = (o);				      \
-	   __typeof__(*(ptr)) _n_ = (n);				      \
-	   (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	      \
-	   			        (unsigned long)_n_, sizeof (*(ptr))); \
+	({ unsigned long _old_ = (unsigned long)(0 ? *(ptr) : (o));	      \
+	unsigned long _new_ = (unsigned long)(0 ? *(ptr) : (n));	      \
+	(__typeof__(*(ptr))) __cmpxchg((ptr), _old_,		      \
+				_new_, sizeof (*(ptr))); \
 	})
 
 #include <asm-generic/cmpxchg-local.h>
-- 
2.47.3

