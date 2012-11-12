From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 12 Nov 2012 22:43:08 +0000
Subject: Re: [PATCH 05/10] sh: clkfwk: add sh_clk_fsidiv_register()
Message-Id: <201211122243.08450.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1352446165-19298-1-git-send-email-horms@verge.net.au>
 <1352446165-19298-6-git-send-email-horms@verge.net.au>
In-Reply-To: <1352446165-19298-6-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 09 November 2012, Simon Horman wrote:
> +
> +static int fsidiv_set_rate(struct clk *clk, unsigned long rate)
> +{
> +       u32 val;
> +       int idx;
> +
> +       idx = (clk->parent->rate / rate) & 0xffff;
> +       if (idx < 2)
> +               __raw_writel(0, clk->mapping->base);
> +       else
> +               __raw_writel(idx << 16, clk->mapping->base);
> +
> +       return 0;
> +}

This gives me a new warning about an unused variable "val" now.

	Arnd
