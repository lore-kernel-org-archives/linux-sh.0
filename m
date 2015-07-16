From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Jul 2015 08:41:42 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Convert to platform_get_*()
Message-Id: <1971413.ULIg8n17Hy@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1435225193-10078-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435225193-10078-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 25 June 2015 11:39:53 Geert Uytterhoeven wrote:
> If the pin function controller (which can be a GPIO controller) is
> instantiated before the interrupt controllers, due to the ordering in
> the DTS, the irq domains for the interrupt controllers referenced by its
> "interrupts-extended" property cannot be found yet:
>=20
>     irq: no irq domain found for /interrupt-controller@e61c0000 !
>=20
> As the sh-pfc driver accesses the platform device's resources directly,
> it cannot find the (optional) IRQ resources, and thinks no interrupts
> are available. This may lead to failures later, when GPIOs are used as
> interupts:
>=20
>     gpio-keys keyboard: Unable to claim irq 0; error -22
>     gpio-keys: probe of keyboard failed with error -22
>=20
> To fix this, add support for deferred probing to sh-pfc, by converting
> the driver from direct platform device resource access to using the
> platform_get_resource() and platform_get_irq() helpers.
>=20
> Note that while this fixes the root cause worked around by commit
> e4ba0a9bddff3ba5 ("ARM: shmobile: r8a73a4: Move pfc node to work around
> probe ordering bug"), I strongly recommend against reverting the
> workaround now, as this would lead to lots of probe deferrals in drivers
> relying on pinctrl. This may be reconsidered once the DT code starts
> taking into account phandle dependencies during device instantation.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This patch is against next-20150625
>=20
> "[PATCH] [RFC] OF: probe order dependency aware of_platform_populate"
> (https://www.marc.info/?l=DEvicetree&m=141873189825553&w=3D1) is a first
> step, but it doesn't postpone the instantiation of the pfc.
>=20
> Tested:
>   - r8a73a4/ape6evm (with pfc before/after irqc in DT),
>   - sh73a0/kzm9g (with pfc before/after intc-irqpin in DT).
>=20
> Regression-tested:
>   - r8a7791/koelsch (pfc doesn't have interrupts),
>   - r8a7740/armadillo (pfc after intc-irqpin in DT),
>   - r8a7740/armadillo-legacy (gpio-keys wired to pfc),
>   - sh73a0/kzm9g-legacy (gpio-keys not wired to pfc).
>=20
> Compile-tested:
>   - sh/se7724_defconfig.
> ---
>  drivers/pinctrl/sh-pfc/core.c | 46 ++++++++++++++++++-------------------=
---
>  1 file changed, 21 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 865d235612c5200a..9796238959047508 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -29,24 +29,25 @@
>  static int sh_pfc_map_resources(struct sh_pfc *pfc,
>  				struct platform_device *pdev)
>  {
> -	unsigned int num_windows =3D 0;
> -	unsigned int num_irqs =3D 0;
> +	unsigned int num_windows, num_irqs;
>  	struct sh_pfc_window *windows;
>  	unsigned int *irqs =3D NULL;
>  	struct resource *res;
>  	unsigned int i;
> +	int irq;
>=20
>  	/* Count the MEM and IRQ resources. */
> -	for (i =3D 0; i < pdev->num_resources; ++i) {
> -		switch (resource_type(&pdev->resource[i])) {
> -		case IORESOURCE_MEM:
> -			num_windows++;
> +	for (num_windows =3D 0;; num_windows++) {

Just a bit of nit-picking, I'd add a space between the two ; (same for the =

next loop).

> +		res =3D platform_get_resource(pdev, IORESOURCE_MEM, num_windows);
> +		if (!res)
>  			break;
> -
> -		case IORESOURCE_IRQ:
> -			num_irqs++;
> +	}

And a blank line here.

The rest looks fine to me.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	for (num_irqs =3D 0;; num_irqs++) {
> +		irq =3D platform_get_irq(pdev, num_irqs);
> +		if (irq =3D -EPROBE_DEFER)
> +			return irq;
> +		if (irq < 0)
>  			break;
> -		}
>  	}
>=20
>  	if (num_windows =3D 0)
> @@ -72,22 +73,17 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
>  	}
>=20
>  	/* Fill them. */
> -	for (i =3D 0, res =3D pdev->resource; i < pdev->num_resources; i++, res=
++) {
> -		switch (resource_type(res)) {
> -		case IORESOURCE_MEM:
> -			windows->phys =3D res->start;
> -			windows->size =3D resource_size(res);
> -			windows->virt =3D devm_ioremap_resource(pfc->dev, res);
> -			if (IS_ERR(windows->virt))
> -				return -ENOMEM;
> -			windows++;
> -			break;
> -
> -		case IORESOURCE_IRQ:
> -			*irqs++ =3D res->start;
> -			break;
> -		}
> +	for (i =3D 0; i < num_windows; i++) {
> +		res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		windows->phys =3D res->start;
> +		windows->size =3D resource_size(res);
> +		windows->virt =3D devm_ioremap_resource(pfc->dev, res);
> +		if (IS_ERR(windows->virt))
> +			return -ENOMEM;
> +		windows++;
>  	}
> +	for (i =3D 0; i < num_irqs; i++)
> +		*irqs++ =3D platform_get_irq(pdev, i);
>=20
>  	return 0;
>  }

--=20
Regards,

Laurent Pinchart

