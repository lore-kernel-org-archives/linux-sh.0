From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 May 2013 01:29:42 +0000
Subject: Re: marzen-reference doesn't boot with CONFIG_PREEMPT
Message-Id: <20130515012942.GI12246@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <4961084.Cgj9yMUAgI@avalon>
In-Reply-To: <4961084.Cgj9yMUAgI@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 15, 2013 at 03:05:18AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 15 May 2013 09:23:59 Simon Horman wrote:
> > On Tue, May 14, 2013 at 09:08:07PM +0200, Laurent Pinchart wrote:
> > > But marzen does (renesas-next-20130513). Is that a known issue ?
> > 
> > No, I was not aware of that.
> > 
> > I would suspect, based on work on the kzm9g, that the problem
> > relates to driver initialisation order. In the case of kzm9g
> > my recollection is that the problem was resolved by initialising
> > clocksources earlier by changing their initcall level.
> 
> Did that reach mainline ? I've tried booting kzm9g-reference with 
> CONFIG_PREEMPT and have been unable to boot it as well with renesas-
> next-20130513. Maybe we should enable CONFIG_PREEMPT by default to catch 
> similar issues in the future.

It made it into 3.10-rc1 and has been in next for a while now.
So it seems that you have found a different problem.

I'm ambivalent to setting CONFIG_PREEMPT by default.
