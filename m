From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Tue, 11 Jan 2011 09:44:59 +0000
Subject: Re: Locking in the clk API
Message-Id: <201101111744.59712.jeremy.kerr@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
In-Reply-To: <20110111091607.GI12552@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Russell,

> I object to this as one of the purposes behind the clk API is to allow
> power savings to be made, and unless we can perform clk enable/disable
> from atomic contexts, the best you can do is enable the clock when the
> device is probed and disable it when it's released.
> 
> [...]
>
> Sometimes the only point that you know you need the clock enabled is when
> your driver has already been called in an atomic context.

.. provided that the enable (and subsequent things that depend on the clock 
signal to be valid) can't be deferred; I'm not sure how often this will be 
possible.

So, it sounds like the best approach is to provide an atomic clk_enable. I 
agree with Sascha that the clk_enable and clk_enable_atomic polarity makes the 
most sense, so how about:

int clk_enable(struct clk *clk)
{
	might_sleep();

	[...]
}

int clk_enable_atomic(struct clk *clk)
{
	BUG_ON(!(clk->flags & CLK_ATOMIC));

	[...]
}

Paul: even though you mention that the atomic clocks are the usual case, I 
think that this way around illustrates the atomic 'restriction' at the call 
site more clearly. When the drivers don't care about the atomicity, 
clk_enable() is fine. When drivers do need an atomic clock, 
clk_enable_atomic() shows this requirement.

Cheers,


Jeremy
