From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 30 Sep 2013 14:38:37 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <4930291.CjfDWjixe7@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Grant,

On Monday 30 September 2013 14:15:15 Grant Likely wrote:
> On Thu, Sep 26, 2013 at 8:46 AM, Linus Walleij wrote:
> > On Wed, Sep 25, 2013 at 11:05 AM, Laurent Pinchart wrote:
> >>> > 3. RFC because I don't know how to enable choosing between CON14 and
> >>> > CON8. In .c version this is done by reading GPIO 6. To do the same in
> >>> > DT mode we'd probably have to use some run-time DT patching, which
> >>> > isn't possible yet, AFAICS.
> >>> 
> >>> I agree with your reasoning there, though perhaps Laurent or Magnus
> >>> have a more enlightened view of things.
> >> 
> >> I'm tempted to say this should be handled by the boot loader, which
> >> should then patch the DT accordingly. This is probably just a poor
> >> attempt not to solve the problem in Linux though :-)
> > 
> > This is not the first time we have come to the conclusion that Linux
> > need to modify the device tree.
> > 
> > And I clearly remember Grant stating that it is in principle a living
> > datastructure, it's not like it's read-only.
> 
> You still don't want the kernel modifying the DT. The DT is primarily
> a communication mechanism from the firmware/platform to the kernel. If
> the platform is responsible for describing the correct configuration
> then it belongs in the DT. If however the kernel needs to do the work
> of figuring out which configuration to use at runtime, then it would
> be better for the DT to describe the possible configurations and let
> the kernel choose the appropriate one.

Could you please elaborate a bit on how you envision this being implemented ?

> > The actual restrictions seem to be more about things like if you
> > need to read this GPIO to figure out how to set up the device tree
> > you already need the base system initialized to access the GPIO
> > so it becomes a chicken-and-egg problem.
> > 
> >> Linus, do you have an opinion on this ? The board has two connectors
> >> (MMC/SD 1 and wifi module) that are not usable concurrently. The user
> >> can select which connector to use through a hardware switch that
> >> existing board code reads at init time to determine which platform
> >> devices to register and how to configure pin muxing. Are you aware of a
> >> similar problem on other boards that would have been solved already ?
> > 
> > Just because the pin control tables *can* be initialized from the device
> > tree doesn't mean all of them *have to*.
> 
> Right. Also, there are patches floating about that allow additional device
> tree fragments to be loaded after the rest of the system is booted. It was
> specifically designed for the beaglebone expansion connectors. That might be
> the way to solve your problem here. (I really want to get that feature
> merged, but I sheepishly admit that I haven't been able to spend any time on
> it)  :-(

-- 
Regards,

Laurent Pinchart

