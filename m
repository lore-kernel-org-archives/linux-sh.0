From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Apr 2013 08:27:48 +0000
Subject: Re: [PATCH v3 4/9] rcar-phy: remove EHCI internal buffer setup
Message-Id: <20130410082748.GJ7983@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SLauP2uySp+9cKYP"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100232.30889.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100232.30889.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org

--SLauP2uySp+9cKYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2013 at 02:32:30AM +0400, Sergei Shtylyov wrote:
> Now that the EHCI internal  buffer setup is done by the platform code, we=
  can
> remove  such code from this driver as it  never  really belonged here.  W=
e also
> no longer need the 2nd memory region now (2nd EHCI controller is simply m=
issing
> in e.g. R8A7778 SoC).
>=20
> The patch has been tested on the Marzen and BOCK-W boards.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> ---
> Changes since version 2:
> - added a note about testing to the changelog;
> - added ACKs from Simon Horman and Kuninori Morimoto.
>=20
> Changes since the original posting:
> - split R8A7779 SoC file change to a separate patch.
>=20
>  drivers/usb/phy/rcar-phy.c |   28 ++++------------------------

you do realise this won't apply, right ?

--=20
balbi

--SLauP2uySp+9cKYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZSKEAAoJEIaOsuA1yqREB64P/RP9rhzUJJOWkD3E5I0Ub7To
n/lVIXunjGOQE+1Edetzo4PJLb3oxkCzbk38NyoKbT99R0hqmrsn3TFUubXQ/LD5
QI1PW5X7T41GwJcykrIAFnPkWc9mxUD+4BGOG8vGy7qgljoyvJoBAXMu/xznyiX7
71uSYJzs0j9F94y6wocxD6cvwEupzpjqFOS0gqxATjHq8hqlsTk37Onr3W8kwqiW
uQxTOhORtetdhXs5xH/jv887AKTpFfnWSaD8W622yPtMrAqttR/722wwaaUIUvFw
Nb2bp9QDwU5TICAU+RN/WInN+nFFD3UOMVJyKw8WYAjRKYwd5SNq+8+aPI5R5Pm2
aQdDtfBi16A4g095CA3673kApzg6264H2U6QxiYh2/QTN29tDs2Nb5MwLu6ujuPJ
bbKMoDLcn+O1wIINkJbiD/9Jf/yvl+ogPe+Fy0zm8ZS6e/hKdey4jrUXT0ehWlCl
MhuWFUzolojwYP7sdX76BLlJ98VhBtpFB3JniKe8T2Eb1DmOfoVSA5vXHfrCuFvr
Z+FEL9y7zUtKMFsLOKYXsucHaZV5p6gYiehyDGDTLBZ9W8xYQX0Ah12394RZkSKd
d9J8gIY3jxWywa6PYjbGxJEq3GDQWrX2+SIxWDbQx/bURKMj3FwGnEM7uwRz+GaS
n0CXAJ80ePPxEQLcDqkn
=3PNI
-----END PGP SIGNATURE-----

--SLauP2uySp+9cKYP--
