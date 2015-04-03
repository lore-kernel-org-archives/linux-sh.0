From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 03 Apr 2015 12:57:27 +0000
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with complex dependencies
Message-Id: <20150403125727.GT10964@mwanda>
List-Id: <linux-sh.vger.kernel.org>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 03, 2015 at 02:42:02PM +0200, Geert Uytterhoeven wrote:
> +int __init board_staging_register_clock(const struct board_staging_clk *bsc)
> +{
> +	struct clk *clk;
> +	int error;
> +
> +	pr_debug("Registering clock %s for con_id %s dev_id %s\n", bsc->clk,
> +		 bsc->con_id, bsc->dev_id);
> +	clk = clk_get(NULL, bsc->clk);
> +	if (IS_ERR(clk)) {
> +		error = PTR_ERR(clk);
> +		pr_err("Failed to get clock %s (%d)\n", bsc->clk, error);
> +		return error;
> +	}
> +
> +	error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
> +	if (error)
> +		pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
> +		return error;

Missing curly braces.  Also it's weird that don't we need a clk_put()
on the error patch as well as the success path?

> +
> +	clk_put(clk);
> +	return 0;
> +}


regards,
dan carpenter
