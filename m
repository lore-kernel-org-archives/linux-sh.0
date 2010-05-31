From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 31 May 2010 11:36:54 +0000
Subject: Re: [PATCH] sh_tmu: compute mult and shift before registration
Message-Id: <20100531113654.GA15411@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1275296994-12005-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275296994-12005-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 31, 2010 at 01:19:51PM +0200, Aurelien Jarno wrote:
> Magnus Damm a ?crit :
> > Hm, are you sure the clock is enabled at this point?
> >
> > The file include/linux/clk.h says that the clock has to be enabled
> > before clk_get_rate() is called.
> > 
> 
> In practice yes, but as you said it seems that theoretically it is not
> guaranteed, so it may break again in the future.
> 
It's a bit risky this early on, board code has ultimate control over what
sort of external oscillator is actually hooked up and promptly kicks a
rate propagation down the chain from the top down in order to reflect
those settings (some boards will have variable input clocks where we need
to test a pin to work out which is actually hooked up).

We've been lucky for the simple cases largely because few boards have
deviated from the defaults, but that's not behaviour we want to rely on.
The alternative is tying in a notifier chain, as we do with the serial
and cpufreq cases.

> It probably means that if the clock is not already started we have to
> start it, call clk_get_rate() and stop it.
> 
The clock yes, but not the timer channel. You can simply use a
clk_enable()/disable() pair around the get_rate and you'll be fine, this
is what most drivers do when the rate information is needed well before
there is any intent to keep the block clocked for any lengthy duration.
This still won't help for the case where the board code kicks down a rate
change, so that still needs a bit of a think.
