From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 19 Mar 2015 15:53:18 +0000
Subject: Re: [RFC V2 4/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <20150319155318.GE7657@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HeFlAV5LIbMFYYuh"
List-Id: <linux-sh.vger.kernel.org>
References: <1426576524-22315-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426576524-22315-5-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > + * Switching a master currently needs some access to either i2c-2 or i=
2c-3.
> > + * Switching could also be done via sysfs or any other config mechanis=
m.
> > + * For this proof-of-concept, extra busses have been used since it
> > simplifies
> > + * locking a little.
>=20
> I have mixed feelings to be honest. When using n internal masters muxed o=
n the=20
> same pins, with pin muxing used as a selector, I could agree that we are=
=20
> dealing with n+1 busses, with n busses between the masters and the demux,=
 and=20
> one external bus. The two extra virtual busses in your example above both=
er=20
> me.

That was chosen so the access to the "virtual" bus would automatically
do the pinctrl change. As I said somewhere, this could be handled
differently.

> This being said, I see this as an attempt to keep the traditional model o=
f I2C=20
> slaves being children of an I2C master while still departing from it at t=
he=20
> hardware level. Wouldn't it be better to depart from it from a software p=
oint=20
> of view as well ? This would allow supporting real multi-master=20
> configurations, but would come with a high refactoring cost in kernel cod=
e.

You mean the slaves belong to an i2c-bus and this bus can be connected
to masters? Yeah, that would be quite a change. And I am still not
convinced if that would solve the issue that the driver model does not
support re-parenting but rather suggests to delete and recreate the
device. From device_add():

 * Do not call this routine or device_register() more than once for
 * any device structure.  The driver model core is not designed to work
 * with devices that get unregistered and then spring back to life.
 * (Among other things, it's very hard to guarantee that all references
 * to the previous incarnation of @dev have been dropped.)  Allocate
 * and register a fresh new struct device instead.

> I'm also worried about power management, how do you envision its=20
> implementation ?

Haven't thought about it so far. That is another reason not to break the
driver model, I guess.

Thanks for your input!

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCvDuAAoJEBQN5MwUoCm2JoAP/jB8WsMOgE+09+Elscn4AM4T
Xtfn1H2yi3izZ+8c/gpqrXTz1fQOpgwDBNbchHhtbGfXjei6E/Avw6r2dlJkHxk7
w7iCx0E1R4FqUdV6vCX79CJ7snD8nNGQG6FzzTBqS17qeJZvepZQNk2qLXCCXO0C
H2eGEsfXxqiWZ7ZeDO4P6aubWQtk842zDi8K+JpeeE/DkQOlCre6dukFbJHM88E7
aufEpxhRG3bQ2NEmpQXte7YNlkUEDzHZlVgVKAHCKOREULkamhSn4Ej8yPghq0Ht
C+gGTB2L9XMErylfWwFK4RxsrFZi2qTRk6wLg38NPWhO0kFbZTxHuArDxNzU5MdB
6pq6Ic7fFjsQQClkJS2+GfkZSKI7n5o3Iz/Ana2rYEqC36GuYSCaeVeqyVOVYNHB
1SK2/qlo33oetYpOS+YUrAWEkfO+EVbh3Sa7nH9ZccNv2ai+iHY5HrdQuzW8oQRz
F5+O+IRyEz2IzxWuh9NzI+mcfS7dLcYFxIXjV986OeNfwtuLxZ8XkULCWuhcfP65
PnVwIgRm9WS0PMJ3rDWklSvIQo/4gw3B6VJB/UYJ1kLGmIam8Gl98uylfqsFpTKU
5KBPGieSVDtYQFBEmP1AkrxuZ58Zsr2oneuYT1huNag/g17eP6Jr1R5lf/5fyqjH
lSYyI39HQ+zVytpKPxJw
=yaQ6
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
