From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Feb 2008 10:28:53 +0000
Subject: [PATCH] sh: fix readsl/writesl argument
Message-Id: <20080220102853.22714.57848.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

writesl() and readsl() use void __iomem * as argument but the current sh 
version of __raw_writesl()/__rawreadsl() takes unsigned long. Casting the
pointer fixes smc91x warnings.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/asm-sh/io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/include/asm-sh/io.h
+++ work/include/asm-sh/io.h	2008-02-20 16:34:28.000000000 +0900
@@ -162,8 +162,8 @@ static inline void reads##bwlq(volatile 
 
 __BUILD_MEMORY_STRING(b, u8)
 __BUILD_MEMORY_STRING(w, u16)
-#define writesl __raw_writesl
-#define readsl  __raw_readsl
+#define writesl(m, a, c) __raw_writesl((unsigned long)(m), (a), (c))
+#define readsl(m, a, c)  __raw_readsl((unsigned long)(m), (a), (c))
 
 #define readb_relaxed(a) readb(a)
 #define readw_relaxed(a) readw(a)
