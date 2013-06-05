From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 05 Jun 2013 11:52:52 +0000
Subject: Re: [PATCH 2/4] irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
Message-Id: <201306051352.52924.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
 <1370406751-3852-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370406751-3852-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 05 June 2013, Simon Horman wrote:
> @@ -0,0 +1,13 @@
> +DT bindings for the R-/SH-Mobile irqpin controller
> +
> +Required properties:
> +
> +- compatible: has to be "renesas,intc-irqpin"
> +- #interrupt-cells: has to be <2>
> +
> +Optional properties:
> +
> +- any properties, listed in interrupts.txt in this directory, and any standard
> +  resource allocation properties
> +- sense-bitfield-width: width of a single sense bitfield in the SENSE register,
> +  if different from the default 4 bits

I think you should add documentation here about how the two interrupt cells
are to be interpreted, to allow people to fill the values from a data sheet
or board schematic.

	Arnd
