From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 20 Oct 2015 16:11:55 +0000
Subject: Re: [PATCH] i2c: rcar: Remove obsolete platform data support
Message-Id: <20151020161155.GO5379@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="da9oBGf5DLtF9ehv"
List-Id: <linux-sh.vger.kernel.org>
References: <1444205791-25480-1-git-send-email-geert+renesas@glider.be>
 <56150C32.5040700@cogentembedded.com>
In-Reply-To: <56150C32.5040700@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--da9oBGf5DLtF9ehv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2015 at 03:12:34PM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> On 10/7/2015 11:16 AM, Geert Uytterhoeven wrote:
>=20
> >Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
> >setup code"), Renesas R-Car SoCs are only supported in generic DT-only
> >ARM multi-platform builds.  The driver doesn't need to use platform data
> >anymore, hence remove platform data configuration.
> >
> >Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >---
> >Commit 4baadb9e05c68962 is now in arm-soc/for-next.
> >---
> >  drivers/i2c/busses/i2c-rcar.c | 19 +------------------
> >  include/linux/i2c/i2c-rcar.h  | 10 ----------
> >  2 files changed, 1 insertion(+), 28 deletions(-)
> >  delete mode 100644 include/linux/i2c/i2c-rcar.h
> >
> >diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar=
=2Ec
> >index 3e125654bb28..cd38406db074 100644
> >--- a/drivers/i2c/busses/i2c-rcar.c
> >+++ b/drivers/i2c/busses/i2c-rcar.c
> [...]
> >@@ -654,14 +652,8 @@ static int rcar_i2c_probe(struct platform_device *p=
dev)
> >
> >  	bus_speed =3D 100000; /* default 100 kHz */
> >  	ret =3D of_property_read_u32(dev->of_node, "clock-frequency", &bus_sp=
eed);
>=20
>    The result can be ignored now.

Yup, my code checkers found this, too ;)

Fixed it here.

>=20
> >-	if (ret < 0 && pdata && pdata->bus_speed)
> >-		bus_speed =3D pdata->bus_speed;
> >
> >-	if (pdev->dev.of_node)
> >-		priv->devtype =3D (long)of_match_device(rcar_i2c_dt_ids,
> >-						      dev)->data;
> >-	else
> >-		priv->devtype =3D platform_get_device_id(pdev)->driver_data;
> >+	priv->devtype =3D (long)of_match_device(rcar_i2c_dt_ids, dev)->data;

I changed this to the enum type of devtype

Other than that:

Applied to for-next, thanks!

> >
> >  	ret =3D rcar_i2c_clock_calculate(priv, bus_speed, dev);
> >  	if (ret < 0)
> [...]
>=20
> MBR, Sergei
>=20

--da9oBGf5DLtF9ehv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmfLAAoJEBQN5MwUoCm2OhQP/1b5uScvQq56dj0236XHCBJz
VWqcLPOHDIoWWEswbgZT2rArII/HEtoC8rxeI4vUKAlV12FBbrSpAFzmxzom8AkL
aUxoWfnw2FKrb4eOsfu9NU1VHSKAHVWBns3JUi0iEFl+ShPL9jEAiNzesxTgaOin
TzfKKX5l4vW9hCoeXDAd/EgQuTYil97RGULJzXJQI6lBijVgASxee51tbPDrrCkv
54eT84YufZPWUgnHV9lHjD1PY/Ko8+AM32SaVdbuSHF4IsSleBy6GPT29D4FTgMy
IwWllAZEHVwN2dE7kopnwSfAgUezREENSRjj4wMnBeXAMgQHcjC8x1+8SJeXKscw
gfLQ8FU+MA/J5Jkr4dRMg4IzkE+SZ/9dCOERwYV2IN5nwwCkFgq50Av7pPdLCEVk
xzXdS44d+KKIrzNtIa+2eD1i6OGxG6jsWlYNTF6uWr/IEIRG/o/dGPXQcsDMdKJA
pcdt8WshTbakkZiXAsVWM7LVBWJv9EVRnh244837mMOK7lYHtLTdoYX6wXGz1qas
iw2ZOylCT/rG/OExHyPid3cS36khSabCkWPzvCGCBQSVx3/ad5XMs/buUF1OtTmq
LRxFD694rkCw0LOJ47L2Bu+YUwhQcsf5i3RFsvTfBIJQYac+g0TYIQiMTQj7vdC4
OwZI58pxFpTLSQYBKi91
=2iSX
-----END PGP SIGNATURE-----

--da9oBGf5DLtF9ehv--
