From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 29 May 2013 00:47:56 +0000
Subject: Re: [PATCH 3/5] sh-pfc: r8a7790: add HSCIF pin groups
Message-Id: <87zjve4nnq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369743728-26084-4-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1369743728-26084-4-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ulrich

Thank you for your patch

>  	SH_PFC_PIN_GROUP(scif1_clk_d),
>  	SH_PFC_PIN_GROUP(scif1_data_e),
>  	SH_PFC_PIN_GROUP(scif1_clk_e),
> +	SH_PFC_PIN_GROUP(hscif0_data),
> +	SH_PFC_PIN_GROUP(hscif0_clk),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl),
> +	SH_PFC_PIN_GROUP(hscif0_data_b),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_b),
> +	SH_PFC_PIN_GROUP(hscif0_data_c),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_c),
> +	SH_PFC_PIN_GROUP(hscif0_data_d),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_d),
> +	SH_PFC_PIN_GROUP(hscif0_data_e),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_e),
> +	SH_PFC_PIN_GROUP(hscif0_data_f),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_f),
> +	SH_PFC_PIN_GROUP(hscif1_data),
> +	SH_PFC_PIN_GROUP(hscif1_clk),
> +	SH_PFC_PIN_GROUP(hscif1_ctrl),
> +	SH_PFC_PIN_GROUP(hscif1_data_b),
> +	SH_PFC_PIN_GROUP(hscif1_clk_b),
> +	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
>  	SH_PFC_PIN_GROUP(scifa0_data),
>  	SH_PFC_PIN_GROUP(scifa0_clk),
>  	SH_PFC_PIN_GROUP(scifa0_ctrl),
...
> @@ -2853,6 +3032,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(intc),
>  	SH_PFC_FUNCTION(scif0),
>  	SH_PFC_FUNCTION(scif1),
> +	SH_PFC_FUNCTION(hscif0),
> +	SH_PFC_FUNCTION(hscif1),
>  	SH_PFC_FUNCTION(scifa0),
>  	SH_PFC_FUNCTION(scifa1),
>  	SH_PFC_FUNCTION(scifa2),

Please re-check alphabetical order :)

Best regards
---
Kuninori Morimoto
