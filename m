From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 21 Jun 2015 21:17:49 +0000
Subject: Re: [PATCH 2/6][RFC] clk: shmobile: CPG write protect register support for MSTP
Message-Id: <20212486.lUScXtKQlU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87381twp4y.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87381twp4y.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Moritomo-san,

(CC'ing Geert)

Thank you for the patch.

On Monday 15 June 2015 04:53:30 Kuninori Morimoto wrote:
> R-Car Gen3 needs to care about CPG write protect register when driver
> driver access to CPG/MSTP.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt           |  3 +++
>  drivers/clk/shmobile/clk-mstp.c                          | 16 ++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt index
> 16ed181..d897b13 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -19,12 +19,15 @@ Required Properties:
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2-W) MSTP gate
> clocks
>      - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2-N) MSTP gate
> clocks
>      - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate
> clocks
> +    - "renesas,r8a7795-mstp-clocks" for R8A7795 (R-Car H3) MSTP
> gate clocks
>      - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate
>      clocks and "renesas,cpg-mstp-clocks" as a fallback.
>    - reg: Base address and length of the I/O mapped registers used by the
> MSTP clocks. The first register is the clock control register and is
> mandatory. The second register is the clock status register and is optional
> when not implemented in hardware.
> +    The third register is the CPG write protect register and is optional
> when
> +    not implemented in hardware.

Given that the write protect register is common for all MSTP clocks, I think 
duplicating it in all MSTP nodes isn't the best solution. I believe we should 
instead restructure the MSTP DT bindings and move the MSTP nodes as children 
of the CPG node, and let the CPG handle the write protect register.

Geert, we've discussed this a couple of times before. Have you given it a try 
? I don't mind doing it, but I want to avoid duplicating work.

>    - clocks: Reference to the parent clocks, one per output clock. The
> parents must appear in the same order as the output clocks.
>    - #clock-cells: Must be 1
> diff --git a/drivers/clk/shmobile/clk-mstp.c
> b/drivers/clk/shmobile/clk-mstp.c index 2d2fe77..eb92cf8 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/spinlock.h>
> +#include "rcar-clk.h"
> 
>  /*
>   * MSTP clocks. We can't use standard gate clocks as we need to poll on the
> @@ -30,12 +31,14 @@
>   * @data: clocks in this group
>   * @smstpcr: module stop control register
>   * @mstpsr: module stop status register (optional)
> + * @cpgwpr: CPG write protect register (optional)
>   * @lock: protects writes to SMSTPCR
>   */
>  struct mstp_clock_group {
>  	struct clk_onecell_data data;
>  	void __iomem *smstpcr;
>  	void __iomem *mstpsr;
> +	void __iomem *cpgwpr;
>  	spinlock_t lock;
>  };
> 
> @@ -69,7 +72,17 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw,
> bool enable) value &= ~bitmask;
>  	else
>  		value |= bitmask;
> -	clk_writel(value, group->smstpcr);
> +
> +	if (group->cpgwpr) {
> +		unsigned long cmn_flags;
> +
> +		rcar_cpgwpcr_lock(&cmn_flags);
> +		clk_writel(~value, group->cpgwpr);
> +		clk_writel(value, group->smstpcr);
> +		rcar_cpgwpcr_unlock(&cmn_flags);
> +	} else {
> +		clk_writel(value, group->smstpcr);
> +	}
> 
>  	spin_unlock_irqrestore(&group->lock, flags);
> 
> @@ -174,6 +187,7 @@ static void __init cpg_mstp_clocks_init(struct
> device_node *np)
> 
>  	group->smstpcr = of_iomap(np, 0);
>  	group->mstpsr = of_iomap(np, 1);
> +	group->cpgwpr = of_iomap(np, 2);
> 
>  	if (group->smstpcr = NULL) {
>  		pr_err("%s: failed to remap SMSTPCR\n", __func__);

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
