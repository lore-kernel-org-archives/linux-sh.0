From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Feb 2014 18:55:23 +0000
Subject: Re: [PATCH v3] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <530F9822.8070904@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393521820-21805-1-git-send-email-bcousson@baylibre.com>
In-Reply-To: <1393521820-21805-1-git-send-email-bcousson@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/27/2014 08:23 PM, Benoit Cousson wrote:

> The Z clock frequency change is effective only after setting the kick
> bit located in the FRQCRB register.
> Without that, the CA15 CPUs clock rate will never change.

> Fix that by checking if the kick bit is cleared and enable it to make
> the clock rate change effective. The bit is cleared automatically upon
> completion.

> Signed-off-by: Benoit Cousson <bcousson+renesas@baylibre.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[...]

> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
> index a59ec21..cbf8c59 100644
> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
[...]
> @@ -83,17 +86,45 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
[...]
> +	/*
> +	 * Note: There is no HW information about the worst case latency.
> +	 *
> +	 * Using experimental measurements, it seems that no more than
> +	 * ~10 iterations are needed, independently of the CPU rate.
> +	 * Since this value might be dependant of external xtal rate, pll1
> +	 * rate or even the other emulation clocks rate, use 1000 as a
> +	 * "super" safe value.
> +	 */
> +	for (i = 1000; i; i--) {
> +		if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
> +			cpu_relax();
> +		else
> +			return 0;

     This can be coded shorter:

		if (!(clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK))
			return 0;
		cpu_relax();

WBR, Sergei

