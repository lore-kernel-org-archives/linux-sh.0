Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E74BD373;
	Wed, 16 Sep 2026 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586064; cv=none; b=Ii+Bq6AGCsAvJzNJEsVl06UShq+CFttmf7+BCmx+q2r3QXM4i4fOrYg1GZCg1ieOg8kN0H2VYZ5YZ9HD0+aEU+6LlOLVEv+6mxs1fjnNhaboJsHi3Bpo0qODxFnI6IV8YvwHwSvK3fhTRaiLNIMfypQs5YrnnRGrl6x4YOLhZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586064; c=relaxed/simple;
	bh=e8JYdVCf4vsRGPnnwF8ZX7ui0EKVrgrE4g8EFhCxNqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SyB+iSD83rVTNDzlsuwQ0BAIcRsnlqIkA+p0uWKhYQfVhGsImuVodR1xozeDv5Yn69jjxGJQO2RqcGOCCqyfEH8UUK08cVIz0CXUAexacAjxkL2Ciyk2mk12TAD/KHvo2DucoZoHLEOCSdEZ0xT/PlNO+GbdvfO2enJ1qqB7zAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UYvyczCR; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UYvyczCR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=R9Z5PkeqCCSetAVEiONleDi7aUQcufGI3Rz8fogM+rs=; t=1789586058;
	x=1790190858; b=UYvyczCRjlKA9jBLR94YLcQ4hY0Q678vR7lw6IGH9HzVjp2gPjCgOTp7V0aYU
	RvwogEV4AHs3dVv9fo4SqSGrGiZhd1l1qSeK3DFFfGjc/b3sENj4mXbn+QZYQHkzKanibkg7eHbg0
	fqChTQm9g8ajEW2VIZwsZdD5NF7AtfsrCW6oEe+fAqswgtiwewo3reMRkIiFxfKxDMFsGd/jB1iSQ
	sy6k7WohJjxuV6lfRpi4km/rMUHoUHuCG3IcFmt3FPuNmj9x8jLMvcPcUn2bT6BClJRUEokg6tYwE
	1QGWYGCPmiH+5WIssnyl/N+9g/IAYo53NCiF6O+kw7roa0Sp8A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x6v57-00000001Bvy-0CPa; Wed, 16 Sep 2026 21:14:09 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x6v56-000000033sC-3Hzz; Wed, 16 Sep 2026 21:14:08 +0200
Message-ID: <fe0bcfeb105251f4d14a3cc96774a1d2f82562f8.camel@physik.fu-berlin.de>
Subject: Re: [RESEND PATCH] sh: ecovec24: use static device properties to
 describe the touchscreen
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rich Felker
 <dalias@libc.org>,  Yoshinori Sato <yoshinori.sato@nifty.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>,  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>, jacopo mondi <jacopo@jmondi.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Date: Wed, 16 Sep 2026 21:14:07 +0200
In-Reply-To: <alUyZ2zVWCPhyHHX@google.com>
References: <alUyZ2zVWCPhyHHX@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Dmitry,

