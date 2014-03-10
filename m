From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 Mar 2014 11:00:31 +0000
Subject: Re: [PATCH v2] phy-rcar-gen2-usb: add device tree support
Message-Id: <CANqRtoTBYZ4=Ct_q6KjGaOtyLum-qpU9Qm06-qxqVm5unUC_3A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403010407.54639.sergei.shtylyov@cogentembedded.com>
	<CANqRtoRTtsF64jZ-n_VbmzkRehUoBWQLEd5jfAL86wyLrvAUPQ@mail.gmail.com>
	<5319D75C.5020701@cogentembedded.com>
	<531A5CD7.6030903@cogentembedded.com>
In-Reply-To: <531A5CD7.6030903@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux-USB <linux-usb@vger.kernel.org>, robh+dt@kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, SH-Linux <linux-sh@vger.kernel.org>, Valentine Barshak <valentine.barshak@cogentembedded.com>, rob@landley.net, linux-doc@vger.kernel.org

Hi Sergei,

On Sat, Mar 8, 2014 at 8:57 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 03/07/2014 05:27 PM, Sergei Shtylyov wrote:
>
>>>> Add support of the device tree probing for the Renesas R-Car generation
>>>> 2 SoCs
>>>> documenting the device tree binding as necessary.
>
>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>
>>>> ---
>>>> This patch is against the 'next' branch of Felipe Balbi's 'usb.git'
>>>> repo.
>
>
>>>> Changes in version 2:
>>>> - restored devm_clk_get() call and the error handling logic in the
>>>> probe()
>>>>    method, removed clk_put() call in the remove() method.
>
>
>>>>   Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29
>>>> +++++++++++
>>>>   drivers/usb/phy/phy-rcar-gen2-usb.c                     |   42
>>>> ++++++++++++++--
>>>>   2 files changed, 68 insertions(+), 3 deletions(-)
>
>
>>>> Index: usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
>>>> =================================>>>> --- /dev/null
>>>> +++ usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
>>>> @@ -0,0 +1,29 @@
>>>> +* Renesas R-Car generation 2 USB PHY
>>>> +
>>>> +This file provides information on what the device node for the R-Car
>>>> generation
>>>> +2 USB PHY contains.
>>>> +
>>>> +Required properties:
>>>> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of
>>>> R8A7790
>>>> SoC.
>>>> +             "renesas,usb-phy-r8a7791" if the device is a part of
>>>> R8A7791
>>>> SoC.
>>>> +- reg: offset and length of the register block.
>>>> +- clocks: clock phandle and specifier pair.
>>>> +- clock-names: string, clock input name, must be "usbhs".
>>>> +
>>>> +Optional properties:
>>>> +- renesas,channel0-pci: boolean, specify when USB channel 0 should be
>>>> connected
>>>> +                       to PCI EHCI/OHCI; otherwise, it will be
>>>> connected
>>>> to the
>>>> +                       USBHS controller.
>>>> +- renesas,channel2-pci: boolean, specify when USB channel 2 should be
>>>> connected
>>>> +                       to PCI EHCI/OHCI; otherwise, it will be
>>>> connected
>>>> to the
>>>> +                       USBSS controller (xHCI).
>
>
>>> Thanks for your efforts here, but this DT binding looks like a mix of
>>> software configuration and hardware description.
>
>
>>     I disagree. I have already explained to Mark Rutland how selecting a
>> particular controller for a particular USB port should depend on the kind
>> of
>> the USB connector used, i.e. the board hardware.

Just to clarify, I'm talking about the selection of USB IP that is
happening inside the SoC. You are right that there are also board
specific dependencies, but that's a different issue. As an example, on
Lager it is possible to use either USB 2.0 Host device functionality
or USB 3.0 Host functionality using the same USB 3.0-compatible
connector that is being exposed by the Lager board. In this case the
board needs to describe that it has a USB3.0-compatbile connector on
r8a7790 USB2, while the r8a7790 PHY driver and USB Host controller
glue needs to represent which internal devices that are mapped to
USB2.

I imagine that there are board-specific DT bits for Lager that
describe USB2 as USB3.0 compatible. Then there are r8a7790 specific
bits that show how the USB2.0 host controller and the USB3.0 host
controller both point to the USB2 channel included in the USB PHY. The
last portion is not modified by the board-level integrator, only the
board specific bits.

>>>> +Example (Lager board):
>>>> +
>>>> +       usb-phy@e6590100 {
>>>> +               compatible = "renesas,usb-phy-r8a7790";
>>>> +               reg = <0 0xe6590100 0 0x100>;
>>>> +               clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
>>>> +               clock-names = "usbhs";
>>>> +               renesas,channel2-pci;
>>>> +       };
>
>
>>> As an example, instead of relying on "renesas,channel0-pci" or
>>> "renesas,channel2-pci" to specify which hard coded software
>>> configuration you want please rework this to expose 3 separate
>>> channels and use DT to point each host controller to the right
>>> channel.
>
>
>>     So you want to expose the channels as "virtual devices"? Or what do
>> you
>> want?

I'm not sure what "virtual devices" would be, but channel sub nodes
sounds like one possibility.

>    OK, let's assume you want either "virtual" PHYs or channel subnodes in
> the PHY node we have now. Now what the PHY driver should do with all these
> phandles pointing from the controller nodes to the PHY nodes or the channel
> subnodes? Scan all device tree in search of the nodes having certain prop
> and get info from such nodes on how to program the channel MUXing register
> using their "compatible" props? Sorry, that doesn't appeal to me at all.

I can't say that I'm 100% sure what is the best solution for this, but
I'm quite OK with basically anything that describes the hardware
mapping between PHY ports and host controllers in a sane way.

Exactly how to represent this in a sane way is however not trivial.
But how fun would that be? =)

One example from my side (which may be bad, not sure) is to point from
each USB Host controller to a subnode in the USB PHY device. But then
you will have to scan all though devices to find the link which may
not be what you want.

>    Now if we got the phandles pointing from the PHY node back to the
> selected controllers, things would look somewhat better. Yet it still looks
> like an unnecessary complication of what I'm proposing and so doesn't appeal
> to me much either.

So my other example is probably same as your proposal above, which
would be to point all USB Host controllers to the same USB PHY, but as
DT properties in the PHY device have one list per USB port that points
back to all possible USB Host controllers. That would make scanning
easier.

>    So, what's your intent here (other than to make my life harder :-)?

Of course, only to make your life harder. =)

My goal is to describe the hardware connections between the PHY ports
and the USB Host controllers so we eventually in software would be
able to switch between USBHS for Function (or maybe Host) and USB PCI
for USB Host on a board where the hardware allows us to do so. I want
to be able to over time improve the kernel and do this without having
to modify the DTS. Actually, I'd like the DTS to show us how we can
switch the hardware.

This is quite different from hard coding one connection in the DTS.

>> Also, it seems almost impossible to represent some USB controllers in DT
>> -- such as USBHS in particular.

I'm not sure if impossible is the word I would pick, but it is indeed
difficult. My opinion is that we cannot rush this kind of development.
It is fine to take shortcuts with platform devices, but with DT we
want to get it right.

>    I've spent several days staring at the various USBHS code and I'm going
> to send you a more detailed report on USBHS vs DT issues.

Sure, if that makes you happy, but I'm more interested in patches myself. =)

>>> So this is a NAK on my side. I expect better.
>
>>     Thanks for your long awaited feedback.
>
>    I'm not convinced that what you're proposing is indeed better though.

Well, I'm looking forward to a better proposal then! =)

Thanks,

/ magnus
