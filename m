Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F763DD86A;
	Thu, 17 Sep 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670970; cv=none; b=igzvNnXudzH8F+8XqvNb6sioXRLCun5LaXHtP4Aq/DrBKL23qbn87jwocx4n50Y3NNDf9hjWXodH6fplzU0vAKMxV4Rh6L9OjbF+gZhR+3ckffhjuMHg6t4qaSU6KtnQyk+r8cBqq2bRzo3p+BXm7+iYsPMAnq1FQWCTvbkoUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670970; c=relaxed/simple;
	bh=Xpbl1k6sLrFTFOh5ZGV0rrvsR4KOlgA2n+Zm+v+sUx0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSJRAxQOwLTSPqp0VMic9duFptVjJfRp9ClWMfK2XzEZeOxMQdI4hN/66T3XHmBPaVgDOu2AMI1jh6iDVU1hxE/2ZHnjYedGkiF2fxiXqkzkVH1ST6sgadVhfYSoNBSmRuuthgISv8/D5ePQOr75aaDvY9l0eqbiGAX5lqcHlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=mkFwOHRD; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="mkFwOHRD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=peHEbB5d41kYnaZ/xtoDqvT4hGsveZjLDVlql+Swn+A=; t=1789670965;
	x=1790275765; b=mkFwOHRD1Vy4xl92XcywYIvThRPUr0KeOWt24RCFRaOg6VYWcP7CKi3iYdLHM
	eVpdmsGqEll35PkqHMu/Xch1cwWHASvYNjRzr9gi75YAyRLDfe6lmy4tqSnr8hG9SkLeYRpjlgFP/
	ShNMXZ9EOZutRSmliA3ElG4vEzix2u8Y+yHBXHKEHiK0vTRxdTxaYyyFF7PjYgY5ryycQDJqZs0cn
	FjZ4LXhKJr59BtrlhfHAMDPoF3pTMhgCzW+cJCpHzcFjAMYagEHmHhi9oMR5IMz8SPcxx8hGzPhal
	dz3ETwExY16X8uwojN0OhtN4siR+EYr7MTL/UXm1Q1+jZwfHwA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x7HAa-00000003udl-2gbW; Thu, 17 Sep 2026 20:49:16 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x7HAa-00000003oEF-1gc9; Thu, 17 Sep 2026 20:49:16 +0200
Message-ID: <d3a2875ba34bf10ddae3626b77da071cd4624348.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] sh: mach-x3proto: convert gpio-keys to software
 nodes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>,  Arnd Bergmann	 <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 20:49:15 +0200
In-Reply-To: <20260704-sh-x3proto-swnode-v1-2-0c039549dc46@gmail.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
	 <20260704-sh-x3proto-swnode-v1-2-0c039549dc46@gmail.com>
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

