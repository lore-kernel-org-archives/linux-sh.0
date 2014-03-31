From: Mike Turquette <mturquette@linaro.org>
Date: Mon, 31 Mar 2014 18:13:10 +0000
Subject: Re: [PATCH] clk: shmobile: rcar-gen2: fix lb/sd0/sd1/sdh clock parent to pll1
Message-Id: <20140331181310.5762.78686@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1396277434-24925-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396277434-24925-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Ben Dooks (2014-03-31 07:50:34)
> The clock generator for rcar-gen2 has the lb, sdh, sd0 and sd1 clocks
> parented to pll1_div2 where the hardware diagram shows these to be
> directly fed from pll1.
> 
> This fixes the initial rate for sdh0 clock to be 97.5MHz instead of
> the reported 48MHz where the manual says the default register values
> are for 97.5MHz.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Taken into clk-next.

Regards,
Mike

> ---
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-sh@vger.kernel.org
> Cc: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/clk/shmobile/clk-rcar-gen2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
> index 01cb49c..7c6be44 100644
> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
> @@ -249,22 +249,22 @@ rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
>                 parent_name = "main";
>                 mult = config->pll3_mult;
>         } else if (!strcmp(name, "lb")) {
> -               parent_name = "pll1_div2";
> +               parent_name = "pll1";
>                 div = cpg_mode & BIT(18) ? 36 : 24;
>         } else if (!strcmp(name, "qspi")) {
>                 parent_name = "pll1_div2";
>                 div = (cpg_mode & (BIT(3) | BIT(2) | BIT(1))) = BIT(2)
>                     ? 8 : 10;
>         } else if (!strcmp(name, "sdh")) {
> -               parent_name = "pll1_div2";
> +               parent_name = "pll1";
>                 table = cpg_sdh_div_table;
>                 shift = 8;
>         } else if (!strcmp(name, "sd0")) {
> -               parent_name = "pll1_div2";
> +               parent_name = "pll1";
>                 table = cpg_sd01_div_table;
>                 shift = 4;
>         } else if (!strcmp(name, "sd1")) {
> -               parent_name = "pll1_div2";
> +               parent_name = "pll1";
>                 table = cpg_sd01_div_table;
>                 shift = 0;
>         } else if (!strcmp(name, "z")) {
> -- 
> 1.9.0
> 
