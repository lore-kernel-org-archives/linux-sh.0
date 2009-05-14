From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 May 2009 03:40:58 +0000
Subject: Re: [PATCH] sh: clkfwk: Changed the init function
Message-Id: <20090514034058.GA10956@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1505.7000500@st.com>
In-Reply-To: <49BA1505.7000500@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 19, 2009 at 09:24:38AM +0100, Francesco VIRLINZI wrote:
> >The clock framework itself also specifies that no assumptions can be made
> >about the state of the clock, so you must call clk_enable() to enable the
> >clock after bumping the refcount with clk_get(), and then and only then
> >can you determine if there is a problem with the clock settings.
> I understand you point of view... and also my example was not so good!
> Let me try again ;-)
> 
> Now in the clock fmwk we have also clk_set_parent/clk_get_parent this means
> we can change the topology on the fly (we have this behavior with video 
> clocks).
> 
> From my point of view the .init function should also initialize the 
> clk->parent field based
> on the loaded hw setting... (I assume we can not hard-code something 
> like clk_x->parent = &clk_y;
> just because something like that it's strictly based on hardware value 
> on power-up).
> 
clk->parent is meant to be hardcoded in most all cases, it is really only
the corner cases that need to change this at all. ie, in the case of root
clocks where the clkin provider can be flipped for a given clock, it
needs to be reparented accordingly. The common case there is if there are
multiple oscillators that can be switched between (also from software,
though of course the board needs to know how it is clocked).

> Therefore I can trust the clk->parent value only after a call to the 
> .init function.
> 
There is basically no point in doing that. Your CPU should have a
reasonable clock topology defined with fairly sensible defaults, which in
turn can be fixed up by the platform code. I've recently been reworking
the clock framework in the sh/clkfwk topic branch as a result of people
having a lot of confusion about how it is supposed to be used. So,
perhaps it helps to summarize the reworked initialization process a bit.

Presently the init process consists of the following steps:

	* arch_clk_init()

		- This is for the CPU to register its clock topology.
		  This is only about available clocks, mapping out
		  relationships, etc. and makes no promises that any
		  given source is used, or even possible on a given
		  board.

		- Note that this is _only_ for initializing the topology,
		  clocks do not need any rate information here if the
		  platform code is forced to set it in the case of a root
		  clock, or if the rate is established in the recalc path
		  from initial root clock propagation.

	* sh_mv.mv_clk_init()

		- This is the platform callback to step in and do any
		  fine tuning of the CPU's clock topology that is
		  necessary. This can include reparenting the root
		  clocks, setting an initial rate for root clocks (to
		  handle the case where different boards have different
		  oscillator frequencies on the same input pin and so
		  on), etc.

	* recalculate_root_clocks()

		- This calls in to ->recalc() for every root clock, to
		  handle things like topology changes made by the
		  platform code.

		- Afterwards, propagate_rate() steps in and kicks that
		  information down to all of the child clocks.

		  propagate_rate() recurses for child clocks that have
		  siblings of their own.

	* clk_enable_init_clocks()

		- With the topology mapped out and all of the rate
		  information set up and propagated, the initialization
		  code can now iterate through the clock list and call in
		  to clk_enable() for every clock that wants to be
		  enabled on initialization (via CLK_ENABLE_ON_INIT).

Now, note that at arch_clk_init()/sh_mv.mv_clk_init() time,
clk_register() is called in to for these clocks, but the enable itself is
deferred. This means that things like clk_get() and the various set
functions are accessible for manipulating and initialization the
topology, but things like clk_get_rate() and friends are not reliable
until after this stage, once clk_init() has had a chance to finish its
work.

In the case where a platform needs to set rate information on a given
clock and force propagation before being able to make other configuration
changes, both recalculate_root_clocks() and propagate_rate() are
available for use by the platform code. In the general case the common
path through clk_init() will be sufficient.

> But with the current clfwk is mandatory that a topology change can be 
> done _only_ after the clock is enabled while in my point of view I
> should be able to change the topology without this constraint.
> 
Yes, that was a bug, and is now corrected. :-)

If you see any problems with the reworked clock framework for your use
cases, now would be the time to raise concerns. I'm still busy hacking up
more generic support for CPG clocks, but you can look at the SH7785 clock
framework as an example of the direction things are heading in.

Also note that things like the frequency table are probably going to be
moved under struct clk directly, with a generic round_rate() mapped on
top of that. We will still need to tie in notifier chains to handle
things like the rate table being rebuilt on parent rate propagation and
so on, but the interdependencies there will be a lot clearer once cpuidle
starts tying in to the rate information on the same clocks as cpufreq.
