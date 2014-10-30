From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Oct 2014 06:31:53 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: r8a7790: Add SDHI clock rate to device tree
Message-Id: <87ppdaxe3t.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414648643-30818-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1414648643-30818-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon

> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> 
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> [simon: rebase]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
(snip)
>  		reg = <0 0xee100000 0 0x200>;
>  		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
> +		renesas,clk-rate = <195000000>;
>  		status = "disabled";
>  	};

Unfortunately, this "renesas,clk-rate" is supporting
only in Renesas BSP, not upstream.
Same comment to r8a7791

Best regards
---
Kuninori Morimoto
