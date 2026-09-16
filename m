Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94B45FFA8;
	Wed, 16 Sep 2026 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590013; cv=none; b=X0Qk22L6s5sGkeBoPgolKclgxDzy5IwpqxE3rU59KbLlSnXFJs+UYMMy5HuaeJG+fz1Zmg0lKurXOkgC+HuzzWq4cJbLzxv04HHyhetNp+Gr6SWY1d6WzAu0UVQMWYNMN2dbUQ3RZ3pl2F6OroPbApU80RsJWY+HH7x9042AeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590013; c=relaxed/simple;
	bh=NX+p/xH9zYnkN23h9QHxqNzdlUoxsjnHcM/dLZ4hvJ0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ppNuWD5TXCpiAFDg5xCdr0C7N+DOXy0hM9COU/GtLuI1dQMXHChoIBjo3KHjYpZ10Tq6QFXd0e1unHyHnS/MGNdXBgV4jI/26X7S9XOBGrBfnrWIVuYB74q8+cjpyE8Y9Dyt+k1rBX+yvCHMQktDLDcFsFKNmmZ2dRk2vGsKL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=BliPZ88q; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=E1ziTaOX; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="BliPZ88q";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="E1ziTaOX"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789589863; bh=TUWjUBKNJj9TfTCFB/BT517
	Urpo4IwIGcdVvkokhmI4=; b=BliPZ88qkp7Wg8FvLDhkjRfkhWDjp2xZXrXGVAVzRfRCbcrrVB
	yonibSyZtqmrQE0lt+96GHS3imYJJtvbhRJwVbpIYyFytWo37GQw64hT6tFz5DJqIwz/a/BMHat
	LCYHzk+sTAeyYOqRbWxGrnyOHuL2jsk4YuXl2vBXoYZgoC4cSl/JSVXo4+4gOA4row09G+mdibg
	QIPXIhXFmfQCAvlPU0u4oYICR0LA578eXNoWXxQSEnWFQgR3JtHG3bVDe/LO/hiw+w9/nx0xykE
	hbs5QrnBNdaYuepAlbw1Xd7mxMv3/EDOyE0Uoh3RokTdaGtJa4nVj3jgV/AJRpSU/Yg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789589863; bh=TUWjUBKNJj9TfTCFB/BT517
	Urpo4IwIGcdVvkokhmI4=; b=E1ziTaOXepKpf0khVVHXAxlZCqCE3enE2EHPVPs6PDOORX6wA3
	pL0Ltfe7g/LMcF98R0pwby6Bh2lleIkCxvCw==;
Date: Wed, 16 Sep 2026 21:17:45 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta <vgupta@kernel.org>,
 Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, "Paul E . McKenney" <paulmck@kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] lib: Add two-byte cmpxchg emulation function
