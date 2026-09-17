Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90284F85AF;
	Thu, 17 Sep 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663148; cv=none; b=IqM7BRERLIXtqyZjZUHFJLxL3pDCOGF2wME93d2gv9otZBV1vEEK/DrlCYkyvvNhorDSKAC8XfaH23qt4AV3OJ77/dPB7CGEPpQuhT1XrAXe8rGkPgCccdltRh1hF/7HTnorzwgUXO4Pfz527GfIJWw3WSqi/1s8Y1TUqVZFy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663148; c=relaxed/simple;
	bh=kcK6nhh7W+FtR/GkcJBP7Jmd3mCfA61aItwWSBreHuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTTIzocmkXt2fr5KToxe6Oo7eYkbu4S/IqjmMVh3w60fReD711A9wEofyehOF1lcJVtXCQKVzVszcphr9B8s9Nk7ET874KXc3g/uivFLUWwIdlxr1OZ3Ntk1jc6sOwjPy9Cyv5L4ALLWPT51BhL6booRp/b+R/TQVmm8h6qoPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=VxQkqBBW; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=E5BykGjy; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="VxQkqBBW";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="E5BykGjy"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663143; bh=3ywXA6YlVC+E1c3gGiCHQc0
	l4jiAYrAVWl7TP3MSFhU=; b=VxQkqBBW9sRnf40WfNQy0UNwy7EMU86vhigeDr60kGk1Nkrdhg
	efJJWIXVw1XFP1+OQSou8wBMpJ9mm7utA+U58oJvMTgL7aCyLwY9vELXF2bepXamAugyOl5Q3Rw
	/ShVX1cJmj1JGkGzZZaQjWvWUaQvEwu4Q0aWkDhKD0PURLdFoIJhf7CE+aV+nA19KvyDAmT4Vzk
	WhwmpmZH3IcLOH1pjWBpzcNTzAY6HTOdje8GXQ0/7Z7chafYH6OnCyiwBsJK0s+rfANzP7ZIqVg
	V2GzCs5/N/I7Aw3n+mVYXxJcQRqknj88K/zJ6/wkxQPUrnlgrvr9SIXo5miscXITElA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663143; bh=3ywXA6YlVC+E1c3gGiCHQc0
	l4jiAYrAVWl7TP3MSFhU=; b=E5BykGjyMCtNsWQZJZqRlWMkluZBFfyP4tpAHl1lcCVJ0wx2pw
	I0nlPir4hT7n7G2VxUHQtJjYQzuxss6cIZDQ==;
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
Subject: [PATCH v3 5/5] xtensa: Emulate two-byte cmpxchg
Date: Thu, 17 Sep 2026 16:38:30 +0000
Message-ID: <20260917163830.3748-6-brads@mainlining.org>
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

Xtensa has no two-byte atomic compare and swap, so the __cmpxchg()
switch lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
which is declared but never defined, so a two-byte cmpxchg() fails at
link time. Route case 2 through the new cmpxchg_emu_u16(), which takes
the old and new values as unsigned long, so the (unsigned long) casts
on _o_ and _n_ at the call move into the function and the macro's
__typeof__(*(ptr)) typing of _o_ and _n_ remains the pointer-integer
type check.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/xtensa/include/asm/cmpxchg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index b6db4838b175..8dea8e357fc0 100644
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
-- 
2.47.3

