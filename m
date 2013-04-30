From: Felipe Balbi <balbi@ti.com>
Date: Tue, 30 Apr 2013 10:35:42 +0000
Subject: Re: [PATCH v6 4/9] rcar-phy: remove EHCI internal buffer setup
Message-Id: <20130430103542.GC12161@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XMCwj5IQnwKtuyBG"
List-Id: <linux-sh.vger.kernel.org>
References: <201304231923.25371.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304231923.25371.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2013 at 07:23:24PM +0400, Sergei Shtylyov wrote:
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

looks alright. I'm not sure who should be taking this series, though.

I won't queue patches for v3.11 until v3.10-rc1 is tagged and since it
depends on the rest of the series, to me it makes little difference if I
take them through my tree or somebody else does.

In any case, here my:

Acked-by: Felipe Balbi <balbi@ti.com>

if anyone wants to take this patch.

--=20
balbi

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRf55+AAoJEIaOsuA1yqREDHwP/RhQRmCqv80b1imvW0RMoiNN
m7/vGG4PRfWpKUF5V9kQIkd/13c7zbjPMIImYVJf7W6d6R5GZ3YVlQGrY38GVh8a
cRKhj7oMuTtBFAbm1d6aH45xZ0oqGCCxPsMyr9KEOefv68vAePeDQEEo+CYcGAEI
Q+KPoa8JXMy7eUAKy5thhrKO86I4pnTWzfF8jdOP3QmOjhVHMqTbH2n8EGNGdzoE
urqzi5ZGJttjkA3Vp8t+gF2xuyTHxpj+8eNAnyfAnmg9hK9dfGya2Mf+0JoRc7vk
haS8npNoaTyxqpzW2IlM8Yjw3kss9gXaMkmtQD6AecdwChKYciDp4PhskG6ULOhS
0mzTvTFw8pvXGJX1BLB9Roz/2E+RqnpkNMN0w3mG/+08y4src2UWhTbR/9GARd0c
T3Y+IpHyBegl7PJeo3U4ZUY001Gc0Qa06H/3TwOI4xjRm150/9mpbxXqAJi1bDUl
q5LauDEN+9Sf+p0ihB30M6NOK7fU6ZUOM2IMTBHE/1PiTG4JWmYCJco3rNh28qqO
fk84pnN/RdKQvMCl+7tYJcwNiiGKD0APreHaxa4yHxo0ChbedkvfIoHKi59G94sp
nUqMb06Fw4XVSFII/BPagxm6PXXIb70NytQ1CIIZuq/m+xYqVV+vvM/Xir1n/URN
WOe3F8OoYxchGTTnTunN
=zgHm
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
