From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 10 May 2011 19:03:02 +0000
Subject: Re: [PATCH 1/5] PM / Runtime: Support for generic I/O power domains (v3)
Message-Id: <201105102103.02697.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl> <201105082322.44268.rjw@sisk.pl> <BANLkTin49iSYn=r8G=L0S2vnZhtZw6RFpw@mail.gmail.com>
In-Reply-To: <BANLkTin49iSYn=r8G=L0S2vnZhtZw6RFpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lin Ming <minggr@gmail.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Tuesday, May 10, 2011, Lin Ming wrote:
> On Mon, May 9, 2011 at 5:22 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > +
> > +/**
> > + * __pm_genpd_restore_device - Restore a pre-suspend state of a device.
> > + * @dev: Device to restore the state of.
> > + * @genpd: Power domain the device belongs to.
> > + */
> > +static void __pm_genpd_restore_device(struct device *dev,
> > +                                     struct generic_power_domain *genpd)
> > +{
> > +       struct device_driver *drv = dev->driver;
> > +
> > +       if (genpd->start_device)
> > +               genpd->start_device(dev);
> > +
> > +       if (drv && drv->pm && drv->pm->runtime_resume)
> > +               drv->pm->runtime_resume(dev);
> > +
> > +       if (genpd->stop_device)
> > +               genpd->stop_device(dev);
> > +}
> 
> Why call ->stop_device in restore function?

Because the device is still suspended at this point, most likely.
Presumably drv->pm->runtime_resume(dev) has restored it's registers, but
the device's runtime PM status hasn't changed (yet).

> BTW,
> you implemented power domains for ARM / shmobile,
> What can we do for other arches?
> I wonder how to implement this "power domain" on x86.

It depends on what kind of x86 you mean.  On PCs we can't control power
domains directly and it is done through ACPI power resources, which works.
I don't think there's a need to rework this.

On Moorestown and similar, I can't say, since I don't know how the hardware
is designed.

Thanks,
Rafael
