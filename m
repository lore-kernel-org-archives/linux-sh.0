From: Stephen Boyd <sboyd@codeaurora.org>
Date: Wed, 27 Jan 2016 23:36:54 +0000
Subject: [RFC/PATCH] sh: Use generic clkdev.h header
Message-Id: <1453937814-17819-1-git-send-email-sboyd@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

The generic header file is almost equivalent to the SH one. The
only difference is that the SH one supports allocating clkdev
lookups early using bootmem allocators instead of the slabs. From
what I can tell using visual inspection, the slab is initialized
before any clkdev allocation is made under arch/sh. So let's
remove the arch specific clkdev.h header and use the generic one
instead.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Not even compile tested, but done with visual inspection.

 arch/sh/include/asm/Kbuild   |  1 +
 arch/sh/include/asm/clkdev.h | 33 ---------------------------------
 2 files changed, 1 insertion(+), 33 deletions(-)
 delete mode 100644 arch/sh/include/asm/clkdev.h

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index aac452b26aa8..a319745a7b63 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,5 +1,6 @@
 
 generic-y += bitsperlong.h
+generic-y += clkdev.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += delay.h
diff --git a/arch/sh/include/asm/clkdev.h b/arch/sh/include/asm/clkdev.h
deleted file mode 100644
index c41901465fb0..000000000000
--- a/arch/sh/include/asm/clkdev.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  Copyright (C) 2010 Paul Mundt <lethal@linux-sh.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Helper for the clk API to assist looking up a struct clk.
- */
-
-#ifndef __CLKDEV__H_
-#define __CLKDEV__H_
-
-#include <linux/bootmem.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-
-#include <asm/clock.h>
-
-static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
-{
-	if (!slab_is_available())
-		return alloc_bootmem_low_pages(size);
-	else
-		return kzalloc(size, GFP_KERNEL);
-}
-
-#ifndef CONFIG_COMMON_CLK
-#define __clk_put(clk)
-#define __clk_get(clk) ({ 1; })
-#endif
-
-#endif /* __CLKDEV_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

