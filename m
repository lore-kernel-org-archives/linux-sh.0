From: Mike Turquette <mturquette@linaro.org>
Date: Sat, 17 Jan 2015 22:01:16 +0000
Subject: Re: [PATCH] clk-gate: fix bit # check in clk_register_gate()
Message-Id: <20150117220116.22722.808@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <2500887.6mMDBajo0S@wasted.cogentembedded.com>
In-Reply-To: <2500887.6mMDBajo0S@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org, sboyd@codeaurora.org
Cc: linux-sh@vger.kernel.org

Quoting Sergei Shtylyov (2014-12-24 06:43:27)
> In case CLK_GATE_HIWORD_MASK flag is passed to clk_register_gate(), the bit #
> should be no higher than 15, however the corresponding check is obviously off-
> by-one.
> 
> Fixes: 045779942c04 ("clk: gate: add CLK_GATE_HIWORD_MASK")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to clk-next. Thanks! Is this causing a visible regression for
you? It is not a new bug so I'd prefer to send it though clk-next unless
something is blowing up on your end.

> 
> ---
> The patch is against Linus' repo because the 'clk-fixes' branch  in  Mike
> Turquette's 'linux.git' repo at Linaro seems very outdated. BTW, the repo
> at kernel.org specified by the MAINTAINERS file doesn't seem to exist --
> can something be done about that?

The clk-fixes branch at git.linaro.org is now updated and the clk tree
at git.kernel.org is also live. Blame the holidays.

For now they will mirror each other (and linux-next will continue to
reference the one at git.linaro.org until 3.19 is released).

Regards,
Mike

> 
>  drivers/clk/clk-gate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/drivers/clk/clk-gate.c
> =================================> --- linux.orig/drivers/clk/clk-gate.c
> +++ linux/drivers/clk/clk-gate.c
> @@ -128,7 +128,7 @@ struct clk *clk_register_gate(struct dev
>         struct clk_init_data init;
>  
>         if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
> -               if (bit_idx > 16) {
> +               if (bit_idx > 15) {
>                         pr_err("gate bit exceeds LOWORD field\n");
>                         return ERR_PTR(-EINVAL);
>                 }
> 
