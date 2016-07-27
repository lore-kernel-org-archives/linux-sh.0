From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 27 Jul 2016 10:15:38 +0000
Subject: Re: [PATCH v4 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160727101537.GD12880@leverpostej>
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
> For simplicity, there is no aic1-specific logic in the driver beyond
> setting the priority register, which is necessary for interrupts to
> work at all. Eventually aic1 will likely be phased out, but it's
> currently in use in deployments and all released bitstream binaries.

[...]

> +	if (!of_device_is_compatible(node, "jcore,aic2")) {

If this is only meant to run for AIC1, it would be better to check for
the "jcore,aic1" compatible string explicitly.

While that shouldn't matter much currently, it better matches the intent
described in the commit message, and avoids surprises and/or churn in
future if you have AIC3+.

Mark.

> +IRQCHIP_DECLARE(jcore_aic2, "jcore,aic2", aic_irq_of_init);
> +IRQCHIP_DECLARE(jcore_aic1, "jcore,aic1", aic_irq_of_init);
> -- 
> 2.8.1
> 