On Sat, 2026-07-04 at 22:04 -0700, Dmitry Torokhov wrote:
> Convert the legacy gpio-keys platform device on the SH-X3 Prototype
> board to use software nodes/properties. This allows us to describe
> the GPIO keys and their GPIO bindings using software nodes, so that
> support for platform data can eventually be removed from the
> gpio-keys driver.
>=20
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/sh/boards/mach-x3proto/setup.c | 165 +++++++++++++++++-------------=
------
>  1 file changed, 78 insertions(+), 87 deletions(-)
>=20
> diff --git a/arch/sh/boards/mach-x3proto/setup.c b/arch/sh/boards/mach-x3=
proto/setup.c
> index ca2802d30565..0d9d5982cf0c 100644
> --- a/arch/sh/boards/mach-x3proto/setup.c
> +++ b/arch/sh/boards/mach-x3proto/setup.c
> @@ -16,8 +16,8 @@
>  #include <linux/input.h>
>  #include <linux/usb/r8a66597.h>
>  #include <linux/usb/m66592.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/gpio_keys.h>
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/property.h>
>  #include <mach/ilsel.h>
>  #include <mach/hardware.h>
>  #include <asm/smp-ops.h>
> @@ -123,87 +123,74 @@ static struct platform_device m66592_usb_peripheral=
_device =3D {
>  	.resource	=3D m66592_usb_peripheral_resources,
>  };
> =20
> -static struct gpio_keys_button baseboard_buttons[NR_BASEBOARD_GPIOS] =3D=
 {
> -	{
> -		.desc		=3D "key44",
> -		.code		=3D KEY_POWER,
> -		.active_low	=3D 1,
> -		.wakeup		=3D 1,
> -	}, {
> -		.desc		=3D "key43",
> -		.code		=3D KEY_SUSPEND,
> -		.active_low	=3D 1,
> -		.wakeup		=3D 1,
> -	}, {
> -		.desc		=3D "key42",
> -		.code		=3D KEY_KATAKANAHIRAGANA,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key41",
> -		.code		=3D KEY_SWITCHVIDEOMODE,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key34",
> -		.code		=3D KEY_F12,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key33",
> -		.code		=3D KEY_F11,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key32",
> -		.code		=3D KEY_F10,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key31",
> -		.code		=3D KEY_F9,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key24",
> -		.code		=3D KEY_F8,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key23",
> -		.code		=3D KEY_F7,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key22",
> -		.code		=3D KEY_F6,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key21",
> -		.code		=3D KEY_F5,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key14",
> -		.code		=3D KEY_F4,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key13",
> -		.code		=3D KEY_F3,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key12",
> -		.code		=3D KEY_F2,
> -		.active_low	=3D 1,
> -	}, {
> -		.desc		=3D "key11",
> -		.code		=3D KEY_F1,
> -		.active_low	=3D 1,
> -	},
> +static const struct software_node x3proto_gpio_keys_node =3D {
> +	.name =3D "x3proto-gpio-keys",
>  };
> =20
> -static struct gpio_keys_platform_data baseboard_buttons_data =3D {
> -	.buttons	=3D baseboard_buttons,
> -	.nbuttons	=3D ARRAY_SIZE(baseboard_buttons),
> +#define __X3PROTO_KEY(_id, _code, _gpio, ...)				\
> +static const struct property_entry x3proto_key##_id##_props[] =3D {	\
> +	PROPERTY_ENTRY_STRING("label", "key" #_id),			\
> +	PROPERTY_ENTRY_U32("linux,code", _code),			\
> +	PROPERTY_ENTRY_GPIO("gpios", &x3proto_gpiochip_node,		\
> +			    _gpio, GPIO_ACTIVE_LOW),			\
> +	__VA_ARGS__							\
> +	{ }								\
> +};									\
> +static const struct software_node x3proto_key##_id##_node =3D {		\
> +	.parent =3D &x3proto_gpio_keys_node,				\
> +	.properties =3D x3proto_key##_id##_props,				\
> +}
> +
> +#define X3PROTO_KEY(_id, _code, _gpio)					\
> +	__X3PROTO_KEY(_id, _code, _gpio)
> +
> +#define X3PROTO_KEY_WAKEUP(_id, _code, _gpio)				\
> +	__X3PROTO_KEY(_id, _code, _gpio,				\
> +		      PROPERTY_ENTRY_BOOL("wakeup-source"),		\
> +	)
> +
> +X3PROTO_KEY_WAKEUP(44, KEY_POWER, 0);
> +X3PROTO_KEY_WAKEUP(43, KEY_SUSPEND, 1);
> +X3PROTO_KEY(42, KEY_KATAKANAHIRAGANA, 2);
> +X3PROTO_KEY(41, KEY_SWITCHVIDEOMODE, 3);
> +X3PROTO_KEY(34, KEY_F12, 4);
> +X3PROTO_KEY(33, KEY_F11, 5);
> +X3PROTO_KEY(32, KEY_F10, 6);
> +X3PROTO_KEY(31, KEY_F9, 7);
> +X3PROTO_KEY(24, KEY_F8, 8);
> +X3PROTO_KEY(23, KEY_F7, 9);
> +X3PROTO_KEY(22, KEY_F6, 10);
> +X3PROTO_KEY(21, KEY_F5, 11);
> +X3PROTO_KEY(14, KEY_F4, 12);
> +X3PROTO_KEY(13, KEY_F3, 13);
> +X3PROTO_KEY(12, KEY_F2, 14);
> +X3PROTO_KEY(11, KEY_F1, 15);
> +
> +static const struct software_node *const x3proto_swnodes[] __initconst =
=3D {
> +	&x3proto_gpio_keys_node,
> +	&x3proto_key44_node,
> +	&x3proto_key43_node,
> +	&x3proto_key42_node,
> +	&x3proto_key41_node,
> +	&x3proto_key34_node,
> +	&x3proto_key33_node,
> +	&x3proto_key32_node,
> +	&x3proto_key31_node,
> +	&x3proto_key24_node,
> +	&x3proto_key23_node,
> +	&x3proto_key22_node,
> +	&x3proto_key21_node,
> +	&x3proto_key14_node,
> +	&x3proto_key13_node,
> +	&x3proto_key12_node,
> +	&x3proto_key11_node,
> +	NULL
>  };
> =20
> -static struct platform_device baseboard_buttons_device =3D {
> +static const struct platform_device_info x3proto_gpio_keys_device_info _=
_initconst =3D {
>  	.name		=3D "gpio-keys",
> -	.id		=3D -1,
> -	.dev		=3D {
> -		.platform_data	=3D &baseboard_buttons_data,
> -	},
> +	.id		=3D PLATFORM_DEVID_NONE,
> +	.swnode		=3D &x3proto_gpio_keys_node,
>  };
> =20
>  static struct platform_device *x3proto_devices[] __initdata =3D {
> @@ -211,7 +198,6 @@ static struct platform_device *x3proto_devices[] __in=
itdata =3D {
>  	&smc91x_device,
>  	&r8a66597_usb_host_device,
>  	&m66592_usb_peripheral_device,
> -	&baseboard_buttons_device,
>  };
> =20
>  static void __init x3proto_init_irq(void)
> @@ -224,7 +210,8 @@ static void __init x3proto_init_irq(void)
> =20
>  static int __init x3proto_devices_setup(void)
>  {
> -	int ret, i;
> +	struct platform_device *pd;
> +	int ret;
> =20
>  	/*
>  	 * IRLs are only needed for ILSEL mappings, so flip over the INTC
> @@ -239,11 +226,11 @@ static int __init x3proto_devices_setup(void)
>  	if (unlikely(ret))
>  		return ret;
> =20
> -	/*
> -	 * Propagate dynamic GPIOs for the baseboard button device.
> -	 */
> -	for (i =3D 0; i < ARRAY_SIZE(baseboard_buttons); i++)
> -		baseboard_buttons[i].gpio =3D x3proto_gpio_chip.base + i;
> +	ret =3D software_node_register_node_group(x3proto_swnodes);
> +	if (ret) {
> +		pr_err("Failed to register software nodes: %d\n", ret);
> +		return ret;
> +	}
> =20
>  	r8a66597_usb_host_resources[1].start =3D
>  		r8a66597_usb_host_resources[1].end =3D ilsel_enable(ILSEL_USBH_I);
> @@ -254,8 +241,12 @@ static int __init x3proto_devices_setup(void)
>  	smc91x_resources[1].start =3D
>  		smc91x_resources[1].end =3D ilsel_enable(ILSEL_LAN);
> =20
> -	return platform_add_devices(x3proto_devices,
> -				    ARRAY_SIZE(x3proto_devices));
> +	ret =3D platform_add_devices(x3proto_devices, ARRAY_SIZE(x3proto_device=
s));
> +	if (ret)
> +		return ret;
> +
> +	pd =3D platform_device_register_full(&x3proto_gpio_keys_device_info);
> +	return PTR_ERR_OR_ZERO(pd);
>  }
>  device_initcall(x3proto_devices_setup);
> =20

It took me some time to fully grasp the rewrite, but I think this should wo=
rk as expected.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
