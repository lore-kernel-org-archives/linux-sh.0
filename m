From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Fri, 21 Nov 2008 13:15:25 +0000
Subject: [RFC PATCH V3] SH4A Add fastpath mutex implementation
Message-Id: <20081121131524.GA761@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add fast mutex path implementation for the SH4A architecture

Signed-off-by: Michael Trimarchi <trimarchimichael@yahoo.it>

---
 arch/sh/include/asm/mutex.h    |    5 ++-
 arch/sh/include/asm/mutex_sh.h |  108 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 1 deletions(-)
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
index 0000000..d805d28
--- /dev/null
+++ b/arch/sh/include/asm/mutex_sh.h
@@ -0,0 +1,108 @@
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
+/*
+ * Attempting to lock a mutex on SH4A is done like in ARMv6+ architecure.
+ * with a bastardized atomic decrement (it is not a reliable atomic decrement
+ * but it satisfies the defined semantics for our purpose, while being
+ * smaller and faster than a real atomic decrement or atomic swap.
+ * The idea is to attempt  decrementing the lock value only once. If once
+ * decremented it isn't zero, or if its store-back fails due to a dispute
+ * on the exclusive store, we simply bail out immediately through the slow
+ * path where the lock will be reattempted until it succeeds.
+ */
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
+		: "t");
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
+		: "t");
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
+	int __res;
+
+	__asm__ __volatile__ (
+		"1: movli.l	@%1, %0	\n\t"
+		"add		#1, %0	\n\t"
+		"movco.l	%0, @%1 \n\t"
+		"bf		1b\n\t"
+		: "=&z" (__res)
+		: "r" (&(count)->counter)
+		: "t");
+
+	if (unlikely(__res <= 0))
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
+ * For __mutex_fastpath_trylock we do an atomic decrement and check the
+ * result and put it in the __res variable.
+ */
+static inline int
+__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	int __res, __orig;
+
+	__asm__ __volatile__ (
+		"1: movli.l	@%2, %0		\n\t"
+		"dt		%0		\n\t"
+		"movco.l	%0,@%2		\n\t"
+		"bf		1b		\n\t"
+		"cmp/eq		#0,%0		\n\t"
+		"bt		2f		\n\t"
+		"mov		#0, %1		\n\t"
+		"bf		3f		\n\t"
+		"2: mov		#1, %1		\n\t"
+		"3:				"
+		: "=&z" (__orig), "=&r" (__res)
+		: "r" (&count->counter)
+		: "t");
+
+	return __res;
+}
+#endif
-- 
1.5.6.5

