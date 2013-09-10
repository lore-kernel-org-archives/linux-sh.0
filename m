From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 10 Sep 2013 15:15:51 +0000
Subject: Re: [PATCH v2 2/2] sh_eth: add device tree support
Message-Id: <522F37A7.90804@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201309070343.25640.sergei.shtylyov@cogentembedded.com> <522E3770.9020305@wwwdotorg.org> <522F2F3A.5070406@cogentembedded.com>
In-Reply-To: <522F2F3A.5070406@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, rob@landley.net, linux-doc@vger.kernel.org

On 09/10/2013 08:39 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 10-09-2013 1:02, Stephen Warren wrote:
> 
>>> Add support of the device tree probing for the Renesas SH-Mobile SoCs
>>> documenting the device tree binding as necessary.
> 
>>> This work is loosely based on an original patch by Nobuhiro Iwamatsu
>>> <nobuhiro.iwamatsu.yj@renesas.com>.
> 
>>> Index: net-next/Documentation/devicetree/bindings/net/sh_eth.txt
> 
>>> +- reg: offset and length of (1) the E-DMAC/feLic register block
>>> (required),
>>> +       (2) the TSU register block (optional).
> 
>> There's an argument that you should specify reg-names entries to allow
>> arbitrary ordering or entries within reg, if there's more than one
>> entry. But, I don't think it's mandatory, just something to consider at
>> present.
> 
>    I also don't think it's needed, the driver has happily worked without
> resource names so far.
> 
>>> +- interrupts: interrupt specifier for the sole interrupt.
>>> +- phy-mode: string, operation mode of the PHY interface (a string that
>>> +        of_get_phy_mode() can understand).
> 
>> DT bindings should be OS-agnostic. of_get_phy_mode() is Linux-specific.
>> Please spell out the complete list of supported values here, without
>> reference to Linux-specific code or documentation.
> 
>    I don't think listing the numerous values of this standrd property in
> every file describing an Ethernet device is practical. How about I
> create file ethernet.txt in the same directory (don't know why I'm the
> first to do it despite many other driver using this property)?

We must list the values somewhere. Creating an ethernet.txt, documenting
them there, and modifying the description of this property to reference
ethernet.txt would be fine.

>>> +- phy-handle: phandle of the PHY device (there should be a PHY
>>> device subnode).
> 
>> Is this a custom property, or part of some generic PHY subsystem
>> binding?
> 
>    The latter.
> 
>> If the latter, please reference the DT binding document for
>> that subsystem.
> 
>    Unfortunately, phy.txt in the same directory describes only
> properties of the "ethernet-phy" nodes. I think the new ethernet.txt
> would be more fitting for the purpose.

That's fine, so long as it's documented somewhere, and this document
references that place.

>> Do you need any clocks properties, IP block reset signals, power domains?
> 
>    Currently not.

What does "currently" mean? Does that mean that the Linux driver simply
doesn't touch those entities at present? If so, that's not enough to say
that those entities should not be described in the DT binding. We should
strive to make the binding completely describe all aspects of the HW,
irrespective of whether a particular driver happens to use that
information at present.

