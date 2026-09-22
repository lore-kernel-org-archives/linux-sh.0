Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397F49363D;
	Tue, 22 Sep 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098587; cv=none; b=Vre7Meq1a7VA10PFCxXNnQ6Yfjj+UPeDV3aX9vTD8LG9Jm+qiSOowK8YEz87rbubs4KtITDeP4S+zZvv0+cgJKoWTyNAO4yQcBZ5C6oEGyEct28G3YZkYlflaxIMAGpx05NEindigunnifP1BbA87V7J4xvCRvnUn0VkXoD57Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098587; c=relaxed/simple;
	bh=G2I/oBZTdGkJuNPKCx3yROTpE+54jzzqW7V8gwCHaF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL2jnIJiP2khNdi4vM7ZZ3tAH263K04pETgp1rOxSgwZXVPeNDksU7nhTfZJlbt7pTr8njSnZ6Q3EeAJshzrvqKtKlCkL7uvtgkJx1crHThnsj+E5LvUoV8EaE83gI1wIAeECWeS1h7U8fo1/EhZqQ6y51mGVl4pjKjh7SPUlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RgdRjyED; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=54xM5N6K; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RgdRjyED";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="54xM5N6K"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098434; bh=e1GcMnqFLCYDoymp6RLJVeb
	pmtQeo9UYDw7sYBJUhCo=; b=RgdRjyEDbXNkMPQ8KeUZHOgR41025YtvXpBr9YubcWfvfFrTkH
	WsjQGi5iKF0/Q7SxfbLq32+CVgwtchQ06SJ5gzIcpi3WGrBxvO4s7NUL6vMe+4bJHUqRhxoD10/
	67IJY2fFgPoeyXd+/kWcUxSXjv/IgzHlouVSWVrT1b3BW0UFuKz9A1hVjASVqQVX0V/Qvbd0fH8
	vHRo8tBFCz/m8QLnTFlKT9PwzfrH5lMW1uOW2QIl5C5/zUZBuVD/2HZxGFpv6GNPma2OJu/CpKj
	7q8LI2RexEJBTUq92MqDBL7Vr+uaH85fX/bcVlapDaVsVUx7mXpsTMIIheGpxXR1AhQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098434; bh=e1GcMnqFLCYDoymp6RLJVeb
	pmtQeo9UYDw7sYBJUhCo=; b=54xM5N6KOQWLgmVo6u80leBEDQVMX+gYb8ekcXt6NwZL2Szwo1
	LHYwY7CewossBjldsNDBthMIOpoIFgYd7dDg==;
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
Subject: [PATCH 2/5] ARC: Emulate two-byte cmpxchg
Date: Tue, 22 Sep 2026 17:33:51 +0000
Message-ID: <20260922173354.14404-3-brads@mainlining.org>
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

ARC has no two-byte atomic compare and swap, so the arch_cmpxchg_relaxed()
macro switch lets case 2 fall through to BUILD_BUG() via default. Route case
2 through the new cmpxchg_emu_u16(), which takes the old and new
values as unsigned long and narrows them itself, so the (uintptr_t)
casts on _o_ and _n_ are no longer needed and the case 2 call passes
them straight.

The switch also now tests sizeof(*(_p_)) instead of sizeof((_p_)),
which switched on the pointer and made the size 1 and size 2 cases
dead code, routing every sub-word cmpxchg() through the 32-bit
llock/scond pair and comparing whole words against sub-word values,
so the compare almost never succeeded. The old and new values are
now declared as unsigned long through (unsigned long)(0 ? *(_p_) :
(old)), the idiom David Laight suggested, which type checks the
arguments against the pointee, so cmpxchg(&p, 4, 5) no longer
compiles silently.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/arc/include/asm/cmpxchg.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890f..4596edfefa95 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -42,16 +42,19 @@
 #define arch_cmpxchg_relaxed(ptr, old, new)				\
 ({									\
 	__typeof__(ptr) _p_ = (ptr);					\
-	__typeof__(*(ptr)) _o_ = (old);					\
-	__typeof__(*(ptr)) _n_ = (new);					\
+	unsigned long _old_ = (unsigned long)(0 ? *(_p_) : (old));		\
+	unsigned long _new_ = (unsigned long)(0 ? *(_p_) : (new));		\
 	__typeof__(*(ptr)) _prev_;					\
 									\
-	switch(sizeof((_p_))) {						\
+	switch (sizeof(*(_p_))) {						\
 	case 1:								\
-		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, _old_, _new_);	\
+		break;							\
+	case 2:								\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *__force)_p_, _old_, _new_);	\
 		break;							\
 	case 4:								\
-		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
+		_prev_ = (__typeof__(*(ptr)))__cmpxchg(_p_, _old_, _new_);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -64,8 +67,8 @@
 #define arch_cmpxchg(ptr, old, new)				        \
 ({									\
 	volatile __typeof__(ptr) _p_ = (ptr);				\
-	__typeof__(*(ptr)) _o_ = (old);					\
-	__typeof__(*(ptr)) _n_ = (new);					\
+	unsigned long _old_ = (unsigned long)(0 ? *(_p_) : (old));		\
+	unsigned long _new_ = (unsigned long)(0 ? *(_p_) : (new));		\
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
@@ -102,7 +105,7 @@
 	__typeof__(ptr) _p_ = (ptr);					\
 	__typeof__(*(ptr)) _val_ = (val);				\
 									\
-	switch(sizeof(*(_p_))) {					\
+	switch (sizeof(*(_p_))) {					\
 	case 4:								\
 		_val_ = __arch_xchg(_p_, _val_);			\
 		break;							\
-- 
2.47.3

