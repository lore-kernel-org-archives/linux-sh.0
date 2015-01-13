From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Jan 2015 14:45:59 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: emev2: Add PFC information to emev2.dtsi
Message-Id: <1701639.rHDfQqXMRy@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418414497-23741-1-git-send-email-niso@kth.se> <1418414497-23741-4-git-send-email-niso@kth.se>
In-Reply-To: <1418414497-23741-4-git-send-email-niso@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso@kth.se>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

Hi Niklas,

Thank you for the patch.

On Friday 12 December 2014 21:01:36 Niklas S=F6derlund wrote:
> With this information all GPIOs can make use of the PFC functionality.
>=20
> Signed-off-by: Niklas S=F6derlund <niso@kth.se>
> ---
>  arch/arm/boot/dts/emev2.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
> index cc7bfe0..518b7fa 100644
> --- a/arch/arm/boot/dts/emev2.dtsi
> +++ b/arch/arm/boot/dts/emev2.dtsi
> @@ -169,12 +169,19 @@
>  		clock-names =3D "sclk";
>  	};
>=20
> +	pfc: pfc@e0140200 {
> +		compatible =3D "renesas,pfc-emev2";
> +		reg =3D <0xe0140200 0x14>, <0xe0140284 0xc>,
> +			<0xe0140294 0x8>, <0xe01402a8 0x4>;

I think a single reg entry set to <0xe0140200 0x100> should be enough.

> +	};
> +
>  	gpio0: gpio@e0050000 {
>  		compatible =3D "renesas,em-gio";
>  		reg =3D <0xe0050000 0x2c>, <0xe0050040 0x20>;
>  		interrupts =3D <0 67 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 68 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 0 32>;
>  		#gpio-cells =3D <2>;
>  		ngpios =3D <32>;
>  		interrupt-controller;
> @@ -186,6 +193,7 @@
>  		interrupts =3D <0 69 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 70 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 32 32>;
>  		#gpio-cells =3D <2>;
>  		ngpios =3D <32>;
>  		interrupt-controller;
> @@ -197,6 +205,7 @@
>  		interrupts =3D <0 71 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 72 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 64 32>;
>  		#gpio-cells =3D <2>;
>  		ngpios =3D <32>;
>  		interrupt-controller;
> @@ -208,6 +217,7 @@
>  		interrupts =3D <0 73 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 74 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 96 32>;
>  		#gpio-cells =3D <2>;
>  		ngpios =3D <32>;
>  		interrupt-controller;
> @@ -219,6 +229,7 @@
>  		interrupts =3D <0 75 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 76 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 128 32>;

Shouldn't this be <&pfc 0 128 31>; ?

>  		#gpio-cells =3D <2>;
>  		ngpios =3D <31>;
>  		interrupt-controller;

--=20
Regards,

Laurent Pinchart

