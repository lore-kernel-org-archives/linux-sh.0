Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC74F0526;
	Thu, 17 Sep 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648099; cv=none; b=QBveOFAieInZ3eEpBpwqEVCxxu3impzdQn96PbB2d4relqfPO9aanGUlAwlcxVj2QyNt0dey0sFvnVrpVFQ90rIAzul6Cdpt60sFDs8pLjufQBs4cQPFsb/38lNyW2kDW8ae2XFSi8AD/YNNJ7U3iK0aBk8z0JQmF/KnAUiy+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648099; c=relaxed/simple;
	bh=dNhv9mq4obzH55lT4kIxVd8uB+BycKnB0uQ6jBCNrw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8sEA17dyZ74Lk4nA0fbY+PLayZW0fd6xhPsc9P0cF0Rif7sRcE9wTHVLoB003cBm2bvPtQpNDX0fK/jCovht+Nn56hNtQhUx0gw8+vycfOxXUz+KRagW6Vc0lcAba9Ts0U5wPXhhHRnX8b20UIV/iv6GDKBP5UmCSjjNeyCymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gaRQMYbK; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gaRQMYbK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=GH7VmVCs4ONMESSMDsg1J1910mif7egOaATVIQHKpQE=; t=1789648093;
	x=1790252893; b=gaRQMYbK7fJaq1Jo1/B79w100BGWf07lhE/ihKnuAOzgYWfzjdNAocGfzkWGo
	P84Fk8vzp30bx3IX0irKILvl/rN8qLs2mVFnIgMowz2gu9AxRVtih0vxTXhFeYmScPcW1lSmDnU7c
	/kiZ0iBgdSY1ADPab4eGA8Whf5Cq1BxXpl9zbU1NPXhGQNu5p3iCOBnjoFpnO3z8asukrqpatg2Lj
	tc6S+6BGuZaMSKxo84653kmH7RQ5JAVWfkQAnMwknk5uvqv8+mSYffDeprj0cX6an5YkUCQ5gxQTr
	RvNwQ0TIPMk0glR2N9BWMcqvIQ5b5mmokIR1UpxauxhGBNMMyA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x7BDk-00000001wUA-0zvx; Thu, 17 Sep 2026 14:28:08 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x7BDk-000000027ri-02Af; Thu, 17 Sep 2026 14:28:08 +0200
Message-ID: <9470a0100b9f890c6ce700fad53f95f8ac07d357.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: mach-x3proto: add software node for GPIO
 controller
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>,  Arnd Bergmann	 <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 14:28:07 +0200
In-Reply-To: <20260704-sh-x3proto-swnode-v1-1-0c039549dc46@gmail.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
	 <20260704-sh-x3proto-swnode-v1-1-0c039549dc46@gmail.com>
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
> We want to convert the legacy gpio-keys platform device on the SH-X3
> Prototype board to use software nodes. To do this properly and allow
> referencing the GPIO controller by address rather than relying on
> name-based matching (which is being removed from the gpiolib core),
> we need to associate the GPIO controller with a software node.
>=20
> Introduce x3proto_gpiochip_node, register it, and associate it with
> x3proto_gpio_chip.
>=20
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/sh/boards/mach-x3proto/gpio.c           | 15 ++++++++++++++-
>  arch/sh/include/mach-x3proto/mach/hardware.h |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3p=
roto/gpio.c
> index c13d51b29702..a09cafc782b4 100644
> --- a/arch/sh/boards/mach-x3proto/gpio.c
> +++ b/arch/sh/boards/mach-x3proto/gpio.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <mach/ilsel.h>
>  #include <mach/hardware.h>
> +#include <linux/property.h>
> =20
>  #define KEYCTLR	0xb81c0000
>  #define KEYOUTR	0xb81c0002
> @@ -73,6 +74,10 @@ static void x3proto_gpio_irq_handler(struct irq_desc *=
desc)
>  	chip->irq_unmask(data);
>  }
> =20
> +const struct software_node x3proto_gpiochip_node =3D {
> +	.name =3D "x3proto-gpio",
> +};
> +
>  struct gpio_chip x3proto_gpio_chip =3D {
>  	.label			=3D "x3proto-gpio",
>  	.direction_input	=3D x3proto_gpio_direction_input,
> @@ -104,9 +109,15 @@ int __init x3proto_gpio_setup(void)
>  	if (unlikely(ilsel < 0))
>  		return ilsel;
> =20
> +	ret =3D software_node_register(&x3proto_gpiochip_node);
> +	if (ret)
> +		goto err_gpio;
> +
> +	x3proto_gpio_chip.fwnode =3D software_node_fwnode(&x3proto_gpiochip_nod=
e);
> +
>  	ret =3D gpiochip_add_data(&x3proto_gpio_chip, NULL);
>  	if (unlikely(ret))
> -		goto err_gpio;
> +		goto err_swnode;
> =20
>  	x3proto_irq_domain =3D irq_domain_create_linear(NULL, NR_BASEBOARD_GPIO=
S,
>  						   &x3proto_gpio_irq_ops, NULL);
> @@ -127,6 +138,8 @@ int __init x3proto_gpio_setup(void)
>  err_irq:
>  	gpiochip_remove(&x3proto_gpio_chip);
>  	ret =3D 0;
> +err_swnode:
> +	software_node_unregister(&x3proto_gpiochip_node);
>  err_gpio:
>  	synchronize_irq(ilsel);
> =20
> diff --git a/arch/sh/include/mach-x3proto/mach/hardware.h b/arch/sh/inclu=
de/mach-x3proto/mach/hardware.h
> index 57ea4a5cca35..1ee5a404973c 100644
> --- a/arch/sh/include/mach-x3proto/mach/hardware.h
> +++ b/arch/sh/include/mach-x3proto/mach/hardware.h
> @@ -3,10 +3,12 @@
>  #define __MACH_X3PROTO_HARDWARE_H
> =20
>  struct gpio_chip;
> +struct software_node;
> =20
>  /* arch/sh/boards/mach-x3proto/gpio.c */
>  int x3proto_gpio_setup(void);
>  extern struct gpio_chip x3proto_gpio_chip;
> +extern const struct software_node x3proto_gpiochip_node;
> =20
>  #define NR_BASEBOARD_GPIOS	16
> =20

Looks good to me, will pick this up for v7.4.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Reviewing part 2 will take slightly longer due to the size of the changes.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
