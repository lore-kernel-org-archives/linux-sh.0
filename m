From: Felipe Balbi <balbi@TI.COM>
Date: Wed, 10 Apr 2013 08:59:05 +0000
Subject: Re: [PATCH v3 6/9] rcar-phy: correct base address
Message-Id: <20130410085905.GN7983@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NKtYx2Ppz7d1tORf"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100236.50822.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100236.50822.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org

--NKtYx2Ppz7d1tORf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2013 at 02:36:50AM +0400, Sergei Shtylyov wrote:
> The memory region that is used by the driver overlaps EHCI and OHCI  regi=
ster
> regions for absolutely no reason now  -- fix it  by adding offset of 0x80=
0 to
> the base address, changing the register #define's accordingly. This has e=
xtra
> positive effect that we now can use devm_ioremap_resource()...
>=20
> Note that the driver and the SoC code have to be in one patch to keep the=
 code
> bisectable...
>=20
> The patch has been tested on the Marzen board.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Felipe Balbi <balbi@ti.com>

This will conflict with latest phy changes but it's only a rename issue.

--=20
balbi

--NKtYx2Ppz7d1tORf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZSnZAAoJEIaOsuA1yqREjk8P/iAD15DkoHIF4f58Wu2X2CTD
+CAXlTqvd9gMh6MRgJEHfnlyc03O41vM7obCBwutIsAOIDZqq+6UWyWIxf5LLDFn
ucuY6p2rVHislvPWk+E0mBBNOrX3/Kipcs0KEw3pT1cihuG8GRttJe3aqXgKnzvQ
y/rr9QQb5oaeT5nUxSyIxuJyGXKarqsGl3R9ciyQVFxoepTGLhxkkrdGTF5w26Y8
VZALCwQLj2Tl9dozNNpugXQg5M/r4ix/y5HA/wXiObu9QT9W2Svztp009IVYcJ6/
IEalQykCh7IZGMW/Fttb8rQ6by0o6rHV7Y242obgmu/lVhO8rMx2mQZgmr/Nmq+W
O0KJahSHAiKxHjZUuUSZrkk8AWYoLJ5uOH9Bo1ouq1914t0IohYo/QwfOrhN2TuQ
Hz2eTHx92l6MPxXgFe+wneRAcafHdJmUoT1WGVj3k8v0OA4WIak3SUuET6FCdnfv
kt7KYiPNPb+eERMClEsHZR0AtlXTl9c6y4YMwPOYPsKBJN3HxuwIf+07TUOUW/Kd
JBi0UhTR1YufJJfE191pQvB6nCEHYOMv348MjzPVF//JWA/Z3Kk4ba2Q2+lOBuif
zV+DIxYF0IOaGJVfBPGxh7uaZRzHHBXC1Utrabebnly4rGx6b8NflS153148+gHc
3BAJUhInrzAdXM+e0JEZ
=P6/0
-----END PGP SIGNATURE-----

--NKtYx2Ppz7d1tORf--
