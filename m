From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 31 Dec 2007 16:49:59 +0000
Subject: Re: [PATCH] sh: sh7712 clock support
Message-Id: <20071231164959.GA23319@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <0C997DD87CC88A4F86C897F52650B52B820E8F@MOLSON.mpc-data.co.uk>
In-Reply-To: <0C997DD87CC88A4F86C897F52650B52B820E8F@MOLSON.mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Murray <amurray@mpc-data.co.uk>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 31, 2007 at 04:32:25PM -0000, Andrew Murray wrote:
> +static void bus_clk_init(struct clk *clk)
> +{
> +	clk->rate = CONFIG_SH_PCLK_FREQ;
> +}
> +
> +static struct clk_ops sh7712_bus_clk_ops = {
> +	.init		= bus_clk_init,
> +};
> +
This shouldn't be necessary, the bus clk already references the master
clk as its parent, and inherits the rate from there. If you have no
recalc work to do, then you should be able to just leave this out
altogether. If you actually need this dummy init, then something is
broken with the upper layer, which we should fix ;-)

Patch looks fine otherwise. Tidy this up and I'll apply it.
