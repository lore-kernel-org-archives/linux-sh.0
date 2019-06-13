From: Christoph Hellwig <hch@lst.de>
Date: Thu, 13 Jun 2019 07:08:49 +0000
Subject: [PATCH 03/17] binfmt_flat: provide a default version of flat_get_relocate_addr
Message-Id: <20190613070903.17214-4-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190613070903.17214-1-hch@lst.de>
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

This way only the two architectures that do masking need to provide
the helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/flat.h    | 2 --
 arch/c6x/include/asm/flat.h    | 1 -
 arch/m68k/include/asm/flat.h   | 1 -
 arch/sh/include/asm/flat.h     | 1 -
 arch/xtensa/include/asm/flat.h | 1 -
 fs/binfmt_flat.c               | 4 ++++
 6 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
index 576241d74704..a185fe023b60 100644
--- a/arch/arm/include/asm/flat.h
+++ b/arch/arm/include/asm/flat.h
@@ -30,6 +30,4 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 #endif
 }
 
-#define	flat_get_relocate_addr(rel)		(rel)
-
 #endif /* __ARM_FLAT_H__ */
diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
index ac87368efad1..c4d703b454c6 100644
--- a/arch/c6x/include/asm/flat.h
+++ b/arch/c6x/include/asm/flat.h
@@ -17,6 +17,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 	put_unaligned(addr, (__force u32 *)rp);
 	return 0;
 }
-#define flat_get_relocate_addr(rel)			(rel)
 
 #endif /* __ASM_C6X_FLAT_H */
diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
index 955617bb937b..217fa89c8e34 100644
--- a/arch/m68k/include/asm/flat.h
+++ b/arch/m68k/include/asm/flat.h
@@ -28,7 +28,6 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 	return put_user(addr, rp);
 #endif
 }
-#define	flat_get_relocate_addr(rel)		(rel)
 
 #define FLAT_PLAT_INIT(regs) \
 	do { \
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 6f3b18679a98..0d520b4cc5ea 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -24,7 +24,6 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 	put_unaligned(addr, (__force u32 *)rp);
 	return 0;
 }
-#define	flat_get_relocate_addr(rel)		(rel)
 
 #define FLAT_PLAT_INIT(_r) \
   do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
index b1bc0d9a8d4e..a1d88aa3ef8a 100644
--- a/arch/xtensa/include/asm/flat.h
+++ b/arch/xtensa/include/asm/flat.h
@@ -17,6 +17,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 	put_unaligned(addr, (__force u32 *)rp);
 	return 0;
 }
-#define flat_get_relocate_addr(rel)			(rel)
 
 #endif /* __ASM_XTENSA_FLAT_H */
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index a4c0b245ab1f..c0e4535dc1ec 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -43,6 +43,10 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 
+#ifndef flat_get_relocate_addr
+#define flat_get_relocate_addr(rel)	(rel)
+#endif
+
 /****************************************************************************/
 
 /*
-- 
2.20.1
