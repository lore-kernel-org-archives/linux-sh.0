From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Apr 2013 09:02:38 +0000
Subject: Re: [PATCH v3 9/9] rcar-phy: handle platform data
Message-Id: <20130410090238.GP7983@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ngPZezdD7QsvFaqQ"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100239.47852.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100239.47852.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--ngPZezdD7QsvFaqQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2013 at 02:39:47AM +0400, Sergei Shtylyov wrote:
> Set the USBPCTRL0 register from the passed platform data in rcar_usb_phy_=
init();
> don't reset it to 0 in  rcar_usb_phy_shutdown()  anymore as that does not=
 make
> sense.  Also, don't allow the driver's probe to succeed when the platform=
 data
> are not supplied with a device.
>=20
> The patch has been tested on the Marzen and BOCK-W boards.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

NAK due to previous comments (passing register contents via pdata).

--=20
balbi

--ngPZezdD7QsvFaqQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZSquAAoJEIaOsuA1yqRELFUP/2/L1ngwZYQS3UIX4Z6kaz+H
cV0tjXJMs1ziV0On/Jvaha71LqR5QDbya6VO0yW/IgWFRogDJm7vU1fu0StVmymY
YJkQNUZAvq4Deqyuxusacl5aiTEiHqLQcxgBwiwSXKIx9Te7dO+2nU3UsxtUqUbi
baebW+JkbgRRSGqGAl7xshuifnK+coyaBD5ItJpcSIjGQ0u35Jg4EaaMvg2BgZPI
rQbcDo0cRHpMAspj8QX88VrIZSCmr4Im1rf3kGu3Ql0NDwi1L+Dqn/J4lIzvUVCj
ZOXqlklrDf2HZ2q9aMgIwZ84JxyiA49TgUUP8OBpgP9x50F0mSMEb7j/8pzHmz9j
1beD9prUWZw3b6uccSe5EZ/Q4Txj7+I4cacOx0suyamkum6riA0q7a1Ll7jlaUBW
ORz4sIZvLiN6D+NmTxC3Z8AmiZqyC4oWEwL7qLwy2y5z5UqlXbptQtz7b9cGjekG
+9qDOm402uP+CnjEMUUyfKY4vHIvH/7XjCF9wCCjj8iDm5cPcEvagFPj0B2f2/tO
HszENNYcnZNl8aGgCoM2JWmSK5F5kLCBAlfBD19tAU5OhkYcr2kx44Mqw08csK64
L3lhGRdCLfWN7jaan/2bmwyaMI38xxto+aD7xsVVFU8UCgKB1kuWkzVsc0EFxL7V
qFVv6VVbzY42NP+8ZSK8
=9Lnf
-----END PGP SIGNATURE-----

--ngPZezdD7QsvFaqQ--
