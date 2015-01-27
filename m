From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 27 Jan 2015 20:35:22 +0000
Subject: Re: [PATCH v2 4/4] ARM: shmobile: emev2-kzm9d: Add PFC information for uart1
Message-Id: <2057603.FzjFJsB71b@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1421583604-27256-1-git-send-email-niso@kth.se> <1421583604-27256-5-git-send-email-niso@kth.se>
In-Reply-To: <1421583604-27256-5-git-send-email-niso@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso@kth.se>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

Hi Niklas,

Thank you for the patch.

On Sunday 18 January 2015 13:20:04 Niklas S=F6derlund wrote:
> Configure the pinmux on kzm9d to use the serial connector for uart1.
>=20
> Signed-off-by: Niklas S=F6derlund <niso@kth.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/emev2-kzm9d.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts
> b/arch/arm/boot/dts/emev2-kzm9d.dts index 667d323..1944627 100644
> --- a/arch/arm/boot/dts/emev2-kzm9d.dts
> +++ b/arch/arm/boot/dts/emev2-kzm9d.dts
> @@ -94,3 +94,16 @@
>  		vdd33a-supply =3D <&reg_3p3v>;
>  	};
>  };
> +
> +&pfc {
> +	uart1_pins: uart@e1030000 {
> +		renesas,groups =3D "uart1_ctrl", "uart1_data";
> +		renesas,function =3D "uart1";
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-0 =3D <&uart1_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};

--=20
Regards,

Laurent Pinchart

