From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 11 Mar 2014 22:32:31 +0000
Subject: Re: [PATCH v2] phy-rcar-gen2-usb: add device tree support
Message-Id: <531F9D02.5060009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403010407.54639.sergei.shtylyov@cogentembedded.com>	<CANqRtoRTtsF64jZ-n_VbmzkRehUoBWQLEd5jfAL86wyLrvAUPQ@mail.gmail.com>	<5319D75C.5020701@cogentembedded.com>	<531A5CD7.6030903@cogentembedded.com> <CANqRtoTBYZ4=Ct_q6KjGaOtyLum-qpU9Qm06-qxqVm5unUC_3A@mail.gmail.com>
In-Reply-To: <CANqRtoTBYZ4=Ct_q6KjGaOtyLum-qpU9Qm06-qxqVm5unUC_3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux-USB <linux-usb@vger.kernel.org>, robh+dt@kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, SH-Linux <linux-sh@vger.kernel.org>, Valentine Barshak <valentine.barshak@cogentembedded.com>, rob@landley.net, linux-doc@vger.kernel.org

Hello.

On 03/10/2014 02:00 PM, Magnus Damm wrote:

>>>>> Add support of the device tree probing for the Renesas R-Car generation
>>>>> 2 SoCs
>>>>> documenting the device tree binding as necessary.

>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>>>> ---
>>>>> This patch is against the 'next' branch of Felipe Balbi's 'usb.git'
>>>>> repo.

>>>>> Changes in version 2:
>>>>> - restored devm_clk_get() call and the error handling logic in the
>>>>> probe()
>>>>>     method, removed clk_put() call in the remove() method.

>>>>>    Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29
>>>>> +++++++++++
>>>>>    drivers/usb/phy/phy-rcar-gen2-usb.c                     |   42
>>>>> ++++++++++++++--
>>>>>    2 files changed, 68 insertions(+), 3 deletions(-)

>>>>> Index: usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
>>>>> =================================>>>>> --- /dev/null
>>>>> +++ usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
>>>>> @@ -0,0 +1,29 @@
>>>>> +* Renesas R-Car generation 2 USB PHY
>>>>> +
>>>>> +This file provides information on what the device node for the R-Car
>>>>> generation
>>>>> +2 USB PHY contains.
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of
>>>>> R8A7790
>>>>> SoC.
>>>>> +             "renesas,usb-phy-r8a7791" if the device is a part of
>>>>> R8A7791
>>>>> SoC.
>>>>> +- reg: offset and length of the register block.
>>>>> +- clocks: clock phandle and specifier pair.
>>>>> +- clock-names: string, clock input name, must be "usbhs".
>>>>> +
>>>>> +Optional properties:
>>>>> +- renesas,channel0-pci: boolean, specify when USB channel 0 should be
>>>>> connected
>>>>> +                       to PCI EHCI/OHCI; otherwise, it will be
>>>>> connected
>>>>> to the
>>>>> +                       USBHS controller.
>>>>> +- renesas,channel2-pci: boolean, specify when USB channel 2 should be
>>>>> connected
>>>>> +                       to PCI EHCI/OHCI; otherwise, it will be
>>>>> connected
>>>>> to the
>>>>> +                       USBSS controller (xHCI).

>>>> Thanks for your efforts here, but this DT binding looks like a mix of
>>>> software configuration and hardware description.

>>>      I disagree. I have already explained to Mark Rutland how selecting a
>>> particular controller for a particular USB port should depend on the kind
>>> of
>>> the USB connector used, i.e. the board hardware.

> Just to clarify, I'm talking about the selection of USB IP that is
> happening inside the SoC.

    I'm talking about the same thing.

> You are right that there are also board
> specific dependencies, but that's a different issue.

    I don't really think so.

> As an example, on
> Lager it is possible to use either USB 2.0 Host device functionality
> or USB 3.0 Host functionality using the same USB 3.0-compatible
> connector that is being exposed by the Lager board.

    Note that USB 3.0 controller (xHCI) knows how to talk USB 2.0 and 1.1 
protocols, and I see little sense enabling EHCI/OHCI for USB 3.0 port (as it's 
done now), unless the xHCI hardware/driver is very buggy.

> In this case the
> board needs to describe that it has a USB3.0-compatbile connector on

    Hm, I think we'll then be the first trying to describe the board connector 
types in the device tree, at least I can't remember any example off the top of 
my head.

> r8a7790 USB2, while the r8a7790 PHY driver and USB Host controller
> glue needs to represent which internal devices that are mapped to
> USB2.

> I imagine that there are board-specific DT bits for Lager that
> describe USB2 as USB3.0 compatible. Then there are r8a7790 specific
> bits that show how the USB2.0 host controller and the USB3.0 host
> controller both point to the USB2 channel included in the USB PHY. The
> last portion is not modified by the board-level integrator, only the
> board specific bits.

    So, those "board specific bits" would be considered the ultimate source of 
information of how to program USB channel MUXes, right? Or you mean to only 
provide the USB connector info there?
    My main concern is where the data to program MUXes would be placed and, 
maybe more importantly, in what way they would be conveyed to the PHY driver, 
while you seem mainly concerning about the topology representation.

