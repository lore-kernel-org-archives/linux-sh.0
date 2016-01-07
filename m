From: Rich Felker <dalias@libc.org>
Date: Thu, 07 Jan 2016 19:10:39 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160107191039.GG238@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
 <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
 <20160106182349.GD238@brightrain.aerifal.cx>
 <20160106222019-mutt-send-email-mst@redhat.com>
 <20160106235301.GA23060@brightrain.aerifal.cx>
 <20160107175944-mutt-send-email-mst@redhat.com>
In-Reply-To: <20160107175944-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Landley <rob@landley.net>, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Thu, Jan 07, 2016 at 07:48:08PM +0200, Michael S. Tsirkin wrote:
> On Wed, Jan 06, 2016 at 06:53:01PM -0500, Rich Felker wrote:
> > On Wed, Jan 06, 2016 at 10:23:12PM +0200, Michael S. Tsirkin wrote:
> > > On Wed, Jan 06, 2016 at 01:23:50PM -0500, Rich Felker wrote:
> > > > On Wed, Jan 06, 2016 at 03:32:18PM +0100, Peter Zijlstra wrote:
> > > > > On Wed, Jan 06, 2016 at 01:52:17PM +0200, Michael S. Tsirkin wrote:
> > > > > > > > Peter, what do you think? How about I leave this patch as is for now?
> > > > > > > 
> > > > > > > No, and I object to removing the single byte implementation too. Either
> > > > > > > remove the full arch or fix xchg() to conform. xchg() should work on all
> > > > > > > native word sizes, for SH that would be 1,2 and 4 bytes.
> > > > > > 
> > > > > > Rick, maybe you could explain how is current 1 byte xchg on llsc wrong?
> > > > > 
> > > > > It doesn't seem to preserve the 3 other bytes in the word.
> > > > > 
> > > > > > It does use 4 byte accesses but IIUC that is all that exists on
> > > > > > this architecture.
> > > > > 
> > > > > Right, that's not a problem, look at arch/alpha/include/asm/xchg.h for
> > > > > example. A store to another portion of the word should make the
> > > > > store-conditional fail and we'll retry the loop.
> > > > > 
> > > > > The short versions should however preserve the other bytes in the word.
> > > > 
> > > > Indeed. Also, accesses must be aligned, so the asm needs to round down
> > > > to an aligned address and perform a correct read-modify-write on it,
> > > > placing the new byte in the correct offset in the word.
> > > > 
> > > > Alternatively (my preference) this logic can be impemented in C as a
> > > > wrapper around the 32-bit cmpxchg. I think this is less error-prone
> > > > and it can be shared between the multiple sh cmpxchg back-ends,
> > > > including the new cas.l one we need for J2.
> > > > 
> > > > > SH's cmpxchg() is equally incomplete and does not provide 1 and 2 byte
> > > > > versions.
> > > > > 
> > > > > In any case, I'm all for rm -rf arch/sh/, one less arch to worry about
> > > > > is always good, but ISTR some people wanting to resurrect SH:
> > > > > 
> > > > >   http://old.lwn.net/Articles/647636/
> > > > > 
> > > > > Rob, Jeff, Sato-san, might I suggest you send a MAINTAINERS patch and
> > > > > take up an active interest in SH lest someone 'accidentally' nukes it?
> > > > 
> > > > We're in the process of preparing such a proposal right now. That
> > > > current intent is that Sato-san and I will co-maintain arch/sh. We'll
> > > > include more details about motivation, proposed development direction,
> > > > existing work to be merged, etc. in that proposal.
> > > 
> > > Well I'd like to be able to make progress with generic
> > > arch cleanups meanwhile.
> > > 
> > > Could you quickly write a version of 1 and 2 byte xchg that
> > > works so I can include it?
> > 
> > Here are quick, untested generic ones:
> > 
> > static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
> > {
> > 	u32 old;
> > 	unsigned long offset = (unsigned long)m & 3;
> > 	volatile u32 *w = (volatile u32 *)(m - offset);
> > 	union { u32 w; u8 b[4]; } u;
> > 	do {
> > 		old = u.w = *w;
> > 		result = w.b[offset];
> > 		w.b[offset] = val;
> > 	} while (cmpxchg(w, old, u.w) != old);
> > 	return result;
> > }
> > 
> > static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
> > {
> > 	u32 old;
> > 	unsigned long result;
> > 	unsigned long offset = ((unsigned long)m & 3) >> 1;
> > 	volatile u32 *w = (volatile u32 *)(m - offset);
> > 	union { u32 w; u16 h[2]; } u;
> > 	do {
> > 		old = u.w = *w;
> > 		result = w.h[offset];
> > 		w.h[offset] = val;
> > 	} while (cmpxchg(w, old, u.w) != old);
> > 	return result;
> > }
> > 
> > It would be nice to have these in asm-generic for archs which don't
> > define their own versions rather than having cruft like this repeated
> > per-arch. Strictly speaking, the volatile u32 used to access the
> > 32-bit word containing the u8 or u16 should be
> > __attribute__((__may_alias__)) too. Is there an existing kernel type
> > for a "may_alias u32" or should it perhaps be added?
> > 
> > Rich
> 
> BTW this seems suboptimal for grb and irq variants which apparently
> can do things correctly.

In principle I agree, but u8/u16 xchg is mostly unused (completely
unused in my builds) and unlikely to matter to performance. Also, the
irq variant is only for the original sh2 which is not even produced
anymore afaik. Our reimplementation of the sh2 ISA, the J2, has a
cas.l instruction that will be used instead because it supports SMP
where interrupt masking is insufficient to achieve atomicity.

Rich
