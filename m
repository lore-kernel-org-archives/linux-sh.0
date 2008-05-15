From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 15 May 2008 08:48:17 +0000
Subject: Re: [PATCH] sh: fix sh7785 master clock value
Message-Id: <20080515084817.GA7397@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <482BF7D0.4080109@renesas.com>
In-Reply-To: <482BF7D0.4080109@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 15, 2008 at 05:44:00PM +0900, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
>  arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
> index 805535a..27fa81b 100644
> --- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
> +++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
> @@ -26,7 +26,7 @@ static int pfc_divisors[] = { 1, 1, 1, 1, 1, 1, 1, 18,
> 
>  static void master_clk_init(struct clk *clk)
>  {
> -	clk->rate *= 36;
> +	clk->rate *= pfc_divisors[ctrl_inl(FRQMR1) & 0x000f];
>  }
> 
>  static struct clk_ops sh7785_master_clk_ops = {
> 
Applied, thanks.
