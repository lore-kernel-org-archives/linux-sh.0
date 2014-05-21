From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 21 May 2014 08:16:45 +0000
Subject: Re: [PATCH 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <537C60ED.9090300@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D805.3070002@renesas.com> <5727435.rfALGRgzCB@wuerfel> <537C5B98.7060401@renesas.com> <5594897.Dm70JHoDO1@wuerfel>
In-Reply-To: <5594897.Dm70JHoDO1@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


(2014/05/21 17:04), Arnd Bergmann wrote:
> On Wednesday 21 May 2014 16:54:00 Yoshihiro Shimoda wrote:
>>
>> (2014/05/20 19:11), Arnd Bergmann wrote:
>>> On Monday 19 May 2014 19:08:05 Yoshihiro Shimoda wrote:
>>>>
>>>>  #include "xhci.h"
>>>>  #include "xhci-mvebu.h"
>>>> +#include "xhci-rcar.h"
>>>>
>>>>  static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>>>>  {
>>>> @@ -39,6 +40,12 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
>>>>
>>>>  static int xhci_plat_start(struct usb_hcd *hcd)
>>>>  {
>>>> +    struct device_node *of_node = hcd->self.controller->of_node;
>>>> +
>>>> +    if (of_device_is_compatible(of_node, "renesas,r8a7790-xhci") ||
>>>> +        of_device_is_compatible(of_node, "renesas,r8a7790-xhci"))
>>>> +            xhci_rcar_start(hcd);
>>>> +
>>>>      return xhci_run(hcd);
>>>>  }
>>>>
>>>> @@ -165,6 +172,15 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>>>                      goto unmap_registers;
>>>>      }
>>>>
>>>> +    if (of_device_is_compatible(pdev->dev.of_node,
>>>> +                                "renesas,r8a7790-xhci") ||
>>>> +        of_device_is_compatible(pdev->dev.of_node,
>>>> +                                "renesas,r8a7791-xhci")) {
>>>> +            ret = xhci_rcar_init_quirk(pdev);
>>>> +            if (ret)
>>>> +                    goto disable_clk;
>>>> +    }
>>>> +
>>>>      ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>>>>      if (ret)
>>>>              goto disable_clk;
>>>> @@ -270,6 +286,8 @@ static const struct of_device_id usb_xhci_of_match[] = {
>>>>      { .compatible = "xhci-platform" },
>>>>      { .compatible = "marvell,armada-375-xhci"},
>>>>      { .compatible = "marvell,armada-380-xhci"},
>>>> +    { .compatible = "renesas,r8a7790-xhci"},
>>>> +    { .compatible = "renesas,r8a7791-xhci"},
>>>>      { },
>>>>  };
>>>>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
>>>
>>> Like the drivers before, this is way more than a quirk, and deserves to
>>> be its own driver. It would be better to have an abstract way to split
>>> out soc specific xhci front-ends and export functions from the xhci-platform
>>> code.
>>
>> Thank you for your comment. But, I couldn't understand your comment...
>> Did you mean that xhci-rcar.c should call of_device_is_compatible(of_node, "renesas,...")?
>> If so, I will modify this patch.
> 
> 
> What I mean is that there should be a separate module that contains all the
> renesas specific code, and that module should register a platform driver
> that contains the match table for its own IDs.
> 
> Then instead of having a common xhci_plat_probe() that gets called as the
> ->probe() callback of the driver, you have a rcar_xhci_probe() function
> that calls into common helper functions exported by the base driver, just
> as we do things for all other drivers. See ehci or ahci for instance.

Thank you very much for the prompt reply!
I will see ehci and ahci drivers.

Best regards,
Yoshihiro Shimoda

> 
> 	Arnd
> 

-- 
Yoshihiro Shimoda
EC No.
