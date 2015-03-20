From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 20 Mar 2015 08:22:39 +0000
Subject: Re: [PATCH 2/3] Documentation: i2c: describe the new slave mode
Message-Id: <20150320082238.GB2071@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-3-git-send-email-wsa@the-dreams.de>
 <20150319201137.GY10068@pengutronix.de>
 <20150320073012.GB906@katana>
 <20150320074214.GD10068@pengutronix.de>
In-Reply-To: <20150320074214.GD10068@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Danin <danindrey@mail.ru>, Marc Dietrich <marvin24@gmx.de>, Debora Grosse <debora@mds.com>, linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 08:42:14AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Wolfram,
>=20
> On Fri, Mar 20, 2015 at 08:30:13AM +0100, Wolfram Sang wrote:
> >=20
> > > > +Finally, Linux can also be an I2C slave in case I2C controllers ha=
ve slave
> > > > +support. Besides this HW requirement, one also needs a software ba=
ckend
> > > I wouldn't have written "Finally, ...". While it's great that we have
> > > slave support now, being enthusiastic here looks strange if someone
> > > reads it while slave support has become "normal".
> >=20
> > OK.
> >=20
> > > > +providing the actual functionality. An example for this is the sla=
ve-eeprom
> > > > +driver, which acts as a dual memory driver. While another I2C mast=
er on the bus
> > > > +can access it like a regular eeprom, the Linux I2C slave can acces=
s the content
> > > > +via sysfs and retrieve/provide information as needed. The software=
 backend
> > > > +driver and the I2C bus driver communicate via events. Here is a sm=
all graph
> > > > +visualizing the data flow and the means by which data is transport=
ed. The
> > > > +dotted line marks only one example. The backend could also use e.g=
=2E a character
> > > > +device, or use in-kernel mechanisms only, or something completely =
different:
> > > Or something self contained, so the userspace part is actually option=
al
> > > (but probably present most of the time).
> >=20
> > With "in-kernel mechanisms" I meant self-contained. Maybe "be in-kernel
> > only"?
> I'm sure "in-kernel mechanisms" wasn't in the mail I replied to. (Hmm,
> or I must have missed that while reading.)

:) Still, I like "be in-kernel only" better, so I'll rephrase.

> > > Does that mean that I have to pass a valid address, or can I use NULL,
> > > too?
> >=20
> > Is NULL a valid pointer to val?
> NULL is a pointer and you didn't wrote about "valid" above. I just

But NULL is not a pointer to val.

> wondered if the necessity just comes from the fact that the function
> takes 3 parameters and so you have to give it 3 (this wouldn't needed to
> be pointed out IMHO) or if the value must be valid (then the wording
> isn't optimal).

I'll try to rephrase.

> Is there a technical reason to require val to be valid?

Better be safe than sorry in case for future needs of 'val' I can't see
now.

> > You need to assume that if the next byte is requested, the previous byte
> > made it to the bus. So, you should do pre-increment in
> > I2C_SLAVE_READ_PROCESSED, not post-increment. I didn't want to write
> This might be a correctness problem, right? If we cannot fix it (with
> the current slave abstraction) should this be pointed out somewhere; at
> least in the eeprom driver as this will probably be the reference for
> the next backend?

Adding some more info to the eeprom driver sounds good. Updating this
paragraph with some infos from this discussion, too.

Thanks,

   Wolfram


--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVC9jOAAoJEBQN5MwUoCm28b0QAKzCs2yMijgPB6CMWLJn/0Tg
ol0ECikYMw4pa7+mPvo6maqmOS7q9jpVQ9ilvUPwtBjAPM/Z4w5LIyzw4Nr6xBFi
snZWrfKtCQhafY0JcVn/gV9KYOxz0D+b3rekr9BFY2QMXTgFcG9q4X73e1xKhy3M
e4rpvo/biKpwiTbSnTN49ttMthmb6n3H/By9Zluf6284UsVykpntrLuOo1hE6p/u
FuMfDdE8+ZCNv8zo39JTkey5wz2iYik3Gk00kWlnbsMmVQ2/m62DKEAGdUmQakyg
WlWaE8pXUeIG0fuYCKhCuwBd4iLkMfjii7s9avRYZxZX48xvvO6vPtnXMCnIAkKi
tHA82DojmVgAoyMrCXviaiTj3Kxv1qOFKT6fETjAejknEcgaQWIVvlJ2Y1x6/Ijz
JG/4NyQWuisYyM2HcByaeB+yKQUR6POn7dOaDG5MEdtvxAVTv/LlTGuSm+N+oabO
nQUPXS2SQwj5yQG4XJ2D55MobD1g9xJar3CB11mA59FAaJTX5PgWeWnLsQEJAvs2
bGSRBgkivwunYgHahxvz7TQSxI9JWrwhs7CMCgPVRjkRYGMWQdfOi9x2juy14j+7
0CqsTkdd66kdbX2s9XRfpV7E8jnaaRzPO+ESFBBFR4iHMv+KBTU/LwWVfqkqzQFn
AjhrN8g+5fsX8ljDxU/P
=UQCh
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
