From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 27 Jan 2015 18:17:27 +0000
Subject: Re: [PATCH v4 3/5] drivers: bus: Add Simple Power-Managed Bus DT Bindings
Message-Id: <20150127181727.GO17721@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <1422288977-20353-1-git-send-email-geert+renesas@glider.be>
 <1422288977-20353-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1422288977-20353-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 26, 2015 at 04:16:15PM +0000, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
> v4:
>   - Replace "simple-bus" by "simple-pm-bus",
>   - Remove the "renesas,bsc" bindings. They will be specified in a
>     separate document.
> 
> v3:
>   - Add Tested-by,
>   - Document required properties inherited from "simple-bus",
>   - Document required "reg" property for "renesas,bsc",
>   - Move "ranges" before "reg" in the example,
> 
> v2:
>   - New.
> ---
>  .../devicetree/bindings/bus/simple-pm-bus.txt      | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.txt b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
> new file mode 100644
> index 0000000000000000..0415e93a816c5ac0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
> @@ -0,0 +1,41 @@
> +Simple Power-Managed Bus
> +============
> +
> +A Simple Power-Managed Bus is a transparent bus that doesn't need a real
> +driver, as it's typically initialized by the boot loader.
> +
> +However, its bus controller is part of a PM domain, or under the control of a
> +functional clock.  Hence, the bus controller's PM domain and/or clock must be
> +enabled for child devices connected to the bus (either on-SoC or externally)
> +to function.
> +
> +The bindings for the Simple Power-Managed Bus extend the bindings for
> +"simple-bus", as specified in ePAPR.

I would note that "simple-pm-bus" follows the "simple-bus" set of
properties, but is not an extension of "simple-bus".

For the reasons I mentioned previously, I don't think that any
"simple-pm-bus" should be "simple-bus" compatible (and I believe we
should document that requirement below).

> +
> +
> +Required properties:
> +  - compatible: Must contain at least "simple-pm-bus".
> +		It's recommended to let this be preceded by one or more
> +		vendor-specific compatible values.
> +  - #address-cells, #size-cells, ranges: Must describe the mapping between
> +		parent address and child address spaces.
> +
> +Optional platform-specific properties for clock or PM domain control (at least
> +one of them is required):
> +  - clocks: Must contain a reference to the functional clock(s),

I'm a little worried about the clocks. What are the expectations on
their configuration?

I don't see how we can generally rely on the clock configuration being
correct unless the input clocks only have on/off controls, and the OS
doesn't see any of the parent clock tree it could potentially change the
configuration of (beyond on/off).

Otherwise we're relying on implicit behaviour elsewhere in Linux (which
_will_ break over time), and this ends up not being usable by anything
else.

I'm coming to the opinion that while we might be able to have common
driver in Linux, we can't have a common "simple-pm-bus" binding because
it implicitly assumes too much about the OS behaviour.

Thanks,
Mark.
