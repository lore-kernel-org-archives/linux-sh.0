From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 19 Jun 2013 21:58:29 +0000
Subject: Re: [RFC] pinctrl: generic: Add DT bindings
Message-Id: <51C22985.50106@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>, James Hogan <james.hogan@imgtec.com>, linux-sh@vger.kernel.org

On 06/11/2013 04:03 PM, Laurent Pinchart wrote:
> Document DT properties for the generic pinctrl parameters and add a
> parser function.

> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

> += Generic pinconf parameters =
> +
> +Pin configuration parameters are expressed by DT properties in the pin
> +controller device state nodes and child nodes. For devices that use the generic
> +pinconf parameters the following properties are defined.
> +
> +- tristate: A boolean, put the pin into high impedance state when set.

I don't think that a Boolean is appropriate here; it's really a tri-state:

* Nothing is specified about the tristate value; don't touch that aspect
of HW.
* Turn tristate on.
* Turn tristate off.

This can be a meaningful distinction when relying on e.g. the bootloader
having already set up the appropriate tristate value, or when
dynamically switching between different pinctrl states and not wanting
to affect tristate, or when piecing together multiple DT nodes that
describe part of a state, where one node covers just muxing and the
other just pin config (e.g. where the mux and pin config configuration
registers in HW affect different overlapping groups).

> +- schmitt: An integer, enable or disable Schmitt trigger mode for the pins.
> +  Valid values are
> +    0: Schmitt trigger disabled (no hysteresis)
> +    1: Schmitt trigger enabled

A similar comment applies here.

> +- slew-rate: An integer controlling the pin slew rate. Values are device-
> +  dependent.
> +
> +- drive-strength: An integer representing the drive strength of pins in mA.
> +  Valid values are device-dependent.

I'm still not convinced that requiring this to be in mA is a good idea.
Different HW will use different units for documentation, or even specify
no units at all, so it might not always be possible to represent this in
terms of mA. Asking for the documentation to be re-written simply to
support the DT binding just isn't going to happen.

