From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 13 Nov 2014 00:15:58 +0000
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Increase MMCIF clock rate to 97.5MHz
Message-Id: <87sihoklaj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org


Hi Kaneko-san

> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> 
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
(snip)
> +	if (np && !of_property_read_u32(np, "renesas,clk-rate", &clk_rate)) {
> +		if (clk_rate) {
> +			ret = clk_set_rate(host->hclk, clk_rate);
> +			if (ret < 0)
> +				dev_err(&pdev->dev,
> +					"cannot set clock rate: %d\n", ret);
> +		}
> +	}

I guess this is came from BSP, and you have similar
bindings on sh_mobile_sdhi.c too.
But, we need to use "standard" method, not BSP original

Best regards
---
Kuninori Morimoto