In-Reply-To: <20260916200215.21774-2-brads@mainlining.org>
References: <20260916200215.21774-1-brads@mainlining.org> <20260916200215.21774-2-brads@mainlining.org>
Message-ID: <D574C4CB-D17D-40CD-A02B-D7AE7D7E8B8E@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 September 2026 21:02:11 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
>cmpxchg() for the architectures lacking native one-byte atomics.
>The same architectures also lack native two-byte cmpxchg(), where
>such an operation is not supported and either fails to compile via
>BUILD_BUG() or fails to link, because the bad pointer sentinels
>these architectures declare are never defined.
>
>Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
>word with READ_ONCE(), splices the two target bytes through a union
>and loops on cmpxchg() of the full word until the compare succeeds.
>Like cmpxchg_emu_u8() it is fully ordered.
>
>Unlike cmpxchg_emu_u8() it takes and returns the natural u16 type
>instead of uintptr_t, per the suggestion from David Laight. The
>macros and inline wrappers at the call sites pass their old and
>new values through (uintptr_t) casts today, so with u16 parameters
>the narrowing happens at the function boundary and the function
>compares and returns exactly the 16 bits the caller asked for,
>which matches the hardware cmpxchg r16 behaviour where a 16-bit
>compare only looks at the low 16 bits of the register.
>
>The Kconfig symbol gating this file is renamed from
>ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
>selects both the one-byte and the two-byte emulation.
>
>Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>Suggested-by: David Laight <david.laight.linux@gmail.com>
>Signed-off-by: Bradley Morgan <brads@mainlining.org>
>---
> arch/Kconfig                |  2 +-
> arch/arc/Kconfig            |  2 +-
> arch/csky/Kconfig           |  2 +-
> arch/sh/Kconfig             |  2 +-
> arch/xtensa/Kconfig         |  2 +-
> include/linux/cmpxchg-emu.h |  4 +++-
> lib/Makefile                |  2 +-
> lib/cmpxchg-emu.c           | 38 +++++++++++++++++++++++++++++++++----
> 8 files changed, 43 insertions(+), 11 deletions(-)
>
>diff --git a/arch/Kconfig b/arch/Kconfig
>index 3bb2e568f5b1..d56064797e09 100644
>--- a/arch/Kconfig
>+++ b/arch/Kconfig
>@@ -1817,7 +1817,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
> 	# strict alignment always, even with -falign-functions.
> 	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
> 
>-config ARCH_NEED_CMPXCHG_1_EMU
>+config ARCH_NEED_CMPXCHG_1_2_EMU
> 	bool
> 
> config ARCH_WANTS_PRE_LINK_VMLINUX
>diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>index 80e61175bf52..0e91d254eccb 100644
>--- a/arch/arc/Kconfig
>+++ b/arch/arc/Kconfig
>@@ -14,7 +14,7 @@ config ARC
> 	select ARCH_HAS_SETUP_DMA_OPS
> 	select ARCH_HAS_SYNC_DMA_FOR_CPU
> 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>-	select ARCH_NEED_CMPXCHG_1_EMU
>+	select ARCH_NEED_CMPXCHG_1_2_EMU
> 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
> 	select ARCH_32BIT_OFF_T
> 	select BUILDTIME_TABLE_SORT
>diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
>index 4331313a42ff..5f26e8615d7d 100644
>--- a/arch/csky/Kconfig
>+++ b/arch/csky/Kconfig
>@@ -37,7 +37,7 @@ config CSKY
> 	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
> 	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
> 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
>-	select ARCH_NEED_CMPXCHG_1_EMU
>+	select ARCH_NEED_CMPXCHG_1_2_EMU
> 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
> 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> 	select COMMON_CLK
>diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
>index d60f1d5a94c0..09e556fced01 100644
>--- a/arch/sh/Kconfig
>+++ b/arch/sh/Kconfig
>@@ -14,7 +14,7 @@ config SUPERH
> 	select ARCH_HIBERNATION_POSSIBLE if MMU
> 	select ARCH_MIGHT_HAVE_PC_PARPORT
> 	select ARCH_WANT_IPC_PARSE_VERSION
>-	select ARCH_NEED_CMPXCHG_1_EMU
>+	select ARCH_NEED_CMPXCHG_1_2_EMU
> 	select CPU_NO_EFFICIENT_FFS
> 	select DMA_DECLARE_COHERENT
> 	select GENERIC_ATOMIC64
>diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>index f2f9cd9cde50..62019fd444d4 100644
>--- a/arch/xtensa/Kconfig
>+++ b/arch/xtensa/Kconfig
>@@ -14,7 +14,7 @@ config XTENSA
> 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
> 	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
> 	select ARCH_HAS_STRNLEN_USER
>-	select ARCH_NEED_CMPXCHG_1_EMU
>+	select ARCH_NEED_CMPXCHG_1_2_EMU
> 	select ARCH_USE_MEMTEST
> 	select ARCH_USE_QUEUED_RWLOCKS
> 	select ARCH_USE_QUEUED_SPINLOCKS
>diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
>index 998deec67740..d7eb96a15f85 100644
>--- a/include/linux/cmpxchg-emu.h
>+++ b/include/linux/cmpxchg-emu.h
>@@ -4,12 +4,14 @@
>  * lacking direct support for these sizes.  These are implemented in terms
>  * of 4-byte cmpxchg operations.
>  *
>- * Copyright (C) 2024 Paul E. McKenney.
>+ * Copyright (C) 2024 Paul E. McKenney <paulmck@kernel.org>
>+ * Copyright (C) 2026 Bradley Morgan <brads@mainlining.org>
>  */
> 
> #ifndef __LINUX_CMPXCHG_EMU_H
> #define __LINUX_CMPXCHG_EMU_H
> 
> uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
>+u16 cmpxchg_emu_u16(volatile u16 *p, u16 old, u16 new);
> 
> #endif /* __LINUX_CMPXCHG_EMU_H */
>diff --git a/lib/Makefile b/lib/Makefile
>index 43421c39d21b..d0e69312176a 100644
>--- a/lib/Makefile
>+++ b/lib/Makefile
>@@ -202,7 +202,7 @@ obj-$(CONFIG_CODE_TAGGING) += codetag.o
> lib-$(CONFIG_GENERIC_BUG) += bug.o
> 
> obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
>-obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_EMU) += cmpxchg-emu.o
>+obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o
> 
> obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> #ensure exported functions have prototypes
>diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
>index 27f6f97cb60d..6586f1a88178 100644
>--- a/lib/cmpxchg-emu.c
>+++ b/lib/cmpxchg-emu.c
>@@ -1,10 +1,11 @@
> // SPDX-License-Identifier: GPL-2.0+
> /*
>- * Emulated 1-byte cmpxchg operation for architectures lacking direct
>- * support for this size.  This is implemented in terms of 4-byte cmpxchg
>- * operations.
>+ * Emulated 1-byte and 2-byte cmpxchg operations for architectures lacking
>+ * direct support for these sizes.  These are implemented in terms of
>+ * 4-byte cmpxchg operations.
>  *
>- * Copyright (C) 2024 Paul E. McKenney.
>+ * Copyright (C) 2024 Paul E. McKenney <paulmck@kernel.org>
>+ * Copyright (C) 2026 Bradley Morgan <brads@mainlining.org>
>  */
> 
> #include <linux/types.h>
>@@ -43,3 +44,32 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> 	return old;
> }
> EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
>+
>+union u16_32 {
>+	u16 h[2];
>+	u32 w;
>+};
>+
>+/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
>+u16 cmpxchg_emu_u16(volatile u16 *p, u16 old, u16 new)
>+{
>+	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
>+	int i = (((uintptr_t)p) & 0x2) / 2;
>+	union u16_32 old32;
>+	union u16_32 new32;
>+	u32 ret;
>+
>+	WARN_ON_ONCE(((uintptr_t)p) & 0x1);
>+	ret = READ_ONCE(*p32);
>+	do {
>+		old32.w = ret;
>+		if (old32.h[i] != old)
>+			return old32.h[i];
>+		new32.w = old32.w;
>+		new32.h[i] = new;
>+		instrument_atomic_read_write(p, 2);
>+		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
>+	} while (ret != old32.w);
>+	return old;
>+}
>+EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);
>

<Comment> Will this rename cause a build regression for ARM V6
architectures?
It appears that arch/arm/Kconfig was not updated alongside the others and
still attempts to select the old symbol:
	select ARCH_NEED_CMPXCHG_1_EMU if CPU_V6
If ARM CPU_V6 code relies on __cmpxchg() calling cmpxchg_emu_u8(), could
this result in an undefined reference since the Kconfig dependency chain is
broken and the emulation library won't be compiled? <Comment>


Deliberate, will be dead code after ardbs series is merged.
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
