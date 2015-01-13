From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Jan 2015 14:27:06 +0000
Subject: Re: [PATCH 2/4] sh-pfc: Add emev2 pinmux support
Message-Id: <4306343.ZxG2x6FY5Y@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418414497-23741-1-git-send-email-niso@kth.se> <1418414497-23741-3-git-send-email-niso@kth.se>
In-Reply-To: <1418414497-23741-3-git-send-email-niso@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso@kth.se>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

Hi Niklas,

Thank you for the patch.

On Friday 12 December 2014 21:01:35 Niklas S=F6derlund wrote:
> Add PFC support for the EMMA Mobile EV2 SoC including pin groups for
> on-chip devices.
>=20
> Signed-off-by: Niklas S=F6derlund <niso@kth.se>
> ---
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
>  drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
>  drivers/pinctrl/sh-pfc/Makefile                    |    1 +
>  drivers/pinctrl/sh-pfc/core.c                      |    9 +
>  drivers/pinctrl/sh-pfc/core.h                      |    1 +
>  drivers/pinctrl/sh-pfc/pfc-emev2.c                 | 1915 ++++++++++++++=
+++
>  6 files changed, 1932 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-emev2.c

[snip]

> diff --git a/drivers/pinctrl/sh-pfc/pfc-emev2.c
> b/drivers/pinctrl/sh-pfc/pfc-emev2.c new file mode 100644
> index 0000000..22c9e15
> --- /dev/null
> +++ b/drivers/pinctrl/sh-pfc/pfc-emev2.c

[snip]

> +#define CPU_ALL_PORT(fn, sfx)						\
> +	PORT_GP_32(0, fn, sfx),						\
> +	PORT_GP_32(1, fn, sfx),						\
> +	PORT_GP_32(2, fn, sfx),						\
> +	PORT_GP_32(3, fn, sfx),						\
> +	PORT_GP_32(4, fn, sfx)

GPIOs are numbered linearly in the datasheet, not using a bank number.=20
Shouldn't that be reflected here ? Additionally the chip has 159 GPIOs, and=
=20
you define 160 of them.

[snip]

I'm afraid I can't review all the data tables, I'll trust you on that :-)

> +/* Pin numbers for pins without a corresponding GPIO port number are
> computed
> + * from the row and column numbers with a 1000 offset to avoid collisions
> with
> + * GPIO port numbers. */
> +#define PIN_NUMBER(row, col)            (1000+((row)-1)*25+(col)-1)

The chip is an 23x23 BGA, shouldn't you multiply by 23 instead of 25 ?

[snip]

> +#define EMEV_MUX_PIN(name, pin, mark) \
> +	static const unsigned int name##_pins[] =3D { pin }; \
> +	static const unsigned int name##_mux[] =3D { mark##_MARK }

[snip]

> +/* =3D [ IIC ] =3D=3D=3D=3D=3D=3D=3D */
> +EMEV_MUX_PIN(iic0_scl, 44, IIC0_SCL);
> +EMEV_MUX_PIN(iic0_sda, 45, IIC0_SDA);

[snip]

> +static const struct sh_pfc_pin_group pinmux_groups[] =3D {

[snip]

> +	SH_PFC_PIN_GROUP(iic0_scl),
> +	SH_PFC_PIN_GROUP(iic0_sda),

[snip]

> +};

[snip]

> +static const char * const iic0_groups[] =3D {
> +	"iic0_scl",
> +	"iic0_sda",
> +};

(Taking IIC0 as an example)

You're defining one pin group per pin. While this isn't an invalid decision=
,=20
the sh-pfc driver tried so far to group related pins in the same group. For=
=20
instance, with IIC0, SCL and SDA can't be used independently, so you always=
=20
need to request both. They could thus be grouped together. Is there a reaso=
n=20
not to follow the same design for EMEV2 ?

[snip]

> +static const struct sh_pfc_function pinmux_functions[] =3D {
> +	SH_PFC_FUNCTION(jtag),
> +	SH_PFC_FUNCTION(lcd),
> +	SH_PFC_FUNCTION(yuv),
> +	SH_PFC_FUNCTION(tp33),
> +	SH_PFC_FUNCTION(iic0),
> +	SH_PFC_FUNCTION(iic1),
> +	SH_PFC_FUNCTION(uart1),
> +	SH_PFC_FUNCTION(uart2),
> +	SH_PFC_FUNCTION(uart3),
> +	SH_PFC_FUNCTION(sd),
> +	SH_PFC_FUNCTION(sdi0),
> +	SH_PFC_FUNCTION(sdi1),
> +	SH_PFC_FUNCTION(sdi2),
> +	SH_PFC_FUNCTION(ab),
> +	SH_PFC_FUNCTION(dtv),
> +	SH_PFC_FUNCTION(cf),
> +	SH_PFC_FUNCTION(usi0),
> +	SH_PFC_FUNCTION(usi1),
> +	SH_PFC_FUNCTION(usi2),
> +	SH_PFC_FUNCTION(usi3),
> +	SH_PFC_FUNCTION(usi4),
> +	SH_PFC_FUNCTION(usi5),
> +	SH_PFC_FUNCTION(ntsc),
> +	SH_PFC_FUNCTION(cam),
> +	SH_PFC_FUNCTION(hsi),
> +};

Could you please order the functions alphabetically, here and above ?

[snip]

--=20
Regards,

Laurent Pinchart

