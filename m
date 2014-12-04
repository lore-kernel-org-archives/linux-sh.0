From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 07:21:55 +0000
Subject: Re: [PATCH 02/02] ARM: shmobile: marzen-reference: Remove IRLM workaround
Message-Id: <20141204072153.GE25806@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203121753.5936.36253.sendpatchset@w520>
 <20141203121813.5936.17433.sendpatchset@w520>
In-Reply-To: <20141203121813.5936.17433.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net

Hi Magnus,

On Wed, Dec 03, 2014 at 09:18:13PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>=20
> Adjust the r8a7779 SoC DTS and the Marzen Reference
> C board code to use DTS only for INTC-IRQPIN IRLM setup.
>=20
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>=20
>  Written on top of renesas-devel-20141202-v3.18-rc7 and
>  [PATCH] ARM: shmobile: r8a7779 CCF DTS update
>=20
>  Has a runtime dependency on:
>  [PATCH 01/02] irqchip: renesas-intc-irqpin: r8a7779 IRLM setup support
>=20
>  arch/arm/boot/dts/r8a7779.dtsi                  |    5 +++--
>  arch/arm/mach-shmobile/board-marzen-reference.c |    7 -------
>  2 files changed, 3 insertions(+), 9 deletions(-)
>=20
> --- 0002/arch/arm/boot/dts/r8a7779.dtsi
> +++ work/arch/arm/boot/dts/r8a7779.dtsi	2014-12-03 20:27:49.000000000 +09=
00
> @@ -139,7 +139,7 @@
>  		interrupt-controller;
>  	};
> =20
> -	irqpin0: irqpin@fe780010 {
> +	irqpin0: irqpin@fe780000 {
>  		compatible =3D "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
>  		#interrupt-cells =3D <2>;
>  		status =3D "disabled";
> @@ -148,7 +148,8 @@
>  			<0xfe780010 4>,
>  			<0xfe780024 4>,
>  			<0xfe780044 4>,
> -			<0xfe780064 4>;
> +			<0xfe780064 4>,
> +			<0xfe780000 4>;

Is there any order implied by the above list?
Na=C3=AFvely I would expect it to be sorted numerically.

>  		interrupts =3D <0 27 IRQ_TYPE_LEVEL_HIGH
>  			      0 28 IRQ_TYPE_LEVEL_HIGH
>  			      0 29 IRQ_TYPE_LEVEL_HIGH
> --- 0001/arch/arm/mach-shmobile/board-marzen-reference.c
> +++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2014-12-03 20:28=
:37.000000000 +0900
> @@ -32,12 +32,6 @@ static void __init marzen_init_timer(voi
>  	clocksource_of_init();
>  }
> =20
> -static void __init marzen_init(void)
> -{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
> -}
> -
>  static const char *marzen_boards_compat_dt[] __initdata =3D {
>  	"renesas,marzen",
>  	"renesas,marzen-reference",
> @@ -50,7 +44,6 @@ DT_MACHINE_START(MARZEN, "marzen")
>  	.init_early	=3D shmobile_init_delay,
>  	.init_time	=3D marzen_init_timer,
>  	.init_irq	=3D r8a7779_init_irq_dt,
> -	.init_machine	=3D marzen_init,
>  	.init_late	=3D shmobile_init_late,
>  	.dt_compat	=3D marzen_boards_compat_dt,
>  MACHINE_END
>=20
