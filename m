From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 22 May 2017 07:41:05 +0000
Subject: Re: [PATCH 4/4] input: tsc2007: move header file out of I2C realm
Message-Id: <20170522074105.umwz723mvkxxmcnj@dell>
List-Id: <linux-sh.vger.kernel.org>
References: <20170521204013.6623-1-wsa@the-dreams.de>
 <20170521204013.6623-5-wsa@the-dreams.de>
In-Reply-To: <20170521204013.6623-5-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, 21 May 2017, Wolfram Sang wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c     | 2 +-
>  drivers/input/touchscreen/tsc2007_core.c | 2 +-
>  drivers/mfd/timberdale.c                 | 2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  include/linux/{i2c =3D> input}/tsc2007.h   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename include/linux/{i2c =3D> input}/tsc2007.h (95%)
>=20
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-e=
covec24/setup.c
> index 6d612792f6b8ec..efca883d3466cc 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -24,7 +24,7 @@
>  #include <linux/usb/r8a66597.h>
>  #include <linux/usb/renesas_usbhs.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c/tsc2007.h>
> +#include <linux/input/tsc2007.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/sh_msiof.h>
>  #include <linux/spi/mmc_spi.h>
> diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/tou=
chscreen/tsc2007_core.c
> index fc7384936011dc..b680b942e4abde 100644
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -25,7 +25,7 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c/tsc2007.h>
> +#include <linux/input/tsc2007.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include "tsc2007.h"
> diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
> index c9339f85359b74..84523b630e2fdf 100644
> --- a/drivers/mfd/timberdale.c
> +++ b/drivers/mfd/timberdale.c
> @@ -32,7 +32,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-ocores.h>
>  #include <linux/i2c-xiic.h>
> -#include <linux/i2c/tsc2007.h>
> +#include <linux/input/tsc2007.h>
> =20
>  #include <linux/spi/spi.h>
>  #include <linux/spi/xilinx_spi.h>
> diff --git a/include/linux/i2c/tsc2007.h b/include/linux/input/tsc2007.h
> similarity index 95%
> rename from include/linux/i2c/tsc2007.h
> rename to include/linux/input/tsc2007.h
> index 4f35b6ad3889fa..c7b7eb024328d5 100644
> --- a/include/linux/i2c/tsc2007.h
> +++ b/include/linux/input/tsc2007.h
> @@ -1,7 +1,7 @@
>  #ifndef __LINUX_I2C_TSC2007_H
>  #define __LINUX_I2C_TSC2007_H
> =20
> -/* linux/i2c/tsc2007.h */
> +/* linux/input/tsc2007.h */
> =20
>  struct tsc2007_platform_data {
>  	u16	model;				/* 2007. */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
