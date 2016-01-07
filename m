From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 07 Jan 2016 15:50:58 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160107142254-mutt-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
 <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
 <20160106182349.GD238@brightrain.aerifal.cx>
 <20160106222019-mutt-send-email-mst@redhat.com>
 <20160106235301.GA23060@brightrain.aerifal.cx>
In-Reply-To: <20160106235301.GA23060@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Landley <rob@landley.net>, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Wed, Jan 06, 2016 at 06:53:01PM -0500, Rich Felker wrote:
> On Wed, Jan 06, 2016 at 10:23:12PM +0200, Michael S. Tsirkin wrote:
> > On Wed, Jan 06, 2016 at 01:23:50PM -0500, Rich Felker wrote:
> > > On Wed, Jan 06, 2016 at 03:32:18PM +0100, Peter Zijlstra wrote:
> > > > On Wed, Jan 06, 2016 at 01:52:17PM +0200, Michael S. Tsirkin wrote:
> > > > > > > Peter, what do you think? How about I leave this patch as is for now?
> > > > > > 
> > > > > > No, and I object to removing the single byte implementation too. Either
> > > > > > remove the full arch or fix xchg() to conform. xchg() should work on all
> > > > > > native word sizes, for SH that would be 1,2 and 4 bytes.
> > > > > 
> > > > > Rick, maybe you could explain how is current 1 byte xchg on llsc wrong?
> > > > 
> > > > It doesn't seem to preserve the 3 other bytes in the word.
> > > > 
> > > > > It does use 4 byte accesses but IIUC that is all that exists on
> > > > > this architecture.
> > > > 
> > > > Right, that's not a problem, look at arch/alpha/include/asm/xchg.h for
> > > > example. A store to another portion of the word should make the
> > > > store-conditional fail and we'll retry the loop.
> > > > 
> > > > The short versions should however preserve the other bytes in the word.
> > > 
> > > Indeed. Also, accesses must be aligned, so the asm needs to round down
> > > to an aligned address and perform a correct read-modify-write on it,
> > > placing the new byte in the correct offset in the word.
> > > 
> > > Alternatively (my preference) this logic can be impemented in C as a
> > > wrapper around the 32-bit cmpxchg. I think this is less error-prone
> > > and it can be shared between the multiple sh cmpxchg back-ends,
> > > including the new cas.l one we need for J2.
> > > 
> > > > SH's cmpxchg() is equally incomplete and does not provide 1 and 2 byte
> > > > versions.
> > > > 
> > > > In any case, I'm all for rm -rf arch/sh/, one less arch to worry about
> > > > is always good, but ISTR some people wanting to resurrect SH:
> > > > 
> > > >   http://old.lwn.net/Articles/647636/
> > > > 
> > > > Rob, Jeff, Sato-san, might I suggest you send a MAINTAINERS patch and
> > > > take up an active interest in SH lest someone 'accidentally' nukes it?
> > > 
> > > We're in the process of preparing such a proposal right now. That
> > > current intent is that Sato-san and I will co-maintain arch/sh. We'll
> > > include more details about motivation, proposed development direction,
> > > existing work to be merged, etc. in that proposal.
> > 
> > Well I'd like to be able to make progress with generic
> > arch cleanups meanwhile.
> > 
> > Could you quickly write a version of 1 and 2 byte xchg that
> > works so I can include it?
> 
> Here are quick, untested generic ones:
> 
> static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
> {
> 	u32 old;
> 	unsigned long offset = (unsigned long)m & 3;
> 	volatile u32 *w = (volatile u32 *)(m - offset);
> 	union { u32 w; u8 b[4]; } u;
> 	do {
> 		old = u.w = *w;
> 		result = w.b[offset];
> 		w.b[offset] = val;
> 	} while (cmpxchg(w, old, u.w) != old);
> 	return result;
> }
> 
> static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
> {
> 	u32 old;
> 	unsigned long result;
> 	unsigned long offset = ((unsigned long)m & 3) >> 1;
> 	volatile u32 *w = (volatile u32 *)(m - offset);
> 	union { u32 w; u16 h[2]; } u;
> 	do {
> 		old = u.w = *w;
> 		result = w.h[offset];
> 		w.h[offset] = val;
> 	} while (cmpxchg(w, old, u.w) != old);
> 	return result;
> }
> 
> It would be nice to have these in asm-generic for archs which don't
> define their own versions rather than having cruft like this repeated
> per-arch. Strictly speaking, the volatile u32 used to access the
> 32-bit word containing the u8 or u16 should be
> __attribute__((__may_alias__)) too.
> Is there an existing kernel type
> for a "may_alias u32" or should it perhaps be added?
> 
> Rich

I'm inclined to write this using shifts, this way there's
no duplication between 1 and 2 byte variants.
And READ_ONCE is better than volatile IMHO.


diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 85c97b18..a858879 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -8,6 +8,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <asm/byteorder.h>
 
 #if defined(CONFIG_GUSA_RB)
 #include <asm/cmpxchg-grb.h>
@@ -19,6 +20,26 @@
 
 extern void __xchg_called_with_bad_pointer(void);
 
+static inline u32 __xchg_cmpxchg(void *ptr, u32 x, int size)
+{
+	int off = (unsigned long)ptr % sizeof(u32);
+	u32 *p = ptr - off;
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
+	} while(cmpxchg(p, oldv, newv) != oldv);
+
+	return ret;
+}
+
 #define __xchg(ptr, x, size)				\
 ({							\
 	unsigned long __xchg__res;			\
@@ -27,8 +48,10 @@ extern void __xchg_called_with_bad_pointer(void);
 	case 4:						\
 		__xchg__res = xchg_u32(__xchg_ptr, x);	\
 		break;					\
+	case 2:						\
 	case 1:						\
-		__xchg__res = xchg_u8(__xchg_ptr, x);	\
+		__xchg__res = __xchg_cmpxchg(__xchg_ptr,\
+					     x, size);	\
 		break;					\
 	default:					\
 		__xchg_called_with_bad_pointer();	\


Testing the above now.
-- 
MST
