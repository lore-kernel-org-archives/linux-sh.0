From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jan 2016 01:40:46 +0000
Subject: Re: [PATCH 1/2] MAINTAINERS: return arch/sh to maintained state, with new maintainers
Message-Id: <20160113014046.GA22101@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108043959.GA7856@brightrain.aerifal.cx>
 <20160111175307.GC6344@twins.programming.kicks-ass.net>
In-Reply-To: <20160111175307.GC6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, "D. Jeff Dionne" <jeff@uClinux.org>, Rob Landley <rob@landley.net>

On Mon, Jan 11, 2016 at 06:53:07PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 07, 2016 at 11:39:59PM -0500, Rich Felker wrote:
> > From: Rich Felker <dalias@libc.org>
> > 
> > Add Yoshinori Sato and Rich Felker as maintainers for arch/sh
> > (SUPERH).
> > 
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Acked-by: D. Jeff Dionne <jeff@uClinux.org>
> > Acked-by: Rob Landley <rob@landley.net>
> 
> A much appreciated move,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Likewise,

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> > ---
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9bff63c..55e48b1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10274,9 +10274,11 @@ S:	Maintained
> >  F:	drivers/net/ethernet/dlink/sundance.c
> >  
> >  SUPERH
> > +M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> > +M:	Rich Felker <dalias@libc.org>
> >  L:	linux-sh@vger.kernel.org
> >  Q:	http://patchwork.kernel.org/project/linux-sh/list/
> > -S:	Orphan
> > +S:	Maintained
> >  F:	Documentation/sh/
> >  F:	arch/sh/
> >  F:	drivers/sh/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
