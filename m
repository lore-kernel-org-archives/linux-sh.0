From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 10 Sep 2013 14:39:54 +0000
Subject: Re: [PATCH v2 2/2] sh_eth: add device tree support
Message-Id: <522F2F3A.5070406@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201309070343.25640.sergei.shtylyov@cogentembedded.com> <522E3770.9020305@wwwdotorg.org>
In-Reply-To: <522E3770.9020305@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, rob@landley.net, linux-doc@vger.kernel.org

Hello.

On 10-09-2013 1:02, Stephen Warren wrote:

>> Add support of the device tree probing for the Renesas SH-Mobile SoCs
>> documenting the device tree binding as necessary.

>> This work is loosely based on an original patch by Nobuhiro Iwamatsu
>> <nobuhiro.iwamatsu.yj@renesas.com>.

>> Index: net-next/Documentation/devicetree/bindings/net/sh_eth.txt

>> +- reg: offset and length of (1) the E-DMAC/feLic register block (required),
>> +       (2) the TSU register block (optional).

> There's an argument that you should specify reg-names entries to allow
> arbitrary ordering or entries within reg, if there's more than one
> entry. But, I don't think it's mandatory, just something to consider at
> present.

    I also don't think it's needed, the driver has happily worked without 
resource names so far.

>> +- interrupts: interrupt specifier for the sole interrupt.
>> +- phy-mode: string, operation mode of the PHY interface (a string that
>> +	    of_get_phy_mode() can understand).

> DT bindings should be OS-agnostic. of_get_phy_mode() is Linux-specific.
> Please spell out the complete list of supported values here, without
> reference to Linux-specific code or documentation.

    I don't think listing the numerous values of this standrd property in 
every file describing an Ethernet device is practical. How about I create file 
ethernet.txt in the same directory (don't know why I'm the first to do it 
despite many other driver using this property)?

>> +- phy-handle: phandle of the PHY device (there should be a PHY device subnode).

> Is this a custom property, or part of some generic PHY subsystem
> binding?

    The latter.

> If the latter, please reference the DT binding document for
> that subsystem.

    Unfortunately, phy.txt in the same directory describes only properties of 
the "ethernet-phy" nodes. I think the new ethernet.txt would be more fitting 
for the purpose.

> If it's custom, what kinds of nodes can this phandle
> point at; what kind of interface must the referenced DT node provide (is
> a #phy-cells property required, must its compatible value be one of a
> specific set of values).

    This is described by the phy.txt in the same directory.

>> +- #address-cells: number of address cells for the MDIO bus, must be equal to 1.
>> +- #size-cells: number of size cells on the MDIO bus, must be equal to 0.

> If this node is expected to contain child nodes, you need to specify
> details of those child nodes.

    They are specified in phy.txt (this file is somewhat obsolete though).

> Can you reference the filename of a generic MDIO binding?

    OK.

> What do the address values mean (perhaps that'd be
> covered by the MDIO binding already, if it's applicable).

>> +Optional properties:
>> +- interrupt-parent: the phandle for the interrupt controller that services
>> +		    interrupts for this device.
>> +- local-mac-address: 6 bytes, MAC address.
>> +- renesas,no-ether-link: boolean, specify when a board does not provide a proper
>> +			 Ether LINK signal.
>> +- renesas,ether-link-active-low: boolean, specify when the Ether LINK signal is
>> +  				 active-low instead of normal active-high.

> Presumably the link signal is some dedicated signal in the Ethernet MAC
> HW block, and not a generic GPIO?

    Indeed.

> Do you need any clocks properties, IP block reset signals, power domains?

    Currently not.

WBR, Sergei

