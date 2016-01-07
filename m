From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 07 Jan 2016 22:41:35 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160108003519-mutt-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
 <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
 <20160106182349.GD238@brightrain.aerifal.cx>
 <20160106222019-mutt-send-email-mst@redhat.com>
 <20160106235301.GA23060@brightrain.aerifal.cx>
 <20160107175944-mutt-send-email-mst@redhat.com>
 <20160107191039.GG238@brightrain.aerifal.cx>
In-Reply-To: <20160107191039.GG238@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Landley <rob@landley.net>, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

> > > It would be nice to have these in asm-generic for archs which don't
> > > define their own versions rather than having cruft like this repeated
> > > per-arch. Strictly speaking, the volatile u32 used to access the
> > > 32-bit word containing the u8 or u16 should be
> > > __attribute__((__may_alias__)) too. Is there an existing kernel type
> > > for a "may_alias u32" or should it perhaps be added?
> > > 
> > > Rich
> > 
> > BTW this seems suboptimal for grb and irq variants which apparently
> > can do things correctly.
> 
> In principle I agree, but u8/u16 xchg is mostly unused (completely
> unused in my builds) and unlikely to matter to performance. Also, the
> irq variant is only for the original sh2 which is not even produced
> anymore afaik. Our reimplementation of the sh2 ISA, the J2, has a
> cas.l instruction that will be used instead because it supports SMP
> where interrupt masking is insufficient to achieve atomicity.
> 
> Rich

Since it looks like there will soon be active maintainers
for this arch, I think it's best if I make the minimal possible
changes and then you guys can rewrite it any way you like,
drop irq variant or whatever.

The minimal change is probably the below code but
the grb variant is just copy paste from xchg_u8
with a minor tweak -
can you pls confirm it looks right?

I tested the llsc code on ppc and x86 and since it's
portable I know the logic is correct there.

Will post v3 with this included but would appreciate
your input first.

---->
sh: support 1 and 2 byte xchg

This completes the xchg implementation for sh architecture.  Note: The
llsc variant is tricky since this only supports 4 byte atomics, the
existing implementation of 1 byte xchg is wrong: we need to do a 4 byte
cmpxchg and retry if any bytes changed meanwhile.

Write this in C for clarity.

Suggested-by: Rich Felker <dalias@libc.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---->

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
index 4713666..5dfdb06 100644
--- a/arch/sh/include/asm/cmpxchg-llsc.h
+++ b/arch/sh/include/asm/cmpxchg-llsc.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_SH_CMPXCHG_LLSC_H
 #define __ASM_SH_CMPXCHG_LLSC_H
 
+#include <asm/byteorder.h>
+
 static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 {
 	unsigned long retval;
@@ -22,29 +24,8 @@ static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 	return retval;
 }
 
-static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
-{
-	unsigned long retval;
-	unsigned long tmp;
-
-	__asm__ __volatile__ (
-		"1:					\n\t"
-		"movli.l	@%2, %0	! xchg_u8	\n\t"
-		"mov		%0, %1			\n\t"
-		"mov		%3, %0			\n\t"
-		"movco.l	%0, @%2			\n\t"
-		"bf		1b			\n\t"
-		"synco					\n\t"
-		: "=&z"(tmp), "=&r" (retval)
-		: "r" (m), "r" (val & 0xff)
-		: "t", "memory"
-	);
-
-	return retval;
-}
-
 static inline unsigned long
-__cmpxchg_u32(volatile int *m, unsigned long old, unsigned long new)
+__cmpxchg_u32(volatile u32 *m, unsigned long old, unsigned long new)
 {
 	unsigned long retval;
 	unsigned long tmp;
@@ -68,4 +49,34 @@ __cmpxchg_u32(volatile int *m, unsigned long old, unsigned long new)
 	return retval;
 }
 
+static inline u32 __xchg_cmpxchg(volatile void *ptr, u32 x, int size)
+{
+	int off = (unsigned long)ptr % sizeof(u32);
+	volatile u32 *p = ptr - off;
+	int bitoff = __BYTE_ORDER = __BIG_ENDIAN ?
+		((sizeof(u32) - 1 - off) * BITS_PER_BYTE) :
+		(off * BITS_PER_BYTE);
+	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
+	u32 oldv, newv;
+	u32 ret;
+
+	do {
+		oldv = READ_ONCE(*p);
+		ret = (oldv & bitmask) >> bitoff;
+		newv = (oldv & ~bitmask) | (x << bitoff);
+	} while (__cmpxchg_u32(p, oldv, newv) != oldv);
+
+	return ret;
+}
+
+static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
+{
+	return __xchg_cmpxchg(m, val, sizeof *m);
+}
+
+static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
+{
+	return __xchg_cmpxchg(m, val, sizeof *m);
+}
+
 #endif /* __ASM_SH_CMPXCHG_LLSC_H */
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
