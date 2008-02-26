From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Feb 2008 05:23:07 +0000
Subject: Re: [PATCH] sh: fix readsl/writesl argument
Message-Id: <20080226052307.GF19814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080220102853.22714.57848.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080220102853.22714.57848.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 21, 2008 at 11:57:12AM +0900, Magnus Damm wrote:
> Hi Stuart,
> 
> On Wed, Feb 20, 2008 at 9:15 PM, Stuart MENEFY <stuart.menefy@st.com> wrote:
> >  Magnus Damm wrote:
> >  > writesl() and readsl() use void __iomem * as argument but the current sh
> >  > version of __raw_writesl()/__rawreadsl() takes unsigned long. Casting the
> >  > pointer fixes smc91x warnings.
> >  ...
> >
> > > --- 0001/include/asm-sh/io.h
> >  > +++ work/include/asm-sh/io.h  2008-02-20 16:34:28.000000000 +0900
> >
> > > -#define writesl __raw_writesl
> >  > -#define readsl  __raw_readsl
> >  > +#define writesl(m, a, c) __raw_writesl((unsigned long)(m), (a), (c))
> >  > +#define readsl(m, a, c)  __raw_readsl((unsigned long)(m), (a), (c))
> >
> >  Wouldn't it be better to do this as inline functions, that way we don't
> >  loose the type checking?
> 
> Yes, I think so too. But step by step. =) I'm planning on replacing a
> lot of code in io.h actually, and I'll use inlines and avoid casting
> to get proper type checking then. Thanks!
> 
There's not a lot of point in merging this for 2.6.25, so lets just drop
this and focus on the proper cleanup for the 2.6.26 window instead.
