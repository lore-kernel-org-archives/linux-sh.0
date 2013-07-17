From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 17 Jul 2013 11:15:35 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: Add i2c pin groups
Message-Id: <4243338.UO4WsQvkPE@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1374058848-6823-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1374058848-6823-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,

Thanks for the patch.

On Wednesday 17 July 2013 12:00:48 Phil Edworthy wrote:
> Add all I2C pin groups to R8A7779 PFC driver.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'll take this in my tree and will send a pull request to Linus for the 
pinctrl tree. Please let me know if you plan to send patches that will depend 
on this one through Simon's tree, in which case I'll ask Linus to provide a 
stable branch.

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  105 +++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index 8e22ca6..777795b 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> @@ -1731,6 +1731,79 @@ static const unsigned int hspi2_b_pins[] = {
>  static const unsigned int hspi2_b_mux[] = {
>  	HSPI_CLK2_B_MARK, HSPI_CS2_B_MARK, HSPI_RX2_B_MARK, HSPI_TX2_B_MARK,
>  };
> +/* - I2C1
> ------------------------------------------------------------------ */
> +static const unsigned int i2c1_pins[] = {
> +	/* SCL, SDA, */
> +	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28),
> +};
> +static const unsigned int i2c1_mux[] = {
> +	SCL1_MARK, SDA1_MARK,
> +};
> +static const unsigned int i2c1_b_pins[] = {
> +	/* SCL, SDA, */
> +	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 11),
> +};
> +static const unsigned int i2c1_b_mux[] = {
> +	SCL1_B_MARK, SDA1_B_MARK,
> +};
> +static const unsigned int i2c1_c_pins[] = {
> +	/* SCL, SDA, */
> +	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 13),
> +};
> +static const unsigned int i2c1_c_mux[] = {
> +	SCL1_C_MARK, SDA1_C_MARK,
> +};
> +static const unsigned int i2c1_d_pins[] = {
> +	/* SCL, SDA, */
> +	RCAR_GP_PIN(1, 26), RCAR_GP_PIN(1, 27),
> +};
> +static const unsigned int i2c1_d_mux[] = {
> +	SCL1_D_MARK, SDA1_D_MARK,
> +};
> +/* - I2C2
> ------------------------------------------------------------------ */
> +static const unsigned int i2c2_pins[] = {
> +	/* SCL, SDA, */
> +	RCAR_GP_PIN(0, 25), RCAR_GP_PIN(0, 26),
> +};
> +static const unsigned int i2c2_mux[] = {
> +	SCL2_MARK, SDA2_MARK,
> +};
> +static const unsigned int i2c2_b_pins[] = {
> +	/* SCL, SDA, */
> +	RCAR_GP_PIN(1, 18), RCAR_GP_PIN(1, 19),
> +};
> +static const unsigned int i2c2_b_mux[] = {
> +	SCL2_B_MARK, SDA2_B_MARK,
> +};
> +static const unsigned int i2c2_c_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(0, 31), RCAR_GP_PIN(0, 30),
> +};
> +static const unsigned int i2c2_c_mux[] = {
> +	SCL2_C_MARK, SDA2_C_MARK,
> +};
> +static const unsigned int i2c2_d_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(1, 24), RCAR_GP_PIN(1, 25),
> +};
> +static const unsigned int i2c2_d_mux[] = {
> +	SCL2_D_MARK, SDA2_D_MARK,
> +};
> +/* - I2C3
> ------------------------------------------------------------------ */
> +static const unsigned int i2c3_pins[] = {
> +	/* SCL, SDA, */
> +	RCAR_GP_PIN(3, 0), RCAR_GP_PIN(2, 30),
> +};
> +static const unsigned int i2c3_mux[] = {
> +	SCL3_MARK, SDA3_MARK,
> +};
> +static const unsigned int i2c3_b_pins[] = {
> +	/* SCL, SDA, */
> +	RCAR_GP_PIN(0, 29), RCAR_GP_PIN(0, 30),
> +};
> +static const unsigned int i2c3_b_mux[] = {
> +	SCL3_B_MARK, SDA3_B_MARK,
> +};
>  /* - INTC
> ------------------------------------------------------------------- */
> static const unsigned int intc_irq0_pins[] = {
>  	/* IRQ */
> @@ -2600,6 +2673,16 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(hspi1_d),
>  	SH_PFC_PIN_GROUP(hspi2),
>  	SH_PFC_PIN_GROUP(hspi2_b),
> +	SH_PFC_PIN_GROUP(i2c1),
> +	SH_PFC_PIN_GROUP(i2c1_b),
> +	SH_PFC_PIN_GROUP(i2c1_c),
> +	SH_PFC_PIN_GROUP(i2c1_d),
> +	SH_PFC_PIN_GROUP(i2c2),
> +	SH_PFC_PIN_GROUP(i2c2_b),
> +	SH_PFC_PIN_GROUP(i2c2_c),
> +	SH_PFC_PIN_GROUP(i2c2_d),
> +	SH_PFC_PIN_GROUP(i2c3),
> +	SH_PFC_PIN_GROUP(i2c3_b),
>  	SH_PFC_PIN_GROUP(intc_irq0),
>  	SH_PFC_PIN_GROUP(intc_irq0_b),
>  	SH_PFC_PIN_GROUP(intc_irq1),
> @@ -2760,6 +2843,25 @@ static const char * const hspi2_groups[] = {
>  	"hspi2_b",
>  };
> 
> +static const char * const i2c1_groups[] = {
> +	"i2c1",
> +	"i2c1_b",
> +	"i2c1_c",
> +	"i2c1_d",
> +};
> +
> +static const char * const i2c2_groups[] = {
> +	"i2c2",
> +	"i2c2_b",
> +	"i2c2_c",
> +	"i2c2_d",
> +};
> +
> +static const char * const i2c3_groups[] = {
> +	"i2c3",
> +	"i2c3_b",
> +};
> +
>  static const char * const intc_groups[] = {
>  	"intc_irq0",
>  	"intc_irq0_b",
> @@ -2943,6 +3045,9 @@ static const struct sh_pfc_function pinmux_functions[]
> = { SH_PFC_FUNCTION(hspi0),
>  	SH_PFC_FUNCTION(hspi1),
>  	SH_PFC_FUNCTION(hspi2),
> +	SH_PFC_FUNCTION(i2c1),
> +	SH_PFC_FUNCTION(i2c2),
> +	SH_PFC_FUNCTION(i2c3),
>  	SH_PFC_FUNCTION(intc),
>  	SH_PFC_FUNCTION(lbsc),
>  	SH_PFC_FUNCTION(mmc0),
-- 
Regards,

Laurent Pinchart

