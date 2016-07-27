From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 27 Jul 2016 10:12:36 +0000
Subject: Re: [PATCH v4 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160727101235.GC12880@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
 <862a5642f4a30f062171bbc14fe95a729eab8ba2.1469595861.git.dalias@libc.org>
In-Reply-To: <862a5642f4a30f062171bbc14fe95a729eab8ba2.1469595861.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jul 27, 2016 at 05:35:09AM +0000, Rich Felker wrote:
> +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	struct aic_data *aic = &aic_data;
> +	unsigned min_irq = 64;
> +
> +	pr_info("Initializing J-Core AIC\n");
> +
> +	if (!of_device_is_compatible(node, "jcore,aic2")) {
> +		unsigned cpu;
> +		for_each_possible_cpu(cpu) {
> +			void __iomem *base = of_iomap(node, cpu);
> +			if (!base)
> +				continue;

This sounds like it would be a critical error.

It would be best to at least pr_warn() if you can't map a CPU's AI
interface.

> +			pr_info("Local AIC1 enable for cpu %u at %p\n",
> +				cpu, base + AIC1_INTPRI);
> +			__raw_writel(0xffffffff, base + AIC1_INTPRI);
> +		}

Here base goes out of scope. If you don't need it, it would be best
practice to iounmap it (even if that happens to be a no-op on your
arch).

> +		min_irq = 16;
> +	}
> +
> +	aic->chip.name = node->name;

It's probably best to give the name explicitly in the driver (e.g.
"AIC"), rather than taknig whatever happens to be in the DT (which
should be 'interrupt-controller@<addr>'.

> +	aic->chip.irq_mask = noop;
> +	aic->chip.irq_unmask = noop;

If the core code wants to mask IRQs, how do you handle that? Can you
mask your CPU traps?

Thanks,
Mark.
