From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Thu, 20 Nov 2008 13:16:54 +0000
Subject: [RFC PATCH V2] Add fastpath sh4a mutex support
Message-Id: <20081120131654.GA27114@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[RFC PATCH V2] Add fastpath sh4a mutex support

Signed-off-by: Michael Trimarchi <trimarchimichale@yahoo.it>

---
 arch/sh/include/asm/mutex.h    |    5 ++-
 arch/sh/include/asm/mutex_sh.h |  101 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletions(-)
 create mode 100644 arch/sh/include/asm/mutex_sh.h

diff --git a/arch/sh/include/asm/mutex.h b/arch/sh/include/asm/mutex.h
index 458c1f7..24b7a98 100644
--- a/arch/sh/include/asm/mutex.h
+++ b/arch/sh/include/asm/mutex.h
@@ -5,5 +5,8 @@
  * implementation in place, or pick the atomic_xchg() based generic
  * implementation. (see asm-generic/mutex-xchg.h for details)
  */
-
+#if defined(CONFIG_CPU_SH4A)
+#include <asm/mutex_sh.h>
+#else
 #include <asm-generic/mutex-dec.h>
+#endif
diff --git a/arch/sh/include/asm/mutex_sh.h b/arch/sh/include/asm/mutex_sh.h
new file mode 100644
index 0000000..c98e875
--- /dev/null
+++ b/arch/sh/include/asm/mutex_sh.h
@@ -0,0 +1,101 @@
+/*
+ * arch/arm/include/asm/mutex.h
+ *
+ * SH optimized mutex locking primitives
+ *
+ * Please look into asm-generic/mutex-xchg.h for a formal definition.
+ */
+#ifndef _ASM_MUTEX_H
+#define _ASM_MUTEX_H
+
+static inline void
+__mutex_fastpath_lock(atomic_t *count, void (*fail_fn)(atomic_t *))
+{
+	int __res;
+
+	__asm__ __volatile__ (
+		"movli.l	@%1, %0	\n"
+		"dt		%0	\n"
+		"movco.l	%0, @%1	\n"
+		: "=&z" (__res)
+		: "r" (&(count)->counter)
+		: "t" );
+
+	if (unlikely(__res != 0))
+		fail_fn(count);
+}
+
+static inline int
+__mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	int __res;
+
+	__asm__ __volatile__ (
+
+		"movli.l	@%1, %0	\n"
+		"dt		%0	\n"
+		"movco.l	%0, @%1	\n"
+		: "=&z" (__res)
+		: "r" (&(count)->counter)
+		: "t" );
+
+	if (unlikely(__res != 0))
+		__res = fail_fn(count);
+
+	return __res;
+}
+
+static inline void
+__mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
+{
+	int __res, __orig;
+
+	__asm__ __volatile__ (
+		"movli.l	@%2, %0	\n\t"
+		"mov		%0, %1	\n\t"
+		"add		#1, %0	\n\t"
+		"movco.l	%0, @%2 "
+		: "=&z" (__res), "=&r" (__orig)
+		: "r" (&(count)->counter)
+		: "t" );
+
+	if (unlikely(__orig != 0))
+		fail_fn(count);
+}
+
+/*
+ * If the unlock was done on a contended lock, or if the unlock simply fails
+ * then the mutex remains locked.
+ */
+#define __mutex_slowpath_needs_to_unlock()	1
+
+/*
+ * For __mutex_fastpath_trylock we use another construct which could be
+ * described as a "single value cmpxchg".
+ *
+ * This provides the needed trylock semantics like cmpxchg would, but it is
+ * lighter and less generic than a true cmpxchg implementation.
+ */
+static inline int
+__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	int __res, __orig;
+
+	__asm__ __volatile__ (
+                "1: movli.l	@%2, %0		\n\t"
+                "dt		%0		\n\t"
+                "movco.l	%0,@%2		\n\t"
+                "bf		1b		\n\t"
+		"cmp/eq		#0,%0		\n\t"
+		"bt		2f		\n\t"
+		"mov		#0, %1		\n\t"
+		"bf		3f		\n\t"
+		"2: mov		#1, %1		\n\t"
+		"3:				"
+                : "=&z" (__orig), "=&r" (__res)
+                : "r" (&count->counter)
+		: "t" );
+
+        return __res;
+}
+#endif
-- 
1.5.6.5

