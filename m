From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 03 Mar 2014 16:50:40 +0000
Subject: Re: [PATCH v2] phy-rcar-gen2-usb: add device tree support
Message-Id: <5314C0E9.2020202@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403010407.54639.sergei.shtylyov@cogentembedded.com> <20140303164426.GD10987@saruman.home>
In-Reply-To: <20140303164426.GD10987@saruman.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-sh@vger.kernel.org, valentine.barshak@cogentembedded.com, rob@landley.net, linux-doc@vger.kernel.org

Hello.

On 03/03/2014 07:44 PM, Felipe Balbi wrote:

>> Add support of the device tree probing for the Renesas R-Car generation 2 SoCs
>> documenting the device tree binding as necessary.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Unless someone on devicetree@vger gives me an ACK pretty soon, I'm
> afraid this patch will miss v3.15.

    Ugh, the USB acceptance window is getting very short...

>> ---
>> This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.
>>
>> Changes in version 2:
>> - restored devm_clk_get() call and the error handling logic in the probe()
>>    method, removed clk_put() call in the remove() method.

>>   Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29 +++++++++++
>>   drivers/usb/phy/phy-rcar-gen2-usb.c                     |   42 ++++++++++++++--
>>   2 files changed, 68 insertions(+), 3 deletions(-)

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

> I wonder if these two properties should be taken care by pinctrl
> framework instead.

    No, the internal port multiplexing is controlled by the PHY itself, see 
the driver source. The same way it was with USB port 1 of the generation 1 
R-Car SoCs.

WBR, Sergei

