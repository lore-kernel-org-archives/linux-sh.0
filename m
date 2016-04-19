From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 06:58:53 +0000
Subject: [PATCH] sh: cmpxchg: fix a  bit shift bug in big_endian os
Message-Id: <5715D72D.7060501@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: ysato@users.sourceforge.jp, dalias@libc.org, mst@redhat.com, peterz@infradead.org, linux-sh@vger.kernel.org

From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

Correct bitoff in big endian OS.

Fixes: 3226aad81aa6 ("sh: support 1 and 2 byte xchg")
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/sh/include/asm/cmpxchg-xchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/arch/sh/include/asm/cmpxchg-xchg.h
index 7219719..1e881f5 100644
--- a/arch/sh/include/asm/cmpxchg-xchg.h
+++ b/arch/sh/include/asm/cmpxchg-xchg.h
@@ -21,7 +21,7 @@ static inline u32 __xchg_cmpxchg(volatile void *ptr, u32 x, int size)
 	int off = (unsigned long)ptr % sizeof(u32);
 	volatile u32 *p = ptr - off;
 #ifdef __BIG_ENDIAN
-	int bitoff = (sizeof(u32) - 1 - off) * BITS_PER_BYTE;
+	int bitoff = (sizeof(u32) - size - off) * BITS_PER_BYTE;
 #else
 	int bitoff = off * BITS_PER_BYTE;
 #endif
-- 
1.9.1

