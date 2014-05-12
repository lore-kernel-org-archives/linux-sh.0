From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 12 May 2014 22:20:28 +0000
Subject: Re: [PATCH v2 12/17] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <3805357.84FqniycGz@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1397565253-22741-13-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397565253-22741-13-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Tuesday 15 April 2014 14:34:08 Geert Uytterhoeven wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
> bit value should thus be inverted in the is_enabled() operation.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
> This depends on the actual fixes, so either we need Mike's ack, or this has
> to wait until the fixes have landed in mainline.

What's the status of this patch ? Do you still carry it in your tree and plan 
to push it upstream at some point ?

> v2:
>   - New
> 
>  drivers/clk/shmobile/clk-mstp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/shmobile/clk-mstp.c
> b/drivers/clk/shmobile/clk-mstp.c index 2e5810c88d11..4f5e2c6ec853 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -112,7 +112,7 @@ static int cpg_mstp_clock_is_enabled(struct clk_hw *hw)
>  	else
>  		value = clk_readl(group->smstpcr);
> 
> -	return !!(value & BIT(clock->bit_index));
> +	return !(value & BIT(clock->bit_index));
>  }
> 
>  static const struct clk_ops cpg_mstp_clock_ops = {

-- 
Regards,

Laurent Pinchart

