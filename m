From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 09 Sep 2013 21:02:40 +0000
Subject: Re: [PATCH v2 2/2] sh_eth: add device tree support
Message-Id: <522E3770.9020305@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201309070343.25640.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201309070343.25640.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, rob@landley.net, linux-doc@vger.kernel.org

On 09/06/2013 05:43 PM, Sergei Shtylyov wrote:
> Add support of the device tree probing for the Renesas SH-Mobile SoCs
> documenting the device tree binding as necessary.
> 
> This work is loosely based on an original patch by Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.yj@renesas.com>.

> Index: net-next/Documentation/devicetree/bindings/net/sh_eth.txt

> +- reg: offset and length of (1) the E-DMAC/feLic register block (required),
> +       (2) the TSU register block (optional).

There's an argument that you should specify reg-names entries to allow
arbitrary ordering or entries within reg, if there's more than one
entry. But, I don't think it's mandatory, just something to consider at
present.

> +- interrupts: interrupt specifier for the sole interrupt.
> +- phy-mode: string, operation mode of the PHY interface (a string that
> +	    of_get_phy_mode() can understand).

DT bindings should be OS-agnostic. of_get_phy_mode() is Linux-specific.
Please spell out the complete list of supported values here, without
reference to Linux-specific code or documentation.

> +- phy-handle: phandle of the PHY device (there should be a PHY device subnode).

Is this a custom property, or part of some generic PHY subsystem
binding? If the latter, please reference the DT binding document for
that subsystem. If it's custom, what kinds of nodes can this phandle
point at; what kind of interface must the referenced DT node provide (is
a #phy-cells property required, must its compatible value be one of a
specific set of values).

> +- #address-cells: number of address cells for the MDIO bus, must be equal to 1.
> +- #size-cells: number of size cells on the MDIO bus, must be equal to 0.

If this node is expected to contain child nodes, you need to specify
details of those child nodes. Can you reference the filename of a
generic MDIO binding? What do the address values mean (perhaps that'd be
covered by the MDIO binding already, if it's applicable).

> +Optional properties:
> +- interrupt-parent: the phandle for the interrupt controller that services
> +		    interrupts for this device.
> +- local-mac-address: 6 bytes, MAC address.
> +- renesas,no-ether-link: boolean, specify when a board does not provide a proper
> +			 Ether LINK signal.
> +- renesas,ether-link-active-low: boolean, specify when the Ether LINK signal is
> +  				 active-low instead of normal active-high.

Presumably the link signal is some dedicated signal in the Ethernet MAC
HW block, and not a generic GPIO? If it's a GPIO, there should be a flag
in the GPIO property/binding you can use for active low.

Do you need any clocks properties, IP block reset signals, power domains?
