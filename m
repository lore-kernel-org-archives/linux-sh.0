From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Feb 2016 18:43:06 +0000
Subject: Re: [PATCH v3 1/2] pinctrl: sh-pfc: Improve pinmux macros documentation
Message-Id: <4029813.xaXaFntOiW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1448890332-773-1-git-send-email-geert+renesas@glider.be> <1448890332-773-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448890332-773-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 30 November 2015 14:32:11 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v3:
>   - Add Acked-by,
>   - Document function names referring to IPSR fields,
>   - Replace "configuration register" by more specific terms,
>   - Rename "ms" to "msel" or "gsel",
>   - EMEV2 PINMUX_IPSR_NOFN() pinmux configurations have a GPIO function,
> 
> v2:
>   - Clarify same width vs. different widths,
>   - Mention GPSR for PINMUX_IPSR_DATA(),
>   - Document NOGM (= NOGP + MSEL),
>   - Fix s/ispr/ipsr/ typos.
> ---
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 94 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 6b8180fbdf86a637..d430ee9a652a4a03
> 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -100,10 +100,31 @@ struct pinmux_cfg_reg {
>  	const u8 *var_field_width;
>  };
> 
> +/*
> + * Describe a config register consisting of several fields of the same
> width
> + *   - name: Register name (unused, for documentation purposes only)
> + *   - r: Physical register address
> + *   - r_width: Width of the register (in bits)
> + *   - f_width: Width of the fixed-width register fields (in bits)
> + * This macro must be followed by initialization data: For each register
> field
> + * (from left to right, i.e. MSB to LSB), 2^f_width enum IDs must be
> specified,
> + * one for each possible combination of the register field bit values.
> + */
>  #define PINMUX_CFG_REG(name, r, r_width, f_width) \
>  	.reg = r, .reg_width = r_width, .field_width = f_width,		\
>  	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])
> 
> +/*
> + * Describe a config register consisting of several fields of different
> widths
> + *   - name: Register name (unused, for documentation purposes only)
> + *   - r: Physical register address
> + *   - r_width: Width of the register (in bits)
> + *   - var_fw0, var_fwn...: List of widths of the register fields (in
> bits),
> + *                          From left to right (i.e. MSB to LSB)
> + * This macro must be followed by initialization data: For each register
> field
> + * (from left to right, i.e. MSB to LSB), 2^var_fwi enum IDs must be
> specified,
> + * one for each possible combination of the register field bit values.
> + */
>  #define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
>  	.reg = r, .reg_width = r_width,	\
>  	.var_field_width = (const u8 [r_width]) \
> @@ -116,6 +137,14 @@ struct pinmux_data_reg {
>  	const u16 *enum_ids;
>  };
> 
> +/*
> + * Describe a data register
> + *   - name: Register name (unused, for documentation purposes only)
> + *   - r: Physical register address
> + *   - r_width: Width of the register (in bits)
> + * This macro must be followed by initialization data: For each register
> bit
> + * (from left to right, i.e. MSB to LSB), one enum ID must be specified.
> + */
>  #define PINMUX_DATA_REG(name, r, r_width) \
>  	.reg = r, .reg_width = r_width,	\
>  	.enum_ids = (const u16 [r_width]) \
> @@ -124,6 +153,10 @@ struct pinmux_irq {
>  	const short *gpios;
>  };
> 
> +/*
> + * Describe the mapping from GPIOs to a single IRQ
> + *   - ids...: List of GPIOs that are mapped to the same IRQ
> + */
>  #define PINMUX_IRQ(ids...)			   \
>  	{ .gpios = (const short []) { ids, -1 } }
> 
> @@ -185,18 +218,63 @@ struct sh_pfc_soc_info {
>   * sh_pfc_soc_info pinmux_data array macros
>   */
> 
> +/*
> + * Describe generic pinmux data
> + *   - data_or_mark: *_DATA or *_MARK enum ID
> + *   - ids...: List of enum IDs to associate with data_or_mark
> + */
>  #define PINMUX_DATA(data_or_mark, ids...)	data_or_mark, ids, 0
> 
> -#define PINMUX_IPSR_NOGP(ispr, fn)					\
> +/*
> + * Describe a pinmux configuration without GPIO function that needs
> + * configuration in a Peripheral Function Select Register (IPSR)
> + *   - ipsr: IPSR field (unused, for documentation purposes only)
> + *   - fn: Function name, referring to a field in the IPSR
> + */
> +#define PINMUX_IPSR_NOGP(ipsr, fn)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn)
> +
> +/*
> + * Describe a pinmux configuration with GPIO function that needs
> configuration
> + * in both a Peripheral Function Select Register (IPSR) and in a
> + * GPIO/Peripheral Function Select Register 1 (GPSR)

s/Register 1/Register/ ?

> + *   - ipsr: IPSR field
> + *   - fn: Function name, also referring to the IPSR field
> + */
>  #define PINMUX_IPSR_DATA(ipsr, fn)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr)
> -#define PINMUX_IPSR_NOGM(ispr, fn, ms)					\
> -	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ms)
> -#define PINMUX_IPSR_NOFN(ipsr, fn, ms)					\
> -	PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)
> -#define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
> -	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
> +
> +/*
> + * Describe a pinmux configuration without GPIO function that needs
> + * configuration in a Peripheral Function Select Register (IPSR), and where
> the
> + * pinmux function has a representation in a Module Select Register
> (MOD_SEL).
> + *   - ipsr: IPSR field

To be consistent with the NOGP macro,

 *   - ipsr: IPSR field (unused, for documentation purposes only)

> + *   - fn: Function name, also referring to the IPSR field
> + *   - msel: Module selector
> + */
> +#define PINMUX_IPSR_NOGM(ipsr, fn, msel)				\
> +	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##msel)
> +
> +/*
> + * Describe a pinmux configuration with GPIO function where the pinmux
> function
> + * has no representation in a Peripheral Function Select Register (IPSR),
> but
> + * instead solely depends on a group selection.
> + *   - gpsr: GPSR field
> + *   - fn: Function name, also referring to the GPSR field
> + *   - gsel: Group selector
> + */
> +#define PINMUX_IPSR_NOFN(gpsr, fn, gsel)				\
> +	PINMUX_DATA(fn##_MARK, FN_##gpsr, FN_##gsel)
> +
> +/*
> + * Describe a pinmux configuration where the pinmux function has a
> + * representation in a Module Select Register (MOD_SEL).

If I'm not mistaken this macro is used for pins that are controlled through 
all three of IPSR, GPSR and MSEL. How about

 * Describe a pinmux configuration with GPIO function that needs configuration
 * in both a Peripheral Function Select Register (IPSR) and a GPIO/Peripheral
 * Function Select Register (GPSR), and where the pinmux function has a
 * representation in a Module Select Register (MOD_SEL).

With those changes,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> + *   - ipsr: IPSR field
> + *   - fn: Function name, also referring to the IPSR field
> + *   - msel: Module selector
> + */
> +#define PINMUX_IPSR_MSEL(ipsr, fn, msel)				\
> +	PINMUX_DATA(fn##_MARK, FN_##msel, FN_##ipsr, FN_##fn)
> 
>  /*
>   * Describe a pinmux configuration for a single-function pin.
> @@ -334,7 +412,7 @@ struct sh_pfc_soc_info {
>  	PINMUX_GPIO_FN(GPIO_FN_##str, PINMUX_FN_BASE, str##_MARK)
> 
>  /*
> - * PORTnCR macro
> + * PORTnCR helper macro for SH-Mobile/R-Mobile
>   */
>  #define PORTCR(nr, reg)							\
>  	{								\

-- 
Regards,

Laurent Pinchart

