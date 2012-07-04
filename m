From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jul 2012 09:39:07 +0000
Subject: Re: Boot regression on Mackerel with current mainline
Message-Id: <Pine.LNX.4.64.1207041125330.21042@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201207031218.24797.rjw@sisk.pl> <Pine.LNX.4.64.1207031336320.29890@axis700.grange>
 <201207031910.24864.rjw@sisk.pl>
In-Reply-To: <201207031910.24864.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>

On Tue, 3 Jul 2012, Rafael J. Wysocki wrote:

> On Tuesday, July 03, 2012, Guennadi Liakhovetski wrote:
> > Hi Rafael
> >=20
> > On Tue, 3 Jul 2012, Rafael J. Wysocki wrote:
> >=20
> > > Hi,
> > >=20
> > > We seem to have a functional regression on Mackerel with 3.5-rc5 which
> > > seems to be related to SDHI.  Namely, the SDHI driver appears to wait=
 forever
> > > for the devices to appear and commenting out all of the sdhi devices =
in the
> > > board file works around the problem.
> > >=20
> > > I can investigate some more later today if need be.
> >=20
> > Have you checked the logs? Are you seeing any of these in the kernel lo=
g:
> >=20
> > genirq: Threaded irq requested with handler=3DNULL and !ONESHOT for irq=
=20
>=20
> I see this only once per boot, but then sh_mobile_sdhi is saying "timeout
> waiting for hardware interrupt" pretty much continuously.

Yes, that's the one. Ok, let's fix it in the driver. In fact, a fix has=20
already been submitted, but for 3.6. I hoped, 3.5 would resort to a softer =

form of the ONESHOT failing, so, I didn't push it for -rc. I think, the=20
easiest would be to apply these two patches:

"mmc: tmio: use MMC opcode defines instead of numbers"
http://git.kernel.org/?p=3Dlinux/kernel/git/cjb/mmc.git;a=3Dcommit;hY8cd9cc=
217b0aa46089a3838a8b1c37b97aa08b

and

"mmc: extend and rename cd-gpio helpers to handle more slot GPIO functions"
http://git.kernel.org/?p=3Dlinux/kernel/git/cjb/mmc.git;a=3Dcommit;h=D8e60f=
b51effc83e6f53de191a8440f46e5a3f2c

The latter one looks big because of a rename, but with "-M" it's pretty=20
trivial. Chris, do you agree?

Thanks
Guennadi

> > with an IRQ number at the end? If so, then this is a known problem, whi=
ch=20
> > I'd hoped would have been long fixed by now:
> >=20
> > https://lkml.org/lkml/2012/6/12/151
> >=20
> > We can nommit a fix for it in mmc, or we can try to re-ping Thomas - if=
=20
> > this is indeed the bug, you're getting...
>=20
> I guess it is, but having reviewed the above e-mail thread I don't think =
any
> fix from Thomas is going to appear.  So, please fix that in MMC, if possi=
ble.
>=20
> Thanks,
> Rafael
>=20

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
