From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 05 Jan 2016 16:22:18 +0000
Subject: [PATCH] sh: support a 2-byte xchg
Message-Id: <1452010849-25546-1-git-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-sh@vger.kernel.org

At the moment, xchg on sh only supports 4 and 1 byte values, so using it
from smp_store_mb means attempts to store a 2 byte value using this
macro fail.

And this happens to be exactly what virtio drivers want to do.

Add a 2-byte xchg variant.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes:
	- compiled only
	- arch maintainers, this is a dependency of
	  virtio driver work, so please ack, do not
	  cherry-pick

 arch/sh/include/asm/cmpxchg-grb.h  | 22 ++++++++++++++++++++++
 arch/sh/include/asm/cmpxchg-irq.h  | 11 +++++++++++
 arch/sh/include/asm/cmpxchg-llsc.h | 21 +++++++++++++++++++++
 arch/sh/include/asm/cmpxchg.h      |  3 +++
 4 files changed, 57 insertions(+)

diff --git a/arch/sh/include/asm/cmpxchg-grb.h b/arch/sh/include/asm/cmpxchg-grb.h
index f848dec..2ed557b 100644
--- a/arch/sh/include/asm/cmpxchg-grb.h
+++ b/arch/sh/include/asm/cmpxchg-grb.h
@@ -23,6 +23,28 @@ static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 	return retval;
 }
 
+static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
+{
+	unsigned long retval;
+
+	__asm__ __volatile__ (
+		"   .align  2             \n\t"
+		"   mova    1f,   r0      \n\t" /* r0 = end point */
+		"   mov    r15,   r1      \n\t" /* r1 = saved sp */
+		"   mov    #-6,   r15     \n\t" /* LOGIN */
+		"   mov.w  @%1,   %0      \n\t" /* load  old value */
+		"   extu.w  %0,   %0      \n\t" /* extend as unsigned */
+		"   mov.w   %2,   @%1     \n\t" /* store new value */
+		"1: mov     r1,   r15     \n\t" /* LOGOUT */
+		: "=&r" (retval),
+		  "+r"  (m),
+		  "+r"  (val)		/* inhibit r15 overloading */
+		:
+		: "memory" , "r0", "r1");
+
+	return retval;
+}
+
 static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
 {
 	unsigned long retval;
diff --git a/arch/sh/include/asm/cmpxchg-irq.h b/arch/sh/include/asm/cmpxchg-irq.h
index bd11f63..f888772 100644
--- a/arch/sh/include/asm/cmpxchg-irq.h
+++ b/arch/sh/include/asm/cmpxchg-irq.h
@@ -14,6 +14,17 @@ static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 	return retval;
 }
 
+static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
+{
+	unsigned long flags, retval;
+
+	local_irq_save(flags);
+	retval = *m;
+	*m = val;
+	local_irq_restore(flags);
+	return retval;
+}
+
 static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
 {
 	unsigned long flags, retval;
diff --git a/arch/sh/include/asm/cmpxchg-llsc.h b/arch/sh/include/asm/cmpxchg-llsc.h
index 4713666..dab6c58 100644
--- a/arch/sh/include/asm/cmpxchg-llsc.h
+++ b/arch/sh/include/asm/cmpxchg-llsc.h
@@ -22,6 +22,27 @@ static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 	return retval;
 }
 
+static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
+{
+	unsigned long retval;
+	unsigned long tmp;
+
+	__asm__ __volatile__ (
+		"1:					\n\t"
+		"movli.l	@%2, %0	! xchg_u16	\n\t"
+		"mov		%0, %1			\n\t"
+		"mov		%3, %0			\n\t"
+		"movco.l	%0, @%2			\n\t"
+		"bf		1b			\n\t"
+		"synco					\n\t"
+		: "=&z"(tmp), "=&r" (retval)
+		: "r" (m), "r" (val & 0xffff)
+		: "t", "memory"
+	);
+
+	return retval;
+}
+
 static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
 {
 	unsigned long retval;
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 85c97b18..5225916 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -27,6 +27,9 @@ extern void __xchg_called_with_bad_pointer(void);
 	case 4:						\
 		__xchg__res = xchg_u32(__xchg_ptr, x);	\
 		break;					\
+	case 2:						\
+		__xchg__res = xchg_u16(__xchg_ptr, x);	\
+		break;					\
 	case 1:						\
 		__xchg__res = xchg_u8(__xchg_ptr, x);	\
 		break;					\
-- 
MST
