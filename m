From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Nov 2008 17:54:26 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081125175426.GB24395@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 25, 2008 at 07:40:39PM +0100, Kristoffer Ericson wrote:
> On Sat, 22 Nov 2008 16:49:52 +0000
> Matt Fleming <mjf@gentoo.org> wrote:
> 
> > On Fri, Nov 21, 2008 at 04:34:45PM +0900, Paul Mundt wrote:
> > > 
> > > So, pending a rewrite of hd64461, we should probably just leave the
> > > __do_IRQ() dispatch as an option there, until someone gets around to
> > > rewriting that mess. I will conditionalize it on !HD64461 for now.
> > 
> > Kristoffer can you try the attached patch, please? It compiles OK but I
> > haven't had chance to test it on actual hardware.
> 
> Sorry for the late reply, been having issues with my internet
> connection. Anyhow, not sure if this solves anything since
> I've already rewritten the IRQ part to be alot more
> sensible. Basicly only wanting to get FB going
> before I push it upstreams.
> 
> What you think Paul?
> 
Matt's patch should allow us to fix the __do_IRQ() problem, if you want
to build on top of that, that is fine, but it is still helpful to know
whether it works for you with CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ enabled.

The only problematic thing I see is the lack of the base IRQ factoring,
only the chained handlers for the multiplexed sources are defined. This
is the way it should be, but it is possible that there will have to be
another handler set up to at least get the hd64461 IRQ firing. This is
the basis for that silly i = 16 thing in the old demux code. Any user
that depends on that behaviour deserves to be broken, though.