On Mon, 2026-07-13 at 14:41 -0700, Dmitry Torokhov wrote:
> Convert the board to use static device properties instead of platform
> data to describe the touchscreen, so that support for platform data can
> be removed from tsc2007 driver (ecovec24 is the last board using this
> mechanism of describing tsc2007).
>=20
> Device properties do not allow custom board methods, so the method for
> getting "pen down" state was removed (the driver is capable of working
> without it). If this functionality is needed proper pin control/gpio
> support needs to be implemented so that the same pin can serve as an
> input GPIO and an interrupt.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>=20
> This is a resend of the patch I sent in August of 2024. My fault of not
> noticing reply from Adrian inquiring about potential negative impact
> from not having GPIO-based "pen down" detection. I believe this is fine,
> the "pen down" is an optional feature and the driver can detect the
> touches even when it is not specified. Additionally, this is an
> evaluation board, so user impact should be negligible.
>=20
> However the bigger question is whether ecovec24 board still relevant.
> According to my research it has the following regressions currently
> unfixed:
>=20
> 5716fb9bd9c6 ("mmc: spi: Convert to use GPIO descriptors")
>   - MMC SPI device naming broken (broke SD fallback mode)
>=20
> 9fda6693335c ("spi: sh-msiof: Convert to use GPIO descriptors")
>   - SPI CS polarity inverted (broke initialization on the MSIOF0 SPI bus)
>=20
> c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver=
")
>   - Camera array sentinel missing (causes out-of-bounds reads and
>     potentially kernel panics)
>   - Camera standby polarity inverted (enadvertently keeps cameras
>     permanently powered off)
>   - Camera disabled iby default (board defconfig points to a deleted
>     driver)
>=20
> They are ~6 years old, so I wonder: do people actually *actively* use
> this board with modern kernels? Should it simply be removed?

We want to switch arch/sh to using device trees in the future anyway, then
we can decide which boards to keep and which ones to remove. We have a patc=
h
series by Yoshinori Sato to convert arch/sh to device trees. It still needs
some work though.

> Thanks!
>=20
>  arch/sh/boards/mach-ecovec24/setup.c | 38 ++++++++--------------------
>  1 file changed, 11 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-e=
covec24/setup.c
> index a641e26f8fdf..110a77f903b5 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_data/tmio.h>
>  #include <linux/platform_data/tsc2007.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/sh_eth.h>
> @@ -589,39 +590,21 @@ static struct platform_device keysc_device =3D {
>  /* TouchScreen */
>  #define IRQ0 evt2irq(0x600)
> =20
> -static int ts_get_pendown_state(struct device *dev)
> -{
> -	int val =3D 0;
> -	gpio_free(GPIO_FN_INTC_IRQ0);
> -	gpio_request(GPIO_PTZ0, NULL);
> -	gpio_direction_input(GPIO_PTZ0);
> -
> -	val =3D gpio_get_value(GPIO_PTZ0);
> -
> -	gpio_free(GPIO_PTZ0);
> -	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
> -
> -	return val ? 0 : 1;
> -}
> -
> -static int ts_init(void)
> -{
> -	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
> -	return 0;
> -}
> +static const struct property_entry tsc2007_properties[] =3D {
> +	PROPERTY_ENTRY_U32("ti,x-plate-ohms", 180),
> +	{ }
> +};
> =20
> -static struct tsc2007_platform_data tsc2007_info =3D {
> -	.model			=3D 2007,
> -	.x_plate_ohms		=3D 180,
> -	.get_pendown_state	=3D ts_get_pendown_state,
> -	.init_platform_hw	=3D ts_init,
> +static const struct software_node tsc2007_swnode =3D {
> +	.name =3D "tsc2007",
> +	.properties =3D tsc2007_properties,
>  };
> =20
>  static struct i2c_board_info ts_i2c_clients =3D {
>  	I2C_BOARD_INFO("tsc2007", 0x48),
>  	.type		=3D "tsc2007",
> -	.platform_data	=3D &tsc2007_info,
>  	.irq		=3D IRQ0,
> +	.swnode		=3D &tsc2007_swnode,
>  };
> =20
>  static struct regulator_consumer_supply cn12_power_consumers[] =3D
> @@ -1242,8 +1225,9 @@ static int __init arch_setup(void)
>  		gpio_direction_output(GPIO_PTF4, 1);
> =20
>  		/* enable TouchScreen */
> -		i2c_register_board_info(0, &ts_i2c_clients, 1);
> +		gpio_request(GPIO_FN_INTC_IRQ0, NULL);
>  		irq_set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
> +		i2c_register_board_info(0, &ts_i2c_clients, 1);
>  	}
> =20
>  	/* enable CEU0 */
> --=20
> 2.55.0.795.g602f6c329a-goog
>=20

Looks good to me. I'll pick this up for v7.4.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
