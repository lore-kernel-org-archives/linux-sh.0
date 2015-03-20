From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 20 Mar 2015 07:31:35 +0000
Subject: Re: [PATCH 1/3] i2c: slave: rework the slave API
Message-Id: <20150320073135.GC906@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sHrvAb52M6C8blB9"
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-2-git-send-email-wsa@the-dreams.de>
 <20150319201751.GZ10068@pengutronix.de>
 <20150320071504.GA906@katana>
 <20150320072441.GA10068@pengutronix.de>
In-Reply-To: <20150320072441.GA10068@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Danin <danindrey@mail.ru>, Marc Dietrich <marvin24@gmx.de>, Debora Grosse <debora@mds.com>, linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > After more discussion, brave users, and additional datasheet evalua=
tion,
> > > > some API updates for the new I2C slave framework became imminent. T=
he
> > > > slave events now get some easier to understand naming. Also, the ev=
ent
> > > > handling has been simplified to only send one event per interrupt.
> > > what is an interrupt here? An event where the bus driver needs feedba=
ck
> > > from the backend?
> >=20
> > More the other way around: when the bus driver needs to notify the
> > backend. I wasn't 100% sure about the word 'interrupt', but then decided
> > a HW slave support without interrupts would be so rare and adventurous
> > that it is okay to use the term :)
> Yeah, I agree on HW slave support without interrupts is hardly possible.
> But I imagine that controllers differ in which situations they can issue
> an interrupt so talking about them for generic code feels strange to me
> because $flexiblecontrolerwithvariousirqs doesn't need to send more
> events than $bareminimumcontroler.

Do you have a better word at hand? "...to send one event per event"? :)


--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVC8zXAAoJEBQN5MwUoCm2N+AP/iq8IzLRILxCedxkHxOjWHhh
cx9sQcdp8sW+EScrrlIM2xbiLulmP2JRP5XSD34gm2WRthF9CdraotrOpLTsQvOj
NF7a57bpmVXTZU0ievlPWVzdH+yNLonEFWILuELSibGWKQRPtz3l4Yc4BSO8GByF
pXTVFMn2TzhSPkzJkmUoeD3QURAzYZidvFcRg4ftv1R+gfaYNyLwoBVxrP3OP/ag
4p4PIIsYHFZT9l3F0lnYDZzNj+zh3TNuEnuyclFxwoJnu71MUHvDng3q7Qkz8N0b
PyEQc+pAY+rNUBi5FFLgf6mYu2KG2gdajxVcmOZGp2A8s9bBsEPnMrVm83XB0uax
8RqDzHuPavNUhoqJnyVizfFA3EXjaMQPZxDtn1Ocxj7lxOuXHqK2fgIkKqUN7ZTL
EDNux49Xy/y6Mqy/TWsJ2Hzt1rSLNpW83qb9SMREgWZzMDWw38CzRcxuLrNE2Vsk
HMsD64kP1RdjcVjZ3ryHM1cxq9QQG4CFragnZpTDBK2ePzooJ2UAwoHp112uLt++
2GJX4i8ccbmRghvqomihVuvO/C+psMrdNiawe8R/RNarAMvz7jG/ApB7QSGUV9bd
fQJQ6kuN3HIdKNkuKSephscJQqRw7vOI3m6mdSzd5GUEZIoh6Ei2KMS/9rDuntea
mdreF8wrTkrEzS8q691R
=hab5
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
