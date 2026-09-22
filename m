Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89219560ADD;
	Tue, 22 Sep 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098581; cv=none; b=vF+s6t8Nyx6W3r+XN79fEBZI4wWFis1vwe2/WD0JH+dZ0JFpjtCSqj0vYcqZ0aNIzm/q+U7EU+gU4Crgk1+mc+9ymu9n06uQtmCDxpkzHZD7vj7prft02BBk8tUdxZTn2/KxyLo/67wBS07kbyNZfynPLSOMy2rS5e+QaeUN12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098581; c=relaxed/simple;
	bh=NIprbG5WL6OpMAMxOPQrRQbIc6U5xN2vwQ5+5CySqcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHYqkaabqCSEi/Ph6dgLORZnUWvWusg7vIdVE6hlCzXkOD6h5OJeeDHKJsUS7JjPozE2gn3HS4mWIsp2Jd8MMBF9xeGZjyn7+qh1lc/sb4Wz5jVe+Jp6Hj9ebkyAbrn2b42rsBYmUxcTx3Buq3I5BiKiUMClhsFd6ZGPPNIpJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=A5/0/GOU; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=NTp5knoE; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="A5/0/GOU";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="NTp5knoE"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098435; bh=wl+BtXFs/QJChJ/sOKgC86/
	HKj3R5tfPpUhFH8oo0uc=; b=A5/0/GOUc+WvYs825/8ouOL1uBIBkqo06ZEzHpL/pV7+uEtN+b
	Q06RZe/uHEgOY77Uzlh5dL9QmnGwW+2nv5v1qBCVhyXNv4T8Uqdv2Yfcc8ENtyEoImQM/c7WOV8
	YCs2e5QkHGlXhMJ+H5KckshFL2DoJqgx/era/7X5JIkCE0YBZeMvl+Q038j/sHyXO00VCzyFPGm
	kc2VoX6bR2Tw+Kt1LeLRBtpqbrdpVvVDQOuAsb8j2YgHfW4NrjXkxLnF+rgsXf3dHDeuCOwIYmb
	gNlbihmQLhGtzbM0wf1poT0eIdtdfFePxhoQW+obXpIAfDOsR7EGFDT9B2A5+J/SlVg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098435; bh=wl+BtXFs/QJChJ/sOKgC86/
	HKj3R5tfPpUhFH8oo0uc=; b=NTp5knoEnFR7JN5OFPhBFH1QY9WSnU+vHpvP8lpWk2ed+OsGcb
	0/J3nRC2j+Rb5PnC8PsP8xBvuryNvrIOpqBQ==;
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
Subject: [PATCH 4/5] csky: Emulate two-byte cmpxchg
Date: Tue, 22 Sep 2026 17:33:53 +0000
Message-ID: <20260922173354.14404-5-brads@mainlining.org>
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

C-SKY has no two-byte atomic compare and swap, so the __cmpxchg()
macros let case 2 fall through to BUILD_BUG() via default. Route case
2 through the new cmpxchg_emu_u16(), which takes the old and new
values as unsigned long, so the (uintptr_t) casts on __old and __new
are no longer needed and the case 2 call passes them straight. The
old and new values are declared as unsigned long through
(unsigned long)(0 ? *(ptr) : (old)), the idiom David Laight
suggested, which type checks the arguments against the pointee, so
cmpxchg(&p, 4, 5) no longer compiles silently.

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

