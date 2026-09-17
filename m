Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033E4FD27E;
	Thu, 17 Sep 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663261; cv=none; b=mxsTkrYkQ8+iyCVB/Ru3PY5kfo1EPNBXL8UpV7Cl3l3K+Otc0ZWi5HtVZ6+DBeG4co4KwU5SrIrzn1a+BDZK2Kgg6ceMqkKEXojbNLwedV5JtMMcBn31/cZ3kOtR1VZ6wourgDWE1pIw/Apb96vFv10Nn2FIAd3oCdZt8F5CnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663261; c=relaxed/simple;
	bh=FJPfu7LFjRjc6ZJbnsAto0bfKwxBduCiy3SP0uqRsFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRhuJpNu8jYdzPoLJAkG9nRPsogVMjFjWIyDjvPjahTMQn8Hzk3WoSiMFzzp37KkBXD+4XWDxZ6sne5ByUiOBfQYbaAaOh5a8Zcc1MxZUUzX0VZK90RFIKI4yggmqV5rWCR7oTHre0o+QJDiwc/QCvVqA83m4fpezjl4OBkU5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=YTDbLKwM; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=vOxLdiXe; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YTDbLKwM";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="vOxLdiXe"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663111; bh=gF0jpOzqVIhOvYSoNgdvd4z
	PpHZVOqEDRyAYG3KMg0M=; b=YTDbLKwMGcQTYm5dxY3iKNEBtq5PZYfPplCnBNArkKE9tM2Zz/
	eu0hGtCPX/qsIDEUpNe8nt4G/I4+qgrRuNu+McSLl6zKJMldhvE96d1mjoPQh3y5tNVgmqY/9t3
	eZQO5dUgjPoXBcHFiuuFtvcAnt2gwzwhDspUmcltwll5RVMTRsENWLQkDWZyxbt8Lk7YPRf3hh2
	iPLD+UyvG7kmcQb6W3Cytg+q4b0y1i4qwne+cS7AVS+7n72nbPFCe/4UckhR2ozTMVo2YMsNL8G
	uaDIWKGcjWM1b2QrFKX6p2Ebu9KYCS8TB47+v++JA8rGv0Rd9i1+88LM6pACdnY9CoA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663111; bh=gF0jpOzqVIhOvYSoNgdvd4z
	PpHZVOqEDRyAYG3KMg0M=; b=vOxLdiXeRsfXKHFjjuEd8N46x17rPZMf9Y7yTn2qUgVQuicb97
	nSPzupPG62E/fI1TAHC6dAzXDxySnyWkQGAw==;
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
Subject: [PATCH v3 3/5] csky: Emulate two-byte cmpxchg
Date: Thu, 17 Sep 2026 16:38:28 +0000
Message-ID: <20260917163830.3748-4-brads@mainlining.org>
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

CSKY has no two-byte atomic compare and swap, so the __cmpxchg()
switches in cmpxchg.h let case 2 fall through to the undefined
__cmpxchg_called_with_bad_pointer(), failing at link time. Route case
2 through the new cmpxchg_emu_u16(), which takes the old and new
values as unsigned long and narrows them itself, so the (uintptr_t)
casts on __old and __new come off in all three switch instances.
The (u16) casts are gone for the same reason.

The __old and __new declarations were typed __typeof__(old) and
__typeof__(new), which skips the pointer-integer type check, so
cmpxchg(&p, 4, 5) compiled silently. Typing them through
(unsigned long)(0 ? *(ptr) : (old)) keeps the value conversion while
making the compiler reject mismatched types, the idiom David
Laight suggested. The same check is added for new.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/csky/include/asm/cmpxchg.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index db6dda47184e..29dc56e4b7f1 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -57,13 +57,16 @@
 #define __cmpxchg_relaxed(ptr, old, new, size)			\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
-	__typeof__(new) __new = (new);				\
-	__typeof__(new) __tmp;					\
-	__typeof__(old) __old = (old);				\
+	unsigned long __old = (unsigned long)(0 ? *(ptr) : (old));	\
+	unsigned long __new = (unsigned long)(0 ? *(ptr) : (new));	\
+	unsigned long __tmp;					\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
 	case 1:							\
-		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;						\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
 		break;						\
 	case 4:							\
 		asm volatile (					\
@@ -90,13 +93,16 @@
 #define __cmpxchg_acquire(ptr, old, new, size)			\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
-	__typeof__(new) __new = (new);				\
-	__typeof__(new) __tmp;					\
-	__typeof__(old) __old = (old);				\
+	unsigned long __old = (unsigned long)(0 ? *(ptr) : (old));	\
+	unsigned long __new = (unsigned long)(0 ? *(ptr) : (new));	\
+	unsigned long __tmp;					\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
 	case 1:							\
-		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;						\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
 		break;						\
 	case 4:							\
 		asm volatile (					\
@@ -124,13 +130,16 @@
 #define __cmpxchg(ptr, old, new, size)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
-	__typeof__(new) __new = (new);				\
-	__typeof__(new) __tmp;					\
-	__typeof__(old) __old = (old);				\
+	unsigned long __old = (unsigned long)(0 ? *(ptr) : (old));	\
+	unsigned long __new = (unsigned long)(0 ? *(ptr) : (new));	\
+	unsigned long __tmp;					\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
 	case 1:							\
-		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;						\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
 		break;						\
 	case 4:							\
 		asm volatile (					\
-- 
2.47.3

