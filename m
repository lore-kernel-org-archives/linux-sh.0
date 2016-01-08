From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 08 Jan 2016 07:23:09 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160108090615-mutt-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
 <20160106182349.GD238@brightrain.aerifal.cx>
 <20160106222019-mutt-send-email-mst@redhat.com>
 <20160106235301.GA23060@brightrain.aerifal.cx>
 <20160107175944-mutt-send-email-mst@redhat.com>
 <20160107191039.GG238@brightrain.aerifal.cx>
 <20160108003519-mutt-send-email-mst@redhat.com>
 <20160108042505.GJ238@brightrain.aerifal.cx>
In-Reply-To: <20160108042505.GJ238@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Landley <rob@landley.net>, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Thu, Jan 07, 2016 at 11:25:05PM -0500, Rich Felker wrote:
> On Fri, Jan 08, 2016 at 12:41:35AM +0200, Michael S. Tsirkin wrote:
> > > > > It would be nice to have these in asm-generic for archs which don't
> > > > > define their own versions rather than having cruft like this repeated
> > > > > per-arch. Strictly speaking, the volatile u32 used to access the
> > > > > 32-bit word containing the u8 or u16 should be
> > > > > __attribute__((__may_alias__)) too. Is there an existing kernel type
> > > > > for a "may_alias u32" or should it perhaps be added?
> > > > > 
> > > > > Rich
> > > > 
> > > > BTW this seems suboptimal for grb and irq variants which apparently
> > > > can do things correctly.
> > > 
> > > In principle I agree, but u8/u16 xchg is mostly unused (completely
> > > unused in my builds) and unlikely to matter to performance. Also, the
> > > irq variant is only for the original sh2 which is not even produced
> > > anymore afaik. Our reimplementation of the sh2 ISA, the J2, has a
> > > cas.l instruction that will be used instead because it supports SMP
> > > where interrupt masking is insufficient to achieve atomicity.
> > > 
> > > Rich
> > 
> > Since it looks like there will soon be active maintainers
> > for this arch, I think it's best if I make the minimal possible
> > changes and then you guys can rewrite it any way you like,
> > drop irq variant or whatever.
> > 
> > The minimal change is probably the below code but
> > the grb variant is just copy paste from xchg_u8
> > with a minor tweak -
> > can you pls confirm it looks right?
> 
> I haven't had a chance to test it, but I don't see anything obviously
> wrong with it.
> 
> > I tested the llsc code on ppc and x86 and since it's
> > portable I know the logic is correct there.
> 
> Sounds good. Since it will also be needed for the cas.l variant I'd
> rather have this in the main asm/cmpxchg.h where it can be shared if
> you see an easy way to do that now, but if not I can take care of it
> later when merging cmpxchg-cas.h. Perhaps just putting __xchg_cmpxchg
> in the main asm/cmpxchg.h would suffice so that only the thin wrappers
> need to be duplicated.
> Ideally it could even be moved outside of the
> arch asm headers, but then there might be annoying header ordering
> issues to deal with.

Well it isn't possible to put it in cmpxchg.h because you get into
annoying ordering issues: __cmpxchg_u32 is needed
so it has to come after the headers, but the wrappers must
come before the headers.

I put it in a header by itself. This way it's easy to reuse,
and even the thin wrappers won't have to be duplicated.

> 
> > Will post v3 with this included but would appreciate
> > your input first.
> 
> Go ahead. Thanks!
> 
> Rich
