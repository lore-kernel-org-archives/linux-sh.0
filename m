From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 21 Nov 2014 07:19:41 +0000
Subject: Re: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
Message-Id: <20141121071941.GK27002@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Wolfram,

this mail is thematically more a reply to patch 1 and maybe just serves
my understanding of the slave support.

On Tue, Nov 18, 2014 at 05:04:54PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> The first user of the i2c-slave interface is an eeprom simulator. It is
> a shared memory which can be accessed by the remote master via I2C and
> locally via sysfs.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Changes since RFC:
> * fix build error for modules
> * don't hardcode size
> * add boundary checks for sysfs access
> * use a spinlock
> * s/at24s/eeprom/g
> * add some docs
> * clean up exit paths
> * use size-variable instead of driver_data
>=20
>  drivers/i2c/Kconfig            |  10 +++
>  drivers/i2c/Makefile           |   1 +
>  drivers/i2c/i2c-slave-eeprom.c | 170 +++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 181 insertions(+)
>  create mode 100644 drivers/i2c/i2c-slave-eeprom.c
>=20
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index b51a402752c4..8c9e619f3026 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -110,6 +110,16 @@ config I2C_STUB
> =20
>  	  If you don't know what to do here, definitely say N.
> =20
> +config I2C_SLAVE
> +	bool "I2C slave support"
> +
> +if I2C_SLAVE
> +
> +config I2C_SLAVE_EEPROM
> +	tristate "I2C eeprom slave driver"
> +
> +endif
> +
>  config I2C_DEBUG_CORE
>  	bool "I2C Core debugging messages"
>  	help
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index 1722f50f2473..45095b3d16a9 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_I2C_CHARDEV)	+=3D i2c-dev.o
>  obj-$(CONFIG_I2C_MUX)		+=3D i2c-mux.o
>  obj-y				+=3D algos/ busses/ muxes/
>  obj-$(CONFIG_I2C_STUB)		+=3D i2c-stub.o
> +obj-$(CONFIG_I2C_SLAVE_EEPROM)	+=3D i2c-slave-eeprom.o
> =20
>  ccflags-$(CONFIG_I2C_DEBUG_CORE) :=3D -DDEBUG
>  CFLAGS_i2c-core.o :=3D -Wno-deprecated-declarations
> diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eepro=
m.c
> new file mode 100644
> index 000000000000..6631400b5f02
> --- /dev/null
> +++ b/drivers/i2c/i2c-slave-eeprom.c
> @@ -0,0 +1,170 @@
> +/*
> + * I2C slave mode EEPROM simulator
> + *
> + * Copyright (C) 2014 by Wolfram Sang, Sang Engineering <wsa@sang-engine=
ering.com>
> + * Copyright (C) 2014 by Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; version 2 of the License.
> + *
> + * Because most IP blocks can only detect one I2C slave address anyhow, =
this
> + * driver does not support simulating EEPROM types which take more than =
one
> + * address. It is prepared to simulate bigger EEPROMs with an internal 1=
6 bit
> + * pointer, yet implementation is deferred until the need actually arise=
s.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +
> +struct eeprom_data {
> +	struct bin_attribute bin;
> +	bool first_write;
> +	spinlock_t buffer_lock;
> +	u8 buffer_idx;
> +	u8 buffer[];
> +};
> +
> +static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
> +				     enum i2c_slave_event event, u8 *val)
> +{
> +	struct eeprom_data *eeprom =3D i2c_get_clientdata(client);
> +
> +	switch (event) {
> +	case I2C_SLAVE_REQ_WRITE_END:
> +		if (eeprom->first_write) {
> +			eeprom->buffer_idx =3D *val;
> +			eeprom->first_write =3D false;
> +		} else {
> +			spin_lock(&eeprom->buffer_lock);
> +			eeprom->buffer[eeprom->buffer_idx++] =3D *val;
> +			spin_unlock(&eeprom->buffer_lock);
> +		}
> +		break;
> +
> +	case I2C_SLAVE_REQ_READ_START:
> +		spin_lock(&eeprom->buffer_lock);
> +		*val =3D eeprom->buffer[eeprom->buffer_idx];
> +		spin_unlock(&eeprom->buffer_lock);
> +		break;
> +
> +	case I2C_SLAVE_REQ_READ_END:
> +		eeprom->buffer_idx++;
You don't check here for buffer_idx >=3D ARRAY_SIZE(buffer)?
Ditto in the I2C_SLAVE_REQ_WRITE_END case.
> +		break;
> +
> +	case I2C_SLAVE_STOP:
> +		eeprom->first_write =3D true;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
This is the most interesting function here because it uses the new
interface, the functions below are only to update and show the simulated
eeprom contents and driver boilerplate, right?

When the eeprom driver is probed and the adapter driver notices a read
request for the respective i2c address, this callback is called with
event=3DI2C_SLAVE_REQ_READ_START. Returning 0 here and provide the first
byte to send make the adapter ack the read request and send the data
provided. If something !=3D 0 is returned a NAK is sent?

How is the next byte requested from the slave driver? I assume with two
additional calls to the callback, first with
event=3DI2C_SLAVE_REQ_READ_END, then event=3DI2C_SLAVE_REQ_READ_START once
more. Would it make sense to reduce this to a single call? Does the
driver at READ_END time already know if its write got acked? If so, how?

This means that for each byte the callback is called. Would it make
sense to make the API more flexible and allow the slave driver to return
a buffer? This would remove some callback overhead and might allow to
let the adapter driver make use of its DMA mechanism.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
