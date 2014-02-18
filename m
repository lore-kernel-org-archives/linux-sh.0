From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 18 Feb 2014 17:38:43 +0000
Subject: Re: [PATCH 1/2] I2C: EMMA Mobile I2C master driver
Message-Id: <20140218173843.GB18768@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PmA2V3Z32TCmWXqI"
List-Id: <linux-sh.vger.kernel.org>
References: <1377688911-10911-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-2-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1378226969-18722-2-git-send-email-ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
To: Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2013 at 05:49:29PM +0100, Ian Molton wrote:
> Add a driver for the EMMA mobile I2C block.
>=20
> The driver supports low and high-speed interrupt driven PIO transfers.
>=20
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -777,6 +777,16 @@ config I2C_RCAR
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-rcar.
> =20
> +config I2C_EM
> +	tristate "EMMA Mobile series I2C adapter"
> +	depends on I2C && HAVE_CLK
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  I2C interface on the Renesas Electronics EM/EV family of processors.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-em
> +

Please keep it sorted.

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-em.c
> @@ -0,0 +1,501 @@
> +/*
> + * Copyright 2013 Codethink Ltd.
> + * Parts Copyright 2010 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Foundatio=
n,
> + * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335, USA.
> + */

Skip the address please.

> +static int em_i2c_xfer(struct i2c_adapter *, struct i2c_msg[], int);

You can skip this forward declaration by reordering.

> +
> +struct em_i2c_device {
> +	struct i2c_adapter	adap;
> +	wait_queue_head_t	i2c_wait;
> +	void __iomem		*membase;
> +	struct clk              *clk;
> +	struct clk              *sclk;
> +	int			irq;
> +	int			flags;
> +	int			pending;
> +	spinlock_t              irq_lock;
> +};
> +
> +#define to_em_i2c(adap) (struct em_i2c_device *)i2c_get_adapdata(adap)
> +
> +static u32 em_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}

Have you tried SMBUS_QUICK (via 'i2cdetect -q')?

> +
> +static struct i2c_algorithm em_i2c_algo =3D {
> +	.master_xfer =3D em_i2c_xfer,
> +	.smbus_xfer =3D NULL,

No need to specify the NULL.

> +	.functionality =3D em_i2c_func,
> +};
> +

