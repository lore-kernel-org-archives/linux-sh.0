From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Jul 2014 13:00:48 +0000
Subject: Re: [PATCH 1/5] i2c: Don't start transfers when suspended
Message-Id: <20140717130047.GF2740@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JSkcQAAxhB1h8DcT"
List-Id: <linux-sh.vger.kernel.org>
References: <1405165771-8732-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1405165771-8732-1-git-send-email-hechtb@gmail.com>
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-i2c@vger.kernel.org, Linux-SH <linux-sh@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Taekgyun Ko <taeggyun.ko@samsung.com>, Ben Dooks <ben@simtec.co.uk>, Magnus Damm <magnus.damm@gmail.com>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bastian,

On Sat, Jul 12, 2014 at 01:49:27PM +0200, Bastian Hecht wrote:
> i2c transfer requests come in very uncontrolled, like from interrupt rout=
ines.
> We might be suspended when this happens. To avoid i2c timeouts caused by
> powered down busses we check for suspension.
>=20
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Thanks for doing this! I add linux-pm to CC because of two questions.

> ---
> I ended up getting i2c timeouts when suspending and provoking touchscreen
> IRQs on an Armadillo board with an sh_mobile i2c bus. Instead of copying
> again the protection mechanism from other bus drivers, we can clean things
> up and move this into the core.

This could be part of the commit message IMO.

>=20
> I assume that all bus drivers use kzalloc or equivalent for the
> struct i2c_adapter. So adap->suspended can't end up uninitialized,
> right?

Better safe than sorry, I'd say. Please add the initialization.

> We could consider using this scheme for freeze/restore too.

linux-pm: opinions?

>=20
>=20
>  drivers/i2c/i2c-core.c | 24 +++++++++++++++++++++++-
>  include/linux/i2c.h    |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 7c7f4b8..9fe9581 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -343,6 +343,13 @@ static int i2c_legacy_resume(struct device *dev)
>  static int i2c_device_pm_suspend(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
> +	struct i2c_adapter *adap =3D i2c_verify_adapter(dev);
> +
> +	if (adap) {
> +		i2c_lock_adapter(adap);
> +		adap->suspended =3D true;
> +		i2c_unlock_adapter(adap);
> +	}
> =20
>  	if (pm)
>  		return pm_generic_suspend(dev);
> @@ -353,6 +360,13 @@ static int i2c_device_pm_suspend(struct device *dev)
>  static int i2c_device_pm_resume(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
> +	struct i2c_adapter *adap =3D i2c_verify_adapter(dev);
> +
> +	if (adap) {
> +		i2c_lock_adapter(adap);
> +		adap->suspended =3D false;
> +		i2c_unlock_adapter(adap);
> +	}
> =20
>  	if (pm)
>  		return pm_generic_resume(dev);
> @@ -1819,7 +1833,10 @@ int i2c_transfer(struct i2c_adapter *adap, struct =
i2c_msg *msgs, int num)
>  			i2c_lock_adapter(adap);
>  		}
> =20
> -		ret =3D __i2c_transfer(adap, msgs, num);
> +		if (adap->suspended)
> +			ret =3D -EIO;
> +		else
> +			ret =3D __i2c_transfer(adap, msgs, num);

a) Minor: I'd swap the branches and invert the condition, so that the
more expected code path comes first

b) linux-pm: I wonder about the return code. Currently, some drivers
return -EIO, some -EBUSY. Do you care which? Since we try to have
designated fault codes in the i2c subsystem, I wonder about -ESHUTDOWN?
Or is this too much of hijacking fault codes?

>  		i2c_unlock_adapter(adap);
> =20
>  		return ret;
> @@ -2577,6 +2594,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u1=
6 addr, unsigned short flags,
> =20
>  	if (adapter->algo->smbus_xfer) {
>  		i2c_lock_adapter(adapter);
> +		if (adapter->suspended) {
> +			res =3D -EIO;
> +			goto unlock;
> +		}
> =20
>  		/* Retry automatically on arbitration loss */
>  		orig_jiffies =3D jiffies;
> @@ -2590,6 +2611,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16=
 addr, unsigned short flags,
>  				       orig_jiffies + adapter->timeout))
>  				break;
>  		}
> +unlock:
>  		i2c_unlock_adapter(adapter);
> =20
>  		if (res !=3D -EOPNOTSUPP || !adapter->algo->master_xfer)
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index b556e0a..af08c75 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -434,6 +434,7 @@ struct i2c_adapter {
>  	int timeout;			/* in jiffies */
>  	int retries;
>  	struct device dev;		/* the adapter device */
> +	unsigned int suspended:1;
> =20
>  	int nr;
>  	char name[48];
> --=20
> 1.9.1
>=20

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTx8j/AAoJEBQN5MwUoCm2X4UP/R/Fdew45b6j6E40nyq5c8kA
m3bYfYKQG2fcJpLFcOVzITeA99if151e4pySnCveyYv5FHxmIFZFxj4yT19/qgqk
K5WXopN2tbjcxo9RYr6tuQOoW5tVok8oM8nD1jIHSkqh307OUBoUah4EAbA+vneM
3CIwYou1yPugI3ZYxnrf2rjnYI9AxbDT/8b1jMHvSkyIUDqsPyzh8NsDmiN/AwOM
wSJuIaH7uQ/vI7UD4oWyBdiuOBujhXEv2bg+4HNIGEpjSXZRbo064+fGs7BHg86X
31HwILIWaj6jRNmHnmZzyopymmRWzHFVnCwbRNAzW4H+LKSDpYTBvrJy7E2gaAGf
3ysr2+V+cWqg20sh6oJb8gXiC0YKtR1bTg/3qxNGPhHVOJc6KMqD4t2CQLoeLOPU
QotGd/dcSE/CEpA4O4FfYUG95i02ruUx4Omr5W7D9EdKQ957oNFnCTyTRloJ3ya7
J56NdZrGYxwgE6Q/7kEJtD+nlIaGTUKluhmbAhyG+FlwAHNuyd/PU+0LQmMc6jh7
cxNW5k3+wGtgKAtZZh44xIlpfucygqk9oCTznCUQeOsN2U71Zj3lFLbHLj5tzC9f
7a7bL1N1+DXnOofgy+cdhkeaQ6HBORqgSD1XGMh3jBA6OntuSHehLOXFep7+cMVF
P42h3P5WsigsRj48vTYV
=yVSe
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
