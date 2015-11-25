From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Nov 2015 01:37:57 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: Improve pinmux macros documentation
Message-Id: <7920206.k8fTIRXnzu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1445368482-24278-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445368482-24278-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso@kth.se>, Koji Matsuoka <koji.matsuoka.xm@rms.renesas.com>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Tuesday 20 October 2015 21:14:42 Geert Uytterhoeven wrote:
> Fix some s/ispr/ipsr/ typos in macro parameters while we're at it.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Clarify same width vs. different widths,
>   - Mention GPSR for PINMUX_IPSR_DATA(),
>   - Document NOGM (=3D NOGP + MSEL),
>   - Fix s/ispr/ipsr/ typos.
> ---
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 84 +++++++++++++++++++++++++++++++++++=
+--
>  1 file changed, 81 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 7b373d43d981899f..63e6cd050d0fb7d2
> 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -100,10 +100,31 @@ struct pinmux_cfg_reg {
>  	const u8 *var_field_width;
>  };
>=20
> +/*
> + * Describe a config register consisting of several fields of the same
> width + *   - name: Register name (unused, for documentation purposes onl=
y)
> + *   - r: Physical register address
> + *   - r_width: Width of the register (in bits)
> + *   - f_width: Width of the fixed-width register fields (in bits)
> + * This macro must be followed by initialization data: For each register
> field + * (from left to right, i.e. MSB to LSB), 2^f_width enum IDs must =
be
> specified, + * one for each possible combination of the register field bit
> values. + */
>  #define PINMUX_CFG_REG(name, r, r_width, f_width) \
>  	.reg =3D r, .reg_width =3D r_width, .field_width =3D f_width,		\
>  	.enum_ids =3D (const u16 [(r_width / f_width) * (1 << f_width)])
>=20
> +/*
> + * Describe a config register consisting of several fields of different
> widths + *   - name: Register name (unused, for documentation purposes
> only) + *   - r: Physical register address
> + *   - r_width: Width of the register (in bits)
> + *   - var_fw0, var_fwn...: List of widths of the register fields (in
> bits), + *                          From left to right (i.e. MSB to LSB)
> + * This macro must be followed by initialization data: For each register
> field + * (from left to right, i.e. MSB to LSB), 2^var_fwi enum IDs must =
be
> specified, + * one for each possible combination of the register field bit
> values. + */
>  #define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
>  	.reg =3D r, .reg_width =3D r_width,	\
>  	.var_field_width =3D (const u8 [r_width]) \
> @@ -116,6 +137,14 @@ struct pinmux_data_reg {
>  	const u16 *enum_ids;
>  };
>=20
> +/*
> + * Describe a data register
> + *   - name: Register name (unused, for documentation purposes only)
> + *   - r: Physical register address
> + *   - r_width: Width of the register (in bits)
> + * This macro must be followed by initialization data: For each register
> bit + * (from left to right, i.e. MSB to LSB), one enum ID must be
> specified. + */
>  #define PINMUX_DATA_REG(name, r, r_width) \
>  	.reg =3D r, .reg_width =3D r_width,	\
>  	.enum_ids =3D (const u16 [r_width]) \
> @@ -124,6 +153,10 @@ struct pinmux_irq {
>  	const short *gpios;
>  };
>=20
> +/*
> + * Describe the mapping from GPIOs to a single IRQ
> + *   - ids...: List of GPIOs that are mapped to the same IRQ
> + */
>  #define PINMUX_IRQ(ids...)			   \
>  	{ .gpios =3D (const short []) { ids, -1 } }
>=20
> @@ -185,16 +218,61 @@ struct sh_pfc_soc_info {
>   * sh_pfc_soc_info pinmux_data array macros
>   */
>=20
> +/*
> + * Describe generic pinmux data
> + *   - data_or_mark: *_DATA or *_MARK enum ID
> + *   - ids...: List of enum IDs to associate with data_or_mark
> + */
>  #define PINMUX_DATA(data_or_mark, ids...)	data_or_mark, ids, 0
>=20
> -#define PINMUX_IPSR_NOGP(ispr, fn)					\
> +/*
> + * Describe a pinmux configuration without GPIO function that needs
> + * configuration in a Peripheral Function Select Register (IPSR)
> + *   - ipsr: IPSR field (unused, for documentation purposes only)
> + *   - fn: Function name
> + */
> +#define PINMUX_IPSR_NOGP(ipsr, fn)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn)

That's very confusing, as the ipsr argument is indeed unused, but the fn=20
argument refers to a field value in an IPSR register. Could we fix that ? T=
he=20
same comment applies for other macros below.

> +
> +/*
> + * Describe a pinmux configuration with GPIO function that needs
> configuration
> + * in both a Peripheral Function Select Register (IPSR) and in a
> + * GPIO/Peripheral Function Select Register 1 (GPSR)
> + *   - ipsr: IPSR field
> + *   - fn: Function name
> + */
>  #define PINMUX_IPSR_DATA(ipsr, fn)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr)

Should we rename this to PINMUX_IPSR_GPSR ?

> -#define PINMUX_IPSR_NOGM(ispr, fn, ms)					\
> +
> +/*
> + * Describe a pinmux configuration without GPIO function that needs
> + * configuration in a Peripheral Function Select Register (IPSR), and wh=
ere
> the
> + * pinmux function has a representation in a configuration register.

I'd talk about module select register instead of configuration register.=20
Configuration register is too vague.

> + *   - ipsr: IPSR field
> + *   - fn: Function name
> + *   - ms: Configuration register selector

I'd rename ms to msel to be more explicit.

> + */
> +#define PINMUX_IPSR_NOGM(ipsr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ms)
> +
> +/*
> + * Describe a pinmux configuration where the pinmux function has no
> + * representation in the configuration registers but instead solely
> + * depends on a group selection.
> + *   - ipsr: IPSR field
> + *   - fn: Function name
> + *   - ms: Group selector
> + */
>  #define PINMUX_IPSR_NOFN(ipsr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)

Those pins can be used as GPIO as well, right ? I think that should be=20
mentioned.

The macro is used for emev2 only. It refers to a GPSR bit, not to an IPSR=20
register. I think the ipsr argument should be renamed to reflect that.

> +
> +/*
> + * Describe a pinmux configuration where the pinmux function has a
> + * representation in a configuration register.

You mention "configuration register" here (and in the PINMUX_IPSR_NOGM=20
description), while you talk about "group selector" for PINMUX_IPSR_NOFN.=20
Aren't they the same ?=20

> + *   - ipsr: IPSR field
> + *   - fn: Function name
> + *   - ms: Configuration register selector
> + */
>  #define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
>=20
> @@ -327,7 +405,7 @@ struct sh_pfc_soc_info {
>  	PINMUX_GPIO_FN(GPIO_FN_##str, PINMUX_FN_BASE, str##_MARK)
>=20
>  /*
> - * PORTnCR macro
> + * PORTnCR helper macro for SH-Mobile/R-Mobile
>   */
>  #define PORTCR(nr, reg)							\
>  	{								\

As the comments I've made here have an air of d=E9j=E0 vu, I checked my rev=
iew to=20
v1 and realized you haven't replied to it. I don't think all the comments I=
=20
made have been addressed in v2.

--=20
Regards,

Laurent Pinchart

