From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Dec 2019 01:24:47 +0000
Subject: [PATCH 3/3] sh: use generic strncpy()
Message-Id: <87sglhyun4.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87woatyutt.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87woatyutt.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Karl Nasrallah <knnspeed@aol.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

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

It needs big fixup to solve these issues,
then, __asm__ code is difficult to maintenance.

To solve/avoid these issues, this patch uses generic strncpy()
instead of architecture specific one.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

	- tidyup git-log

 arch/sh/include/asm/string_32.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/sh/include/asm/string_32.h b/arch/sh/include/asm/string_32.h
index 3558b1d..be3f9a0 100644
--- a/arch/sh/include/asm/string_32.h
+++ b/arch/sh/include/asm/string_32.h
@@ -28,32 +28,6 @@ static inline char *strcpy(char *__dest, const char *__src)
 	return __xdest;
 }
 
-#define __HAVE_ARCH_STRNCPY
-static inline char *strncpy(char *__dest, const char *__src, size_t __n)
-{
-	register char *__xdest = __dest;
-	unsigned long __dummy;
-
-	if (__n = 0)
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
-}
-
 #define __HAVE_ARCH_STRCMP
 static inline int strcmp(const char *__cs, const char *__ct)
 {
-- 
2.7.4
