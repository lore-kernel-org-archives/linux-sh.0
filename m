From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 02 Jan 2018 10:57:51 +0000
Subject: [PATCH] sh: shut up gcc-8 warnings
Message-Id: <20180102105805.1688638-1-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Many uses of strncpy() on sh causes  a warning like

arch/sh/include/asm/string_32.h:50:42: warning: array subscript is above array bounds [-Warray-bounds]

This avoids the warning by turning the pointer arithmetic into an
integer operation that does not get checked the same way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/string_32.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/string_32.h b/arch/sh/include/asm/string_32.h
index 55f8db6bc1d7..98ddb5bbd3b8 100644
--- a/arch/sh/include/asm/string_32.h
+++ b/arch/sh/include/asm/string_32.h
@@ -47,7 +47,7 @@ static inline char *strncpy(char *__dest, const char *__src, size_t __n)
 		" add	#1, %0\n"
 		"2:"
 		: "=r" (__dest), "=r" (__src), "=&z" (__dummy)
-		: "0" (__dest), "1" (__src), "r" (__src+__n)
+		: "0" (__dest), "1" (__src), "r" ((uintptr_t)__src+__n)
 		: "memory", "t");
 
 	return __xdest;
@@ -105,7 +105,7 @@ static inline int strncmp(const char *__cs, const char *__ct, size_t __n)
 		"sub	%3, %2\n"
 		"3:"
 		:"=r" (__cs), "=r" (__ct), "=&r" (__res), "=&z" (__dummy)
-		: "0" (__cs), "1" (__ct), "r" (__cs+__n)
+		: "0" (__cs), "1" (__ct), "r" ((uintptr_t)__cs+__n)
 		: "t");
 
 	return __res;
-- 
2.9.0

