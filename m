From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Jun 2011 22:54:38 +0000
Subject: Re: [PATCH][RFC] drivers: sh: late disabling of clocks
Message-Id: <20110615225432.GB28947@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609091339.14510.31590.sendpatchset@t400s>
In-Reply-To: <20110609091339.14510.31590.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Wed, Jun 15, 2011 at 11:21:40PM +0900, Magnus Damm wrote:
> On Tue, Jun 14, 2011 at 3:41 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Jun 13, 2011 at 05:59:08PM +0900, Simon Horman wrote:
> >> On Thu, Jun 09, 2011 at 06:13:39PM +0900, Magnus Damm wrote:
> >> > From: Magnus Damm <damm@opensource.se>
> >> >
> >> > This RFC patch kills two birds with one stone:
> >> >
> >> > 1) Fix existing issue where in-use clocks without software
> >> >    reference are disabled during boot. One example of this
> >> >    is the handling of the Mackerel serial console output.
> >> >
> >> > 2) Make sure so far unused clocks actually get turned off
> >>
> >> Is access to allow_disable SMP-safe?
> >> In particular, does the the access in clk_late_init()
> >> need to be guarded by clock_lock as calls to __clk_disable() are?
> >
> > On reflection I think that the problem is a bit deeper.
> >
> > I think allow_disable is set to 1 prematurely, as it indicates
> > to __clk_disable() that calling clk->ops->disable(clk) is allowed,
> > even if the iteration of the loop in clk_late_init() is not complete.
> >
> > My proposed re-working of clk_late_init() is below.
> > Completely untested.
> 
> Right, I was thinking something along those lines too. The spinlock
> should make sure we're serialized.

Great. Feel free to take my ideas verbatim if it helps.

