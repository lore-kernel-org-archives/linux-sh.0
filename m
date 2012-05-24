From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 May 2012 14:48:39 +0000
Subject: Re: [PATCH] sh: switch various MSTP PM clocks to device-ID look-up
Message-Id: <20120524144838.GE11860@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204262327080.32219@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204262327080.32219@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 24, 2012 at 10:56:32AM +0200, Guennadi Liakhovetski wrote:
> On Fri, 27 Apr 2012, Paul Mundt wrote:
> > On Thu, Apr 26, 2012 at 11:48:32PM +0200, Guennadi Liakhovetski wrote:
> > This seems more like a failure in runtime PM than an issue with
> > connection IDs. We use connection IDs particularly in cases where there
> > is ambiguity, or multiple clocks for the same device, which we want to
> > toggle at different times. We won't be blindly moving off of connection
> > IDs where that behaviour is desirable if there is insufficiently granular
> > infratructure to migrate to.
> 
> Sorry for an almost one month long pause. Maybe we could close this thread 
> by verifying my current understanding and checking your preferences.
> 
No problem, it's better to hash things out in email even if it takes some
cycles rather than burning cycles on patches prematurely.

> 1. The drivers I was looking at: SDHI, MMCIF, MSIOF all do clk_get(dev, 
>    "name%d"); where name%d is sdhi%d, mmc%d and msiof%d respectively.
> 2. Some other drivers, like i2c do just clk_get(dev, NULL);
> 3. Others yet, e.g., sci do clk_get(dev, name), where name is fixed - it 
>    doesn't have the interface number in it. The sci driver uses two clocks 
>    with connection IDs "sci_ick" and "sci_fck."
> 
> This seems a bit messy to me, but, well, as long as it works - no need to 
> change anything there:-) My understanding would be, that a preferred 
> scheme would be to either use no connection ID at all or use a fixed one - 
> without an index. On the platform side:
> 
I agree with you that the first two are messy and doing something about
them is a worthwhile endeavour. I think where we either have a
misunderstanding or a differing of opinions is the 3rd case.

With regards to the lack of an interface number, that's intentional and
by design. All clock lookups using connection IDs factor in the interface
number at CLKDEV_ICK_ID() time, and as you have correctly identified,
this is primarily of value for when we have multiple clocks for one
device.

