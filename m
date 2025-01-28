Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA71199EAD;
	Tue, 28 Jan 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059205; cv=pass; b=tc4k6njfFtW423QEXx12ANz3e0vGnIA5+UPSEc0oyr2coNTkTQSewSyrVk3wUFkFABEMUCDS6XGPZd1jHMfmBXHc/p6bX6FITCksi8uAHAdA4Dr3q+B1JsSkaL5ZM4ACOfFpsiMivfTQyDXyRS3/MxUO8NVOfCloASqs7VsdyiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059205; c=relaxed/simple;
	bh=EdA22AkyRoAizIpB0PGxRDeAueKtCPwFuj3iWnoUJtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WCy3OoSxWj+JHMYsTh4IM2QimPJjCVNxpneVt4F+Z/iOHxZQERhb9VGdjcyls1V3QZinH30iI4xn9GgR1BSG1W2BOCf0H1bBkD2BS/bQDuTGzE3UuLZ1z3CHlNHlBRFa3UPUfyuw/dGSI4pUYnOBob0TdKgcn2zCzRgxj8hvI/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=igoSZ0Su; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=jcb9npVI; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="igoSZ0Su";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="jcb9npVI"
ARC-Seal: i=1; a=rsa-sha256; t=1738059193; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZKwm6jTj3bB7wiN7CoRMiLzM49QEBwUp8DrU7fXD7GYrJlxOpJvmYOVjBLFlfhFxC7
    l/6SzLqCMSbFBks+W4bC8A00+8dng1mb9d4qM6slJw32DX5xs0vArkE6rW0nyXf6xtUa
    o57XDFbAj82uF8WOk3+t/I5KDT3eVpowG0fxeEmAxEAMkoIn1Crmex7QpstGnwJ+m9f5
    n8TuRfndbImkBNJe09nxH+BQ32OqIdjgOHH/T6pqWUS+el5X/hZgwYsUpyEHboEG0Sao
    /BihIqTwh1mNXCcVb6ZQ0DxnEfZ6UDaiGtABaxO/tZxozaL87qRwPqNa1IFldMANT4Sv
    b1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1738059193;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UeGEL5ZN9u1XMTWwIoSZ4Kd9XnK2HX8VS2EFGTPLILg=;
    b=nRbkct9nLkrPJPWPmr5/a12ag2CSnMLeBKMYBG1zfuadoFzotfGCByI9VmQbriC6kb
    y208fJZ+izctioxoUaz9Yw/SHZ3QU2sZzydzlgLH7HAQ8afMozRqL6T59tALpK9YbHTo
    30e9yOAwgk9D48BOKnCSHnld3YbUqkev8R7kQyNkG6GGUhyMs3unzsFW0f1gigL4nmhX
    JYiQ4qPBHaAhfHHaOr3ycoY43PF6CyZhvbcWsFkuJbx5N8/Z33UFYGw4JZv+aqcvad8n
    oX29W/tpV28n35W6ECMjEBKtZ0O8wpD0wHCvy1aa4Du7x5cYhUGROif/RSoFzQ8n59mq
    VqXg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1738059193;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UeGEL5ZN9u1XMTWwIoSZ4Kd9XnK2HX8VS2EFGTPLILg=;
    b=igoSZ0SuLNfwFO/xSwwKtELc26vq6OPhFAWF5WFA7WJK8r4os0O/8A1MxEyXiZryXA
    Uz0IXhnDNJp4sLJ4Y90uVZRnkLJK1zEI7ER9TX8ROfPkuFI440zsV/YXmrWwCfZits6J
    /8nwSh+Bo4xhlDRkzZhTNCUv3sLVoFhLBw/4y9XIXLdbHGrOAjx5zyXFCjFqY1cUSEh0
    MClkW1DWgTFZzKrPY9n7XnSZ4YljDN1H5/EATaur1AYozw9CDX5J4MheZEZJjzswZ3Bo
    tIrjsapY+RfWubSV76e3x9qyWI0enipnDaPVCBY48t1PzNNEh/D1KkcQRCZ3v3p3IkzA
    BgzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1738059193;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UeGEL5ZN9u1XMTWwIoSZ4Kd9XnK2HX8VS2EFGTPLILg=;
    b=jcb9npVIzioZmgdcNKcUew+ubDhJBT6dYNIxOMD9GcgBoJg56fYD89lj0QKm9LVdxR
    PtuHvoHbO/+FqPfcyZBQ==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.2.17 AUTH)
    with ESMTPSA id J1a25110SADC1WS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Jan 2025 11:13:12 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH v2] sh: Remove IO memcpy and memset from sh code
