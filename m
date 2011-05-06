From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 06 May 2011 17:55:26 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add definitions for 3 more power domains on sh7372
Message-Id: <201105061955.26719.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1105051826080.29735@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105051826080.29735@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday, May 06, 2011, Guennadi Liakhovetski wrote:
> Hi Rafael,

Hi,

[Adding linux-pm to the CC list, because some people in there may be
interested in the discussion.]

> On Thu, 5 May 2011, Rafael J. Wysocki wrote:
> 
> > On Thursday, May 05, 2011, Guennadi Liakhovetski wrote:
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > ---
> > > 
> > > Rafael, a modest contribution to your power-domains branch;) I've also had 
> > > to add devices to these domains in my tests, but we have to be careful 
> > > with those additions. Not all, what's logical, works... E.g., to test PM 
> > > with some devices / drivers, certain other devices had to be disabled, 
> > > which is, certainly, not suitable for the mainline.
> > 
> > OK, but some more details would be helpful. :-)
> 
> I think, my main concern with the power domain API is, that you need 
> drivers for all devices. Consider this: in the core we will want to add 
> all devices to respective domains, e.g., all devices from the 
> sh7372_early_devices[] and sh7372_late_devices[] arrays in setup-sh7372.c. 
> But there will be (embedded) systems, that will not want to build all 
> those drivers, but will want to save power by turning those domains off. 
> What shall it be doing? So, either we need a way to only selectively add 
> even centrally defined devices to their power domains, or a way, to manage 
> those power domains even if not all drivers are present.

Hmm.  We can add a check for dev->driver to the loop checking if all
devices in the power domain are suspended in __pm_genpd_poweroff().
If dev->driver is NULL, the device will be regarded as "suspended".

That should do the trick AFAICS.

> > > We'll have to think about what and how exactly to mainline a bit more.
> > 
> > No question about that.  For now, I'd like to push
> > 
> > https://patchwork.kernel.org/patch/742942/
> > https://patchwork.kernel.org/patch/742932/
> 
> Yes, that's what I based all my tests on.
> 
> > upstream, depending on what Magnus thinks of the second one.  I also did
> > a A4MP patch:
> > 
> > https://patchwork.kernel.org/patch/743142/
> > 
> > which I think is safe, because there is only one device in this domain.
> > 
> > I guess we may simply add domains as needed, ie. once we have tested that
> > all of the drivers in a given domain work well together, we may add that
> > domain and populate it with devices in a single patch.
> > 
> > Of course, what we have right now may not be suitable for the more
> > complicated cases (eg. domains containing CPUs or interrupt controllers),
> > so most likely we will need to extend the common code in the process.
> > 
> > Please tell me what you think.
> 
> Right, there are also domains, which we will never want to suspend, at 
> least not during operation. Even for system suspend sometimes you have to 
> keep some domains powered for wakeup.

Right.

> But why are driver runtime_suspend() 
> methods, for devices in a power domain, only called when the complete 
> domain is going down? Perhaps, the idea behind this design is, that 
> driver's runtime_suspend() / restore() only save and restore device's 
> state. So, they only have to be called, when the device loses power, i.e., 
> when the domain is turned off. But what if the device also has some 
> internal means to save power, e.g., by switching off some PLLs, with this 
> design this will only happen when the whole domain goes down. Why not call 
> driver's rtpm methods for each device individually, like in the default 
> platform-device case?

Because _if_ the runtime_suspend()/runtime_resume() callbacks only save
and restore the device's state, it will be wasteful to call those routines
every time the device goes into the "suspended" state without powering
down the entire domain.

The stop_device() and start_device() callbacks are meant for the thing
you're referring to.  They are domain-specific and may call some device
routines in principle (those routines can be pointed to by the device's
subsys_data pointer, which is only used for the clock management on
shmobile right now).

Thanks,
Rafael
