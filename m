From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 30 Oct 2014 14:26:34 +0000
Subject: Re: [PATCH v4 0/5] R-Car Gen2 DMA Controller driver
Message-Id: <20141030142634.GF23852@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="O98KdSgI27dgYlM5"
List-Id: <linux-sh.vger.kernel.org>
References: <1414628894-24460-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414628894-24460-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 02:28:09AM +0200, Laurent Pinchart wrote:
> Hello,
>=20
> This patch sets adds a new driver for the DMA controller found in the R-C=
ar
> Gen2 SoCs under the name "Direct Memory Access Controller for System
> (SYS-DMAC)". Support for the "Realtime Direct Memory Access Controller
> (RT-DMAC)" and "Direct Memory Access Controller for Audio (Audio-DMAC)" w=
ill
> be added later.

This series works fine with my soon to be published I2C DMA support
patches \o/

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUUkqZAAoJEBQN5MwUoCm2Hy4P/RuOfu0BE8FKYINZFC+1rSfz
YzF+3uxVxuOfP20XuuxLUMSjK0Lel0iE6PBzLhBr7WGelfJsbOyFKDP6zgo8IXUt
Nfz1zHsz7+j0/6RGQzJTmbp+Bk3yzz5ekmau/c4mRpmNrl/ImehqhXOVm2as1ipi
l8tc+/LWY2dYpnFbDxjklwDjoCusYVB/lLSn1KBIU5dc0+BZbR8Q2wM274YBRZCL
J1hGyo55Ey65Y0qI43zUjQnOKdWv8lzGJdzs5NAigrn/6Y/5I71XjGSj4y/BlyEn
dhodVOEqjJIr01AhY/l6ZjwJl50vpHP/drXEg6h2fNCekvdJ09WxCyyCK7bEY1J6
lnoeWuxxXlo4YAaIcfMM8AvSyVQP9y8XYrAIRwy+PPNMcZ5dP1DsUjCQphEhuRIB
F4REcaabgK0aLLuxrUpzTujr/PxTxQekVxxFphv8yrRkXMO3LywB5fIF17nZHTR2
UHvp1NDVzrQFt0MxlDkOBz7KGS665IWbPhgkBQcTFsUNDhOR/NkZXCZQNEIZxsHf
p08UJ1/ogvA9hCDqD29RwoHaeWO3i3iadmFs4fJXGuQvFmGz/zNfgMBum46JHVVI
bXF7OAVV96rDNkdeWh6RTHNTww20qU9zmcQKXOPj72alRtSoiWR9N///LJUbuVBb
Ygagq3gRCNFFIQb3KyNY
=NAW5
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
