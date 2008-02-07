From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Feb 2008 10:50:52 +0000
Subject: [PATCH] sh: make copy_to/from_user() static inline
Message-Id: <20080207105052.9553.69636.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch changes copy_from_user() and copy_to_user() from macros
into static inline functions. This way we can use them as function
pointers. Also unify the 64 bit and 32 bit versions.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/asm-sh/uaccess.h    |   29 +++++++++++++++++++++++++++++
 include/asm-sh/uaccess_32.h |   24 +++---------------------
 include/asm-sh/uaccess_64.h |   19 -------------------
 3 files changed, 32 insertions(+), 40 deletions(-)

--- 0001/include/asm-sh/uaccess.h
+++ work/include/asm-sh/uaccess.h	2008-02-07 19:42:10.000000000 +0900
@@ -1,5 +1,34 @@
+#ifndef __ASM_SH_UACCESS_H
+#define __ASM_SH_UACCESS_H
+
 #ifdef CONFIG_SUPERH32
 # include "uaccess_32.h"
 #else
 # include "uaccess_64.h"
 #endif
+
+static inline unsigned long
+copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long __copy_from = (unsigned long) from;
+	__kernel_size_t __copy_size = (__kernel_size_t) n;
+
+	if (__copy_size && __access_ok(__copy_from, __copy_size))
+		return __copy_user(to, from, __copy_size);
+
+	return __copy_size;
+}
+
+static inline unsigned long
+copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long __copy_to = (unsigned long) to;
+	__kernel_size_t __copy_size = (__kernel_size_t) n;
+
+	if (__copy_size && __access_ok(__copy_to, __copy_size))
+		return __copy_user(to, from, __copy_size);
+
+	return __copy_size;
+}
+
+#endif /* __ASM_SH_UACCESS_H */
--- 0001/include/asm-sh/uaccess_32.h
+++ work/include/asm-sh/uaccess_32.h	2008-02-07 18:46:35.000000000 +0900
@@ -10,8 +10,8 @@
  *              Copyright (C) 1996, 1997, 1998 by Ralf Baechle
  *     and i386 version.
  */
-#ifndef __ASM_SH_UACCESS_H
-#define __ASM_SH_UACCESS_H
+#ifndef __ASM_SH_UACCESS_32_H
+#define __ASM_SH_UACCESS_32_H
 
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -302,24 +302,6 @@ extern void __put_user_unknown(void);
 /* Return the number of bytes NOT copied */
 __kernel_size_t __copy_user(void *to, const void *from, __kernel_size_t n);
 
-#define copy_to_user(to,from,n) ({ \
-void *__copy_to = (void *) (to); \
-__kernel_size_t __copy_size = (__kernel_size_t) (n); \
-__kernel_size_t __copy_res; \
-if(__copy_size && __access_ok((unsigned long)__copy_to, __copy_size)) { \
-__copy_res = __copy_user(__copy_to, (void *) (from), __copy_size); \
-} else __copy_res = __copy_size; \
-__copy_res; })
-
-#define copy_from_user(to,from,n) ({ \
-void *__copy_to = (void *) (to); \
-void *__copy_from = (void *) (from); \
-__kernel_size_t __copy_size = (__kernel_size_t) (n); \
-__kernel_size_t __copy_res; \
-if(__copy_size && __access_ok((unsigned long)__copy_from, __copy_size)) { \
-__copy_res = __copy_user(__copy_to, __copy_from, __copy_size); \
-} else __copy_res = __copy_size; \
-__copy_res; })
 
 static __always_inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
@@ -507,4 +489,4 @@ struct exception_table_entry
 
 extern int fixup_exception(struct pt_regs *regs);
 
-#endif /* __ASM_SH_UACCESS_H */
+#endif /* __ASM_SH_UACCESS_32_H */
--- 0001/include/asm-sh/uaccess_64.h
+++ work/include/asm-sh/uaccess_64.h	2008-02-07 18:46:35.000000000 +0900
@@ -202,15 +202,6 @@ extern void __put_user_unknown(void);
 /* XXX: should be such that: 4byte and the rest. */
 extern __kernel_size_t __copy_user(void *__to, const void *__from, __kernel_size_t __n);
 
-#define copy_to_user(to,from,n) ({ \
-void *__copy_to = (void *) (to); \
-__kernel_size_t __copy_size = (__kernel_size_t) (n); \
-__kernel_size_t __copy_res; \
-if(__copy_size && __access_ok((unsigned long)__copy_to, __copy_size)) { \
-__copy_res = __copy_user(__copy_to, (void *) (from), __copy_size); \
-} else __copy_res = __copy_size; \
-__copy_res; })
-
 #define copy_to_user_ret(to,from,n,retval) ({ \
 if (copy_to_user(to,from,n)) \
 	return retval; \
@@ -225,16 +216,6 @@ if (__copy_to_user(to,from,n)) \
 	return retval; \
 })
 
-#define copy_from_user(to,from,n) ({ \
-void *__copy_to = (void *) (to); \
-void *__copy_from = (void *) (from); \
-__kernel_size_t __copy_size = (__kernel_size_t) (n); \
-__kernel_size_t __copy_res; \
-if(__copy_size && __access_ok((unsigned long)__copy_from, __copy_size)) { \
-__copy_res = __copy_user(__copy_to, __copy_from, __copy_size); \
-} else __copy_res = __copy_size; \
-__copy_res; })
-
 #define copy_from_user_ret(to,from,n,retval) ({ \
 if (copy_from_user(to,from,n)) \
 	return retval; \
