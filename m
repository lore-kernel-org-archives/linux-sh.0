From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 10 Oct 2015 07:20:50 +0000
Subject: Re: [PATCH v2 3/4] i2c: s3c2410: enable RuntimePM before registering to the core
Message-Id: <20151010072050.GA1619@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
List-Id: <linux-sh.vger.kernel.org>
References: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
 <1444383567-18113-3-git-send-email-wsa@the-dreams.de>
 <5618AB74.2070001@samsung.com>
In-Reply-To: <5618AB74.2070001@samsung.com>
To: linux-arm-kernel@lists.infradead.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2015 at 03:08:52PM +0900, Krzysztof Kozlowski wrote:
> W dniu 09.10.2015 o 18:39, Wolfram Sang pisze:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > The core may register clients attached to this master which may use
> > funtionality from the master. So, RuntimePM must be enabled before, oth=
erwise
> > this will fail. While here, move drvdata, too.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/i2c/busses/i2c-s3c2410.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-=
s3c2410.c
> > index 50bfd8cef5f224..336e34e1ca597d 100644
> > --- a/drivers/i2c/busses/i2c-s3c2410.c
> > +++ b/drivers/i2c/busses/i2c-s3c2410.c
> > @@ -1243,19 +1243,21 @@ static int s3c24xx_i2c_probe(struct platform_de=
vice *pdev)
> >  	i2c->adap.nr =3D i2c->pdata->bus_num;
> >  	i2c->adap.dev.of_node =3D pdev->dev.of_node;
> > =20
> > +	platform_set_drvdata(pdev, i2c);
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_enable(&i2c->adap.dev);
> > +
> >  	ret =3D i2c_add_numbered_adapter(&i2c->adap);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
> > +		pm_runtime_disable(&i2c->adap.dev);
> > +		pm_runtime_disable(&pdev->dev);
> >  		s3c24xx_i2c_deregister_cpufreq(i2c);
> >  		clk_unprepare(i2c->clk);
> >  		return ret;
> >  	}
> > =20
> > -	platform_set_drvdata(pdev, i2c);
> > -
> > -	pm_runtime_enable(&pdev->dev);
> > -	pm_runtime_enable(&i2c->adap.dev);
> > -
> >  	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", dev_name(&i2c->adap.dev=
));
> >  	return 0;
> >  }
> >=20
>=20
> Hi,
>=20
> Unfortunately on Odroid XU3, Exynos5420, samsung,s3c2440-i2c,
> next-20151009-1-ga93b1a6f5055:

Thanks for testing! Will send v3 in a minute.


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGLxSAAoJEBQN5MwUoCm2BWYQALDG8nF05xGqFRBw2tjDtqK0
AEkXKcOtD7c0+QISpOVyhDDx/KdCkQIQp+TroXFjYgQTOw0n6Sapgq786U9d3bft
EZ2gD0GXz4UPpkkdcY+zxO+u6F0tBaaEUdrLD6mZcf39GVeYSGuJQvZvR8Eko0Gi
yAQQWzNp/uVXX+BORb4WeEW9sl/pdXdnTdUZ7oMk4lzyrmCLtvWqJSK4QtVppCTs
NldR17VPgQ73SkvZVJ1Nmi+/+O/WF5q0Ew8e9ZZuZCOfzCkHHgi5dJVRvph+ZOW9
XM1AAPIC9z+iwJZxcwX4MQbOdDGL//2UmtoU2Pyxk4GKNmUpPgY/1KrhlMqO56l2
gwO5KOHU2igYqjvlyZGx3d5HDLLwJnd5y6ptclkieKVZkU4121Sf1IAKkVAMqIgr
N+K+0x8Nc//ZDnPhmaX7Pn+WhuBf40BjIaqic0jo8YT8WiBTzmB0NBTjur17fPQe
f8PorjIc2b5RasqbQVi9MR6dSs8BC1VIUPHSbFAShVinpvbItOxbykmoPYybQ0Mw
qQ+IWH+xmKrlBV6XGdKoaZzRtgzBFyE3DOUUKM4d3kIwWRsf7Pf/nC4V0q+RyOnQ
oTz9AabrvA66RJeKYEQ9SiVljnJf/7Eeb0GXFKW74Q4e3F+YWiHjPNTGoFqe+rtT
mVS9VY/UA+NKJJDwUef1
=qJ2N
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
