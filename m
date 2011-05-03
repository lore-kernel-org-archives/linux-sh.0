From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 03 May 2011 22:37:58 +0000
Subject: Re: [PATCH/RFC] ARM: mach-shmobile: sh7372 power domain prototype
Message-Id: <201105040037.58894.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20110411194911.7991.79950.sendpatchset@t400s>
In-Reply-To: <20110411194911.7991.79950.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday, May 03, 2011, Guennadi Liakhovetski wrote:
> On Sat, 30 Apr 2011, Rafael J. Wysocki wrote:
> 
> > On Friday, April 29, 2011, Rafael J. Wysocki wrote:
> > > On Friday, April 29, 2011, Guennadi Liakhovetski wrote:
> > > > On Thu, 21 Apr 2011, Guennadi Liakhovetski wrote:
> > > > 
> > > > > On Tue, 19 Apr 2011, Guennadi Liakhovetski wrote:
> > > > > 
> > > > > > On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:
> > > > > > 
> > > > > > > Hi Magnus
> > > > > > > 
> > > > > > > On Tue, 12 Apr 2011, Magnus Damm wrote:
> > > > > > > 
> > > > > > > > From: Magnus Damm <damm@opensource.se>
> > > > > > > > 
> > > > > > > > This experimental sh7372-specific Runtime PM prototype
> > > > > > > > adds support for the A4LC and A4MP power domains.
> > > > > > > > 
> > > > > > > > Tested on the Mackerel board together with the LCDC:
> > > > > > > > 
> > > > > > > > # blank HDMI fbdev
> > > > > > > > echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.1/graphics/fb1/blank
> > > > > > > > 
> > > > > > > > # blank LCD panel fbdev
> > > > > > > > echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > > > > > > > # unblank LCD panel fbdev
> > > > > > > > echo 0 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > > > > > > > 
> > > > > > > > Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > >  arch/arm/mach-shmobile/pm_runtime.c |  227 ++++++++++++++++++++++++++++++++++-
> > > > > > > >  1 file changed, 222 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > Your patch worked mostly, below is a small addition (to be applied on top 
> > > > > > > of your patch), that adds several new domains and devices and fixes a 
> > > > > > > couple of issues with your original patch. Notice an "#if 0" around i2c 
> > > > > > > devices: activating them causes problems - output on the LCDC disappears 
> > > > > > > and the boot process doesn't complete, but without a serial console I 
> > > > > > > couldn't tell, what exactly was the problem. Should be investigated 
> > > > > > > further.
> > > > > > 
> > > > > > Below is a fixed version of the earlier proposed fix;)
> > > > > 
> > > > > v3: I think, I've got the use-counting and power-domain initialisation 
> > > > > correct this time too. At least this version works without any need to 
> > > > > modify the runtime PM core.
> > > > 
> > > > v4: (1) add checks for BIT_ACTIVE for devices without any clocks 
> > > > associated with them, this fixes Oopses. (2) I think, this time I've 
> > > > finally found _the_ correct time and place to remove the "prd" from the 
> > > > list. As before, this is a work in progress, subject to change, depending 
> > > > on surrounding developments. Posting here just for reference.
> > > 
> > > Please have a look at these patches:
> > > https://patchwork.kernel.org/patch/740162/
> > > https://patchwork.kernel.org/patch/740152/
> > > which are based on the patchset from:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git power-domains
> > 
> > I had to rebase this branch due to recent modifications requested by reviewers.
> > 
> > Also the two patches above have been updated, but the latest versions have
> > been tested with the A4LC power domain and LCDC and confirmed to work.
> 
> Ok, I rebased my patches on top of your work. In principle, it works 
> nicely practically out of the box. Just had to add power domain 
> definitions, and add my devices to those domains - nice work!

Thanks!

> But now I have the following question: currently for rtpm to power down a 
> domain, all devices' rtpm has to be enabled. Which is not the case by 
> default without drivers loaded. This is already my first doubt - if there 
> is no driver, shall the device be really holding the domain?

Well, that depends.  In general, when runtime PM is not enabled, the
core doesn't know if it is safe to power down the device (it may be
someone's parent or something like this).  This extends to power domains IMO.

However, in specific situations it may be safe to remove power from a
power domain regardless, but that would require an additional power domain
field or flag and a little more complicated code to handle that.  I decided
to do the simpler thing first, but I'm not against adding the more complicated
handling on top of it in principle.

> Does it have to be powered on? Maybe we could define a flag in device PM
> properties for this?

I'm not sure if device PM properties are a good place to add the flag to.
In that case the meaning of the flag would overlap with the meaning of
disable_depth somewhat.  Perhaps it's better if that's a power domain flag,
but as I said I'm not sure.

> Then, if a driver is bound to a device, it usually enables rtpm, so, 
> as long as it is bound, it can put the device, which can lead to domain 
> powering down - if all other devices agree. But when the driver unbinds 
> from the device again we have the same problem as above. Also, in some 
> cases unbinding the driver is (almost) the only possibility to identify 
> the moment, from which the device is not needed anymore. Shall we keep its 
> rtpm enabled then?

Well, I'm slightly against that.

It follows from my experience that trying to do runtime PM of devices without
drivers is going to fail at least for some of them (it did for PCI and USB)
and there's no good way to distinguish working from non-working ones.
For this reason, I think it's better to require that a driver be bound to the
device and let the driver enable/disable the runtime PM.

> For example, consider SDHI / TMIO SD-host driver on sh-mobile. As long as 
> TMIO is bound to the device, it has to watch for card insert / eject 
> events, and for that it has to be powered on. There are also many other 
> peripherals in the same power domain, so, to power the domain down you 
> either have to disable card-detection, or unbind the driver, but keep the 
> rtpm enabled. What do you think is the preferred way to handle this?

I would go for disabling card detection.

Thanks,
Rafael
