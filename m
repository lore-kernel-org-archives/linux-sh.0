From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 25 Feb 2014 17:59:08 +0000
Subject: Re: Maybe this is CCF bug
Message-Id: <17869992.1nPDtJfItE@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjlkq1v1.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87zjlkq1v1.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Mike,

On Sunday 23 February 2014 16:35:54 Mike Turquette wrote:
> Quoting Laurent Pinchart (2014-02-21 06:04:20)
> > On Friday 21 February 2014 13:42:10 Ben Dooks wrote:
> > > On 21/02/14 13:30, Laurent Pinchart wrote:

[snip]

> > > > Another approach to fix the problem was proposed by Ben Dooks in his
> > > > "[PATCH 1/3] clk: add clock-indices support" patch series was to
> > > > standardize the reneses,clock-indices property into a clock-indices
> > > > property, usable by of_clk_get_parent_name() without requiring the
> > > > parent clock driver to have probed the device yet. That's more complex
> > > > but would have the added benefit of making the clock specifier
> > > > translation consistent, at least in this case. I'm not sure whether
> > > > we'll always be able to achieve consistency as some exotic clock
> > > > providers might require a really weird translation mechanism.
> > > 
> > > I think there is a couple of issues here, the first is that
> > > of_clk_get_parent_name() exists at-all. It would be nicer just to be
> > > able to pass a set of 'struct clk *' to the clock registration code.
> > > Although this may also still have an issue where we cannot use
> > > self-referential clocks (I added a hack to allow the mstp driver to use
> > > sub-nodes for each mstp clock group to get around that as a first
> > > implementation)
> > > 
> > > I have not seen any comments on my clock-indices patch yet, I wonder
> > > if anyone has had a chance to review it.
> > 
> > From a code point of view your proposal looks nice, what I wonder is
> > whether that's the direction we want to take. It would fix the problem in
> > this case, but as I've mentioned I'm not sure whether we can solve it
> > generically for all providers with exotic requirements.
> > 
> > Mike probably has a wider view of the issue, that's why I'd like him to
> > comment on this.
> 
> In the past we could not pass struct clk * to clock registration code
> because there was no guarantee that the parent clock had been
> registered.

Could we have that guarantee now ? I expect this would result in a lot of 
probe deferral, which might not be good from a boot time point of view.

> Furthermore the definition of struct clk is not exposed to the wide world so
> we can't use static data to initialize it.
> 
> I have considered the ability for a clk_init_data structure to pass a list
> of parents via struct clk_init_data **parents. This mimics the linkage that
> devicetree gives us, at least within a clock provider. And really we
> probably should be using DT to link up clock providers via phandles.

On DT platforms using clock references instead of names would be a good idea I 
believe. We of course need a different solution on platforms without DT, and 
even on ARM for platforms that haven't been fully converted to DT.

> In general the string-based lookup scheme internal to CCF (and now leaked
> out into DT bindings) is showing signs of age and short-sightedness. Perhaps
> a combination of the existing phandle-based linkage between clock providers
> in DT and some way to express the same for clk_init_data would be sufficient
> to remove the need use clock name strings for expressing parent/child
> relationships?

I have boards not fully ported to DT that instantiate all their clocks through 
DT but look them up in C code with names for platform devices. We would need 
something similar, possibly replacing the clock name by the full DT path to 
its provider node.

-- 
Regards,

Laurent Pinchart

