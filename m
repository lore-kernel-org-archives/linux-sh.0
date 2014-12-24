From: Felipe Balbi <balbi@ti.com>
Date: Wed, 24 Dec 2014 00:40:38 +0000
Subject: Re: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <20141224004038.GG32702@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0qt3EE9wi45a2ZFX"
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
To: linux-sh@vger.kernel.org

--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2014 at 10:41:49PM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> On 12/23/2014 10:17 PM, Felipe Balbi wrote:
>=20
> [...]
>=20
> >>>>>>>>>There is a typo ("prove" instead of "probe") in the error messag=
e printed when
> >>>>>>>>>the platform initialization fails. Replace that word with more f=
itting "init".
>=20
> >>>>>>>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.c=
om>
>=20
> >>>>>>>>this actually goes through me, I'll take it in a bit.
>=20
> >>>>>>>     Er, OK. Could you update MAINTAINERS?
>=20
> >>>>>>there is no entry for renesas driver in MAINTAINERS.
>=20
> >>>>>>Shimoda-san, care to send a patch adding yourself or Morimoto-san as
> >>>>>>maintainers for Renesas driver and pointing to my tree in kernel.or=
g ?
>=20
> >>>>>I would like to move the renesas_usbhs driver to drivers/usb/gadget/=
udc somehow.
> >>>>>Because the driver is almost used for a gadget driver.
> >>>>>The driver has a host driver support now. But, it is not used recent=
ly.
>=20
> >>>>>After that, this MAINTAINERS issue becomes clear, I think.
> >>>>>Felipe-san and Sergei-san, what do you think?
>=20
> >>>>     I'm against such move.
>=20
> >>>Thank you for the reply. But, I would like to know why you are against=
 such move.
>=20
> >>    Because we still need the host mode; RZ/A1H (R7S72100) SoC should n=
eed it
> >>soon), and bi-modal USBHS hardware is better placed in its own director=
y.
>=20
> >yeah, I'll agree with Sergei here. All other dual role IPs have their
>=20
>    Thanks. :-)
>=20
> >own directories (musb, dwc3, dwc2, isp1760, chipidea...).
>=20
>    However, I'm only seeing ISP1760 files in drivers/usb/host/...

There are patches pending :-) But now that I look at it, Laurent added
peripheral support but kept the thing under drivers/usb/host. I asked
him to move it out from there.

--=20
balbi

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmguGAAoJEIaOsuA1yqREDcQQAIRHhKwYD0b28PtG4cLCVcVO
/gkBhMJn/sAswEhXfuKxSDbKFUiI6qHKhSLOjYLXN2M0oPZtBLB+YZmr7oVg1P2E
NijaAeV/lYhZRksAGjQWi1DB2tEAfIWOc0IFDn/jcI+X8gkrGW6HwiSZU3Cd9wkQ
pupRnGHqdwGDR8U6bKaKkRFoE3B7257am25N3gX524Kho5K8HmdnA5Bt1ERAc0NC
rKJRxrs+q47XsCj3PfDqXTFBWKYTgccA4dyapMfN99TcIZEZVV/LFOOLfRwxXGTe
GFs8g8DsM0xI8OboUSjRo/I0bvpiUSUVsZcpMDEnBZZQxRyCgHYChgZnI7DRnqmJ
N6lUNP8Rz5XonkfnRTdJ7BFCeZ6bdMbthfVkMBkL5W3tIwp11exveQ6JuW2rK0c0
AyV0t9S3jjB0Ke6e4JsCT+/2SoDYaZhpnP5oPZlt9RYy4imU9OpgoX/zGrdccMC3
wJb5CaQmZKXuM1/emwxj/eyze6pHdYwvYZMs3/maop8FlQlHuuj8DvMszFyh/YvY
FSe6KQO38zHrbgxW96b/Si2U+vlvJ9WJAVs7Jue7lY18v53v4jWPjXNX4bUu1saV
rYxi8iFnuX6Y/C0uNSr8mJNonukuRbEbhtZ2SZVNkccQshb6n+seRGnSyiUi0KjL
S1VVxQwOUSt0zd5OnzNz
=Ebit
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
