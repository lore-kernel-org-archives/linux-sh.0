From: Rich Felker <dalias@libc.org>
Date: Sun, 17 Jan 2016 02:32:47 +0000
Subject: Re: [PATCH 1/2] MAINTAINERS: return arch/sh to maintained state, with new maintainers
Message-Id: <20160117023247.GJ238@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108043959.GA7856@brightrain.aerifal.cx>
 <20160111175307.GC6344@twins.programming.kicks-ass.net>
 <20160113014046.GA22101@verge.net.au>
 <20160115005229.GB238@brightrain.aerifal.cx>
 <CAMuHMdVWtxq+62Uz1xqzrnmjor2aOKnxsirSerXhiwh=UfTKiQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVWtxq+62Uz1xqzrnmjor2aOKnxsirSerXhiwh=UfTKiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "D. Jeff Dionne" <jeff@uclinux.org>, Rob Landley <rob@landley.net>

On Fri, Jan 15, 2016 at 10:31:13AM +0100, Geert Uytterhoeven wrote:
> Hi Rich, Sato-san,
> 
> On Fri, Jan 15, 2016 at 1:52 AM, Rich Felker <dalias@libc.org> wrote:
> > On Wed, Jan 13, 2016 at 10:40:46AM +0900, Simon Horman wrote:
> >> On Mon, Jan 11, 2016 at 06:53:07PM +0100, Peter Zijlstra wrote:
> >> > On Thu, Jan 07, 2016 at 11:39:59PM -0500, Rich Felker wrote:
> >> > > From: Rich Felker <dalias@libc.org>
> >> > >
> >> > > Add Yoshinori Sato and Rich Felker as maintainers for arch/sh
> >> > > (SUPERH).
> >> > >
> >> > > Signed-off-by: Rich Felker <dalias@libc.org>
> >> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> > > Acked-by: D. Jeff Dionne <jeff@uClinux.org>
> >> > > Acked-by: Rob Landley <rob@landley.net>
> >> >
> >> > A much appreciated move,
> >> >
> >> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>
> >> Likewise,
> >>
> >> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

> > While patch 2/2 still seems to need discussion and resolution, I don't
> > think this part (1/2, adding us as maintainers) is controversial. Can
> > it be committed now? Geert? Andrew?
> 
> I think it should go in either through Andrew, or through yourself, depending
> on whether you already have other stuff ready for this merge window, and have
> a git repo to pull from.
> 
> Do you have a git repository to ask Linus to pull from, and to provide a branch
> for linux-next integration testing?

Not quite yet. If it can be done in this merge window, I think it
makes sense for Andrew to do it to make it official that arch/sh isn't
abandoned, and Sato-san and I can have the repo setup well ahead of
the next window. How does that sound?

I'd love it if we could get some of the actual code changes in for
this merge window too but I'm not clear whether there's still time.

Rich
