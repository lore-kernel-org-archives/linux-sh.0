From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 03 Jun 2009 05:04:01 +0000
Subject: Re: [PATCH] sh: sh7724 clock framework rewrite
Message-Id: <uiqjdj4ce.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Magnus

thank you for nice patch.

on new clock-sh7724.c

> +static unsigned long pll_recalc(struct clk *clk)
> +{
> +	return clk->parent->rate * (((__raw_readl(FRQCRA) >> 24) & 0x3f) + 1);
> +}

sh7724 needs "* 2" here.
please check old clock-sh7722.c

> -#if defined(CONFIG_CPU_SUBTYPE_SH7724)
> -#define STCPLL(frqcr) ((((frqcr >> 24) & 0x3f) + 1) * 2)
> -#else
>  #define STCPLL(frqcr) (((frqcr >> 24) & 0x1f) + 1)
> -#endif

If I add "*2" here, It works =).

Best regards
--
Kuninori Morimoto
 
