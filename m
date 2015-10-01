From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Oct 2015 14:21:37 +0000
Subject: Re: [PATCH] [RFC] pinctrl: sh-pfc: Improve pinmux macros documentation
Message-Id: <2076556.DQZeNT6qkv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1443017673-12311-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443017673-12311-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso@kth.se>, Koji Matsuoka <koji.matsuoka.xm@rms.renesas.com>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch. This was much needed.

On Wednesday 23 September 2015 16:14:33 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Please review and comment!
> 
>   - I still have a hard time understanding the subtilties of the various
>     PINMUX_IPSR_*() macros,

So do we all :-)

>   - Which macro is most appropriate for describing single-function pins:
>     PINMUX_DATA() or PINMUX_IPSR_NOGP()?
>     (cfr. "[RFC] pinctrl: sh-pfc: r8a7795: Add pinmux data for
>      single-function pins",
>      http://www.spinics.net/lists/linux-sh/msg44823.html)
> 
> Thanks!
> ---
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 77 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index e18e306b4ac276c7..434209c8e22e72fc
> 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -95,10 +95,31 @@ struct pinmux_cfg_reg {
>  	const u8 *var_field_width;
>  };
> 
> +/*
> + * Describe a config register consisting of multiple fixed-width fields

Slightly nitpicking: instead of fixed-width I'd say

"Describe a config register consisting of several fields of the same width"

This is more important for the variable-width fields in the documentation of 
the PINMUX_CFG_REG_VAR macro, as variable-width could be understood as fields 
which length varies at runtime. For that register I would say

"Describe a config register consisting of several fields of different widths"

Feel free to ignore this comment if you think it's overkill.

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
> + * Describe a config register consisting of multiple variable-width fields
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
> @@ -111,6 +132,14 @@ struct pinmux_data_reg {
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
> @@ -119,6 +148,10 @@ struct pinmux_irq {
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
> @@ -180,16 +213,58 @@ struct sh_pfc_soc_info {
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
> +/*
> + * Describe a pinmux configuration without GPIO function that needs
> + * configuration in a Peripheral Function Select Register (IPSR)
> + *   - ipsr: IPSR field (unused, for documentation purposes only)
> + *   - fn: Function name
> + */
>  #define PINMUX_IPSR_NOGP(ispr, fn)					\

While you're at it, could you s/ispr/ipsr/ ?

>  	PINMUX_DATA(fn##_MARK, FN_##fn)
> +
> +/*
> + * Describe a pinmux configuration with GPIO function that needs
> configuration
> + * in a Peripheral Function Select Register (IPSR)
> + *   - ipsr: IPSR field
> + *   - fn: Function name
> + */
>  #define PINMUX_IPSR_DATA(ipsr, fn)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr)

This one is confusing. While ipsr refers to the name of an IPSR field, that's 
for documentation purpose only (the IPSR fields are not named in the code but 
they're mentioned in comments in the IPSR register definitions). After 
expansion FN_##ipsr refers to a field value of a GSPR register. For instance

	PINMUX_IPSR_DATA(IP0_0, D0)

will expand to

	D0_MARK, FN_D0, FN_IP0_0

When applying that configuration FN_D0 will set the IPSR bits to select the D0 
function, while FN_IP0_0 will set the GSPR bits to set the pin mux to function 
instead of GPIO.

I wonder whether we should rename the macros to make their purpose clearer. 
This one should really convey the above meaning explicitly using a name that 
shows that both a GPIO/function mux and a function selector mux are used.

> +
> +/*
> + * Describe a pinmux configuration where ???
> + *   - ipsr: IPSR field
> + *   - fn: Function name
> + *   - ms: Configuration register selector
> + */
>  #define PINMUX_IPSR_NOGM(ispr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ms)

MSEL adds another muxing level that muxes modules as a whole instead of 
individual pins. I'm not sure exactly how it's wired up at the hardware level. 
It would be interesting to find out the exact hardware structure of the pin 
muxes to hopefully better name (and possibly structure) the driver constructs.

PINMUX_IPSR_NOGM really means PINMUX_IPSR_NOGP_MSEL, but that would be longer.

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

That macro is used by EMEV2 only. Maybe we could move it there.

> +/*
> + * Describe a pinmux configuration where the pinmux function has a
> + * representation in a configuration register.
> + *   - ipsr: IPSR field
> + *   - fn: Function name
> + *   - ms: Configuration register selector
> + */
>  #define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
> 
> @@ -322,7 +397,7 @@ struct sh_pfc_soc_info {
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

