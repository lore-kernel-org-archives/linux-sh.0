From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Tue, 26 Feb 2008 06:39:57 +0000
Subject: Re: [PATCH] sh: fix readsl/writesl argument
Message-Id: <aec7e5c30802252239q471d6c04q39c434eab7604da3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080220102853.22714.57848.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080220102853.22714.57848.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 26, 2008 at 2:23 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Feb 21, 2008 at 11:57:12AM +0900, Magnus Damm wrote:
>  > On Wed, Feb 20, 2008 at 9:15 PM, Stuart MENEFY <stuart.menefy@st.com> wrote:
>  > >  Magnus Damm wrote:
>  > >  > writesl() and readsl() use void __iomem * as argument but the current sh
>  > >  > version of __raw_writesl()/__rawreadsl() takes unsigned long. Casting the
>  > >  > pointer fixes smc91x warnings.
>  > >  ...
>  > >
>  > > > --- 0001/include/asm-sh/io.h
>  > >  > +++ work/include/asm-sh/io.h  2008-02-20 16:34:28.000000000 +0900
>  > >
>  > > > -#define writesl __raw_writesl
>  > >  > -#define readsl  __raw_readsl
>  > >  > +#define writesl(m, a, c) __raw_writesl((unsigned long)(m), (a), (c))
>  > >  > +#define readsl(m, a, c)  __raw_readsl((unsigned long)(m), (a), (c))
>  > >
>  > >  Wouldn't it be better to do this as inline functions, that way we don't
>  > >  loose the type checking?
>  >
>  > Yes, I think so too. But step by step. =) I'm planning on replacing a
>  > lot of code in io.h actually, and I'll use inlines and avoid casting
>  > to get proper type checking then. Thanks!
>  >
>  There's not a lot of point in merging this for 2.6.25, so lets just drop
>  this and focus on the proper cleanup for the 2.6.26 window instead.

Sure, merging this for 2.6.25 doesn't make any sense.

I do however wonder what a proper cleanup would look like...

I heard something about starting to use __raw_readN/writeN() instead
of ctrl_inN/outN() for on-chip access, and with proper type checking
we should use unsigned longs to specify address for
__raw_readN/writeN().  But we can't do that since  __raw_writeN() in
lib/iomap.c takes void __iomem * instead of unsigned long.

Arm solves this by using macros and casting, but then we loose the
type checking. What about using __readN/writeN() for on-chip access?
Or maybe just keep ctrl_inN/outN() and focus on fixing up the rest.

/ magnus
