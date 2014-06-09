From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 09 Jun 2014 12:34:19 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <5395A9CB.5010008@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com> <1599447.RVY9gPzyeE@avalon>
In-Reply-To: <1599447.RVY9gPzyeE@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com, grant.likely@linaro.org, devicetree@vger.kernel.org, rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 06/09/2014 03:44 PM, Laurent Pinchart wrote:

> Thank you for the patch.

    Could you please remove the parts of the patch to which you didn't reply? 
I've hardly found your comment.

> On Saturday 24 May 2014 02:06:03 Sergei Shtylyov wrote:
>> This PHY, though formally being a part of Renesas USBHS controller, contains
>> the UGCTRL2 register that controls multiplexing of the USB ports (Renesas
>> calls them channels) to the different USB controllers: channel 0 can be
>> connected to either PCI EHCI/OHCI or USBHS controllers, channel 2 can be
>> connected to PCI EHCI/OHCI or xHCI controllers.

>> This is a new driver for this USB PHY currently already supported under
>> drivers/ usb/phy/. The reason for writing the new driver was the
>> requirement that the multiplexing of USB channels to the controller be
>> dynamic, depending on what USB drivers are loaded,  rather than static as
>> provided by the old driver. The infrastructure provided by
>> drivers/phy/phy-core.c seems to fit that purpose ideally. The new driver
>> only supports device tree probing for now.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

>> Index: linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
>> =================================>> --- /dev/null
>> +++ linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
>> @@ -0,0 +1,60 @@
>> +* Renesas R-Car generation 2 USB PHY
>> +
>> +This file provides information on what the device node for the R-Car
>> generation +2 USB PHY contains.
>> +
>> +Required properties:
>> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790
>> SoC. +	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791
>> SoC. +- reg: offset and length of the register block.
>> +- #phy-cells: see phy-bindings.txt in the same directory, must be 2.
>> +- clocks: clock phandle and specifier pair.
>> +- clock-names: string, clock input name, must be "usbhs".

> Is that the functional clock for the PHY ? If so, what about naming it "fck"
> (or something similar) ?

    No, it's the clock for the USBHS controller to which this PHY belongs.

WBR, Sergei

