Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C35326D5;
	Thu, 17 Sep 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663118; cv=none; b=cBGgp7u4DFcq5fe2JwdNZvZdzNlz83F8sLqTHrEXi1BTuyPXzHZQQfAtEbjCCAiaFu2mRLSCynKJaikVSyVejhtJD0WN/MSCEvXyIgJnxKJmSQ4PWV6aL/dU1QispviAlRkhOckywQObUIREQMTOxTJd19JPipcBFo4dPUY7JxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663118; c=relaxed/simple;
	bh=Q3a7nffzh4TnjwGqjLdckQ0m6RsFoKo/58dZkbxxriE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeAo4DLZFs5qdP2XNaN4qL2AwbbUbuxn4BTO9qF1qMc58pWoIjZGRQVuxOLbD5EWR/JNOXz67RIk91hS5L7JZrW8xGEb/leeBPOrWXseTbm5e55bD6aVLsVYzxbrn2K4BVjkM3vmKUz7Og/e0Ikx/eWbtaUvBv1y41s3ca5d2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=mavJU5Ux; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=1gfHML2R; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="mavJU5Ux";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="1gfHML2R"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663110; bh=3RvxnExRr/i5KZDzKSfMkA5
	w2CfSpqJW35Z/SWmaY2g=; b=mavJU5UxEV8BUwL3X8Q3WN5WEJY2eRju5jxKcshQHv7K3lfuQ1
	b2S8WHhugFwCMPjBRCLRKXRi4ni8kKxptKKbgGDh07yvVMNuViOIx6/CnKfahTQAU9fYOnzE87h
	2ojZepIf/xJHn78KdWO4O3V3YGuhHjBsL4iq8HQVPl00ylxvTWjZf6Q58x0hD5I33hZsE3jP/pW
	3gfno69YS0GXlVvqjCtty8f2c+A6iQ8sD5YoNK8t9sWpbWPdGLVfoBTpm1x4lPb0H60B6TMZPUz
	fGl8EZl/LaBLBAXgopK8C8yey5iZwqDytD+xrKOVv0irLTf//LjRjjXKyny+OJQvRCg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663110; bh=3RvxnExRr/i5KZDzKSfMkA5
	w2CfSpqJW35Z/SWmaY2g=; b=1gfHML2RRTH3V9hBrigdMnz+gaI97gHJK6V0ovv+sg0p56cx1s
	1OQuOzAuP4zKnEgy87RReNAcrr0smG/1wVAw==;
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
Subject: [PATCH v3 1/5] lib: Add two-byte cmpxchg emulation function
Date: Thu, 17 Sep 2026 16:38:26 +0000
Message-ID: <20260917163830.3748-2-brads@mainlining.org>
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

The Kconfig symbol gating this file is renamed from
ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
selects both the one-byte and the two-byte emulation.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig                |  2 +-
 arch/arc/Kconfig            |  2 +-
 arch/csky/Kconfig           |  2 +-
 arch/sh/Kconfig             |  2 +-
 arch/xtensa/Kconfig         |  2 +-
 include/linux/cmpxchg-emu.h |  4 +++-
 lib/Makefile                |  2 +-
 lib/cmpxchg-emu.c           | 40 ++++++++++++++++++++++++++++++++-----
 8 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3bb2e568f5b1..d56064797e09 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1817,7 +1817,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
 	# strict alignment always, even with -falign-functions.
 	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
 
-config ARCH_NEED_CMPXCHG_1_EMU
+config ARCH_NEED_CMPXCHG_1_2_EMU
 	bool
 
 config ARCH_WANTS_PRE_LINK_VMLINUX
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 80e61175bf52..0e91d254eccb 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -14,7 +14,7 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 4331313a42ff..5f26e8615d7d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -37,7 +37,7 @@ config CSKY
 	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d60f1d5a94c0..09e556fced01 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -14,7 +14,7 @@ config SUPERH
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f2f9cd9cde50..62019fd444d4 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -14,7 +14,7 @@ config XTENSA
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
index 998deec67740..2db70f1e3925 100644
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
diff --git a/lib/Makefile b/lib/Makefile
index 43421c39d21b..d0e69312176a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -202,7 +202,7 @@ obj-$(CONFIG_CODE_TAGGING) += codetag.o
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
-obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_EMU) += cmpxchg-emu.o
+obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 #ensure exported functions have prototypes
diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
index 27f6f97cb60d..ac1c84383887 100644
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
@@ -40,6 +41,35 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
 		instrument_atomic_read_write(p, 1);
 		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
 	} while (ret != old32.w);
-	return old;
+	return (u16)old;
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
2.47.3

