From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 16 May 2013 14:55:09 +0000
Subject: Re: [PATCH 03/12] sh-pfc: r8a7778: add MMCIF pin groups
Message-Id: <5194F34D.5080904@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehd7wg3s.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehd7wg3s.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 16-05-2013 11:15, Kuninori Morimoto wrote:

> Add MMCIF CLK/CMD/DATA groups to R8A7778 PFC driver.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   39 ++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)

> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> index 137dd59..8a8060c 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> @@ -1434,6 +1434,33 @@ SCIF_PFC_CLK(hscif1_clk_a,	HSCK1_A);
>   SCIF_PFC_PIN(hscif1_clk_b,	RCAR_GP_PIN(4, 2));
>   SCIF_PFC_CLK(hscif1_clk_b,	HSCK1_B);
>
> +/* - MMC macro -------------------------------------------------------------- */
> +#define MMC_PFC_PINS(name, args...)		SH_PFC_PINS(name, args)
> +#define MMC_PFC_CTRL(name, clk, cmd)		SH_PFC_MUX2(name, clk, cmd)
> +#define MMC_PFC_DAT1(name, d0)			SH_PFC_MUX1(name, d0)
> +#define MMC_PFC_DAT4(name, d0, d1, d2, d3)	SH_PFC_MUX4(name, d0, d1, d2, d3)
> +#define MMC_PFC_DAT8(name, d0, d1, d2, d3, d4, d5, d6, d7)\
> +						SH_PFC_MUX8(name, d0, d1, d2, d3, \
> +								  d4, d5, d6, d7)

    No CD/WP pins?

> +/* - MMC -------------------------------------------------------------------- */
> +MMC_PFC_PINS(mmc_ctrl,		RCAR_GP_PIN(1, 5),	RCAR_GP_PIN(1, 6));
> +MMC_PFC_CTRL(mmc_ctrl,		MMC_CLK,		MMC_CMD);
> +MMC_PFC_PINS(mmc_data1,		RCAR_GP_PIN(1, 7));
> +MMC_PFC_DAT1(mmc_data1,		MMC_D0);
> +MMC_PFC_PINS(mmc_data4,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
> +				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6));
> +MMC_PFC_DAT4(mmc_data4,		MMC_D0,			MMC_D1,
> +				MMC_D2,			MMC_D3);
> +MMC_PFC_PINS(mmc_data8,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
> +				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6),
> +				RCAR_GP_PIN(1, 4),	RCAR_GP_PIN(1, 0),
> +				RCAR_GP_PIN(0, 30),	RCAR_GP_PIN(0, 31));
> +MMC_PFC_DAT8(mmc_data8,		MMC_D0,			MMC_D1,
> +				MMC_D2,			MMC_D3,
> +				MMC_D4,			MMC_D5,
> +				MMC_D6,			MMC_D7);
> +

    MMC pin groups should follow I2C groups.

WBR, Sergei

