From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Dec 2019 01:24:09 +0000
Subject: [PATCH v2 2/3] sh: fixup strncpy() warning and add missing padding
Message-Id: <87tv5xyuo6.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87woatyutt.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87woatyutt.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Karl Nasrallah <knnspeed@aol.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Karl Nasrallah <knnspeed@aol.com>

Current SH will get below warning at strncpy()

In file included from ${LINUX}/arch/sh/include/asm/string.h:3,
                 from ${LINUX}/include/linux/string.h:20,
                 from ${LINUX}/include/linux/bitmap.h:9,
                 from ${LINUX}/include/linux/nodemask.h:95,
                 from ${LINUX}/include/linux/mmzone.h:17,
                 from ${LINUX}/include/linux/gfp.h:6,
                 from ${LINUX}/innclude/linux/slab.h:15,
                 from ${LINUX}/linux/drivers/mmc/host/vub300.c:38:
${LINUX}/drivers/mmc/host/vub300.c: In function 'new_system_port_status':
${LINUX}/arch/sh/include/asm/string_32.h:51:42: warning: array subscript\
  80 is above array bounds of 'char[26]' [-Warray-bounds]
   : "0" (__dest), "1" (__src), "r" (__src+__n)
                                     ~~~~~^~~~

And current implementation is missing padding which strncpy()
should support.

This patch solves these 2 issues.

Signed-off-by: Karl Nasrallah <knnspeed@aol.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

	- tidyup git-log
	- tidyup 80char
	- tidyup Subject

 arch/sh/include/asm/string_32.h | 58 +++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/sh/include/asm/string_32.h b/arch/sh/include/asm/string_32.h
index 3558b1d..3b4aec0 100644
--- a/arch/sh/include/asm/string_32.h
+++ b/arch/sh/include/asm/string_32.h
@@ -31,27 +31,47 @@ static inline char *strcpy(char *__dest, const char *__src)
 #define __HAVE_ARCH_STRNCPY
 static inline char *strncpy(char *__dest, const char *__src, size_t __n)
 {
-	register char *__xdest = __dest;
-	unsigned long __dummy;
+	char * retval = __dest;
+	const char * __dest_end = __dest + __n - 1;
+	register unsigned int * r0_register __asm__ ("r0");
 
+	/* size_t is always unsigned */
 	if (__n = 0)
-		return __xdest;
-
-	__asm__ __volatile__(
-		"1:\n"
-		"mov.b	@%1+, %2\n\t"
-		"mov.b	%2, @%0\n\t"
-		"cmp/eq	#0, %2\n\t"
-		"bt/s	2f\n\t"
-		" cmp/eq	%5,%1\n\t"
-		"bf/s	1b\n\t"
-		" add	#1, %0\n"
-		"2:"
-		: "=r" (__dest), "=r" (__src), "=&z" (__dummy)
-		: "0" (__dest), "1" (__src), "r" (__src+__n)
-		: "memory", "t");
-
-	return __xdest;
+		return retval;
+
+	/*
+	 * Some notes:
+	 * - cmp/eq #imm8,r0 is its own instruction
+	 * - incrementing dest and comparing to dest_end handles the size
+	 *   parameter in only one instruction
+	 * - mov.b R0,@Rn+ is SH2A only, but we can fill a delay slot with
+	 *   "add #1,%[dest]"
+	 */
+
+	__asm__ __volatile__ (
+		"strncpy_start:\n\t"
+		"mov.b @%[src]+,%[r0_reg]\n\t"
+		"cmp/eq #0,%[r0_reg]\n\t"
+		"bt.s strncpy_pad\n\t"
+		"cmp/eq %[dest],%[dest_end]\n\t"
+		"bt.s strncpy_end\n\t"
+		"mov.b %[r0_reg],@%[dest]\n\t"
+		"bra strncpy_start\n\t"
+		"add #1,%[dest]\n\t"
+		"strncpy_pad:\n\t"
+		"bt.s strncpy_end\n\t"
+		"mov.b %[r0_reg],@%[dest]\n\t"
+		"add #1,%[dest]\n\t"
+		"bra strncpy_pad\n\t"
+		"cmp/eq %[dest],%[dest_end]\n\t"
+		"strncpy_end:\n\t"
+		: [src] "+r" (__src), [dest] "+r" (__dest),
+		  [r0_reg] "+&z" (r0_register)
+		: [dest_end] "r" (__dest_end)
+		: "t","memory"
+		);
+
+	return retval;
 }
 
 #define __HAVE_ARCH_STRCMP
-- 
2.7.4
