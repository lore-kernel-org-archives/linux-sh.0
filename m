From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 27 Feb 2014 16:28:35 +0000
Subject: Re: [PATCH 06/11] phy-rcar-usb-gen2: add device tree documentation
Message-Id: <530F67B3.7060606@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1391595554-20640-7-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1391595554-20640-7-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 27/02/14 16:09, Sergei Shtylyov wrote:
> Hello.
>
> On 05-02-2014 14:19, Ben Dooks wrote:
>
>> Documentation for phy-rcar-usb-gen2 device tree binding.
>
>     Only phy-rcar-gen2-usb.
>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
>     That's the latest posting of the binding document I've found. It
> wasn't posted to linux-usb.
>
>> diff --git
>> a/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>> b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>> new file mode 100644
>> index 0000000..e1d2dd9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>> @@ -0,0 +1,16 @@
>> +Renesas RCar gen2 USB PHY bindings
>> +
>> +Required properties:
>> + - compatible: "renesas,usb-phy-r8a7790" for the R8A7790 SoC or
>> +    "renesas,rcar-gen2-usb-phy" for any generic comaptible device.
>
>     s/comaptible/compatible/. And the second value is seriously not needed.
> If you can't test the patch with all SoCs, and are in doubt, just leave
> one SoC specific value, and let the others add other values after testing.

Ok, will remove the generic one.

>> + - reg : A single region to access device registers
>> + - clocks : The reference to the clock to use for this block
>> + - clock-names : The name for the clock at index 0 (must be "usbhs")
>> +
>> +Note, interrupt is currently not supported by the driver, but there
>> should
>> +be a node in the device tree for it.
>
>     Hm, I thought USBHS PHY itself doesn't have any interrupts. Should
> check the manuals on whether the USBHS interrupt has any PHY specific
> conditions...

I will check, there is mention of an OtG interrupt in the GIC irq map.

>> +
>> +Optional properties:
>> +
>> + - renesas,usb0-hs: boolean, if present USB0 is connected to HS device.
>
>     This description seems completely wrong. The property and bits it
> control don't have to do with USB device connected to USB channel 0;
> they have to do with the host/function controller, and in this case both
> alternatives (EHCI and USBHS) support HS, so the property doesn't
> provide any real distinction.
>
>> + - renesas,usb2-ss: boolean, if present USB2 is connected to XHCI
>> controller.
>
>     It wouldn't hurt to describe what it is connected to USB2 if the
> property is missing.
>
> WBR, Sergei

Thanks, I will look over these tomorrow.

Any chance of a patch to fix the issues found in the driver by then?



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
