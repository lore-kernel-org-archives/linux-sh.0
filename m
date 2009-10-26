From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 26 Oct 2009 10:23:22 +0000
Subject: Re: [PATCH] sh: rsk7203 CONFIG_MTD=n fix
Message-Id: <200910261123.24013.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi, all
just in these days I'm designing a new custom borad derived from rsk7203.
I'd like to use linux-sh instead of uc-linux.
What toolchain should I use?
Where can I find the git user manual

Thanks a lot=20

Reagrds



Alle 11:08, luned=C3=AC 26 ottobre 2009, Magnus Damm ha scritto:
> From: Magnus Damm <damm@opensource.se>
>
> Fix the rsk7203 board code to build with CONFIG_MTD=3Dn.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>  arch/sh/boards/mach-rsk/devices-rsk7203.c |    4 ----
>  arch/sh/boards/mach-rsk/setup.c           |   23 ++++++++++++++---------
>  2 files changed, 14 insertions(+), 13 deletions(-)
>
> --- 0001/arch/sh/boards/mach-rsk/devices-rsk7203.c
> +++ work/arch/sh/boards/mach-rsk/devices-rsk7203.c	2009-10-26
> 12:32:26.000000000 +0900 @@ -11,10 +11,6 @@
>  #include <linux/types.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mtd/map.h>
>  #include <linux/smsc911x.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
> --- 0001/arch/sh/boards/mach-rsk/setup.c
> +++ work/arch/sh/boards/mach-rsk/setup.c	2009-10-26 12:02:16.000000000
> +0900 @@ -15,14 +15,12 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/physmap.h>
> +#ifdef CONFIG_MTD
>  #include <linux/mtd/map.h>
> +#endif
>  #include <asm/machvec.h>
>  #include <asm/io.h>
>
> -static const char *probes[] =3D { "cmdlinepart", NULL };
> -
> -static struct mtd_partition *parsed_partitions;
> -
>  static struct mtd_partition rsk_partitions[] =3D {
>  	{
>  		.name		=3D "Bootloader",
> @@ -41,6 +39,8 @@ static struct mtd_partition rsk_partitio
>  };
>
>  static struct physmap_flash_data flash_data =3D {
> +	.parts		=3D rsk_partitions,
> +	.nr_parts	=3D ARRAY_SIZE(rsk_partitions),
>  	.width		=3D 2,
>  };
>
> @@ -60,7 +60,8 @@ static struct platform_device flash_devi
>  	},
>  };
>
> -static struct mtd_info *flash_mtd;
> +#ifdef CONFIG_MTD
> +static const char *probes[] =3D { "cmdlinepart", NULL };
>
>  static struct map_info rsk_flash_map =3D {
>  	.name		=3D "RSK+ Flash",
> @@ -68,6 +69,10 @@ static struct map_info rsk_flash_map =3D {
>  	.bankwidth	=3D 2,
>  };
>
> +static struct mtd_info *flash_mtd;
> +
> +static struct mtd_partition *parsed_partitions;
> +
>  static void __init set_mtd_partitions(void)
>  {
>  	int nr_parts =3D 0;
> @@ -77,14 +82,14 @@ static void __init set_mtd_partitions(vo
>  	nr_parts =3D parse_mtd_partitions(flash_mtd, probes,
>  					&parsed_partitions, 0);
>  	/* If there is no partition table, used the hard coded table */
> -	if (nr_parts <=3D 0) {
> -		flash_data.parts =3D rsk_partitions;
> -		flash_data.nr_parts =3D ARRAY_SIZE(rsk_partitions);
> -	} else {
> +	if (nr_parts > 0) {
>  		flash_data.nr_parts =3D nr_parts;
>  		flash_data.parts =3D parsed_partitions;
>  	}
>  }
> +#else
> +static inline void set_mtd_partitions(void) {}
> +#endif
>
>  static struct platform_device *rsk_devices[] __initdata =3D {
>  	&flash_device,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Fabio Giovagnini

Aurion s.r.l.
CF e P.IVA 00885711200
Tel. +39.335.8350919

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
