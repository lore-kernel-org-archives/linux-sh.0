From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 25 May 2016 10:25:04 +0000
Subject: Re: [PATCH v3 03/12] of: add J-Core interrupt controller bindings
Message-Id: <20160525102503.GG1337@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <03e22cb9679aa7d45f07dba0bf6610ec824cae11.1464148904.git.dalias@libc.org>
In-Reply-To: <03e22cb9679aa7d45f07dba0bf6610ec824cae11.1464148904.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Cooper <jason@lakedaemon.net>, Kumar Gala <galak@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  .../bindings/interrupt-controller/jcore,aic.txt    | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> new file mode 100644
> index 0000000..5dc99b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> @@ -0,0 +1,29 @@
> +J-Core Advanced Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : Should be "jcore,aic1" for the (obsolete) first-generation aic
> +  with 8 interrupt lines with programmable priorities, or "jcore,aic2" for
> +  the "aic2" core with 64 interrupts.
> +
> +- reg : Memory region for configuration.
> +
> +- interrupt-controller : Identifies the node as an interrupt controller
> +
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +
> +Optional properties:
> +
> +- cpu-offset : For SMP, the offset to the per-cpu memory region for
> +  configuration, to be scaled by the cpu number.

I take is that "cpu number" means the "sequential, zero-based hardware
cpu id" defined in patch 2. I would recommend that you explicitly
mention that (e.g. here say "hardware cpu id" rather than "cpu number"),
so as to not have this confused with Linux logical IDs.

Thanks,
Mark.

> +
> +
> +Example:
> +
> +aic: interrupt-controller@200 {
> +	compatible = "jcore,aic2";
> +	reg = < 0x200 0x10 >;
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +};
> -- 
> 2.8.1
> 
> 
