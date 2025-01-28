Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428C1DF250;
	Tue, 28 Jan 2025 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053808; cv=pass; b=uDEQJ759+FLfaixG3XYOFsLuiBER5JBceYVwScFu4WNnQyNPybPZcYfVWJneKowbyRITohnCK2Bpqm3a+ZdvDryFCVOiR0vjPlTqif7kNa1Vhk1VcRu4+GRrNhw0IkMLRIra8L6O+FdJfgrxznJ8UGqMkVuYzP9PFizcRHZYhus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053808; c=relaxed/simple;
	bh=3doHFkzjsq+ipMFQyXsACTky5fspIz7lN86s+fdYHYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Pn1EfJ6EHDJcabEydR/yiSSnFOKGjZACO4m2C69gGZUN1sfsV3oImIT2NySNDcNVs7k4CyGaXmpTi1a3hZIT8cxR2XnF2WE603c8jZYPJmBfOjQFr/gIE/ILN6Wv22O340Sb35UPnw5c4j6sBgQtsL/TBhPRaGwlRiujRMsz0z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=fF0DzmvS; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=84Mod60X; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="fF0DzmvS";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="84Mod60X"
ARC-Seal: i=1; a=rsa-sha256; t=1738053788; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IXWq/s88KXRqC6ykVaEfmapcUGRZBZieuYZZNImcV5Rzaa7s9p995LBXRP8m+NGu99
    NT5oTIPIm2bT2+FUu6FA9FP5GTDhMP4BQ3g7sOWuXHybylhVy/HjiZOU7yXIXt93ENPw
    Lg7lyxRnYI4tWCJLDtVMhL94k+ijpUYa4WDGnNw11j7tWjERFUWb4Mqgdnvpzbt81QE2
    rVwZ27aLly8q6JFJBA7rEhI54z8s94xFzqz7kYVIHtunxzcHSZIKuNVL77ShhP/+ZcCY
    wX+t2Mk/5Mfp+nq5IsgdyNeP6/ZaPL14VLzoN4k4XW7k3sroMGejkvTWmOEJFUN4m5RL
    ZC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1738053788;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=9Jqsbtm4hPLjQVWFiGaPCVZK4atmLMRdIUOO7zygNsw=;
    b=npY2NcN0Q8CzUh82qVMhKPwjSSQOt+OCCbvE9Acddt9TTXtmOE1dbXdT5dC6SnEKRq
    o2i1wpBLn8D9ORlhn+nIPhzseydIJRP4QU8CwJYTtofRnP6kfdUqAQQAYMY4ApwqJRCR
    Ph9zWIXvYgeNtZ/U+5KywNi/EIvLqTcdcgn5xNSW1YYoOxE4okgTcHX/Bw086D/DHML6
    CumlInwXNgnSKwjIwAN7e+4DCshbqZiocmle8mksw/8n/lc7sbFXuNo5s92Ww+3gKGQR
    UpFaJ4/hHz+E4Dct6sT96FlwgO/EABKVvIP1alBWazGR1wQCaPMHqmREUvqgKU+alqZE
    IBjw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1738053788;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=9Jqsbtm4hPLjQVWFiGaPCVZK4atmLMRdIUOO7zygNsw=;
    b=fF0DzmvS9Bhyle2dwjMekGMhPiPSQfJCmEcQej7v3fgtKV8Sy/VWZUQdssqy7zy1bV
    XL3Wn3I1qh0ZjC1m+C6inAWS6b0fKETDoNuLrxd+kLcJ00hrryyel0TyJ1puHubjtdAx
    E+gNN1aJr77Ck/Vooq0K+w89eqMSSUsLckjJz1KD0WnTRHoYLq1Zlpba1WlQbHI89ao3
    PO0QoMn1dFXetGfVKIOjmUxhYUn7aZB2eT5Y385JVWmYejNrr+RQ8ru2hoTQ+gyItMju
    5Wka0gwO/jArGWfuJHef/AX/4EABemL77BD6qcZJ1E5Heb3N+PM+2BgukIW+XCY+i5fH
    SAGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1738053788;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=9Jqsbtm4hPLjQVWFiGaPCVZK4atmLMRdIUOO7zygNsw=;
    b=84Mod60Xu+POWrbjEFxWGcTL34vUwlZpkthJKbiQe9yW3DEOiJYZoystNI6xDhqwh0
    b1H5ydT45xa7L8Ja3TBw==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.2.17 AUTH)
    with ESMTPSA id J1a25110S8h70Lu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Jan 2025 09:43:07 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] sh: Remove IO memcpy and memset from sh code
Date: Tue, 28 Jan 2025 09:42:54 +0100
Message-Id: <20250128084254.1408815-1-julian@outer-limits.org>
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
new implementation from lib/iomem_copy.c. It uses word accesses if the
buffers are aligned and only falls back to byte accesses for potentially
unaligned parts of a buffer. Keep only the SH4 optimized memcpy_fromio.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 arch/sh/include/asm/io.h |  8 ++----
 arch/sh/kernel/io.c      | 62 ++--------------------------------------
 2 files changed, 6 insertions(+), 64 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf5eab840d57..89a9b86bf844 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -269,12 +269,10 @@ __BUILD_IOPORT_STRING(q, u64)
 #define IO_SPACE_LIMIT 0xffffffff
 
 /* We really want to try and get these to memcpy etc */
-#define memset_io memset_io
+#ifdef CONFIG_CPU_SH4
 #define memcpy_fromio memcpy_fromio
-#define memcpy_toio memcpy_toio
-void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
-void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
-void memset_io(volatile void __iomem *, int, unsigned long);
+void memcpy_fromio(void *, const volatile void __iomem *, size_t);
+#endif
 
 /* Quad-word real-mode I/O, don't ask.. */
 unsigned long long peek_real_address_q(unsigned long long addr);
diff --git a/arch/sh/kernel/io.c b/arch/sh/kernel/io.c
index da22f3b32d30..a3e181643f75 100644
--- a/arch/sh/kernel/io.c
+++ b/arch/sh/kernel/io.c
@@ -5,21 +5,18 @@
  * Copyright (C) 2000 - 2009  Stuart Menefy
  * Copyright (C) 2005  Paul Mundt
  */
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <asm/machvec.h>
 #include <asm/io.h>
 
 /*
  * Copy data from IO memory space to "real" memory space.
  */
-void memcpy_fromio(void *to, const volatile void __iomem *from, unsigned long count)
+#ifdef CONFIG_CPU_SH4
+void memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 {
 	/*
 	 * Would it be worthwhile doing byte and long transfers first
 	 * to try and get aligned?
 	 */
-#ifdef CONFIG_CPU_SH4
 	if ((count >= 0x20) &&
 	     (((u32)to & 0x1f) == 0) && (((u32)from & 0x3) == 0)) {
 		int tmp2, tmp3, tmp4, tmp5, tmp6;
@@ -53,59 +50,6 @@ void memcpy_fromio(void *to, const volatile void __iomem *from, unsigned long co
 			: "7"(from), "0" (to), "1" (count)
 			: "r0", "r7", "t", "memory");
 	}
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
 }
 EXPORT_SYMBOL(memcpy_fromio);
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
+#endif
-- 
2.34.1

