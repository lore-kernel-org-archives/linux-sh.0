From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 07 Mar 2014 22:57:07 +0000
Subject: Re: [PATCH v2] phy-rcar-gen2-usb: add device tree support
Message-Id: <531A5CD7.6030903@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403010407.54639.sergei.shtylyov@cogentembedded.com> <CANqRtoRTtsF64jZ-n_VbmzkRehUoBWQLEd5jfAL86wyLrvAUPQ@mail.gmail.com> <5319D75C.5020701@cogentembedded.com>
In-Reply-To: <5319D75C.5020701@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux-USB <linux-usb@vger.kernel.org>, robh+dt@kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, SH-Linux <linux-sh@vger.kernel.org>, Valentine Barshak <valentine.barshak@cogentembedded.com>, rob@landley.net, linux-doc@vger.kernel.org

Hello.

On 03/07/2014 05:27 PM, Sergei Shtylyov wrote:

>>> Add support of the device tree probing for the Renesas R-Car generation 2 SoCs
>>> documenting the device tree binding as necessary.

>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>> ---
>>> This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.

>>> Changes in version 2:
>>> - restored devm_clk_get() call and the error handling logic in the probe()
>>>    method, removed clk_put() call in the remove() method.

>>>   Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29 +++++++++++
>>>   drivers/usb/phy/phy-rcar-gen2-usb.c                     |   42
>>> ++++++++++++++--
>>>   2 files changed, 68 insertions(+), 3 deletions(-)

>>> Index: usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
>>> =================================>>> --- /dev/null
>>> +++ usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
>>> @@ -0,0 +1,29 @@
>>> +* Renesas R-Car generation 2 USB PHY
>>> +
>>> +This file provides information on what the device node for the R-Car
>>> generation
>>> +2 USB PHY contains.
>>> +
>>> +Required properties:
>>> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790
>>> SoC.
>>> +             "renesas,usb-phy-r8a7791" if the device is a part of R8A7791
>>> SoC.
>>> +- reg: offset and length of the register block.
>>> +- clocks: clock phandle and specifier pair.
>>> +- clock-names: string, clock input name, must be "usbhs".
>>> +
>>> +Optional properties:
>>> +- renesas,channel0-pci: boolean, specify when USB channel 0 should be
>>> connected
>>> +                       to PCI EHCI/OHCI; otherwise, it will be connected
>>> to the
>>> +                       USBHS controller.
>>> +- renesas,channel2-pci: boolean, specify when USB channel 2 should be
>>> connected
>>> +                       to PCI EHCI/OHCI; otherwise, it will be connected
>>> to the
>>> +                       USBSS controller (xHCI).

>> Thanks for your efforts here, but this DT binding looks like a mix of
>> software configuration and hardware description.

>     I disagree. I have already explained to Mark Rutland how selecting a
> particular controller for a particular USB port should depend on the kind of
> the USB connector used, i.e. the board hardware.

>>> +Example (Lager board):
>>> +
>>> +       usb-phy@e6590100 {
>>> +               compatible = "renesas,usb-phy-r8a7790";
>>> +               reg = <0 0xe6590100 0 0x100>;
>>> +               clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
>>> +               clock-names = "usbhs";
>>> +               renesas,channel2-pci;
>>> +       };

>> As an example, instead of relying on "renesas,channel0-pci" or
>> "renesas,channel2-pci" to specify which hard coded software
>> configuration you want please rework this to expose 3 separate
>> channels and use DT to point each host controller to the right
>> channel.

>     So you want to expose the channels as "virtual devices"? Or what do you
> want?

    OK, let's assume you want either "virtual" PHYs or channel subnodes in the 
PHY node we have now. Now what the PHY driver should do with all these 
phandles pointing from the controller nodes to the PHY nodes or the channel 
subnodes? Scan all device tree in search of the nodes having certain prop and 
get info from such nodes on how to program the channel MUXing register using 
their "compatible" props? Sorry, that doesn't appeal to me at all.
    Now if we got the phandles pointing from the PHY node back to the selected 
controllers, things would look somewhat better. Yet it still looks like an 
unnecessary complication of what I'm proposing and so doesn't appeal to me 
much either.
    So, what's your intent here (other than to make my life harder :-)?

> Also, it seems almost impossible to represent some USB controllers in DT
> -- such as USBHS in particular.

    I've spent several days staring at the various USBHS code and I'm going to 
send you a more detailed report on USBHS vs DT issues.

[...]

>> So this is a NAK on my side. I expect better.

>     Thanks for your long awaited feedback.

    I'm not convinced that what you're proposing is indeed better though.

>> Thanks,

>> / magnus

WBR, Sergei

