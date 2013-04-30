From: Felipe Balbi <balbi@ti.com>
Date: Tue, 30 Apr 2013 10:36:49 +0000
Subject: Re: [PATCH v6 6/9] rcar-phy: correct base address
Message-Id: <20130430103649.GD12161@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3Pql8miugIZX0722"
List-Id: <linux-sh.vger.kernel.org>
References: <201304231930.22352.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304231930.22352.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2013 at 07:30:21PM +0400, Sergei Shtylyov wrote:
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

--=20
balbi

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRf57BAAoJEIaOsuA1yqREzGQP/RklL7uxQgBhMdpN0eDFMav+
W+GzEKv7cdk9yeeT39O7lOOivoWw3SysFqbK/ViZHYRy1EvMi/Cr3Y2RhHyH7RU4
1r7oCodwW3mZaKHMeX/P/qlu0Sz1vZA19jybR6JKENo2/k20kL1HrFjjBvmG7eHW
XDWCT6q5b2ch5ombsxTYXX3Qk6tYGk4T6P91Ka5ALViAXiEErIfuxuf0dJMvtOU+
lC0NqMnZ8VSKMOpiVjS39PVC7CXTuGRpsEla/2DJ78CLHR+DXkMtMmvzIbDbh7CQ
tJUvoKmpFS/6PK5ttoIT+E+4EuoJWROJfAG1gtlHoiamPcfUP8UA6eHYrSEYNND5
modiJrxILXQVF2FdPt3wbfjxdpIoyroGqlxUOLO5OgjSlMrhVUtCE1Q+KaKxx/G3
1NfIuL075RlyEP8LHPC9ldsaUqm7CFpFUNZQUaX9msbbtW+jg2E96YE+7qfxnSDO
BrD2WMrQq6HULyUniKG3fLDibMq0hQhlusuPF9RJoFu1Ci8+PLV0dZPtzSyXDvJ4
9ESVTPeODw1Ebn3Sy909G9p8A+WBAsLEcbBIB9PPvE5CTTpX9m8cz6yxHEBebXmQ
qjE+fDPZKSWkcIOFhVsFD6FI3fLW8yo58jwsyauclSqttPUVhPBfp0yGUqnTVcvl
+E7L3EXmsc7FWo0WgEiM
=lbjm
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
