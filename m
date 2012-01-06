From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 06 Jan 2012 08:34:13 +0000
Subject: Re: [PATCH 02/11] mmc: tmio_mmc: support the generic MMC GPIO card
Message-Id: <Pine.LNX.4.64.1201060924100.16279@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
 <1325686636-23905-3-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoTLh2i9s6F_g10+RPnDvA+RkpVYqaYb6-Z=8dvk_YyGYw@mail.gmail.com>
In-Reply-To: <CANqRtoTLh2i9s6F_g10+RPnDvA+RkpVYqaYb6-Z=8dvk_YyGYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

Hi Magnus

Thanks for your review(s)!

On Fri, 6 Jan 2012, Magnus Damm wrote:

> On Wed, Jan 4, 2012 at 11:17 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > If the platform specified a GPIO number and IRQ trigger polarity flags,=
 use
> > the generic MMC GPIO card hotplug helper.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0drivers/mmc/host/tmio_mmc.h =A0 =A0 | =A0 =A04 --
> > =A0drivers/mmc/host/tmio_mmc_pio.c | =A0 69 +++++++++++++++++----------=
------------
> > =A0include/linux/mfd/tmio.h =A0 =A0 =A0 =A0| =A0 19 +++++++---
> > =A03 files changed, 43 insertions(+), 49 deletions(-)
> > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > index 0dc9804..4ef9307 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -1,8 +1,10 @@
> > =A0#ifndef MFD_TMIO_H
> > =A0#define MFD_TMIO_H
> >
> > +#include <linux/device.h>
> > =A0#include <linux/fb.h>
> > =A0#include <linux/io.h>
> > +#include <linux/jiffies.h>
> > =A0#include <linux/platform_device.h>
> > =A0#include <linux/pm_runtime.h>
> >
> > @@ -64,8 +66,8 @@
> > =A0#define TMIO_MMC_SDIO_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> > =A0/*
> > =A0* Some platforms can detect card insertion events with controller po=
wered
> > - * down, in which case they have to call tmio_mmc_cd_wakeup() to power=
 up the
> > - * controller and report the event to the driver.
> > + * down, using a GPIO IRQ, in which case they have to fill in cd_irq, =
cd_gpio,
> > + * and cd_flags fields of struct tmio_mmc_data.
> > =A0*/
> > =A0#define TMIO_MMC_HAS_COLD_CD =A0 =A0 =A0 =A0 =A0 (1 << 3)
> > =A0/*
> > @@ -98,18 +100,23 @@ struct tmio_mmc_data {
> > =A0 =A0 =A0 =A0struct tmio_mmc_dma =A0 =A0 =A0 =A0 =A0 =A0 *dma;
> > =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev;
> > =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0power;
> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd_gp=
io;
> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd_ir=
q;
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd_flag=
s;
> > =A0 =A0 =A0 =A0void (*set_pwr)(struct platform_device *host, int state);
> > =A0 =A0 =A0 =A0void (*set_clk_div)(struct platform_device *host, int st=
ate);
> > =A0 =A0 =A0 =A0int (*get_cd)(struct platform_device *host);
> > =A0 =A0 =A0 =A0int (*write16_hook)(struct tmio_mmc_host *host, int addr=
);
> > =A0};
>=20
> This looks much easier than callbacks and notifiers. Thanks!
>=20
> But why do you need to pass three values here? I expected it to be
> sufficient with GPIO and perhaps also with trigger flags. Shouldn't
> gpio_to_irq() give you the IRQ from the GPIO?

Well, it could:-) What about sh7372? sh73a0 does implement it, whereas=20
sh7372 only returns an error. And - yes, we can fix that one. But this=20
tells me - there can be other platforms like that, and they might not get=20
fixed quickly enough. Should we really refuse to work with them? We could=20
make this parameter optional: set to to an error code and the cd-gpio will =

try to use gpio_to_irq(). If it fails - no luck.

> And why on earth would
> we want to trigger on something else than both edges?

Both edges seems like a logical choice to me too. But - remember the time, =

when one of sh-mobile platforms didn't implement triggering on both edges? =

Until we've implemented a software workaround, whereby we switch to the=20
opposite edge after each interrupt? Are you sure there are no such=20
platforms around left?

> The SoC code may me rather limited in terms of supporting
> gpio_to_irq() but that needs to be fixed then. On SH-Mobile the PFC
> code has been updated to allow this, so it's only SoC-specific code
> missing. Anyone with access to hardware and data sheet can do this,
> and if there are some issues with this then I'd be happy to help
> myself.
>=20
> On the cosmetic side, wouldn't it make sense to have a structure of
> these values and just pass that along? Otherwise people will mix and
> match short and ints for the GPIO and it may become rather messy over
> time.

Short for GPIO? Why would anyone use that and how can that become=20
messy?:-) In principle - I'm basically fine either way. If you really=20
prefer a struct here - we can do that too, yes.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
