From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 03 Sep 2015 00:10:08 +0000
Subject: Re: [PATCH 1/2] [RFC] pinctrl: sh-pfc: r8a7795: Add pinmux data for single-function pins
Message-Id: <87twrcqse6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441219910-28964-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441219910-28964-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> +	PINMUX_DATA(AVS1_MARK, FN_AVS1),
> +	PINMUX_DATA(AVS2_MARK, FN_AVS2),
> +	PINMUX_DATA(HDMI0_CEC_MARK, FN_HDMI0_CEC),
> +	PINMUX_DATA(HDMI1_CEC_MARK, FN_HDMI1_CEC),
> +	PINMUX_DATA(MSIOF0_RXD_MARK, FN_MSIOF0_RXD),
> +	PINMUX_DATA(MSIOF0_SCK_MARK, FN_MSIOF0_SCK),
> +	PINMUX_DATA(MSIOF0_TXD_MARK, FN_MSIOF0_TXD),
> +	PINMUX_DATA(SD2_CMD_MARK, FN_SD2_CMD),
> +	PINMUX_DATA(SD3_CLK_MARK, FN_SD3_CLK),
> +	PINMUX_DATA(SD3_CMD_MARK, FN_SD3_CMD),
> +	PINMUX_DATA(SD3_DAT0_MARK, FN_SD3_DAT0),
> +	PINMUX_DATA(SD3_DAT1_MARK, FN_SD3_DAT1),
> +	PINMUX_DATA(SD3_DAT2_MARK, FN_SD3_DAT2),
> +	PINMUX_DATA(SD3_DAT3_MARK, FN_SD3_DAT3),
> +	PINMUX_DATA(SD3_DS_MARK, FN_SD3_DS),
> +	PINMUX_DATA(SSI_SCK5_MARK, FN_SSI_SCK5),
> +	PINMUX_DATA(SSI_SDATA5_MARK, FN_SSI_SDATA5),
> +	PINMUX_DATA(SSI_WS5_MARK, FN_SSI_WS5),

I think you can use PINMUX_IPSR_NOGP() for this purpose.
And, you can find PINMUX_IPSR_NOGP() listed place in end of pinmux_data()
