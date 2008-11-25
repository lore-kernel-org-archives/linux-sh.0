From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Nov 2008 19:50:11 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081125195010.GA26464@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 25, 2008 at 08:48:21PM +0100, Kristoffer Ericson wrote:
> On Wed, 26 Nov 2008 02:54:26 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> > Matt's patch should allow us to fix the __do_IRQ() problem, if you want
> > to build on top of that, that is fine, but it is still helpful to know
> > whether it works for you with CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ enabled.
> > 
> > The only problematic thing I see is the lack of the base IRQ factoring,
> > only the chained handlers for the multiplexed sources are defined. This
> > is the way it should be, but it is possible that there will have to be
> > another handler set up to at least get the hd64461 IRQ firing. This is
> > the basis for that silly i = 16 thing in the old demux code. Any user
> > that depends on that behaviour deserves to be broken, though.
> 
> I've attached the code I got so far. You can atleast see my 
> approach to the issue.
> 
The approach you use has all of the same problems as the old code in
terms of how the demux is handled and how it completely sidesteps the
generic hardirq code. Additionally, this is new code, rather than
refactoring existing code. If Matt's patch doesn't work for you, then we
just leave CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ disabled for hd64461. If it
does work however, then you are much better off adopting that code and
including it in your MFD driver. The main thing is to fix what we have
in-tree first.
