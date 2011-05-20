From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 May 2011 11:37:03 +0000
Subject: Re: [PATCH 4/4] clk: Add simple gated clock
Message-Id: <201105201337.03501.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1305876469.327589.409938867568.4.gpush@pororo>
In-Reply-To: <1305876469.327589.409938867568.4.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 20 May 2011 09:27:49 Jeremy Kerr wrote:
> +static int clk_gate_enable(struct clk_hw *clk)
> +{
> +       struct clk_gate *gate = to_clk_gate(clk);
> +       u32 reg;
> +
> +       reg = __raw_readl(gate->reg);
> +       reg |= 1 << gate->bit_idx;
> +       __raw_writel(reg, gate->reg);
> +
> +       return 0;
> +}

__raw_readl/__raw_writel is a rather bad choice for a common driver,
it might not do what you need. Unfortunately, readl() also wouldn't
do the right thing on all architectures, because it might only
be available on PCI buses. Maybe iowrite32 would be best here?

Instead of the bit_idx, a mask value might be better to avoid
confusion with the different ways of counting bits from one or
the other end.

	Arnd
