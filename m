From: Aoi Shinkai <shinkoi2005@gmail.com>
Date: Wed, 10 Jun 2009 15:37:55 +0000
Subject: [PATCH] sh: Fix sh4a llsc operation
Message-Id: <4A2FD353.5080201@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes sh4a llsc operation.
Most of all is taken from arm and mips.

Signed-off-by: Aoi Shinkai <shinkoi2005@gmail.com>
---
diff --git a/arch/sh/include/asm/atomic-llsc.h b/arch/sh/include/asm/atomic-llsc.h
index 4b00b78..18cca1f 100644
--- a/arch/sh/include/asm/atomic-llsc.h
+++ b/arch/sh/include/asm/atomic-llsc.h
@@ -104,4 +104,29 @@ static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
 	: "t");
 }

+#define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
+
+/**
+ * atomic_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+static inline int atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int c, old;
+	c = atomic_read(v);
+	for (;;) {
+		if (unlikely(c = (u)))
+			break;
+		old = atomic_cmpxchg((v), c, c + (a));
+		if (likely(old = c))
+			break;
+		c = old;
+	}
+	return c != (u);
+}
 #endif /* __ASM_SH_ATOMIC_LLSC_H */
diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index 6327ffb..978b58e 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -45,7 +45,7 @@
 #define atomic_inc(v) atomic_add(1,(v))
 #define atomic_dec(v) atomic_sub(1,(v))

-#ifndef CONFIG_GUSA_RB
+#if !defined(CONFIG_GUSA_RB) && !defined(CONFIG_CPU_SH4A)
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
@@ -73,7 +73,7 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)

 	return ret != u;
 }
-#endif
+#endif /* !CONFIG_GUSA_RB && !CONFIG_CPU_SH4A */

 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
diff --git a/arch/sh/include/asm/cmpxchg-llsc.h b/arch/sh/include/asm/cmpxchg-llsc.h
index 0fac3da..4713666 100644
--- a/arch/sh/include/asm/cmpxchg-llsc.h
+++ b/arch/sh/include/asm/cmpxchg-llsc.h
@@ -55,7 +55,7 @@ __cmpxchg_u32(volatile int *m, unsigned long old, unsigned long new)
 		"mov		%0, %1				\n\t"
 		"cmp/eq		%1, %3				\n\t"
 		"bf		2f				\n\t"
-		"mov		%3, %0				\n\t"
+		"mov		%4, %0				\n\t"
 		"2:						\n\t"
 		"movco.l	%0, @%2				\n\t"
 		"bf		1b				\n\t"
diff --git a/arch/sh/include/asm/spinlock.h b/arch/sh/include/asm/spinlock.h
index 6028356..69f4dc7 100644
--- a/arch/sh/include/asm/spinlock.h
+++ b/arch/sh/include/asm/spinlock.h
@@ -26,7 +26,7 @@
 #define __raw_spin_is_locked(x)		((x)->lock <= 0)
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 #define __raw_spin_unlock_wait(x) \
-	do { cpu_relax(); } while ((x)->lock)
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)

 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
