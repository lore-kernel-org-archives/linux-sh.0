From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 15 Jul 2011 02:53:38 +0000
Subject: Re: [PATCH 1/6] clk: Prototype and document clk_register()
Message-Id: <20110715025338.GN2927@ponder.secretlab.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<1310352837-4277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1310352837-4277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jul 11, 2011 at 11:53:52AM +0900, Mark Brown wrote:
> This allows the compiler to ensure drivers are using the correct prototype.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  include/linux/clk.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 7c26135..2ca4f66 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -136,6 +136,18 @@ extern struct clk_hw_ops clk_gate_ops;
>  
>  #endif /* CONFIG_GENERIC_CLK_GATE */
>  
> +/**
> + * clk_register - register and initialize a new clock
> + *
> + * @ops: ops for the new clock
> + * @hw: struct clk_hw to be passed to the ops of the new clock
> + * @name: name to use for the new clock
> + *
> + * Register a new clock with the clk subsytem.  Returns either a
> + * struct clk for the new clock or a NULL pointer.
> + */
> +struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
> +			 const char *name);
>  
>  #else /* !CONFIG_GENERIC_CLK */
>  
> -- 
> 1.7.5.4
> 
