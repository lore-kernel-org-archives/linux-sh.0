From: Mike Turquette <mturquette@linaro.org>
Date: Wed, 26 Feb 2014 20:54:55 +0000
Subject: Re: [PATCH] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <20140226205455.12081.91122@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <530C9D2A.8030409@baylibre.com>
In-Reply-To: <530C9D2A.8030409@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Laurent Pinchart (2014-02-25 09:48:38)
> On Tuesday 25 February 2014 18:07:54 Benoit Cousson wrote:
> > On 25/02/2014 17:01, Laurent Pinchart wrote:
> > > On Tuesday 25 February 2014 14:39:54 Benoit Cousson wrote:
> > >> +  /*
> > >> +   * Set KICK bit in FRQCRB to update hardware setting and
> > >> +   * wait for completion.
> > >> +   */
> > >> +  kick = clk_readl(zclk->kick_reg);
> > >> +  kick |= CPG_FRQCRB_KICK;
> > >> +  clk_writel(kick, zclk->kick_reg);
> > > 
> > > Does CCF guarantee that two set_rate calls for different clocks will not
> > > occur concurrently ? If so a brief comment would be nice. Otherwise we
> > > need a lock around this.
> > 
> > So far, this is the only user of the register. That's why there is no
> > lock. It is explained in the changelog. But if you want I can re-use the
> > same comment here.
> 
> A comment would be nice, yes. You can make it shorter than the commit message.

CCF holds a global mutex during a call to clk_set_rate. So clk_prepare,
clk_unprepare, clk_set_parent or a competing clk_set_rate will not touch
this register during the critical section.

However it is possible to reenter the framework, but usually you control
that code flow.

The main two reasons to introduce your own more granular register-level
locking are:

1) clk_enable & clk_disable hold a separate global spinlock (not the
global mutex), so if this register is used for set_rate operations AND
enable/disable operations then you'll need a spinlock.

2) Other stuff outside of the clk framework touches this register
(sounds like it is not the case here).

Regards,
Mike
