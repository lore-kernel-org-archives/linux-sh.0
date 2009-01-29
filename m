From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 29 Jan 2009 01:12:54 +0000
Subject: Re: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and clean up maple bus driver (2/3)
Message-Id: <200901282012.56699.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1586976.Qj0ey7Ajbh"
List-Id: <linux-sh.vger.kernel.org>
References: <1233186456.6734.16.camel@localhost.localdomain> <200901281944.57894.vapier@gentoo.org> <1233190170.6734.36.camel@localhost.localdomain>
In-Reply-To: <1233190170.6734.36.camel@localhost.localdomain>
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>

--nextPart1586976.Qj0ey7Ajbh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 28 January 2009 19:49:30 Adrian McMenamin wrote:
> On Wed, 2009-01-28 at 19:44 -0500, Mike Frysinger wrote:
> > On Wednesday 28 January 2009 19:09:10 Adrian McMenamin wrote:
> > > +static struct maple_driver vmu_flash_driver = {
> > > +	.function =	MAPLE_FUNC_MEMCARD,
> > > +	.drv = {
> > > +		.name =		"Dreamcast_visual_memory",
> >
> > i thought there was like a 16byte limit or something on this ?
>
> Don't think so, it's just a const char* isn't it?

yeah, looks like.  not sure what i remember.
-mike

--nextPart1586976.Qj0ey7Ajbh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJgQKYAAoJEEFjO5/oN/WBuasQAJyBRG8GcuCDrYc49MXpbpoh
Yf/mR628/d71apzAQACOiIerICXWlKUY/OloGQtUUeByCQJSBPtKRNKjFyVM4t3p
hT9KY6fcmGlD84fQ7cBBCYhj7hiWZOj0r3oKw0Dmo2WjyTDTL3BnXFvuxwSaTGL2
yxfDCvzfin8KU3/2IKOy5wss7pe7RilHrxreW+X3v0X2Zd6eDgHUDcYyU0Cqi7lH
hhjnjMuQHQDI1PSOvZ0mDPsOnoilgFOg79iI9n5MF3D9DwotsXtzqmbJ/Oinvenr
gk74XZ2xsaXM9aYxD8I2mFL6KE+31PhmHFasvhy88l7NSsRk8Tn+SmqVLLz5oAgI
Ytf6nKGGoNJDWsAA7Qq2ALmy4X36IdToq7+QPZmGg8WZqLjznfAxTrdzfdeRd4dT
lkoe8q7MhbEtdbJkhg3ZrNR8Y0058z+zLZGI1wSfZSOc10CUixQV1xCDvppmhEPH
XgIvK96EmPTBP1TTb5ySRmaf6Qd6ZI2yBMA9DsOZUHosDartwdIKaaLI3lDvM9Lt
koXTSaYZ3SzB0xsUy4OzTNjJRw6npPT8M58SgAAXWuaCpNWlbpXI0yzhJX/C29Qn
h/gu2ho1ML2XUNTHDAcT1P8k7GMqj8BHmQ00JZK6c/CwpQXtSt4DXCNCf1jLw43t
49UpsmV13u/4TBNF4XBD
=5Oby
-----END PGP SIGNATURE-----

--nextPart1586976.Qj0ey7Ajbh--
