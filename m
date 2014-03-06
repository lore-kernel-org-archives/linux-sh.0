From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 06 Mar 2014 19:54:51 +0000
Subject: Re: [PATCH 3/9] phy-rcar-usb-gen2: add device tree support
Message-Id: <5318E09D.6000305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-4-git-send-email-ben.dooks@codethink.co.uk> <5318C973.70501@cogentembedded.com> <5318BC3A.808@codethink.co.uk>
In-Reply-To: <5318BC3A.808@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@lists.codethink.co.uk, magnus.damn@opensource.se, horms@verge.net.au, Felipe Balbi <balbi@ti.com>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Hello.

On 03/06/2014 09:19 PM, Ben Dooks wrote:

>>> Add support for the phy-rcar-gen2-usb driver to be probed from device
>>> tree.

>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
[...]

>>>   drivers/usb/phy/phy-rcar-gen2-usb.c                | 34
>>> +++++++++++++++++---
>>>   3 files changed, 66 insertions(+), 5 deletions(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt

>>> diff --git
>>> a/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>>> b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>>> new file mode 100644
>>> index 0000000..5351a30
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
>>> @@ -0,0 +1,36 @@
>>> +Renesas RCar gen2 USB PHY bindings
>>> +----------------------------------
>>> +
>>> +Bindings for the USB PHY block used in some Renesas SoCs.
>>> +
>>> +Required properties:
>>> + - compatible:  "renesas,usb-phy-r8a7790" for the R8A7790 SoC
>>> +        "renesas,usb-phy-r8a7791" for the R8A7791 SoC
>>> + - reg : A single region to access device registers
>>> + - clocks : The reference to the clock to use for this block
>>> + - clock-names : The name for the clock at index 0 (must be "usbhs")
>>> +
>>> +Optional properties:
>>> +
>>> + - renesas,usb0-device: boolean, if present USB0 is connected to HS
>>> device
>>> +            otherwise the USB0 is connected to OHCI/EHCI host.

>>     IIUC, the testing has shown that USBHS is dual-role controller in
>> that case, i.e. supports both host and device roles (the manual has the
>> host controller details too). Vladimir, is it so?

> Currently there is no auto-detection for this, so it gets set at
> start time.

    The mode can be auto-detected by reading SW5. My point was however, that 
it doesn't seem correct to call the prop "renesas,usb0-device". I'd rather 
suggest "renesas,usb0-usbhs" if you keep sticking to the scheme opposite to 
the platform data.

WBR, Sergei

