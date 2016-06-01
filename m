From: Rob Herring <robh@kernel.org>
Date: Wed, 01 Jun 2016 13:58:52 +0000
Subject: Re: [PATCH v3 04/12] of: add J-Core timer bindings
Message-Id: <20160601135852.GA17217@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <5341dfbb085d5647ebb6fe4390ca329b63e0e03d.1464148904.git.dalias@libc.org>
In-Reply-To: <5341dfbb085d5647ebb6fe4390ca329b63e0e03d.1464148904.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  .../devicetree/bindings/timer/jcore,pit.txt        | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/jcore,pit.txt b/Documentation/devicetree/bindings/timer/jcore,pit.txt
> new file mode 100644
> index 0000000..96c6815
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/jcore,pit.txt
> @@ -0,0 +1,28 @@
> +J-Core Programmable Interval Timer and Clocksource
> +
> +Required properties:
> +
> +- compatible: Must be "jcore,pit".
> +
> +- reg: Memory region for timer/clocksource registers.
> +
> +- interrupts: An interrupt to assign for the timer. The actual pit
> +  core is integrated with the aic and allows the timer interrupt
> +  assignment to be programmed by software, but this property is
> +  required in order to reserve an interrupt number that doesn't
> +  conflict with other devices.
> +
> +Optional properties:
> +
> +- cpu-offset: For SMP, the per-cpu offset to the local timer
> +  programming memory range.
> +
> +
> +Example:
> +
> +timer@200 {
> +	compatible = "jcore,pit";
> +	reg = < 0x200 0x30 >;
> +	cpu-offset = < 0x300 >;

This is outside the reg range. Perhaps reg should include each range of 
per cpu registers.

Rob
