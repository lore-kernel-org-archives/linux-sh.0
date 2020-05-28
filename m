From: Rich Felker <dalias@libc.org>
Date: Thu, 28 May 2020 22:14:51 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <20200528221450.GF1079@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
In-Reply-To: <20200528161416.GY1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 28, 2020 at 12:14:16PM -0400, Rich Felker wrote:
> On Wed, May 27, 2020 at 10:46:00PM -0700, Christoph Hellwig wrote:
> > [adding Linus]
> > 
> > On Thu, May 07, 2020 at 07:35:52AM -0700, Christoph Hellwig wrote:
> > > Any progress on this?  I plan to resend the sh dma-mapping I've been
> > > trying to get upstream for a year again, and they would conflict,
> > > so I could look into rebasing them first.
> > 
> > So for years now it has been close to and in the end impossible to
> > provoke sh maintainer action.  At the same point hardware is pretty much
> > long gone for the real commercial variants, and never took off for the
> > open hardware nommu variant.
> > 
> > Linus, would you ok with a 5.8 pull request to just kill off arch/sh/?
> 
> It is in active use. Please do not act on such a request. I would be
> much quicker to ack things that actually need ack if I weren't CC'd on
> hundreds of random non-arch-specific changes that don't need it, but I
> understand that's how the kernel process works. If there are things
> that need ack please feel free to ping.
> 
> Note that I specifically acked and requested the sh5 removal.

To follow up, I see that there was a patch series of yours (3/24) I
missed ack'ing fairly recently. At first glance it looks good. It
happened to arrive while I was getting over being horribly sick with
what I thought was covid19. If there's further action needed on it
I'll address it asap now that I'm aware of it.

In general, most of the patches I see are things that the linux-sh
list and myself end up cc'd on that are only tangentially related to
arch/sh or even not related at all. In that case I normally trust
other maintainers familiar with the cross-arch changes being made that
the small arch/sh part of the change is ok if the broader change is
abstractly ok.

Part of why I really disliked the "just kill it all" response to this
thread is that the sh5 removal is specifically for the sake of making
the arch more maintainable. That, along with forward-porting Sato's
SH4 device tree patches (I've tried this but ran into problems, and
need some help with it), has long been on my agenda for the arch, to
reduce (and ultimately eliminate) the amount of legacy "only on
arch/sh" stuff left so that it's not a burden on other maintainers and
contributors. Seeing sentiment along the lines of "why don't you just
remove it all while you're at it?" as a response is disheartening and
also dismissive of Arnd's work making the sh5 removal happen.

Aside from that, the open source & open hardware J-core models are
still active and in development, with the latest release having been
made this month, and the J32 with MMU nearly complete and pending
release, contingent mostly on integration and testing with Linux.