Date: Tue, 28 Jan 2025 11:13:06 +0100
Message-Id: <20250128101306.1475491-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Remove IO memcpy and memset from sh specific code and fall back to the
new implementations from lib/iomem_copy.c. They use word accesses if the
buffers are aligned and only fall back to byte accesses for potentially
unaligned parts of a buffer.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
Changes for V2:
- Removed also SH4 specific memcpy_fromio code
---
 arch/sh/include/asm/io.h |   8 ---
 arch/sh/kernel/io.c      | 111 ---------------------------------------
 2 files changed, 119 deletions(-)
 delete mode 100644 arch/sh/kernel/io.c

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf5eab840d57..1e33a1c8b72d 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -268,14 +268,6 @@ __BUILD_IOPORT_STRING(q, u64)
 
 #define IO_SPACE_LIMIT 0xffffffff
 
-/* We really want to try and get these to memcpy etc */
-#define memset_io memset_io
-#define memcpy_fromio memcpy_fromio
-#define memcpy_toio memcpy_toio
-void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
-void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
-void memset_io(volatile void __iomem *, int, unsigned long);
-
 /* Quad-word real-mode I/O, don't ask.. */
 unsigned long long peek_real_address_q(unsigned long long addr);
 unsigned long long poke_real_address_q(unsigned long long addr,
diff --git a/arch/sh/kernel/io.c b/arch/sh/kernel/io.c
deleted file mode 100644
index da22f3b32d30..000000000000
--- a/arch/sh/kernel/io.c
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * arch/sh/kernel/io.c - Machine independent I/O functions.
- *
- * Copyright (C) 2000 - 2009  Stuart Menefy
- * Copyright (C) 2005  Paul Mundt
- */
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <asm/machvec.h>
-#include <asm/io.h>
-
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void memcpy_fromio(void *to, const volatile void __iomem *from, unsigned long count)
-{
-	/*
-	 * Would it be worthwhile doing byte and long transfers first
-	 * to try and get aligned?
-	 */
-#ifdef CONFIG_CPU_SH4
-	if ((count >= 0x20) &&
-	     (((u32)to & 0x1f) == 0) && (((u32)from & 0x3) == 0)) {
-		int tmp2, tmp3, tmp4, tmp5, tmp6;
-
-		__asm__ __volatile__(
-			"1:			\n\t"
-			"mov.l	@%7+, r0	\n\t"
-			"mov.l	@%7+, %2	\n\t"
-			"movca.l r0, @%0	\n\t"
-			"mov.l	@%7+, %3	\n\t"
-			"mov.l	@%7+, %4	\n\t"
-			"mov.l	@%7+, %5	\n\t"
-			"mov.l	@%7+, %6	\n\t"
-			"mov.l	@%7+, r7	\n\t"
-			"mov.l	@%7+, r0	\n\t"
-			"mov.l	%2, @(0x04,%0)	\n\t"
-			"mov	#0x20, %2	\n\t"
-			"mov.l	%3, @(0x08,%0)	\n\t"
-			"sub	%2, %1		\n\t"
-			"mov.l	%4, @(0x0c,%0)	\n\t"
-			"cmp/hi	%1, %2		! T if 32 > count	\n\t"
-			"mov.l	%5, @(0x10,%0)	\n\t"
-			"mov.l	%6, @(0x14,%0)	\n\t"
-			"mov.l	r7, @(0x18,%0)	\n\t"
-			"mov.l	r0, @(0x1c,%0)	\n\t"
-			"bf.s	1b		\n\t"
-			" add	#0x20, %0	\n\t"
-			: "=&r" (to), "=&r" (count),
-			  "=&r" (tmp2), "=&r" (tmp3), "=&r" (tmp4),
-			  "=&r" (tmp5), "=&r" (tmp6), "=&r" (from)
-			: "7"(from), "0" (to), "1" (count)
-			: "r0", "r7", "t", "memory");
-	}
-#endif
-
-	if ((((u32)to | (u32)from) & 0x3) == 0) {
-		for (; count > 3; count -= 4) {
-			*(u32 *)to = *(volatile u32 *)from;
-			to += 4;
-			from += 4;
-		}
-	}
-
-	for (; count > 0; count--) {
-		*(u8 *)to = *(volatile u8 *)from;
-		to++;
-		from++;
-	}
-
-	mb();
-}
-EXPORT_SYMBOL(memcpy_fromio);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void memcpy_toio(volatile void __iomem *to, const void *from, unsigned long count)
-{
-	if ((((u32)to | (u32)from) & 0x3) == 0) {
-		for ( ; count > 3; count -= 4) {
-			*(volatile u32 *)to = *(u32 *)from;
-			to += 4;
-			from += 4;
-		}
-	}
-
-	for (; count > 0; count--) {
-		*(volatile u8 *)to = *(u8 *)from;
-		to++;
-		from++;
-	}
-
-	mb();
-}
-EXPORT_SYMBOL(memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- * This needs to be optimized.
- */
-void memset_io(volatile void __iomem *dst, int c, unsigned long count)
-{
-        while (count) {
-                count--;
-                writeb(c, dst);
-                dst++;
-        }
-}
-EXPORT_SYMBOL(memset_io);
-- 
2.34.1

