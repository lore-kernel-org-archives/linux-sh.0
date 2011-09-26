From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 26 Sep 2011 08:39:24 +0000
Subject: Re: [BUG] on sh7372 (mackerel) with today's Linus' (github) master
Message-Id: <20110926083924.GD22455@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1109231012490.25166@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1109231012490.25166@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Sep 24, 2011 at 03:07:07PM +0200, Rafael J. Wysocki wrote:
> On Saturday, September 24, 2011, Russell King - ARM Linux wrote:
> > On Sat, Sep 24, 2011 at 12:58:37AM +0200, Rafael J. Wysocki wrote:
> > > Well, since nobody seems to execute anything that may sleep under
> > > clocks_mutex, perhaps we can do something like this:
> > 
> > No - a spinlock prevents preemption, a mutex does not.
> > 
> > It's runtime PM which is doing stuff wrong here.  You're not supposed to
> > give up the clk struct with it enabled.
> 
> OK, so below is a fix confined to clock_ops.c.

Looks fine from a read-through the patch, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
