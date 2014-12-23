From: Felipe Balbi <balbi@ti.com>
Date: Tue, 23 Dec 2014 19:17:14 +0000
Subject: Re: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <20141223191714.GC28059@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gr/z0/N6AeWAPJVB"
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
To: linux-sh@vger.kernel.org

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2014 at 03:46:41PM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> On 12/19/2014 4:33 AM, yoshihiro shimoda wrote:
>=20
> [...]
>=20
> >>>>>>>There is a typo ("prove" instead of "probe") in the error message =
printed when
> >>>>>>>the platform initialization fails. Replace that word with more fit=
ting "init".
>=20
> >>>>>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> >>>>>>this actually goes through me, I'll take it in a bit.
>=20
> >>>>>     Er, OK. Could you update MAINTAINERS?
>=20
> >>>>there is no entry for renesas driver in MAINTAINERS.
>=20
> >>>>Shimoda-san, care to send a patch adding yourself or Morimoto-san as
> >>>>maintainers for Renesas driver and pointing to my tree in kernel.org ?
>=20
> >>>I would like to move the renesas_usbhs driver to drivers/usb/gadget/ud=
c somehow.
> >>>Because the driver is almost used for a gadget driver.
> >>>The driver has a host driver support now. But, it is not used recently.
>=20
> >>>After that, this MAINTAINERS issue becomes clear, I think.
> >>>Felipe-san and Sergei-san, what do you think?
>=20
> >>     I'm against such move.
>=20
> >Thank you for the reply. But, I would like to know why you are against s=
uch move.
>=20
>    Because we still need the host mode; RZ/A1H (R7S72100) SoC should need=
 it
> soon), and bi-modal USBHS hardware is better placed in its own directory.

yeah, I'll agree with Sergei here. All other dual role IPs have their
own directories (musb, dwc3, dwc2, isp1760, chipidea...).

--=20
balbi

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmb+6AAoJEIaOsuA1yqRE2xcQAI5R/WSPKlB5Y8DoZr3Tattw
bcgl1mdYlHbNk/o5eaZlKNBKfzGIkVuX1mgyAzIgT1mNJZGYWR6RM+IJ5JzlGxOi
dMSGdjgpjthQHK7AX5L9N3x+ZU+XHK3LkIrXxgMVR3hKYZmzxb0zxzTfarWKgslZ
dPyr/L9d4Vf6eYyL1oiLLRxuKwNX2yj09fxMZPCZOtX4Kl5UFEnHzB0vm7nYS+je
O7T9Pfroq0sforqrIyHIFgUw9G01QcYdRjM9Z2L0WcTBalO9cq6CU23DicgFFn6F
5XKIhZQhP9eqCoG7xOMO9S+RPz9JdOfjS7aXK5LuO/49wgollnHb77fXY9jM9Ns+
PuyiHRA1/sv37NmpdSgUuqyOj3bZ5wyGOK4OOApw4Qdqg1ChmNHC/wVvdKXXxqkA
ZD428NOwk5S+1DcX8xtjuZkgS8BSTv0CbzMGTXspLp5ngh1d4fXaZz73h4HBaoDV
bUD2Ni2RAlalb624JnwP2oq8hg6ezJ6gxChK4mEHR9ZDf0Nfe4z9g41TeKTvgdp1
sz8ndJz1oXKP6p4rpsDuFlKDnqRdayyomgndpF0D+wPIFyvYXWERyG+d6elz0daI
gYw+FV8fIdGfNnXLEi9MBKZukcWmqwVpgVX//XfmhmAZvVgYskVTkG3eJQD/zIge
6DMH+KyzGXaKeOATzlj4
=SxjE
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
