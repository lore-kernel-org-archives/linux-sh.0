From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jul 2014 09:07:25 +0000
Subject: Re: [PATCH 03/13] irqchip: renesas-irqc: Add DT binding documentation
Message-Id: <20140711090725.GJ12420@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
 <1404908623-909-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404908623-909-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jul 09, 2014 at 02:23:33PM +0200, Geert Uytterhoeven wrote:
> The renesas-irqc driver supports DT, but the DT binding documentation was
> missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  .../bindings/interrupt-controller/renesas,irqc.txt | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> new file mode 100644
> index 000000000000..f819e2a5907c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> @@ -0,0 +1,30 @@
> +DT bindings for the R-Mobile/R-Car interrupt controller
> +
> +Required properties:
> +
> +- compatible: has to be "renesas,irqc-<soctype>", "renesas,irqc" as fallback.
> +  Examples with soctypes are:
> +    - "renesas,irqc-r8a73a4" (R-Mobile AP6)
> +    - "renesas,irqc-r8a7790" (R-Car H2)
> +    - "renesas,irqc-r8a7791" (R-Car M2)
> +- #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
> +  interrupts.txt in this directory
> +
> +Optional properties:
> +
> +- any properties, listed in interrupts.txt, and any standard resource allocation
> +  properties
> +
> +Example:
> +
> +	irqc0: interrupt-controller@e61c0000 {
> +		compatible = "renesas,irqc-r8a7790", "renesas,irqc";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		reg = <0 0xe61c0000 0 0x200>;
> +		interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 3 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> -- 
> 1.9.1
> 
