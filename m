From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 25 Nov 2014 12:19:45 +0000
Subject: Re: [PATCH v7 1/2] clk: shmobile: div6: support selectable-input clocks
Message-Id: <1571106.tcuMiAsC17@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1415375468-15378-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1415375468-15378-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415375468-15378-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-sh@vger.kernel.org
Cc: horms@verge.net.au, mturquette@linaro.org, geert@linux-m68k.org, magnus.damm@gmail.com, devicetree@vger.kernel.org, mark.rutland@arm.com

Hi Ulrich,

Thank you for the patch.

On Friday 07 November 2014 16:51:07 Ulrich Hecht wrote:
> Support for setting the parent at initialization time based on the current
> hardware configuration in DIV6 clocks with selectable parents as found in
> the r8a73a4, r8a7740, sh73a0, and other SoCs.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/clk/shmobile/clk-div6.c | 113 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 101 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/shmobile/clk-div6.c
> b/drivers/clk/shmobile/clk-div6.c index f065f69..639241e 100644
> --- a/drivers/clk/shmobile/clk-div6.c
> +++ b/drivers/clk/shmobile/clk-div6.c

[snip]

> +static int cpg_div6_clock_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct div6_clock *clock = to_div6_clock(hw);
> +	u8 hw_index;
> +	u32 mask;
> +
> +	if (index >= __clk_get_num_parents(hw->clk))
> +		return -EINVAL;

Should this check be moved to the CCF core ?

> +	mask = ~((BIT(clock->src_width) - 1) << clock->src_shift);
> +	hw_index = clock->parents[index];
> +
> +	clk_writel((clk_readl(clock->reg) & mask) |
> +		(hw_index << clock->src_shift), clock->reg);
> 
>  	return 0;
>  }

[snip]

-- 
Regards,

Laurent Pinchart

