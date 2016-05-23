From: Rob Herring <robh@kernel.org>
Date: Mon, 23 May 2016 20:53:20 +0000
Subject: Re: [PATCH v2 03/12] of: add J-Core interrupt controller bindings
Message-Id: <20160523205320.GA21655@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <2bdca4260d5bb2b3820e4309e2ba445c4c7bfbf6.1463708766.git.dalias@libc.org>
In-Reply-To: <2bdca4260d5bb2b3820e4309e2ba445c4c7bfbf6.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Cooper <jason@lakedaemon.net>, Kumar Gala <galak@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, May 20, 2016 at 02:53:04AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  .../bindings/interrupt-controller/jcore,aic.txt    | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> new file mode 100644
> index 0000000..dc9fde8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
> @@ -0,0 +1,28 @@
> +J-Core Advanced Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : Should be "jcore,aic1" for the (obsolete) first-generation aic
> +  with 8 interrupt lines with programmable priorities, or "jcore,aic2" for
> +  the "aic2" core with 64 interrupts.
> +
> +- interrupt-controller : Identifies the node as an interrupt controller
> +
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.

No level/edge support? Need 2 cells if so.

> +
> +Additional properties required for aic1:
> +
> +- reg : Memory region for configuration.
> +
> +- cpu-offset : For SMP, the offset to the per-cpu memory region for
> +  configuration, to be scaled by the cpu number.
> +
> +
> +Example:
> +
> +aic: interrupt-controller {
> +	compatible = "jcore,aic2";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +};
> -- 
> 2.8.1
> 
> 
