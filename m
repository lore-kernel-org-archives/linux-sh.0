From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 01 Oct 2013 20:53:11 +0000
Subject: Re: [PATCH 09/10] pwm-backlight: Use an optional power supply
Message-Id: <20131001205310.GD9201@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Qrgsu6vtpU/OV/zm"
List-Id: <linux-sh.vger.kernel.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-10-git-send-email-treding@nvidia.com>
 <524B17ED.1080806@wwwdotorg.org>
In-Reply-To: <524B17ED.1080806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 12:43:57PM -0600, Stephen Warren wrote:
> On 09/23/2013 03:41 PM, Thierry Reding wrote:
> > Many backlights require a power supply to work properly. This commit
> > uses a power-supply regulator, if available, to power up and power down
> > the panel.
>=20
> I think that all backlights require a power supply, albeit the supply
> may not be SW-controllable. Hence, shouldn't the regulator be mandatory
> in the binding, yet the driver be defensively coded such that if one
> isn't specified, the driver continues to work?

That has already changed in my local version of this patch.

> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight=
/pwm_bl.c
>=20
> > @@ -253,6 +264,16 @@ static int pwm_backlight_probe(struct platform_dev=
ice *pdev)
> >  		}
> >  	}
> > =20
> > +	pb->power_supply =3D devm_regulator_get_optional(&pdev->dev, "power");
>=20
> ... so I think that should be devm_regulator_get(), since the regulator
> isn't really optional.
>=20
> > +	if (IS_ERR(pb->power_supply)) {
> > +		if (PTR_ERR(pb->power_supply) !=3D -ENODEV) {
> > +			ret =3D PTR_ERR(pb->power_supply);
> > +			goto err_gpio;
> > +		}
> > +
> > +		pb->power_supply =3D NULL;
>=20
> If devm_regulator_get_optional() returns an error value or a valid
> value, then I don't think that this driver should transmute error values
> into NULL; NULL might be a perfectly valid regulator value. Related, I
> think the if (pb->power_supply) tests should be replaced with if
> (!IS_ERR(pb->power_supply)) instead.

All of that is already done in my local tree. This actually turns out to
work rather smoothly with the new support for optional regulators. The
regulator core will give you a dummy regulator (assuming it's there
physically but hasn't been wired up in software) that's always on, so
the driver doesn't even have to special case it anymore.

Thierry

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSzY2AAoJEN0jrNd/PrOhbosQAI8JpuY1LGvyC3O93TMjpk2Y
JicLAk8h13WtQR+o1efNd0XkNJZ3rCX3qSr4aneLVKu0IdppFATnuD4rfd9z+R/u
ZD9Gb5CUBGKFGJWdi2K7awNQff7XWtCtwGRw0B8DXl1fWe6gCwtnvc41OZgRyJcB
icoatpV4xjRrIWYx44WS0uyC3vjhuxOIqMM3/nkfGLpzWySq+awyz4qzXrVP/cN9
Tl6WJtjlozamsq7Gx6ywqUrTiyJdZsPpu8k88f9phDlVMNxJkkehw+uOqqu8C1pt
GEt+6DbeyPxDkgueeWHI20FJeK1wF26xHtpHaY5iy14veH5rSFqqBgtN9/0ONujQ
XfudBxC8ZxF/lMpuTDVoo6O3GaplSNvsmO6iyeG79bvuHxpqE0VQYoiB25V6wG01
mZyuLs5qX2WS8gumzNxJeNJWPO85eKdCPuOd2OKEAMJTQCguruwEfJHuuLUe3tkU
Kqi2H8pGu7SQhYom/CR9wtfMEz3ypHWBo/qoCC/ZCgaA7Q7iUOJMYfUsJYTvwG/u
SOqoFWBeicJXLW1qfeUZ6veksTyDu3gtsx6Rqgbd8ca/B5cK2C99zqsZhyvKKA4U
QNUk0esD29BtCyTVx+UeHNd6YEBPjq9S1wWYGeykx8u7Zxf2onkqAcX13G3ZQ3AD
eKYYhEPMdTQmC+NOt7Uy
=9gdD
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