>>>>> +Example (Lager board):
>>>>> +
>>>>> +       usb-phy@e6590100 {
>>>>> +               compatible = "renesas,usb-phy-r8a7790";
>>>>> +               reg = <0 0xe6590100 0 0x100>;
>>>>> +               clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
>>>>> +               clock-names = "usbhs";
>>>>> +               renesas,channel2-pci;
>>>>> +       };

>>>> As an example, instead of relying on "renesas,channel0-pci" or
>>>> "renesas,channel2-pci" to specify which hard coded software
>>>> configuration you want please rework this to expose 3 separate
>>>> channels and use DT to point each host controller to the right
>>>> channel.

>>>      So you want to expose the channels as "virtual devices"? Or what do
>>> you want?

> I'm not sure what "virtual devices" would be,

    Devices without the "reg" property. By the way, from the manuals it didn't 
became crystal clear to me whether USBHS internal PHY (that is programmable 
and controls USB0/2 channel MUX among other things) and USB 2.0/3.0 PHY (that 
is not programmable but USB 3.0 part of which can be used alternatively as 
SATA0 PHY) is even one and the same thing. The PHY registers we control thru 
the dedicated PHY driver are documented along with other USBHS registers, so 
one might have an impression this PHY is dedicated to USBHS only... If this is 
not so, the USB PHY design and the way it's documented seems quite 
questionable to me.

> but channel sub nodes sounds like one possibility.

    OK.

>>     OK, let's assume you want either "virtual" PHYs or channel subnodes in
>> the PHY node we have now. Now what the PHY driver should do with all these
>> phandles pointing from the controller nodes to the PHY nodes or the channel
>> subnodes? Scan all device tree in search of the nodes having certain prop
>> and get info from such nodes on how to program the channel MUXing register
>> using their "compatible" props? Sorry, that doesn't appeal to me at all.

> I can't say that I'm 100% sure what is the best solution for this, but
> I'm quite OK with basically anything that describes the hardware
> mapping between PHY ports and host controllers in a sane way.

> Exactly how to represent this in a sane way is however not trivial.
> But how fun would that be? =)

    I'm afraid I'm not a huge fan of device trees (although I had to acquaint 
myself with them back in 2006, my first experience wasn't quite successful), 
so the fun for me seems somewhat dubious... I'm of the opinion that plain old 
platform devices are far more flexible than DT, and seeing DT more as a 
necessary evil used to bring the ARM kernel to the more reasonable sizes
and follow the x86 suit with the multiplatform builds...

> One example from my side (which may be bad, not sure) is to point from
> each USB Host controller to a subnode in the USB PHY device. But then
> you will have to scan all though devices to find the link which may
> not be what you want.

    Yes, I would like to avoid that.

>>     Now if we got the phandles pointing from the PHY node back to the
>> selected controllers, things would look somewhat better. Yet it still looks
>> like an unnecessary complication of what I'm proposing and so doesn't appeal
>> to me much either.

> So my other example is probably same as your proposal above, which
> would be to point all USB Host controllers to the same USB PHY, but as
> DT properties in the PHY device have one list per USB port that points
> back to all possible USB Host controllers. That would make scanning
> easier.

    OK...

>>     So, what's your intent here (other than to make my life harder :-)?

> Of course, only to make your life harder. =)

    Well, so far you seem to succeed. :-)

> My goal is to describe the hardware connections between the PHY ports
> and the USB Host controllers so we eventually in software would be
> able to switch between USBHS for Function (or maybe Host) and USB PCI
> for USB Host on a board where the hardware allows us to do so. I want
> to be able to over time improve the kernel and do this without having
> to modify the DTS.

    Not sure I understand what you're imagining here...

> Actually, I'd like the DTS to show us how we can
> switch the hardware.

    That's clear. I'm only not sure we really need that information in the 
device tree in order to switch the hardware. Oh well...

> This is quite different from hard coding one connection in the DTS.

    Well, having such limited platform data, I had little choice but mimic it 
in DT as it's usually done, at least for a first try...

>>> Also, it seems almost impossible to represent some USB controllers in DT
>>> -- such as USBHS in particular.

> I'm not sure if impossible is the word I would pick, but it is indeed
> difficult.

    Let's agree on "very difficult". :-)

> My opinion is that we cannot rush this kind of development.
> It is fine to take shortcuts with platform devices, but with DT we
> want to get it right.

    OK... but that makes the PHY DT work a matter of quite distant future, 
doesn't it? I mean unless we use much avoided so far auxdata thing for USBHS.

>>     I've spent several days staring at the various USBHS code and I'm going
>> to send you a more detailed report on USBHS vs DT issues.

> Sure, if that makes you happy, but I'm more interested in patches myself. =)

    No, it won't, so let's skip it.

>>>> So this is a NAK on my side. I expect better.

>>>      Thanks for your long awaited feedback.

>>     I'm not convinced that what you're proposing is indeed better though.

> Well, I'm looking forward to a better proposal then! =)

    Unfortunately, I'm lacking your imagination here. :-)

> Thanks,

> / magnus

WBR, Sergei