> +static int em_i2c_wait_for_event(struct em_i2c_device *i2c_dev, u16 *sta=
tus)
> +{
> +	int interrupted;
> +
> +	do {
> +		interrupted =3D wait_event_interruptible_timeout(
> +				i2c_dev->i2c_wait, i2c_dev->pending,
> +				i2c_dev->adap.timeout);

Have you tested signals extensively? It can be done right, yet it is
complex. Most drivers decide to skip the interruptible.

> +
> +		if (i2c_dev->pending) {
> +			spin_lock_irq(&i2c_dev->irq_lock);
> +			i2c_dev->pending =3D 0;
> +			spin_unlock_irq(&i2c_dev->irq_lock);
> +			*status =3D readl(i2c_dev->membase + I2C_OFS_IICSE0);
> +			return 0;
> +		}
> +
> +	} while (interrupted);
> +
> +	*status =3D 0;
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int em_i2c_stop(struct em_i2c_device *i2c_dev)
> +{
> +	u16 status;
> +
> +	/* Send Stop condition */
> +	writel((readl(i2c_dev->membase + I2C_OFS_IICC0) | I2C_BIT_SPT0 |
> +		I2C_BIT_SPIE0), i2c_dev->membase + I2C_OFS_IICC0);

I'd think a em_set_bit() function would make the code more readable.

> +
> +	/* Wait for stop condition */
> +	em_i2c_wait_for_event(i2c_dev, &status);
> +	/* FIXME - check status? */

What about the FIXME?

> +
> +	if ((readl(i2c_dev->membase + I2C_OFS_IICSE0) & I2C_BIT_SPD0) !=3D 0)

!=3D 0 is superfluous, same for =3D=3D 1 later.

> +		return 0;
> +
> +	return -EBUSY;
> +}
> +
> +	/* Send / receive data */
> +	do {
> +		/* Arbitration, Extension mode or Slave mode are errors*/
> +		if (status & (I2C_BIT_EXC0 | I2C_BIT_COI0 | I2C_BIT_ALD0)
> +				|| !(status & I2C_BIT_MSTS0))
> +			goto out_reset;
> +
> +		if (!(status & I2C_BIT_TRC0)) { /* Read transaction */
> +
> +			/* msg->flags is Write type */
> +			if (!(msg->flags & I2C_M_RD))
> +				goto out_reset;
> +
> +			if (count =3D=3D msg->len)
> +				break;
> +
> +			msg->buf[count++] =3D
> +				readl(i2c_dev->membase + I2C_OFS_IIC0);
> +
> +
> +			writel((readl(i2c_dev->membase + I2C_OFS_IICC0)
> +				| I2C_BIT_WREL0),
> +				i2c_dev->membase + I2C_OFS_IICC0);
> +
> +		} else { /* Write transaction */
> +
> +			/* msg->flags is Read type */
> +			if ((msg->flags & I2C_M_RD))
> +				goto out_reset;
> +
> +			/* Recieved No ACK */
> +			if (!(status & I2C_BIT_ACKD0)) {
> +				em_i2c_stop(i2c_dev);
> +				goto out;
> +			}
> +
> +			if (count =3D=3D msg->len)
> +				break;
> +
> +			/* Write data */
> +			writel(msg->buf[count++], i2c_dev->membase
> +				+ I2C_OFS_IIC0);
> +		}
> +
> +		/* Wait for R/W transaction */
> +		if (em_i2c_wait_for_event(i2c_dev, &status))
> +			goto out_reset;
> +
> +	} while (1);

Have you tried using another loop than this endless do/while?

> +
> +	if (stop)
> +		em_i2c_stop(i2c_dev);
> +
> +	return count;
> +
> +out_reset:
> +	em_i2c_reset(adap);
> +out:
> +	return -EREMOTEIO;
> +}
> +
> +static int em_i2c_wait_free(struct i2c_adapter *adap)
> +{
> +	struct em_i2c_device *i2c_dev =3D to_em_i2c(adap);
> +	int timeout =3D adap->timeout;
> +	int status;
> +
> +	/* wait until I2C bus free */
> +	while ((readl(i2c_dev->membase + I2C_OFS_IICF0) & I2C_BIT_IICBSY)
> +			&& timeout--) {
> +		schedule_timeout_uninterruptible(1);
> +	}

Are you sure you want to loop with a 1 jiffy granularity?

> +
> +	status =3D (timeout <=3D 0);
> +
> +	if (status)
> +		dev_info(&adap->dev, "I2C bus is busy\n");
> +
> +	return status;
> +}
> +
> +static int em_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +	int num)
> +{
> +	struct em_i2c_device *i2c_dev =3D to_em_i2c(adap);
> +	int ret =3D 0;
> +	int i;
> +
> +	em_i2c_enable_clock(i2c_dev);
> +	em_i2c_reset(adap);

You reset the adapter before every transfer?

> +
> +	/* Attempt to gain control of the adapter */
> +	i =3D 0;
> +	while (em_i2c_wait_free(adap)) {
> +		switch (i) {
> +		case 0:
> +			if (!(readl(i2c_dev->membase + I2C_OFS_IICSE0)
> +					& I2C_BIT_MSTS0)) {
> +				/* Slave mode -> Error */
> +				ret =3D -EBUSY;
> +				goto out;
> +			}
> +
> +			em_i2c_stop(i2c_dev);
> +			break;
> +		case 1:
> +			em_i2c_reset(adap);

=2E..and here again?

> +			break;
> +		case 2:
> +			ret =3D -EREMOTEIO;
> +			goto out;
> +		}
> +		i++;
> +	}
> +
> +	/* Send messages */
> +	for (i =3D 0; i < num; i++) {
> +		ret =3D __em_i2c_xfer(adap, &msgs[i], (i =3D=3D (num - 1)));
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	/* I2C transfer completed */
> +	ret =3D i;
> +
> +out:
> +	em_i2c_disable_clock(i2c_dev);
> +
> +	return ret;
> +}
> +

> +	spin_lock_init(&i2c_dev->irq_lock);
> +
> +	if (of_find_property(pdev->dev.of_node, "high-speed", NULL))
> +		i2c_dev->flags |=3D I2C_BIT_SMC0;

Please derive this from the standard property "clock-frequency" which
configures the bus speed for I2C.

> +	of_i2c_register_devices(&i2c_dev->adap);

The core does this for you.

> +static int em_i2c_remove(struct platform_device *dev)
> +{
> +	struct em_i2c_device *i2c_dev =3D platform_get_drvdata(dev);
> +
> +	i2c_del_adapter(&i2c_dev->adap);
> +
> +	clk_disable(i2c_dev->clk);

Aren't the clocks off already?

> +	clk_unprepare(i2c_dev->clk);
> +
> +	return 0;
> +}
> +


> +
> +MODULE_LICENSE("GPLv2");

GPL v2

> +MODULE_DESCRIPTION("EMEV2 I2C bus driver");
> +MODULE_AUTHOR("Ian Molton");

Email address?

> +
> --=20
> 1.7.10.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTA5qiAAoJEBQN5MwUoCm2jkYP/0iMdz6ppgdufsEhupEWbymR
HjE/veUmR3t1GeOKEwhXPAmGA00rsyOBkp0eNbfUlvnMYdLWAZRD1FjF1MVGazwB
Lt8gOPaxm17xoEEMUOBrHKd5DnaO8gzK+0bjvWCXw2cgWZNGEHq66SRc/t222YHZ
XzRh5cdA57PcIH+B6ajLB94BJANUWxhvJDnXi+Cg5IpCiaMEm4dZZGSNOrMRhHyj
7hmXw0SE186j9ILLfVfV5sSNAlt/gYX7lCn/Q1jW8riUx/RmzqeQKIvOCUy2CkFC
MHRBbKrADx2md4Gi8pbozBWNQ8tReOct4m3aZmgLhpxkGrs8KWGAkWYebOObVGsX
9Zx1gE76D7VjGNmi9Znha1m8JG2BpdaZqlbz//SljPPkp7OMwX5I+iwmvZwyftQV
7LzePxUjhFnPdOhNu8ehb4MbKgFOrxW1zmfPJzvwwT49xTO/i+rVZap189qQZBz7
YRPNHUDhHZQtgi+UWdWpbdCy+b9Cbe7FYeCYuObtv2yhoDfq8pXOTELLXj1dKpLL
6yaqoLOQqOnAiMryCq8MmlfzpbEb4OM4NFESNHHtg4bNsHbGpyUBEK5CYkn4kj6G
Lgwzagi/FbmWc0TyYVR+Itn422iAROiHROlIl5/oEozyhGx4I9tI3/2XGRjyUj+0
UAmtOwy43NTcBh2b5wag
=M9iS
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
