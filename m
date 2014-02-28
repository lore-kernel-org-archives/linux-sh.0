From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Feb 2014 21:23:46 +0000
Subject: Re: [PATCH] phy-rcar-gen2-usb: add device tree support
Message-Id: <53110C63.5020207@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402270312.51588.sergei.shtylyov@cogentembedded.com> <20140227155657.GD8647@e106331-lin.cambridge.arm.com>
In-Reply-To: <20140227155657.GD8647-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "valentine.barshak-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <valentine.barshak-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello.

On 02/27/2014 06:56 PM, Mark Rutland wrote:

>> Add support of the device tree probing for the Renesas R-Car generation 2 SoCs
>> documenting the device tree binding as necessary.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.

>>   Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29 +++++++
>>   drivers/usb/phy/phy-rcar-gen2-usb.c                     |   64 ++++++++++++++--
>>   2 files changed, 85 insertions(+), 8 deletions(-)

>> Index: usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
>> =================================>> --- /dev/null
>> +++ usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
>> @@ -0,0 +1,29 @@
>> +* Renesas R-Car generation 2 USB PHY
>> +
>> +This file provides information on what the device node for the R-Car generation
>> +2 USB PHY contains.
>> +
>> +Required properties:
>> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
>> +	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.

> Is the r8a7791's USB PHY known to be different to that of the r8a7790?

    Not at all, according to the preliminary manuals. The problem is the 
SH-Mobile maintainers don't trust the manuals (translated from Japanese, they 
are sometimes indeed of a questionable quality).

> If this is just to possibly handle the two differently in future, why
> not have "renesas,usb-phy-r8a7790" as a fallback in the compatible list?
> That was you only need it in the driver for now.

    The SH-Mobile maintainers are against that approach.

>> +- reg: offset and length of the register block.
>> +- clocks: clock phandle and specifier pair.
>> +- clock-names: string, clock input name, must be "usbhs".
>> +
>> +Optional properties:
>> +- renesas,channel0-pci: boolean, specify when USB channel 0 should be connected
>> +			to PCI EHCI/OHCI; otherwise, it will be connected to the
>> +			USBHS controller.
>> +- renesas,channel2-pci: boolean, specify when USB channel 2 should be connected
>> +			to PCI EHCI/OHCI; otherwise, it will be connected to the
>> +			USBSS controller (xHCI).

> When would you want this to connect to PCI, and when would you not? Why
> is this not a run-time decision?

    I think it's mostly connector type thing: A (host) vs B (device), USB 2.0 
vs 3.0. With B connector you certainly want USBHS controller which is includes 
the function controller (testing has shown that it also has the host 
controller but the manuals don't quite say that). With A connector, user would 
probably prefer PCI EHCI/OHCI, unless you have a USB 3.0 port in which case 
the preference would probably be xHCI. So it appears to be the board specific 
thing. Some runtime switching (e.g. downgrading from xHCI to PCI EHCI/OHCI) 
might be considered too but I don't quite have a picture how that would work yet.

>> +
>> +Example (Lager board):
>> +
>> +	usb-phy@e6590100 {
>> +		compatible = "renesas,usb-phy-r8a7790";
>> +		reg = <0 0xe6590100 0 0x100>;
>> +		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
>> +		clock-names = "usbhs";
>> +		renesas,channel2-pci;
>> +	};

> We're not using the generic phy bindings?

    It's not a driver/phy/ but driver/usb/phy/ code, so I guess we're not.

> How is the linkage to the host controller expressed?

    Looking at Documentation/devicetree/bindings/usb/, it's via "usb-phy" 
property in the host device nodes.

> [...]

>> -	clk = devm_clk_get(dev, "usbhs");
>> +	if (np)
>> +		clk = of_clk_get_by_name(np, "usbhs");
>> +	else
>> +		clk = clk_get(dev, "usbhs");

> Doesn't clk_get (and hence devm_clk_get) call of_clk_get_by_name?

    Indeed, stupid me. I just didn't expect it, so didn't even look there.

> Cheers,
> Mark.

WBR, Sergei


