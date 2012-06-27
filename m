From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 27 Jun 2012 13:52:27 +0000
Subject: [PATCH] asm-generic: fix compile breakage "'TAINT_WARN' undeclared"
Message-Id: <Pine.LNX.4.64.1206271507200.24173@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org

TAINT_WARN is defined in kernel.h and used in asm-generic/bug.h. Not 
including kernel.h there breaks build on sh:

In file included from linux/include/linux/thread_info.h:54,
                 from linux/include/linux/preempt.h:9,
                 from linux/include/linux/spinlock.h:50,
                 from linux/include/linux/mmzone.h:7,
                 from linux/include/linux/gfp.h:4,
                 from linux/include/linux/mm.h:8,
                 from linux/arch/sh/kernel/asm-offsets.c:13:
linux/arch/sh/include/asm/thread_info.h: In function 'set_restore_sigmask':
linux/arch/sh/include/asm/thread_info.h:172: error: 'TAINT_WARN' undeclared (first use in this function)
linux/arch/sh/include/asm/thread_info.h:172: error: (Each undeclared identifier is reported only once
linux/arch/sh/include/asm/thread_info.h:172: error: for each function it appears in.)

Also, since nothing in bug.h is usable from assembly, it is safe to extend 
the "#ifndef __ASSEMBLY__" block over all WARN() macros.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Compile-tested a couple of configurations on sh, ARM, x86

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 2520a6e..f4965c0 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -59,8 +59,8 @@ struct bug_entry {
  * appear at runtime.  Use the versions with printk format strings
  * to provide better diagnostics.
  */
-#ifndef __WARN_TAINT
 #ifndef __ASSEMBLY__
+#ifndef __WARN_TAINT
 extern __printf(3, 4)
 void warn_slowpath_fmt(const char *file, const int line,
 		       const char *fmt, ...);
@@ -69,12 +69,12 @@ void warn_slowpath_fmt_taint(const char *file, const int line, unsigned taint,
 			     const char *fmt, ...);
 extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
-#endif
 #define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
 #define __WARN_printf(arg...)	warn_slowpath_fmt(__FILE__, __LINE__, arg)
 #define __WARN_printf_taint(taint, arg...)				\
 	warn_slowpath_fmt_taint(__FILE__, __LINE__, taint, arg)
 #else
+#include <linux/kernel.h>
 #define __WARN()		__WARN_TAINT(TAINT_WARN)
 #define __WARN_printf(arg...)	do { printk(arg); __WARN(); } while (0)
 #define __WARN_printf_taint(taint, arg...)				\
@@ -105,6 +105,7 @@ extern void warn_slowpath_null(const char *file, const int line);
 		__WARN_printf_taint(taint, format);			\
 	unlikely(__ret_warn_on);					\
 })
+#endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-- 
1.7.2.5

