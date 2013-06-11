From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 11 Jun 2013 11:57:49 +0000
Subject: Re: [PATCH] pinctrl: r8a7790: fix two pin numbers
Message-Id: <2711822.DMoBdX8i72@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306111328440.9621@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306111328440.9621@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday 11 June 2013 13:42:17 Guennadi Liakhovetski wrote:
> Fix two erroneous MMCIF1 pin numbers on r8a7790.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Hi Simon
> 
> You merged my earlier patch "pinctrl: r8a7790: add pinmux data for MMCIF
> and SDHI interfaces" whereas Laurent pointed out 2 wrong pin numbers in
> that version and I was supposed to fix them... Would it be possible to
> merge this fix with that original patch or could you apply it on top?
> 
> Thanks
> Guennadi
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   16 +++++++---------
>  1 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 85d77a4..1d4a5f7 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -2371,8 +2371,7 @@ static const unsigned int tpu0_to3_pins[] = {
>  static const unsigned int tpu0_to3_mux[] = {
>  	TPU0TO3_MARK,
>  };
> -
> -/* - MMCIF
> ------------------------------------------------------------------ */ +/* -
> MMCIF0 ----------------------------------------------------------------- */
> static const unsigned int mmc0_data1_pins[] = {
>  	/* D[0] */
>  	RCAR_GP_PIN(3, 18),
> @@ -2406,7 +2405,7 @@ static const unsigned int mmc0_ctrl_pins[] = {
>  static const unsigned int mmc0_ctrl_mux[] = {
>  	MMC0_CLK_MARK, MMC0_CMD_MARK,
>  };
> -
> +/* - MMCIF1
> ----------------------------------------------------------------- */ static
> const unsigned int mmc1_data1_pins[] = {
>  	/* D[0] */
>  	RCAR_GP_PIN(3, 26),
> @@ -2427,7 +2426,7 @@ static const unsigned int mmc1_data8_pins[] = {
>  	RCAR_GP_PIN(3, 26), RCAR_GP_PIN(3, 27),
>  	RCAR_GP_PIN(3, 28), RCAR_GP_PIN(3, 29),
>  	RCAR_GP_PIN(3, 30), RCAR_GP_PIN(3, 31),
> -	RCAR_GP_PIN(3, 13), RCAR_GP_PIN(3, 14),
> +	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
>  };
>  static const unsigned int mmc1_data8_mux[] = {
>  	MMC1_D0_MARK, MMC1_D1_MARK, MMC1_D2_MARK, MMC1_D3_MARK,
> @@ -2440,8 +2439,7 @@ static const unsigned int mmc1_ctrl_pins[] = {
>  static const unsigned int mmc1_ctrl_mux[] = {
>  	MMC1_CLK_MARK, MMC1_CMD_MARK,
>  };
> -
> -/* - SDHI
> ------------------------------------------------------------------- */ +/*
> - SDHI0 ------------------------------------------------------------------
> */ static const unsigned int sdhi0_data1_pins[] = {
>  	/* D0 */
>  	RCAR_GP_PIN(3, 2),
> @@ -2477,7 +2475,7 @@ static const unsigned int sdhi0_wp_pins[] = {
>  static const unsigned int sdhi0_wp_mux[] = {
>  	SD0_WP_MARK,
>  };
> -
> +/* - SDHI1
> ------------------------------------------------------------------ */
> static const unsigned int sdhi1_data1_pins[] = {
>  	/* D0 */
>  	RCAR_GP_PIN(3, 10),
> @@ -2513,7 +2511,7 @@ static const unsigned int sdhi1_wp_pins[] = {
>  static const unsigned int sdhi1_wp_mux[] = {
>  	SD1_WP_MARK,
>  };
> -
> +/* - SDHI2
> ------------------------------------------------------------------ */
> static const unsigned int sdhi2_data1_pins[] = {
>  	/* D0 */
>  	RCAR_GP_PIN(3, 18),
> @@ -2549,7 +2547,7 @@ static const unsigned int sdhi2_wp_pins[] = {
>  static const unsigned int sdhi2_wp_mux[] = {
>  	SD2_WP_MARK,
>  };
> -
> +/* - SDHI3
> ------------------------------------------------------------------ */
> static const unsigned int sdhi3_data1_pins[] = {
>  	/* D0 */
>  	RCAR_GP_PIN(3, 26),
-- 
Regards,

Laurent Pinchart

