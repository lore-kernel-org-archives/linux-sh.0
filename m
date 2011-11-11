From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 11 Nov 2011 07:49:17 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 A4R suspend/resume order fix
Message-Id: <Pine.LNX.4.64.1111110846230.4608@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20110927085408.27727.59395.sendpatchset@w520>
In-Reply-To: <20110927085408.27727.59395.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, 11 Nov 2011, Magnus Damm wrote:

> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM / shmobile: Avoid restoring the INTCS state during initiali=
zation
> >
> > The SH7372 PM domain initialization routine calls pd_power_up()
> > that executes the domain's .resume() callback, if present, and for
> > the A4R domain this callback attepmts to restore the INTCS state from
> > uninitialized data. =A0To avoid that, introduce __pd_power_up() that
> > will only execute the domain's .resume() callback if its second
> > argument is 'true' and make the SH7372 PM domain initialization
> > use it with 'false' as its second argument. =A0Redefine pd_power_up()
> > as a wrapper around __pd_power_up().
> >
> > Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Looks fine to me, from my point of view your implementation is better
> than the other alternatives.
>=20
> It is correct that Guennadi reported this issue, and the Signed-off
> clearly shows that this specific implementation is coming from you. I
> suppose there are more important things in life than git attribution,
> but I do feel that I did spend a significant amount of time tracking
> down this issue, writing the initial patch and then also communicating
> with you guys. I may be wrong, but I suspect that if didn't do this
> then this issue wouldn't have been fixed.
>=20
> Unfortunately there does not seem to be any tag for that kind of work,
> but if it existed then I would prefer to add this in between you and
> Guennadi:
>=20
> Tracked-down-by: Magnus Damm <damm@opensource.se>

Yes, I also was looking for a suitable attribution to mention you in my=20
version of the patch, and ended up just saying "thanks." But, I think,=20
we're allowed to be creative here, we're not prohibited to create our own=20
tags - whether or not they're going to be standardised. Maybe we can put=20
it even stronger to emphasise, that you not only tracked the problem down, =

but also proposed the first fix. Something like

Initial-fix-by:
or
Original-fix-by:

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
