From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Jan 2015 21:50:20 +0000
Subject: Re: [PATCH v2 3/4] ARM: shmobile: emev2: Add PFC information to emev2.dtsi
Message-Id: <2620818.4JADgt3ejj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1421583604-27256-1-git-send-email-niso@kth.se> <1421583604-27256-4-git-send-email-niso@kth.se>
In-Reply-To: <1421583604-27256-4-git-send-email-niso@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso@kth.se>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

Hi Niklas,

Thank you for the patch.

On Sunday 18 January 2015 13:20:03 Niklas S=F6derlund wrote:
> With this information all GPIOs can make use of the PFC functionality.
>=20
> Signed-off-by: Niklas S=F6derlund <niso@kth.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/emev2.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
> index cc7bfe0..bb45694 100644
> --- a/arch/arm/boot/dts/emev2.dtsi
> +++ b/arch/arm/boot/dts/emev2.dtsi
> @@ -169,12 +169,18 @@
>  		clock-names =3D "sclk";
>  	};
>=20
> +	pfc: pfc@e0140200 {
> +		compatible =3D "renesas,pfc-emev2";
> +		reg =3D <0xe0140200 0x100>;
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
> @@ -186,6 +192,7 @@
>  		interrupts =3D <0 69 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 70 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 32 32>;
>  		#gpio-cells =3D <2>;
>  		ngpios =3D <32>;
>  		interrupt-controller;
> @@ -197,6 +204,7 @@
>  		interrupts =3D <0 71 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 72 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 64 32>;
>  		#gpio-cells =3D <2>;
>  		ngpios =3D <32>;
>  		interrupt-controller;
> @@ -208,6 +216,7 @@
>  		interrupts =3D <0 73 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 74 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 96 32>;
>  		#gpio-cells =3D <2>;
>  		ngpios =3D <32>;
>  		interrupt-controller;
> @@ -219,6 +228,7 @@
>  		interrupts =3D <0 75 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 76 IRQ_TYPE_LEVEL_HIGH>;
>  		gpio-controller;
> +		gpio-ranges =3D <&pfc 0 128 31>;
>  		#gpio-cells =3D <2>;
>  		ngpios =3D <31>;
>  		interrupt-controller;

--=20
Regards,

Laurent Pinchart

