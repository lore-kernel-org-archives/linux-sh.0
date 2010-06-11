From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Jun 2010 06:01:51 +0000
Subject: Re: [PATCH v2] sh_tmu: compute mult and shift before registration
Message-Id: <20100611060151.GA11425@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 11, 2010 at 02:02:26PM +0900, Magnus Damm wrote:
> For the CMT driver I think it's best to begin with reverting the
> commit f4d7c3565c1692c54d9152b52090fe73f0029e37 and then add your
> changes on top of that.
> 
> From my point of view we really don't want to have the unused
> clk_enable((), clk_get_rate(), clk_disable() hackery left in the
> drivers.
> 
At the moment the enable/get_rate/disable sequence isn't unused, it's
just not terribly desirable. As soon as we have a better way around it
then of course killing that off would be ideal. We only got in to this
mess in the first place due to the registration/enabling ordering.

> Perhaps the same thing should be done for the TMU as well, any ideas Paul?
> 
Yes, the same can be carried over there. Once we have a solution that
forks for the CMT and TMU case then we'll also want to use it for MTU2.
The main reason for MTU2 not having the same interface initially was
simply because none of the SH-2A parts provided sensible clock
definitions for MTU2, and mostly tended to prefer the CMT for wakeups
anyways.

> I agree with adding a __clocksource_updatefreq_hz(cs, p->rate) line to
> sh_cmt_clocksource_enable(), but the p->rate value should already be
> up to date so I don't think you need to add any clk_get_rate() call.
> 
> Want me to hack up a replacement patch?
> 
This all started out from Aurelien's bug report, so as long as that
remains addressed I'm pretty flexible with how we handle the
registration/enable case. 

Note that the clock framework is initialized before the early timer is,
but some boards might still have unusual ordering due to the propagation
of their initial XTAL values.
