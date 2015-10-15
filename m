From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 15 Oct 2015 11:49:25 +0000
Subject: Re: [PATCH v2 1/4] i2c: designware-platdrv: enable RuntimePM before registering to the core
Message-Id: <20151015114925.GE1546@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dFWYt1i2NyOo1oI9"
List-Id: <linux-sh.vger.kernel.org>
References: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2015 at 10:39:24AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, other=
wise
> this will fail.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

No feedback here, but for the other two drivers the same principle was
acked. CCing Mika, just in case.

Applied to for-current, thanks!

> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 3dd2de31a2f8d3..73d58415bbc100 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -253,12 +253,6 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  	adap->dev.parent =3D &pdev->dev;
>  	adap->dev.of_node =3D pdev->dev.of_node;
> =20
> -	r =3D i2c_add_numbered_adapter(adap);
> -	if (r) {
> -		dev_err(&pdev->dev, "failure adding adapter\n");
> -		return r;
> -	}
> -
>  	if (dev->pm_runtime_disabled) {
>  		pm_runtime_forbid(&pdev->dev);
>  	} else {
> @@ -268,6 +262,13 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  		pm_runtime_enable(&pdev->dev);
>  	}
> =20
> +	r =3D i2c_add_numbered_adapter(adap);
> +	if (r) {
> +		dev_err(&pdev->dev, "failure adding adapter\n");
> +		pm_runtime_disable(&pdev->dev);
> +		return r;
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.1.4
>=20

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWH5LFAAoJEBQN5MwUoCm2hycP/igWNlZvMbK/S4LCcmH2iOfK
eNNxmHcfRufwD2Ap8ljL9gX485h36K8pegW8Y2JQa5jxaopEnYDuj+BzAl1eA1N4
5poyjm3XVzMqP3ONYalc6bm/4gNHhl22ilOA8YHXRbXmBhP6898e3uyALy90XMTt
P2B8yIID3jzl4M23GG7IAcFdamV+6kR32Z5ctS1FcUD8SseLU8L4PE130tvCSmQe
O6Lkl8U5OMC+AJybg/mAyNRlMU2/W/rMlkUOFDQYxcQ8TblqClzmp6k/UuDspZ2L
HjWnBox96Bfklz0LZoLytD8lYflqG84+epjeUV009Djj1aXYhoka9kieAoyw/Zkx
fpw1Ur+VLdjTFceTio2QMZGJbp7S8PFEeAQkrg0u4uGgv1xf4MCO2KVEYT16iY7r
a+NUNfrlZC2eUkX1UaqBWATKFVEYco0J1jOL+oxAM6X9k/vDOLpWa8zdhagHhwEr
H/omkHCsHTNQ4euaNgCM+MauPrjILj5/d46awx+P5NQycFs0A1yvDsC39zV/ovYg
J/574ZNf2NOr/7oVgFRTckUGjMt1YoMw1h7mwiaphMuCT1123O3weexntMDvQzl2
+A3POki9FzIlJkXSmX0UfGemU9FOaotAgDF2X4jkx5cWDItbc2HAm+ymR7S7ENdz
+WpHLsRE39n3eTA/ev9G
=OO3h
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
