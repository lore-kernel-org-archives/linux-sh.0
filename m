From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 24 Apr 2012 12:14:25 +0000
Subject: Re: [PATCH/RFC] sh: ecovec: switch MMC power control to regulator
Message-Id: <20120424121424.GA13747@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
 <Pine.LNX.4.64.1204201850180.3974@axis700.grange>
 <20120420170744.GC3080@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1204241342590.21239@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204241342590.21239@axis700.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2012 at 01:46:09PM +0200, Guennadi Liakhovetski wrote:

> One more question in this respect: I see, that most other MMC drivers use=
=20
> "vmmc" as supply name. How important is it for all MMC drivers to use the=
=20
> same name? Shall I use it for MMCIF and TMIO-MMC too?

The only thing from a regulator API point of view is that the name
should be something that users can easily match up with the schematic -
the general advice is that it should correspond to the name given in the
chip datasheet as that can be tied in with relative ease, though so long
as it's clear it doesn't *really* matter.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlpj8AAoJEBus8iNuMP3dk1IP/3/FL9PoV+S30/G35AuVreKS
hx9B4gJobxmvUZxDfLoBCb/YQE1BR3+UAlJCYQSpZerTRg8Y6ObNa5J7ErWWPlgT
4wBmrBiHvGePYhnOi9U8zv2FMyTdG5qvEPhMTjT+YoCojaKweZlJPsj2q0FN0I9b
CjUtimCMPOrwClOHhnTiGftsqOcd1BAsLfj0tV14tml9aE6Cp+jMxUOXwuKsp2R5
aslu3c/y498OLgEbuH3YPid8FKh5RBo50WwyRDdUiLcgiOws+wslmKdZqw/lzSk8
+KDFYXJapt9U1IAU1H3iu+e/Nnx85S862bTU3oTlDtISIfVOJnOgrU5ZuUi7eJmj
IIxSi7/0EJ1FBqk3wMjdGXqEzlBwKze1Ry6Drzakn6i8rgbU1B+db44J1+ZM7sMm
jUjwpF9O0QCySA0UUvPxVqfq0vBJJ5UdY9QWkyJgoiS99OMjqytwUzrP0vdEDb0e
dXHGsP3gjWMbMVXhT9F3lRxzQXHq2mk5wWuDADdGPb28JjOEN6OPMcdNr7DNwImm
EkDrtZtFuRFrut4pgjetCd1sc9R62T3PE0K8uHerH0M+MAphbqrk3M2zKG/xsygk
y8ywNbEhQ8vTtOLcd9/yKgQ0JnVnkqGRouz0T6n0wsGJ/QeK7ao/Rsuf5SP2L5om
WxrFm02hsDSgRosTW3LA
=/1gf
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
