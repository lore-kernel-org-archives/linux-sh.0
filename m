From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Jul 2014 14:59:59 +0000
Subject: Re: [PATCH v2 5/5] i2c: tegra: Remove suspension check
Message-Id: <20140717145958.GA32534@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
List-Id: <linux-sh.vger.kernel.org>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
 <1405608520-5644-5-git-send-email-hechtb@gmail.com>
In-Reply-To: <1405608520-5644-5-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 04:48:40PM +0200, Bastian Hecht wrote:
[...]
>  #ifdef CONFIG_PM_SLEEP
> -static int tegra_i2c_suspend(struct device *dev)
> -{
> -	struct tegra_i2c_dev *i2c_dev =3D dev_get_drvdata(dev);
> -
> -	i2c_lock_adapter(&i2c_dev->adapter);
> -	i2c_dev->is_suspended =3D true;
> -	i2c_unlock_adapter(&i2c_dev->adapter);
> -
> -	return 0;
> -}
> -
>  static int tegra_i2c_resume(struct device *dev)
>  {
>  	struct tegra_i2c_dev *i2c_dev =3D dev_get_drvdata(dev);
> @@ -842,14 +827,12 @@ static int tegra_i2c_resume(struct device *dev)
>  		return ret;
>  	}
> =20
> -	i2c_dev->is_suspended =3D false;
> -
>  	i2c_unlock_adapter(&i2c_dev->adapter);
> =20
>  	return 0;
>  }
> =20
> -static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_suspend, tegra_i2c_resu=
me);
> +static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_resume);

Shouldn't this be:

	static SIMPLE_DEV_OPS(tegra_i2c_pm, NULL, tegra_i2c_resume);

instead?

Thierry

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx+TuAAoJEN0jrNd/PrOhaWwP/AgRxS2d+EecHKjm411ljsiD
JwHW+gL42M9tkTIZPTPA1KgiQr+DSAXTBh6Zke621iUDkbMzFsUv4wYYP8tZLXC4
iEL2GaVX1bry8PhwFBe89660oSgnqjpugeM1X7hvXly+Hl89p79JqOkQvdBqa7RO
yYPQufIyPhkJzUCu1swiGhoMJGcDjsQAu1ujzSnYhDZNRNf+Bj2Z5mKar4aQy0B6
Y444hBKUZ6zRrnpD/URLBI2963CArwEVBvmO+Pk5xAcWqFYVKjAL1Ot0gUI0tPm1
5RpkZ0mwAMajGbVZAIm8xN5CjP3Ed/MPvACH77dU/PHPxULF7A5Clq3Ev2A3AOnK
yvy9fpkiSgaXBXVppxjfmMYNz1NzwdbHmTLNq9RWe9aEslHDod2/inBbsUA3kDMY
9eTVogq27RGgZL9jmtj0FqKp81UQ7up4kRMVmco9XC5245jivBhwhRdgbDGT9LNl
SwVh4W/zowGhz432X5uP5llujBgXVFuis9NUcYFYPy6Uw6LXAydEEQKGtlD2UamU
sOw6J8+9bSfdwoJLoh+GaH9CGuVIGd7PUMSlxauke+hHHSwBU5BISVNr877XZouD
5f8Qeb2+LRBcxSZigI7FSOZDfZoXIdUURHaPSDDTQEystMCqEE4/4aRNttaH/Mj3
aVAn/fZc2RN2hYaJt/pr
=Vn9M
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