Perhaps if we use sci as an example you'll see why we went with the
abstraction that way:

	- We have cases where gating of the block is controlled
	  independently of the actual clock that's of any relevance to
	  the driver. 

		- This is especially visible in cases where we have MSTP
		  bits wrapped to function clocks that control block
		  gating but don't actually have anything to do with the
		  clock input otherwise.

	- The main clock driving sh-sci is not sci_fck, but sci_ick (or
	  in the case where it doesn't exist, pclk).

		- While sci_fck exists for off/on control, it has very
		  little other functionality.
		  
	- sci_ick can be arbitrarily defined.

		- At present this is primarily wrapped to the pclk
		  value due to the fact we're using external clock input
		  to drive the block.

		- The intent has always been to support switching over to
		  having the sh-sci block generate its own clock when
		  necessary, once we have a facility in place to register
		  sci_ick from within the driver itself.

		- We have quite a few blocks that follow this model.

So, in summary:

	- sci_fck: module on/off
	- sci_ick: pclk if external, otherwise internally driven

For extra points:

	- Internal generation is a per-port property, so we can have
	  cases where internal generation is used for some ports while
	  the pclk input is used for others (this largely depends on both
	  the baud rate generator and pinmux state).

In these sorts of cases I suppose we have to look at what runtime PM
cares about. I expect that it's only sci_fck that runtime PM requires any
visibility of, while the sci_ick state remains an internal property. I
expect there is some way that we can get the two to co-exist and get the
sort of behaviour that you're after, but it's not obvious that the
present runtime PM approach is sufficiently granular for dealing with
this. clk_get(dev, NULL) certainly doesn't contain enough information
for us to work out whether sci_fck or _ick is needed, and they will both
need to be enabled/disabled at different times and for different reasons.

> Here my understanding is, that for clocks, that should be referenced from 
> the runtime PM a device reference is compulsory, so, CLKDEV_ICK_ID() or 
> CLKDEV_DEV_ID() should be used. For clocks, used by drivers with an 
> indexed connection ID, CLKDEV_CON_ID() entries will work too. This means, 
> that at least the runtime PM on platforms, touched by this patch, is 
> disabled for affected devices, but I personally have no idea how much of a 
> problem that is, I don't work with any of them.
> 
Perhaps part of the problem is that MSTP control really doesn't really
belong in the clock framework to begin with. MSTP control was shoe-horned
in because that's more or less where it fit from an API point of view in
terms of block enable/disable functionality -- obviously pre-dating
runtime PM and others. Perhaps we're at a point where we need to think
about decoupling MSTP control in to a different API and then thinking
about how to tie that in to runtime PM. On the other hand, the clock
framework utilization by runtime PM at the moment matches MSTP control
pretty well, so I'm also not in a hurry to attempt to introduce another
paradigm and create even more busy work (this was already tried and
abandoned with the hwblk API and so on).

Perhaps the simplest solution is simply having some API extension in
runtime PM in which we are able to associate a function clock for control
on a per-device level without relying purely on clk_get(dev, NULL) to do
the right thing -- indeed this is probably the way things are going to
have to go for the common struct clk fiasco, which for reasons
unbeknownst to me favours pre-clkdev clk_get_sys() string lookups from
the dark ages for everything.

> So, if this situation is acceptable, no problem with me, we can drop this 
> series. If, however, we want to change something in this, would be nice to 
> know your opinion. If my this patch-set can be adjusted to fulfill any of 
> your wishes in this area - we could try to do that:-)
> 
I don't actually have any problems with the series as you've posted it, I
just bristled at the notion that connection IDs are bad and are to be
avoided, while in practice they do have an important application and is
something runtime PM needs to figure out how to deal with.

In the case of your patch, I think that especially in the grouped case it
helps to break things out. For example, you've switched dmac_11_6_fck and
dmac_5_0_fck to sh-dma-engine.1 and .0 respectively, while those may not
functionally be the same, unless sh-dma-engine.1 controls all of channels
11 to 6 and sh-dma-engine.0 is assuming control of channels 5 to 0. If
it's the case that each channel is being registered independently (as we
do have with the TMU, PCIe, etc.) then we simply maintain ICK behaviour
mapping to the corresponding shared MSTP bit (not really any different
from shared IRQ utilization that the dmaengine stuff is doing, too).

We also have cases where devices with a -1 id are supported alongside
those with >= 0 ids that wish to use the same clock lookup strategy.
Any of your #2 or #3 case as noted above will handle this, while the #1
case is completely broken (there are many cases where we have clk0 names
to support this behaviour even though we're really dealing with a -1 id
case) and should be ripped out of the tree with prejudice.

If you're interested in doing cleanups in this area, there are a few
things that I'd like to see done:

	- Killing anything that attempts to construct a clock string for
	  lookup by hand.

	- Getting rid of the clk0 names where -1 dev id behaviour is
	  implied and working out an alternate way to connect the lookup
	  to the driver. Some of these will actually be valid dev.0 cases
	  that simply predate the introduction of the . in the device
	  name.

	- Naming consistency. Many clocks that we don't use in any driver
	  have weird combination dev and ick or con id strings -- like
	  hac0/1_fck that need to make up their mind. Once we've
	  got a convention in place it'll be easier to prevent people
	  from deviating too much and introducing more driver lookup
	  mess. A lot of this also predates clkdev lookups.

With those issues addressed I think a lot of the ambiguity will go away
and it should be a lot more readily apparent when we need a con/dev/ick
clock lookup.
