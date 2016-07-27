From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 27 Jul 2016 10:05:05 +0000
Subject: Re: [PATCH v4 1/2] of: add J-Core interrupt controller bindings
Message-Id: <20160727100504.GB12880@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
 <9039efc9336670b3399b9104f1ab5e1a2d8d9025.1469595861.git.dalias@libc.org>
In-Reply-To: <9039efc9336670b3399b9104f1ab5e1a2d8d9025.1469595861.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jul 27, 2016 at 05:35:09AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  .../bindings/interrupt-controller/jcore,aic.txt    | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> new file mode 100644
> index 0000000..b7a56ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> @@ -0,0 +1,26 @@
> +J-Core Advanced Interrupt Controller
> +
> +Required properties:
> +
> +- compatible: Should be "jcore,aic1" for the (obsolete) first-generation aic
> +  with 8 interrupt lines with programmable priorities, or "jcore,aic2" for
> +  the "aic2" core with 64 interrupts.
> +
> +- reg: Memory region(s) for configuration. For SMP, there should be one
> +  region per cpu, indexed by the sequential, zero-based hardware cpu
> +  number (which is also the logical cpu number).

Nit: remove the bit about the logical number. That's a linux detail that
doesn't belong in the binding.

> +- interrupt-controller: Identifies the node as an interrupt controller
> +
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.

... where the value encoded in that cell is?

I guess it's the zero-based index of the interrupt?

No flags? Can the AIC only do one trigger type?

Thanks,
Mark.
