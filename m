Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A443DAACF;
	Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405399; cv=none; b=SC9u9GhtzhfdlEJgep5w1OFYceztkKj7HPwsrFA9gMtymuKOPxGNNmG0JKQ6Du8ADeMWlKYLH0+E3HqAM4EbAqBEX7tRS7gBfStWV3ctsF0aq/ZIuaqJLwmLSvoxASJgWH2PWr/jgPM7gVAGY7xlT6psBN/9NdYdO36Xpbg8c+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405399; c=relaxed/simple;
	bh=TuuTOaMQ5CtbHB/T/beb4jh4obKXy2f4Onreb6XZOSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0teCw9DIdNSMQVXDfrbcMjiV3si1pgjusLFSh87lfxohoPvqouhXFDCfL4SJuY9Z1ccCkkA5EirMDGAPfZ6yj8cW3rIhiMRA9U5cRa4rydub66Z3snJTB2ieQwuxr+5gWVoJhpmkokiN2iMMzO6xtTi9B2awXCGgGUJUBIPpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KroFTypS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KroFTypS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FB01F000FF;
	Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405397;
	bh=VbdLi+EDmLcgVFxgUSeMxfNMSzbYFZbpIXpV4Hl7qmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KroFTypSGnohwcGpN+KRwC1ZmI67dspXTn/09hNxvGg/caOOURUEeKoe4Rz7LjmKu
	 rbIhUtUNwgPOPBYz2U5J9fVQxM5NT+9aaWxZpHdhAFhTwCOoCZVvPEhLldTambQlar
	 h9JJX0Ci3ftL/qKrNmwb6m4oFMqcjb4m1wrRwYun0VHdmakXrmdcybw9upgWvlgi98
	 FspS3n+Y89lbAdxeilhTCCxo7jL2dTn6DyoRRrPioa/ZRxYZy+gNS4DMSoN5PNfjgh
	 JOkE53rVCIrZeYI3lq8ARmBCqAXgToJ1EVWa5eTzpe8n7kXdMTGuha0nV+4Byq/2ID
	 TdV/LlbXH0nJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5FF5ACE0D79; Wed,  7 Oct 2026 13:36:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-snps-arc@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org,
	kernel-team@meta.com,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/5] lib: Add two-byte cmpxchg emulation function
Date: Wed,  7 Oct 2026 13:36:32 -0700
Message-Id: <20261007203636.1982188-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
References: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bradley Morgan <brads@mainlining.org>

cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
cmpxchg() for the architectures lacking native one-byte atomics.
The same architectures also lack native two-byte cmpxchg(), where
such an operation is not supported and either fails to compile via
BUILD_BUG() or fails to link, because the bad pointer sentinels
these architectures declare are never defined.

Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
word with READ_ONCE(), splices the two target bytes through a union
and loops on cmpxchg() of the full word until the compare succeeds.
Like cmpxchg_emu_u8() it is fully ordered.

Unlike cmpxchg_emu_u8() it casts the old and new values to u16
internally and returns unsigned long, taking the old and new values
as unsigned long, per the suggestion from David Laight. The switch
statements in the architecture macros instantiate every size case,
so a cmpxchg() on a pointer type checks the two-byte case as well,
and a u16 parameter or return would make the macro casts and return
conversions warn there. With unsigned long parameters and return the
call sites need no narrowing casts, pointer exchanges compile warning
free, and the function still compares and returns exactly the 16 bits
the caller asked for, which matches the hardware cmpxchg r16
behaviour where a 16-bit compare only looks at the low 16 bits of
the register.

cmpxchg_emu_u8() keeps returning the old value unmasked, so a caller
that passes a wider old than 8 bits still gets it back as passed,
matching the behaviour the one-byte emulator always had.

The Kconfig symbol gating this file is renamed from
ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
selects both the one-byte and the two-byte emulation.

[ paulmck: Apply kernel test robot feedback. ]

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@kernel.org>
---
 include/linux/cmpxchg-emu.h |  4 +++-
 lib/cmpxchg-emu.c           | 38 +++++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
index 998deec67740a..2db70f1e39253 100644
--- a/include/linux/cmpxchg-emu.h
+++ b/include/linux/cmpxchg-emu.h
@@ -4,12 +4,14 @@
  * lacking direct support for these sizes.  These are implemented in terms
  * of 4-byte cmpxchg operations.
  *
- * Copyright (C) 2024 Paul E. McKenney.
+ * Copyright (C) 2024 Paul E. McKenney <paulmck@kernel.org>
+ * Copyright (C) 2026 Bradley Morgan <brads@mainlining.org>
  */
 
 #ifndef __LINUX_CMPXCHG_EMU_H
 #define __LINUX_CMPXCHG_EMU_H
 
 uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
+unsigned long cmpxchg_emu_u16(volatile u16 *p, unsigned long old, unsigned long new);
 
 #endif /* __LINUX_CMPXCHG_EMU_H */
diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
index 27f6f97cb60dd..25c69224a7597 100644
--- a/lib/cmpxchg-emu.c
+++ b/lib/cmpxchg-emu.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Emulated 1-byte cmpxchg operation for architectures lacking direct
- * support for this size.  This is implemented in terms of 4-byte cmpxchg
- * operations.
+ * Emulated 1-byte and 2-byte cmpxchg operations for architectures lacking
+ * direct support for these sizes.  These are implemented in terms of
+ * 4-byte cmpxchg operations.
  *
- * Copyright (C) 2024 Paul E. McKenney.
+ * Copyright (C) 2024 Paul E. McKenney <paulmck@kernel.org>
+ * Copyright (C) 2026 Bradley Morgan <brads@mainlining.org>
  */
 
 #include <linux/types.h>
@@ -43,3 +44,32 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
 	return old;
 }
 EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
+
+union u16_32 {
+	u16 h[2];
+	u32 w;
+};
+
+/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
+unsigned long cmpxchg_emu_u16(volatile u16 *p, unsigned long old, unsigned long new)
+{
+	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
+	int i = (((uintptr_t)p) & 0x2) / 2;
+	union u16_32 old32;
+	union u16_32 new32;
+	u32 ret;
+
+	WARN_ON_ONCE(((uintptr_t)p) & 0x1);
+	ret = READ_ONCE(*p32);
+	do {
+		old32.w = ret;
+		if (old32.h[i] != (u16)old)
+			return (unsigned long)old32.h[i];
+		new32.w = old32.w;
+		new32.h[i] = (u16)new;
+		instrument_atomic_read_write(p, 2);
+		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
+	} while (ret != old32.w);
+	return (u16)old;
+}
+EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);
-- 
2.40.1

