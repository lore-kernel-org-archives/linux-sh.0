From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 28 Feb 2014 11:17:05 +0000
Subject: Re: [PATCH 06/11] phy-rcar-usb-gen2: add device tree documentation
Message-Id: <53107031.7010301@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1391595554-20640-7-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1391595554-20640-7-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 28/02/14 00:11, Sergei Shtylyov wrote:
> Hello.
>
> On 02/27/2014 07:28 PM, Ben Dooks wrote:
>
>>>> Documentation for phy-rcar-usb-gen2 device tree binding.
>
>>>     Only phy-rcar-gen2-usb.
>
>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
>>>     That's the latest posting of the binding document I've found. It
>>> wasn't posted to linux-usb.
>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>>>> b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>>>> new file mode 100644
>>>> index 0000000..e1d2dd9
>>>> --- /dev/null
>>>> +++
>>>> b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>>>> @@ -0,0 +1,16 @@
> [...]
>>>> + - reg : A single region to access device registers
>>>> + - clocks : The reference to the clock to use for this block
>>>> + - clock-names : The name for the clock at index 0 (must be "usbhs")
>>>> +
>>>> +Note, interrupt is currently not supported by the driver, but there
>>>> should
>>>> +be a node in the device tree for it.
>
>>>     Hm, I thought USBHS PHY itself doesn't have any interrupts. Should
>>> check the manuals on whether the USBHS interrupt has any PHY specific
>>> conditions...
>
>> I will check, there is mention of an OtG interrupt in the GIC irq map.
>
>     This PHY is not OTG, and neither USBHS itself. I'm not sure which IP
> that interrupt belongs to though...

I though maybe it was one of the special-function pins for detecting a
device, but there's no other documentation on the situation that I am
considering just removing the interrupt from the documentation.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
