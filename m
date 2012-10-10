From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 10 Oct 2012 22:58:46 +0000
Subject: Re: [PATCH 05/14] media: add a V4L2 OF parser
Message-Id: <3554867.jEolfa3C2z@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <1398413.j3yGqyN4Du@avalon> <5075D947.3080903@gmail.com>
In-Reply-To: <5075D947.3080903-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Sylwester,

On Wednesday 10 October 2012 22:23:35 Sylwester Nawrocki wrote:
> On 10/10/2012 03:25 PM, Laurent Pinchart wrote:
> > On Tuesday 09 October 2012 13:00:24 Hans Verkuil wrote:
> >> On Tue 9 October 2012 12:34:48 Sylwester Nawrocki wrote:
> >>> On 10/08/2012 11:40 AM, Guennadi Liakhovetski wrote:
> >>>> On Fri, 5 Oct 2012, Sylwester Nawrocki wrote:
> >>>>> I would really like to see more than one user until we add any core
> >>>>> code. No that it couldn't be changed afterwards, but it would be nice
> >>>>> to ensure the concepts are right and proven in real life.
> >>>> 
> >>>> Unfortunately I don't have any more systems on which I could easily
> >>>> enough try this. I've got a beagleboard with a camera, but I don't
> >>>> think
> >>>> I'm a particularly good candidate for implementing DT support for OMAP3
> >>>> camera drivers;-) Apart from that I've only got soc-camera based
> >>>> systems, of which none are _really_ DT-ready... At best I could try an
> >>>> i.MX31 based board, but that doesn't have a very well developed .dts
> >>>> and
> >>>> that would be soc-camera too anyway.
> >>> 
> >>> I certainly wouldn't expect you would do all the job. I mean it would be
> >>> good to possibly have some other developers adding device tree support
> >>> based on that new bindings and new infrastructure related to them.
> > 
> > As I mentioned in another e-mail, I plan to work on DT support for the
> > OMAP3 ISP, but I first need generic clock framework support for OMAP3.
> 
> OK, let's hope it's available soon.

I've been told a month and a half ago that v3.7 was a plausible target, let's 
see.

> >>> There have been recently some progress in device tree support for Exynos
> >>> SoCs, including common clock framework support and we hope to add FDT
> >>> support to the Samsung SoC camera devices during this kernel cycle,
> >>> based on the newly designed media bindings. This is going to be a second
> >>> attempt, after our initial RFC from May [1]. It would still be SoC
> >>> specific implementation, but not soc-camera based.
> >>> 
> >>> I wasn't a big fan of this asynchronous sub-devices probing, but it now
> >>> seems to be a most complete solution to me. I think it just need to be
> >>> done right at the v4l2-core so individual drivers don't get complicated
> >>> too much.
> >> 
> >> After investigating this some more I think I agree with that. There are
> >> some things where we should probably ask for advice from the i2c
> >> subsystem devs, I'm thinking of putting the driver back into the
> >> deferred-probe state in particular.
> > 
> > We might actually not need that, it might be easier to handle the circular
> > dependency problem from the other end. We could add a way (ioctl, sysfs,
> > ...) to force a V4L2 bridge driver to release its subdevs. Once done, the
> > subdev driver could be unloaded and/or the subdev device unregistered,
> > which would release the resources used by the subdev, such as clocks. The
> > bridge driver could then be unregistered.
> 
> That sounds like an option. Perhaps it could be done by v4l2-core, e.g. a
> sysfs entry could be registered for a media or video device if driver
> requests it.

That's what I was thinking about.

> I'm not sure if we should allow subdevs in "released" state, perhaps it's
> better to just unregister subdevs entirely right away ?

I think we need three states: not created, unbound and bound (names are not 
set in stone). The not created state corresponds to a subdev that hasn't been 
created yet by its I2C/SPI/whatever driver (agreed, it's not really a state 
technically). Upon creation the subdev is not bound to any bridge driver. It 
later gets bound when the bridge driver requests the subdev through the API 
the V4L2 core will provide (most probably using notifiers). The new sysfs 
entry would be used to unbind subdevs (either selectively, or all in one go) 
from the bridge, in which case they will go back to the unbound state, 
allowing driver removal or device release.

> >> Creating v4l2-core support for this is crucial as it is quite complex and
> >> without core support this is going to be a nightmare for drivers.

-- 
Regards,

Laurent Pinchart

