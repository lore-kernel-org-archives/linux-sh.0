From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 04 Aug 2015 08:15:03 +0000
Subject: Re: [PATCH 3/4 v3][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <87oain5v7i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <873801w377.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <873801w377.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

> diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
> new file mode 100644
> index 0000000..fc1c4da
> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a7795-clock.h
> @@ -0,0 +1,31 @@
> +#ifndef __DT_BINDINGS_CLOCK_RCAR_GEN3_H__
> +#define __DT_BINDINGS_CLOCK_RCAR_GEN3_H__
> +
> +/* CPG */
> +#define RCAR_GEN3_CLK_MAIN		0
> +#define RCAR_GEN3_CLK_PLL0		1
> +#define RCAR_GEN3_CLK_PLL1		2
> +#define RCAR_GEN3_CLK_PLL2		3
> +#define RCAR_GEN3_CLK_PLL3		4
> +#define RCAR_GEN3_CLK_PLL4		5
(snip)

About this, file name is r8a7795-clock.h, and it is using GEN3 for each definition.
I thought all Gen3 series (will) have compatible mapping, but maybe it can't.
So, maybe using SoC naming (same as before) in v4 is good idea.

