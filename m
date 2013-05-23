From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 12:42:37 +0000
Subject: Re: [PATCH 04/17 v2] sh-pfc: r8a7778: add HSPI pin groups
Message-Id: <519E0EBD.2030806@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877giq4c8l.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877giq4c8l.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 23-05-2013 7:16, Kuninori Morimoto wrote:

> Add HSPI CLK/CS/RX/TX pin groups to R8A7778 PFC driver.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2

>   - alphabetical change

>   drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   61 ++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)

> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> index 605f8ae..bf5e3d8 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> @@ -1371,6 +1371,43 @@ SCIF_PFC_CLK(hscif1_clk_a,	HSCK1_A);
>   SCIF_PFC_PIN(hscif1_clk_b,	RCAR_GP_PIN(4, 2));
>   SCIF_PFC_CLK(hscif1_clk_b,	HSCK1_B);

> +/* - HSPI macro --------------------------------------------------------------*/
> +#define HSPI_PFC_PIN(name, args...)		SH_PFC_PINS(name, args)
> +#define HSPI_PFC_DAT(name, clk, cs, rx, tx)	SH_PFC_MUX4(name, clk, cs, rx, tx)

    It's strange that you didn't call it HSPI_PFC_MUX() as in the I2C 
PFC patch as it's the same case of mixing the signals of a different 
nature in the same group.

> +
> +/* - HSPI0 -------------------------------------------------------------------*/
> +HSPI_PFC_PIN(hspi0_a,	RCAR_GP_PIN(3, 19),	RCAR_GP_PIN(3, 20),
> +			RCAR_GP_PIN(3, 21),	RCAR_GP_PIN(3, 22));
> +HSPI_PFC_DAT(hspi0_a,	HSPI_CLK0_A,		HSPI_CS0_A,
> +			HSPI_RX0_A,		HSPI_TX0);

    Not HSPI_TX0_A? Strange...

> +
> +HSPI_PFC_PIN(hspi0_b,	RCAR_GP_PIN(2, 25),	RCAR_GP_PIN(2, 26),
> +			RCAR_GP_PIN(2, 24),	RCAR_GP_PIN(2, 27));
> +HSPI_PFC_DAT(hspi0_b,	HSPI_CLK0_B,		HSPI_CS0_B,
> +			HSPI_RX0_B,		HSPI_TX0_B);
> +
[...]

WBR, Sergei

